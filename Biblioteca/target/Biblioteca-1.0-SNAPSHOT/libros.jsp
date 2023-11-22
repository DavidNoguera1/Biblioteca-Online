<%-- 
    Document   : Libros
    Created on : 28/10/2023, 3:14:04 p. m.
    Author     : David Noguera
--%>

<%@page import="com.jd.biblioteca.ListasN"%>
<%@page import="com.jd.biblioteca.Libro"%>
<%@include file= "templates/header.jsp" %>

    <section class="bg-light py-5 border-bottom">
        <div class="container px-5 my-5">
            <div class="text-center mb-5">
                <h2 class="fw-bolder">Todos los libros agregados</h2>
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
                <div class="col-lg-6 col-xl-4"><br>
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
                                    Año de publicacion: <%= current.libro.getAnio()%>
                                </li>
                                <li class="mb-2 ">
                                    <img src="imagenes/<%= current.libro.getFoto()%>" alt="<%= current.libro.getTitulo()%>" width="200" height="250">
                                </li>
                            </ul>
                            
                            <%
                                if (current.libro.isPrestado()== false) {
                                        
                                    
                            %>
                            <div class="d-grid">
                                <a class="btn btn-outline-danger" href="#!" data-bs-toggle="modal" data-bs-target="#confirmacionModal" onclick="extraerTituloEliminar('<%= current.libro.getTitulo() %>')">Eliminar</a>
                            </div><br>
                            <div class="d-grid">
                                <a class="btn btn-outline-success" href="#!" data-bs-toggle="modal" data-bs-target="#PrestarLibro" onclick="extraerTituloPrestar('<%= current.libro.getTitulo() %>')">Prestar Libro</a>
                            </div>
                            <%
                                      
                                }
                                else{
                                
                            %>
                            <br>
                            <br>
                            <div class="d-grid">
                                <a class="btn btn-outline-dark" href="#!" data-bs-toggle="modal" data-bs-target="#libroNoDisponible">Libro no disponible</a>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div><br>
                
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
                    <h5 class="modal-title" id="staticBackdropLabel">prestar</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>¿Estas seguro de que desea eliminar el sigueinte libro?: <span id="libroEliminar"></span></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-danger" onclick="eliminarLibro()">Eliminar</button>
                </div>
            </div>
        </div>
    </div>
            
    <div class="modal fade" id="PrestarLibro" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Prestar libro</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>¿Quieres pedir prestado el siguiente libro?: <span id="libroPrestar"></span></p>
                    
                  </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-success" onclick="prestarLibro()">Prestar </button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="libroNoDisponible" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Libro no disponible</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Actualmente libro se encuentra prestado, Selecciona otro libro que se encuentre disponible</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Listo</button>
                </div>
            </div>
        </div>
    </div>        
    <script>
    var Titulo;
    var Prestar;
    function extraerTituloEliminar(titulo) {
        Titulo = titulo; // Guarda el titulo del libro para usarlo en la función eliminarTarea
        document.getElementById("libroEliminar").innerText = Titulo;
        
    }
    
    function extraerTituloPrestar(titulo) {
        Prestar = titulo; // Guarda el titulo del libro para usarlo en la función eliminarTarea
        document.getElementById("libroPrestar").innerText = Prestar;
        
        
    }
    
    function extraerTituloBuscar(titulo) {
        Prstar = titulo; // Guarda el titulo del libro para usarlo en la función eliminarTarea
        document.getElementById("bookTitle").innerText = Prestar;
        
    }
        
    function eliminarLibro() {
        location.href = "SvLibro?tipo=delete&titulo=" + Titulo;
        Titulo = null;
    }
    
    function prestarLibro() {
        location.href = "SvLibro?tipo=prestar&titulo=" + Prestar;
        Titulo = null;
        
    }
    
    </script>
    
    
<%@include file= "templates/footer.jsp" %>
