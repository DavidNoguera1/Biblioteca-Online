<%-- 
    Document   : Libros
    Created on : 28/10/2023, 3:14:04 p.�m.
    Author     : David Noguera
--%>

<%@page import="com.jd.biblioteca.ListasN"%>
<%@page import="com.jd.biblioteca.Libro"%>
<%@include file= "templates/headerIndex.jsp" %>

    <section class="bg-light py-5 border-bottom">
        <div class="container px-5 my-5">
            <div class="text-center mb-5">
                <h2 class="fw-bolder">Libros disponibles</h2>
                <p class="lead mb-0">Escoge el que mas te guste :)</p>
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
                                   Autor: <%= current.libro.getAutor()%>
                                </li>
                                <li class="mb-2">
                                    A�o de publicacion: <%= current.libro.getAnio()%>
                                </li>
                                <li class="mb-2">
                                    <img src="imagenes/<%= current.libro.getFoto()%>" alt="<%= current.libro.getTitulo()%>" width="100" height="150">
                                </li>
                            </ul>
                            <div class="d-grid">
                                <a class="btn btn-outline-danger" href="#!" data-bs-toggle="modal" data-bs-target="#confirmacionModal" onclick="tituloEliminar('<%= current.libro.getTitulo() %>')">Eliminar</a>
                            </div>
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
    <div class="modal fade" id="confirmacionModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Eliminar</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    �Est� seguro de que desea eliminar la tarea?
                  </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-danger" onclick="eliminarLibro()">Eliminar</button>
                </div>
            </div>
        </div>
    </div>
            
    <script>
    var Titulo;
    
    function tituloEliminar(titulo) {
        Titulo = titulo; // Guarda el titulo del libro para usarlo en la funci�n eliminarTarea
        
    }
        
    function eliminarLibro() {
        location.href = "SvLibro?tipo=delete&titulo=" + Titulo;
        Titulo = null;
    }
    </script>            
<%@include file= "templates/footer.jsp" %>  
