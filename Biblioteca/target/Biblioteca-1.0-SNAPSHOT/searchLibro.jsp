<%-- 
    Document   : searchLibro
    Created on : 31 oct 2023, 11:05:14
    Author     : PC
--%>

<%@page import="com.jd.biblioteca.ListasN"%>
<%@page import="com.jd.biblioteca.Libro"%>
<%@include file= "templates/header.jsp" %>

<section class="bg-light py-5 border-bottom">
    <div class="container px-5 my-5">
        <div class="text-center mb-5">
            <h2 class="fw-bolder">Resultados obtenidos</h2>
            <p class="lead mb-0">Esperamos que hayas encontrado lo que deseabas</p>
        </div>
        <div class="row gx-5 justify-content-center">
            <%
                ServletContext context = request.getServletContext();
                ListasN<Libro> listaLibros = ListasN.leerLista(context);
                String parametro = request.getParameter("tituloOAutor");

                if (listaLibros != null && parametro != null) {
                    ListasN.Nodo current = listaLibros.inicio;

                    while (current != null) {
                        // Verifica si el título o autor del libro coincide con el parámetro de búsqueda
                        if (current.libro.getTitulo().toLowerCase().contains(parametro.toLowerCase()) ||
                            current.libro.getAutor().toLowerCase().contains(parametro.toLowerCase())) {
            %>
            <div class="col-lg-6 col-xl-4">
                <div class="card mb-5 mb-xl-0">
                    <div class="card-body p-5">
                        <div class="small text-uppercase fw-bold text-muted">Libro</div>
                        <ul class="list-unstyled mb-4">
                            <li class="mb-2">
                                Titulo: <%= current.libro.getTitulo() %>
                            </li>
                            <li class="mb-2">
                                Autor: <%= current.libro.getAutor() %>
                            </li>
                            <li class="mb-2">
                                Año de publicacion: <%= current.libro.getAnio() %>
                            </li>
                            <li class="mb-2">
                                <img src="imagenes/<%= current.libro.getFoto() %>"
                                     alt="<%= current.libro.getTitulo() %>" width="100" height="150">
                            </li>
                        </ul>
                        <div class="d-grid">
                            <a class="btn btn-outline-danger" href="#!" data-bs-toggle="modal" data-bs-target="#confirmacionModal"
                               onclick="tituloEliminar('<%= current.libro.getTitulo() %>')">Eliminar</a>
                        </div>
                        <br>
                        <div class="d-grid">
                            <a class="btn btn-outline-success" href="#!" data-bs-toggle="modal" data-bs-target="#PrestarLibro"
                               onclick="tituloEliminar('<%= current.libro.getTitulo() %>')">Prestar Libro</a>
                        </div>
                    </div>
                </div>
            </div>
            <br>
            <%
                        }
                        current = current.siguiente;
                    }
                } else {
            %>
            <div class="text-center">
                <p>No hay libros disponibles o la búsqueda está vacía.</p>
            </div>
            <%
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
                <p>¿Está seguro de que desea eliminar la tarea: <span id="bookTitle"></span></p> 
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
                ¿Quieres pedir prestado el siguiente  libro?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-success"  >Prestar </button>
            </div>
        </div>
    </div>
</div>

<script>
    var Titulo;

    function tituloEliminar(titulo) {
        Titulo = titulo; // Guarda el titulo del libro para usarlo en la función eliminarTarea
        document.getElementById("bookTitle").innerText = Titulo;

    }

    function eliminarLibro() {
        location.href = "SvLibro?tipo=delete&titulo=" + Titulo;
        Titulo = null;
    }

    function titulo() {
        return Titulo; // Guarda el titulo del libro para usarlo en la función eliminarTarea

    }

</script>


<%@include file= "templates/footer.jsp" %>  