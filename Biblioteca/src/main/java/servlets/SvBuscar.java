/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import com.jd.biblioteca.Libro;
import com.jd.biblioteca.ListasN;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author juand
 */
@WebServlet(name = "SvBuscar", urlPatterns = {"/SvBuscar"})
public class SvBuscar extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tituloOAutor = request.getParameter("tituloOAutor");

        // Verifica si se ha proporcionado un título o autor en la solicitud
        if (tituloOAutor != null && !tituloOAutor.trim().isEmpty()) {
            // Limpia los espacios en blanco al comienzo y al final del título o autor
            tituloOAutor = tituloOAutor.trim();

            ListasN<Libro> listaLibros = ListasN.leerLista(getServletContext());
            Libro libro = listaLibros.buscarLibroPorTituloOAutor(tituloOAutor);

            if (libro != null) {
                // Guarda el libro encontrado en el alcance de solicitud
                request.setAttribute("libroEncontrado", libro);
                // Redirige a searchLibro.jsp
                String forward = "searchLibro.jsp";
                RequestDispatcher dispatcher = request.getRequestDispatcher(forward);
                dispatcher.forward(request, response);
            } else {
                // Maneja el caso en el que no se encuentra el libro
                response.setContentType("text/plain");
                response.getWriter().write("Libro no encontrado");
            }
        } else {
            // Maneja el caso en el que el título o autor esté vacío después de la limpieza
            response.setContentType("text/plain");
            response.getWriter().write("Por favor, ingrese un título o autor válido");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
}