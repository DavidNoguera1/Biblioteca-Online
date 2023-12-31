/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.jd.biblioteca;

import java.io.EOFException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

/**
 *
 * @author David Noguera Esta clase manejara la lista doblemente enlazada y sus
 * respectivos metodos
 * @param <Libros>
 */
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;

// <T> tipo genérico declaracion de clase
public class ListasN<T> implements Serializable {

    public Nodo inicio = null;
    public Nodo fin = null;

    // Clase interna Nodo que representa un elemento de la lista
    public class Nodo implements Serializable {

        public Libro libro;
        public Nodo siguiente;
        public Nodo anterior;

        public Nodo(Libro libro) {
            this.libro = libro;
            this.siguiente = null;
            this.anterior = null;
        }
    }

    // Boolean que verifica si la lista está vacía
    public boolean verificarContenido() {
        return inicio == null;
    }

    public void agregarLibroAlComienzo(Libro libro) {
        Nodo nuevoNodo = new Nodo(libro);

        if (inicio == null) {
            // Caso 1: La lista está vacía
            inicio = nuevoNodo;
            fin = nuevoNodo;
        } else {
            // Caso 2: La lista no está vacía
            nuevoNodo.siguiente = inicio;
            inicio.anterior = nuevoNodo;

            // Actualiza el inicio
            inicio = nuevoNodo;
        }
    }

    public void agregarLibroAlFinal(Libro libro) {
        Nodo nuevoNodo = new Nodo(libro);

        if (inicio == null) {
            // Si la lista está vacía, el nuevo nodo es tanto el inicio como el fin
            inicio = nuevoNodo;
            fin = nuevoNodo;
        } else {
            // Si no está vacía, el nuevo nodo se agrega al final y se actualiza el fin
            nuevoNodo.anterior = fin;
            fin.siguiente = nuevoNodo; // Establecer el enlace hacia adelante del último nodo al nuevo nodo
            fin = nuevoNodo;
        }
    }

    public void listarLibros() {
        Nodo actual = inicio; // Comenzamos desde el primer nodo

        while (actual != null) { // Recorremos la lista mientras haya nodos
            Libro libro = actual.libro; // Obtenemos el libro del nodo actual
            System.out.println("Título: " + libro.getTitulo());
            System.out.println("Autor: " + libro.getAutor());
            System.out.println("Año: " + libro.getAnio());
            System.out.println("Foto: " + libro.getFoto());
            System.out.println("Prestado" + libro.isPrestado());
            System.out.println(); // Separador entre libros

            actual = actual.siguiente; // Avanzamos al siguiente nodo
        }
    }
    
    public void eliminarLibroPorTitulo(String titulo) {
        Nodo actual = inicio;

        // Buscamos el nodo con el título dado
        while (actual != null) {
            if (actual.libro.getTitulo().equals(titulo)) {
                // Caso 1: El nodo a eliminar es el primero
                if (actual == inicio) {
                    inicio = actual.siguiente;
                    if (inicio != null) {
                        inicio.anterior = null;
                    } else {
                        fin = null;
                    }
                    return;
                }

                // Caso 2: El nodo a eliminar es el último
                if (actual == fin) {
                    fin = actual.anterior;
                    fin.siguiente = null;
                    return;
                }

                // Caso 3: El nodo a eliminar está en medio
                actual.anterior.siguiente = actual.siguiente;
                actual.siguiente.anterior = actual.anterior;
                return;
            }

            actual = actual.siguiente; // Avanzamos al siguiente nodo
        }

        // Si el título no se encuentra en la lista
        System.out.println("El libro con el título " + titulo + " no existe en la lista.");
    }
    
    public Libro buscarLibroPorTituloOAutor(String tituloOAutor) {
    // Limpia los espacios en blanco al comienzo y al final del título o autor
    tituloOAutor = tituloOAutor.trim();

    // Convertir el título o autor proporcionado a minúsculas (o mayúsculas)
    String tituloOAutorBuscado = tituloOAutor.toLowerCase(); // Esto con el fin de evitar posibles complicaciones

    Nodo actual = inicio;

    while (actual != null) {
        // Limpia los espacios en blanco al comienzo y al final del título y autor del libro actual
        String titulo = actual.libro.getTitulo().trim();
        String autor = actual.libro.getAutor().trim();

        // Convertir el título y autor del libro actual a minúsculas (o mayúsculas) y comparar
        if (titulo.toLowerCase().equals(tituloOAutorBuscado) || autor.toLowerCase().equals(tituloOAutorBuscado)) {
            return actual.libro; // Retorna el libro si se encuentra
        }

        actual = actual.siguiente; // Avanza al siguiente nodo
    }

    return null; // Retorna null si no se encuentra el libro
    }
    
    public void devolverLibro(String titulo) {
        Nodo actual = inicio;

        while (actual != null) {
            if (actual.libro.getTitulo().equals(titulo)) {
                actual.libro.setPrestado(false); // Cambia el valor de prestado a false
                System.out.println("Libro devuelto con éxito: " + titulo);
                return;
            }

            actual = actual.siguiente; // Avanza al siguiente nodo
        }

        // Si el libro no se encuentra en la lista
        System.out.println("El libro con el título " + titulo + " no existe en la lista.");
    }

    public boolean existeLibroPorTitulo(String titulo) {
        Nodo actual = inicio;

        while (actual != null) {
            if (actual.libro.getTitulo().equalsIgnoreCase(titulo.trim())) {
                return true; // Retorna true si el libro con el mismo título se encuentra en la lista
            }

            actual = actual.siguiente; // Avanza al siguiente nodo
        }

        return false; // Retorna false si no se encuentra el libro con el mismo título
    }

    
    // Método para guardar la lista en un archivo
    public static void guardarLista(ListasN listaActualizada, ServletContext context) {
        // Ruta relativa y absoluta del archivo de datos serializados
        String rutaRelativa = "/data/listaLibros.ser";
        String rutaAbsoluta = context.getRealPath(rutaRelativa);
        File archivo = new File(rutaAbsoluta);

        try (FileOutputStream fos = new FileOutputStream(archivo); ObjectOutputStream oos = new ObjectOutputStream(fos)) {
            oos.writeObject(listaActualizada);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Método para leer la lista desde un archivo
    public static ListasN<Libro> leerLista(ServletContext context) {
        ListasN<Libro> lista = null;
        String rutaRelativa = "/data/listaLibros.ser";
        String rutaAbsoluta = context.getRealPath(rutaRelativa);
        File archivo = new File(rutaAbsoluta);

        if (archivo.exists() && archivo.isFile()) {
            try (FileInputStream fis = new FileInputStream(archivo); ObjectInputStream ois = new ObjectInputStream(fis)) {
                lista = (ListasN<Libro>) ois.readObject();
            } catch (EOFException e) {
                System.out.println("El archivo de datos está vacío.");
            } catch (IOException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }

        if (lista == null) {
            lista = new ListasN<Libro>(); // Crea una nueva lista si no se pudo cargar desde el archivo
        }

        return lista;
    }
    
    public void marcarLibroComoPrestado(String titulo) {
        Nodo actual = inicio;

        while (actual != null) {
            if (actual.libro.getTitulo().equals(titulo)) {
                actual.libro.setPrestado(true); // Cambia el valor de prestado a true
                System.out.println("Libro marcado como prestado: " + titulo);
                return;
            }

            actual = actual.siguiente; // Avanza al siguiente nodo
        }

        // Si el libro no se encuentra en la lista
        System.out.println("El libro con el título " + titulo + " no existe en la lista.");
    }
}
