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
            // Si la lista está vacía, el nuevo nodo es tanto el inicio como el fin
            inicio = nuevoNodo;
            fin = nuevoNodo;
        } else {
            // Si no está vacía, el nuevo nodo se agrega al comienzo y se actualiza el inicio
            nuevoNodo.siguiente = inicio;
            inicio.anterior = nuevoNodo; // Establecer el enlace hacia atrás del nodo actual al nuevo nodo
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

    // Método para guardar la lista en un archivo
    public static void guardarLista(ListasN listaActualizada, ServletContext context) {
        // Ruta relativa y absoluta del archivo de datos serializados
        String rutaRelativa = "/data/listaLibros.ser";
        String rutaAbsoluta = context.getRealPath(rutaRelativa);
        File archivo = new File(rutaAbsoluta);

        try (FileOutputStream fos = new FileOutputStream(archivo);
             ObjectOutputStream oos = new ObjectOutputStream(fos)) {
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
            try (FileInputStream fis = new FileInputStream(archivo);
                 ObjectInputStream ois = new ObjectInputStream(fis)) {
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
}


    

