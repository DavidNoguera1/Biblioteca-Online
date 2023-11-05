<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Business Frontpage - Start Bootstrap Template</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container px-5">
                <a class="navbar-brand" href="index.jsp">Biblioteca</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <form class="d-flex" action="searchLibro.jsp" method="GET">
                    <input class="form-control me-2" type="search" name="tituloOAutor" placeholder="Buscar libro" aria-label="Search" required>
                    <button class="btn btn-outline-primary" type="submit">Buscar</button>
                </form>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="login.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="libros.jsp">Libros agregados</a></li>
                        <li class="nav-item"><a class="nav-link" href="librosPrestados.jsp">Libros Prestados</a></li>
                        <li class="nav-item"><a class="nav-link" href="index.jsp">Cerrar sesion</a></li>
                    </ul>
                </div>
            </div>
        </nav>