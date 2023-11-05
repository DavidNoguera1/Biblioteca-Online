<%@include file= "templates/header.jsp" %>

<!-- Header-->
<header class="bg-dark py-5">
    <div class="container px-5">
        <div class="row gx-5 justify-content-center">
            <div class="col-lg-6">
                <div class="text-center my-5">
                    <h1 class="display-5 fw-bolder text-white mb-2">Bienvenido a nuestra gran biblioteca virtual <%= session.getAttribute("usuario")%></h1>
                    <p class="lead text-white-50 mb-4">Nuestra biblioteca virtual te permitira agregar una variedad de libros explora diversos titulos a traves de la lectura!</p>
                    <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
                        <a class="btn btn-primary btn-lg px-4 me-sm-3" href="#formulario">Agregar libro</a>
                        <a class="btn btn-outline-light btn-lg px-4" href="libros.jsp">Mostrar libros</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<section class="bg-light py-5" id="formulario">
    <div class="container px-5 my-5 px-5">
        <div class="text-center mb-5">
            <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-book"></i></div>
            <h2 class="fw-bolder">Agrega un nuevo libro</h2>
            <p class="lead mb-0">Asegurese de llenar todos los campos</p>
        </div>
        <div class="row gx-5 justify-content-center">
            <div class="col-lg-6">
                <form id="contactForm" action="SvLibro" method="POST" enctype="multipart/form-data">
                    <!-- Título Input -->
                    <div class="form-floating mb-3">
                        <input class="form-control" id="titulo" name="titulo" type="text" title="Ingrese el título del libro" required>
                        <label for="titulo">Título</label>
                    </div>
                    <!-- Autor Input -->
                    <div class="form-floating mb-3">
                        <input class="form-control" id="autor" name="autor" type="text" title="Ingrese el autor del libro" required>
                        <label for="autor">Autor</label>
                    </div>
                    <!-- Año Input -->
                    <div class="form-floating mb-3">
                        <input class="form-control" id="anio" name="anio" type="text"  pattern="[0-9]*" title="Por favor, ingrese solo números." required>
                        <label for="anio">Año de publicación</label>
                        <div class="invalid-feedback">El libro requiere un año de publicación válido.</div>
                    </div>
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="foto">Foto:</label>
                        <input type="file" name="foto" class="form-control" id="foto" accept="foto/*">
                    </div>
                    <!-- Submit Button -->
                    <div class="d-grid">
                        <button class="btn btn-primary btn-lg" id="submitButton" type="submit">Agregar Libro</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<%@include file= "templates/footer.jsp" %>

<script>
    // Validación personalizada para el campo de imagen
    document.getElementById("contactForm").addEventListener("submit", function (event) {
        var imageInput = document.getElementById("foto");
        if (imageInput.files.length === 0) {
            alert("¡Imagen del libro requerida!");
            event.preventDefault(); // Evita el envío del formulario si no se seleccionó una imagen
        }
    });
</script>