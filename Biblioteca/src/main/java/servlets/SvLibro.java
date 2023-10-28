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
        // Inicializar la lista de libros en el método init
        libros = new ListasN();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        // Directorio donde se almacenara el archivo
        String uploadDirectory = getServletContext().getRealPath("imagenes");
        System.out.println("uploadDirectory: " + uploadDirectory);

        //Ruta completa del archivo
        String filePath = uploadDirectory + File.separator + fileName;
        System.out.println("filePath: " + filePath);

        //Guardar el archivo en el sistemaa de archivos
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

        // Cargar la lista de libros desde el archivo
        ListasN<Libro> listaLibros = ListasN.leerLista(getServletContext());

        if (listaLibros == null) {
            listaLibros = new ListasN<Libro>();
        }

        // Crear un nuevo libro con los datos del formulario
        Libro nuevoLibro = new Libro(titulo, autor, anio, foto);

        // Agregar el libro al comienzo de la lista
        libros.agregarLibroAlComienzo(nuevoLibro);

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
