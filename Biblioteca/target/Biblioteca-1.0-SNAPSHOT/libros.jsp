<%-- 
    Document   : Libros
    Created on : 28/10/2023, 3:14:04 p. m.
    Author     : David Noguera
--%>

<%@page import="com.jd.biblioteca.ListasN"%>
<%@page import="com.jd.biblioteca.Libro"%>
<%@include file= "templates/headerIndex.jsp" %>

    <section class="bg-light py-5 border-bottom">
        <div class="container px-5 my-5">
            <div class="text-center mb-5">
                <h2 class="fw-bolder">Pay as you grow</h2>
                <p class="lead mb-0">With our no hassle pricing plans</p>
            </div>
            <div class="row gx-5 justify-content-center">
                <%
                    // Obtener la lista doblemente enlazada desde el contexto del servlet
                    ServletContext context = request.getServletContext();
                    ListasN<Libro> listaLibros = ListasN.leerLista(context);

                    if (listaLibros != null) {
                        ListasN.Nodo current = listaLibros.inicio;
                        while (current != null) {
                %>
                <div class="col-lg-6 col-xl-4">
                    <div class="card mb-5 mb-xl-0">
                        <div class="card-body p-5">
                            <div class="small text-uppercase fw-bold text-muted">Libro</div>
                            <ul class="list-unstyled mb-4">
                                <li class="mb-2">
                                   Titulo: <%= current.libro.getTitulo()%> 
                                </li>
                                <li class="mb-2">
                                    <%= current.libro.getAutor()%>
                                </li>
                                <li class="mb-2">
                                    <%= current.libro.getAnio()%>
                                </li>
                                <li class="mb-2">
                                    <img src="imagenes/<%= current.libro.getFoto()%>" alt="<%= current.libro.getTitulo()%>" width="100" height="150">
                                </li>
                            </ul>
                            <div class="d-grid"><a class="btn btn-outline-primary" href="#!">Choose plan</a></div>
                        </div>
                    </div>
                </div>
                <%
                            current = current.siguiente;
                        }
                    } else {
                        out.println("No hay libros disponibles.");
                    }
                %>
            </div>
        </div>
    </section>
                
<%@include file= "templates/footer.jsp" %>  
