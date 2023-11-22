/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import com.jd.biblioteca.Libro;
import com.jd.biblioteca.ListasN;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author David Noguera
 */
@MultipartConfig
@WebServlet(name = "SvLibro", urlPatterns = {"/SvLibro"})
public class SvLibro extends HttpServlet {

    public ListasN<Libro> libros;  // Lista de libros

    @Override
    public void init() throws ServletException {
        super.init();

        // Cargar la lista de libros desde el archivo al inicio de la aplicación
        libros = ListasN.leerLista(getServletContext());

        if (libros == null) {
            libros = new ListasN<Libro>();
        }
    }
    
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipo = request.getParameter("tipo");
        if (tipo != null && tipo.equals("delete")) {
            String tituloToDelete = request.getParameter("titulo");
            eliminarLibroPorTitulo(tituloToDelete);

            //Después de eliminar un libro con éxito en tu servlet
            response.sendRedirect("libros.jsp");
        }
        else if (tipo != null && tipo.equals("prestar")) {
            String tituloAPrestar = request.getParameter("titulo");

            // Buscar el libro en la lista y marcarlo como prestado
            marcarLibroComoPrestado(tituloAPrestar);

            // Guardar la lista actualizada en el archivo
            ListasN.guardarLista(libros, getServletContext());

            // Redirigir a la página de libros
            response.sendRedirect("libros.jsp");
        }
        else if (tipo != null && tipo.equals("devolver")) {
            String tituloToReturn = request.getParameter("titulo");

            // Devolver el libro
            devolverLibro(tituloToReturn);

            // Guardar la lista actualizada en el archivo
            ListasN.guardarLista(libros, getServletContext());

            // Después de devolver un libro con éxito en tu servlet
            response.sendRedirect("librosPrestados.jsp");
        }
    }
    
    public void eliminarLibroPorTitulo(String titulo) {
        // Asegúrate de tener la implementación de la clase Nodo y el método eliminarLibroPorTitulo en tu clase ListasN

        // Suponiendo que tu clase ListasN tiene el método eliminarLibroPorTitulo, puedes hacer lo siguiente:
        libros.eliminarLibroPorTitulo(titulo);

        // Guarda la lista actualizada en el archivo después de la eliminación
        ListasN.guardarLista(libros, getServletContext());
    }
    
    private void marcarLibroComoPrestado(String titulo) {
        Libro libroEncontrado = libros.buscarLibroPorTituloOAutor(titulo);

        if (libroEncontrado != null) {
            libroEncontrado.setPrestado(true);
            System.out.println("Libro marcado como prestado: " + titulo);
        } else {
            System.out.println("El libro con el título " + titulo + " no se encontró en la lista.");
        }

        // Guardar la lista actualizada en el archivo
        ListasN.guardarLista(libros, getServletContext());
    }

    private void devolverLibro(String titulo) {
        Libro libroEncontrado = libros.buscarLibroPorTituloOAutor(titulo);

        if (libroEncontrado != null) {
            libroEncontrado.setPrestado(false);
            System.out.println("Libro devuelto con éxito: " + titulo);
        } else {
            System.out.println("El libro con el título " + titulo + " no se encontró en la lista.");
        }

        // Guardar la lista actualizada en el archivo
        ListasN.guardarLista(libros, getServletContext());
    }

    //Emplearemos el metodo doPost para el añadido de los libros
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener la parte del archivo      
        Part imagenPart = request.getPart("foto");
        System.out.println("imagenPart" + imagenPart);

        // Nombre original del archivo
        String fileName = imagenPart.getSubmittedFileName();
        System.out.println("fileName: " + fileName);

        // Directorio donde se almacenará el archivo
        String uploadDirectory = getServletContext().getRealPath("imagenes");
        System.out.println("uploadDirectory: " + uploadDirectory);

        // Ruta completa del archivo
        String filePath = uploadDirectory + File.separator + fileName;
        System.out.println("filePath: " + filePath);

        // Guardar el archivo en el sistema de archivos
        try (InputStream input = imagenPart.getInputStream(); OutputStream output = new FileOutputStream(filePath)) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = input.read(buffer)) > 0) {
                output.write(buffer, 0, length);
            }
        }

        // Obtener los parámetros del formulario
        String titulo = request.getParameter("titulo");
        String autor = request.getParameter("autor");
        String anio = request.getParameter("anio");
        String foto = fileName;
        boolean prestado = false;
        
        // Verificar si el título ya existe en la lista
        if (libros.existeLibroPorTitulo(titulo)) {
            // El libro ya existe, puedes manejar el error de alguna manera
            response.sendRedirect("login.jsp?alert=registro-error");
            return;  // Detener el flujo para evitar agregar el libro duplicado
        }

        
        // Crear un nuevo libro con los datos del formulario
        Libro nuevoLibro = new Libro(titulo, autor, anio, foto, prestado);

        // Agregar el libro al comienzo de la lista
        libros.agregarLibroAlComienzo(nuevoLibro);

        libros.listarLibros();

        // Guardar la lista actualizada en el archivo
        ListasN.guardarLista(libros, getServletContext());

        // Redirige a la página libros.jsp
        response.sendRedirect("libros.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
