<%-- 
    Document   : Libros
    Created on : 28/10/2023, 3:14:04 p. m.
    Author     : David Noguera
--%>

<%@page import="com.jd.biblioteca.ListasN"%>
<%@page import="com.jd.biblioteca.Libro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Persistencia Noguera</h1>
    <tbody>
        <%
            // Obtener la lista doblemente enlazada desde el contexto del servlet
            ServletContext context = request.getServletContext();
            ListasN<Libro> listaLibros = ListasN.leerLista(context);

            if (listaLibros != null) {
                ListasN.Nodo current = listaLibros.inicio;
                while (current != null) {
        %>
        <tr>
            <td><%= current.libro.getTitulo()%></td>
            <td><%= current.libro.getAutor()%></td>
            <td><%= current.libro.getAnio()%></td>
            <td>
                <!-- Aquí puedes mostrar la imagen del libro utilizando la propiedad "foto" -->
                <img src="imagenes/<%= current.libro.getFoto()%>" alt="<%= current.libro.getTitulo()%>" width="100" height="150">
            </td>
        </tr>
        <%
                    current = current.siguiente;
                }
            } else {
                out.println("No hay libros disponibles.");
            }
        %>
    </tbody>
</body>
</html>
