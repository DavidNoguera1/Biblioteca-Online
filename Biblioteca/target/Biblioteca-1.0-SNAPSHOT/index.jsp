<%-- 
    Document   : index
    Author     : DNoguera
--%>

<!DOCTYPE html>
<%@include file= "templates/headerIndex.jsp" %>

<section class="vh-100" style="background: linear-gradient(to bottom, #3498db, #005b96);">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col col-xl-10">
                <div class="card" style="border-radius: 1rem;">
                    <div class="row g-0">
                        <div class="col-md-6 col-lg-5 d-none d-md-block">
                            <img src="https://i.pinimg.com/originals/1e/9b/e6/1e9be63de4a8befbb7ace6f9eb31d101.jpg"
                                 alt="login form" class="img-fluid" style="border-radius: 1rem 0 0 1rem;" />
                        </div>
                        <div class="col-md-6 col-lg-7 d-flex align-items-center">
                            <div class="card-body p-4 p-lg-5 text-black">


                                <form id="loginForm" action="SvLogin" method="post">

                                    <div class="alert alert-danger alert-dismissible fade show" role="alert" style="display: none;" id="errorAlert">
                                        Datos incorrectos o usuario no existente. Vuelva a intentarlo.
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>

                                    <div class="alert alert-success alert-dismissible fade show" role="alert" style="display: none;" id="registroSuccessAlert">
                                        ¡Registro exitoso! El usuario se añadio al sistema.
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>


                                    <div class="alert alert-danger alert-dismissible fade show" role="alert" style="display: none;" id="registroErrorAlert">
                                        La cedula ingresada ya esta registrada a un usuario existente. Vuelva a intentarlo con otro numero de cedula.
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>



                                    <div class="d-flex align-items-center mb-3 pb-1">
                                        <i class="fas fa-cubes fa-2x me-3" style="color: #273B6F;"></i>
                                        <span class="h1 fw-bold mb-0">Biblioteca Web</span>
                                    </div>

                                    <h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Introduzca sus credenciales</h5>


                                    <div class="form-outline mb-4">
                                        <input type="text" id="cedula" name="cedula" class="form-control form-control-lg" required/>
                                        <label class="form-label" for="cedula">Cedula</label>
                                    </div>

                                    <div class="form-outline mb-4">
                                        <input type="password" id="contrasenia" name="contrasenia" class="form-control form-control-lg" required/>
                                        <label class="form-label" for="contrasenia">Contraseña</label>
                                    </div>

                                    <div class="pt-1 mb-4">
                                        <button class="btn btn-dark btn-lg btn-block" type="submit">Login</button>
                                    </div>

                                    <p class="mb-5 pb-lg-2" style="color: #393f81;">No está registrado? <a href="#!" style="color: #0000FF;" data-bs-toggle="modal" data-bs-target="#exampleModal">Regístrate aquí</a></p>
                                    <a href="#!" class="small text-muted">Terms of use.</a>
                                    <a href="#!" class="small text-muted">Privacy policy</a>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ventana Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-dark text-white">
            <div class="modal-header border-bottom-0">
                <h5 class="modal-title" id="exampleModalLabel">Registro(Ingrese sus datos, no se permiten espacios en la cedula y contraseña)</h5>
                <button type="button" class="btn-close text-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="usuario-details">
                    <form id="registroForm" action="SvUsuario" method="post" class="row g-3 needs-validation">
                        <!-- Campo de cédula -->
                        <!-- Campo de cédula -->
                        <div class="col-md-4 input-group">
                            <label class="input-group-text" for="cedula">Número de cédula:</label>
                            <input type="text" id="cedula" name="cedula" class="form-control" required pattern="[0-9]*" title="Ingresa solo números (sin espacios ni otros caracteres)" />
                            <div class="valid-feedback">
                                Looks good!
                            </div>
                            <div class="invalid-feedback">
                                Por favor, ingresa solo números (sin espacios ni otros caracteres).
                            </div>
                        </div>


                        <!-- Campo de nombre de usuario -->
                        <div class="col-md-4 input-group">
                            <label class="input-group-text" for="nombre">Nombre:</label>
                            <input type="text" id="nombre" name="nombre" class="form-control" required>
                            <div class="valid-feedback">
                                Looks good!
                            </div>
                            <div class="invalid-feedback">
                                Por favor, complete este campo.
                            </div>
                        </div>

                        <!-- Campo de contraseña -->
                        <div class="col-md-4 input-group">
                            <label class="input-group-text" for="contrasenia">Contraseña:</label>
                            <input type="password" id="contrasenia" name="contrasenia" class="form-control" required pattern="[^\s]+" title="No se permiten espacios" />
                            <div class="valid-feedback">
                                Looks good!
                            </div>
                            <div class="invalid-feedback">
                                Por favor, complete este campo sin espacios.
                            </div>
                        </div>

                        <div class="col-12">
                            <button type="submit" class="btn btn-primary">Registrarse</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<!<!-- Funcion que abre la modal de registro -->
<script>
    $(document).ready(function () {
        // Agrega un controlador de clic al enlace "Regístrate aquí"
        $("a[href='#exampleModal']").on('click', function () {
            // Muestra el modal cuando se hace clic en el enlace
            $('#exampleModal').modal('show');
        });
    });
</script>



<!-- JavaScript para mostrar la alerta cuando falle el proceso de login -->
<script>
    // JavaScript para mostrar la alerta cuando sea necesario
    document.addEventListener("DOMContentLoaded", function () {
        // Obtén la alerta por su ID
        const errorAlert = document.getElementById('errorAlert');

        // Verifica si hay un parámetro de alerta en la URL (por ejemplo, '?alert=error')
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('alert') && urlParams.get('alert') === 'error') {
            // Muestra la alerta si el parámetro de alerta es 'error'
            errorAlert.style.display = 'block';
        }
    });
</script>

<!-- JavaScript para mostrar la alerta de registro cuando exista una cedula previamente registrada -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Obtén la alerta por su ID
        const registroErrorAlert = document.getElementById('registroErrorAlert');

        // Verifica si hay un parámetro de alerta en la URL (por ejemplo, '?alert=registro-error')
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('alert') && urlParams.get('alert') === 'registro-error') {
            // Muestra la alerta de registro si el parámetro de alerta es 'registro-error'
            registroErrorAlert.style.display = 'block';
        }
    });
</script>

<!-- JavaScript para mostrar la alerta de registro exitoso cuando sea necesario -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Obtén la alerta por su ID
        const registroSuccessAlert = document.getElementById('registroSuccessAlert');

        // Verifica si hay un parámetro de alerta en la URL (por ejemplo, '?alert=registro-success')
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('alert') && urlParams.get('alert') === 'registro-success') {
            // Muestra la alerta de registro exitoso si el parámetro de alerta es 'registro-success'
            registroSuccessAlert.style.display = 'block';
        }
    });
</script>






<%@include file= "templates/footerIndex.jsp" %>