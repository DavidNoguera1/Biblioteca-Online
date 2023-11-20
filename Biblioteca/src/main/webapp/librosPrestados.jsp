<%@page import="com.jd.biblioteca.ListasN"%>
<%@page import="com.jd.biblioteca.Libro"%>
<%@include file= "templates/header.jsp" %>
<section class="bg-light py-5 border-bottom">
    <div class="container px-5 my-5">
        <div class="text-center mb-5">
            <h2 class="fw-bolder">Libros Prestados</h2>
            <p class="lead mb-0">Aqui estan los libros que actualmente estan prestados, no olvides de devolverlos :)</p>
        </div>
        <div class="row gx-5 justify-content-center">
            <%
                // Obtener la lista doblemente enlazada desde el contexto del servlet
                ServletContext context = request.getServletContext();
                ListasN<Libro> listaLibros = ListasN.leerLista(context);

                if (listaLibros != null) {
                    ListasN.Nodo current = listaLibros.inicio;
                    while (current != null) {
                        // Verificar si el libro está prestado antes de mostrarlo
                        if (current.libro.isPrestado()) {
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
                        
                        <div class="d-grid">
                            <a class="btn btn-outline-success" href="#!" data-bs-toggle="modal" data-bs-target="#devolverLirbo" onclick="extraerTituloDevolver('<%= current.libro.getTitulo() %>')">Devolver Libro</a>
                        </div>
                    </div>
                </div>
            </div><br>
            <%
                        }
                        current = current.siguiente;
                    }
                } else {
                    out.println("No hay libros disponibles.");
                }
            %>
        </div>
    </div>
</section>

<div class="modal fade" id="devolverLirbo" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Devolver libro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>¿Quieres devolver el siguiente libro?: <span id="libroDevolver"></span></p>

              </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-success" onclick="prestarLibro()">¡Devolver! </button>
            </div>
        </div>
    </div>
</div>
<script>
    var Titulo;
    
    function extraerTituloDevolver(titulo) {
        Titulo = titulo; // Guarda el titulo del libro para usarlo en la función eliminarTarea
        document.getElementById("libroDevolver").innerText = Titulo;
        
    }
    
    function prestarLibro() {
        location.href = "SvLibro?tipo=devolver&titulo=" + Titulo;
        Titulo = null;
        
    }
    
</script>

<%@include file= "templates/footer.jsp" %>
