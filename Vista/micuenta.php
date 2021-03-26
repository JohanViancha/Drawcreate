


<!-- End of Sidebar -->

<?php

        require_once 'menu.php';

?>
   
<?php

        require_once 'encabezado.php';

?>

<div class="container-fluid mb-5">

         <h1 class="mb-4 text-gray-800"><b>Mi cuenta</b></h1>

        <div class="row">
                <div class="col-12 col-lg-4 mb-3">
                        <div class="list-group" id="list-tab" role="tablist">
                                <a class="list-group-item list-group-item-action active" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile">Perfil</a>
                                <a class="list-group-item list-group-item-action" id="list-security-list" data-toggle="list" href="#list-security" role="tab" aria-controls="security">Seguridad</a>
                                <a class="list-group-item list-group-item-action" id="list-mywork-list" data-toggle="list" href="#list-mywork" role="tab" aria-controls="mywork">Mi trabajo</a>
                        </div>
                </div>
                
                <div class="col-12 col-lg-8">
                        <div class="tab-content" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">
                                        <div class="card">
                                                        <img src="../img/user.png" class="rounded mx-auto d-block" alt="...">
                                                        <hr class="sidebar-divider d-none d-md-block">
                                                        <div class="card-body">
                                                        <h5 class="card-title">Mis datos</h5>

                                                        <form>
                                                                <div class="form-row">
                                                                        <div class="form-group col-12 col-sm-12 col-md-6 col-lg-6">
                                                                        <label for="nom_usu">Nombres</label>
                                                                        <input type="text" class="form-control" value="<?php echo $_SESSION["nombre"] ?>">
                                                                        </div>

                                                                        <div class="form-group col-12 col-sm-12 col-md-6 col-lg-6">
                                                                        <label for="ape_usu">Apellidos</label>
                                                                        <input type="text" class="form-control" value="<?php echo $_SESSION["apellido"] ?>">
                                                                        </div>
                                                                        
                                                                        <div class="form-group col-12 col-sm-12 col-md-6 col-lg-6">
                                                                        <label for="tipdoc_cli">Tipo Documento</label>
                                                                        <input type="text" style="cursor:not-allowed" Readonly class="form-control" id="numdoc_cli" value="<?php echo $_SESSION["tipo_documento"] ?>">
                                                                        </div>
                                                                        <div class="form-group col-12 col-sm-12 col-md-6 col-lg-6">
                                                                        <label for="numdoc_cli">Numero Documento</label>
                                                                        <input type="text" style="cursor:not-allowed" Readonly class="form-control" id="numdoc_cli" value="<?php echo $_SESSION["documento"] ?>">
                                                                        </div>
                                                                        <div class="form-group col-12 col-sm-12 col-md-6 col-lg-6">
                                                                        <label for="gen_cli">Genero</label>
                                                                        <select id="gen_cli" class="form-control">
                                                                                <option value="Masculino">Masculino</option>
                                                                                <option value="Femenino">Femenino</option>
                                                                                <option value="Otros">Otros</option>
                                                                        </select>
                                                                        </div>
                                                                        <div class="form-group col-12 col-sm-12 col-md-6 col-lg-6">
                                                                        <label for="corele_cli">Correo Electronico</label>
                                                                        <input type="email" style="cursor:not-allowed" Readonly class="form-control" id="corele_cli" value="<?php echo $_SESSION["correo"] ?>">
                                                                        </div>
                                                                        <div class="form-group col-12 col-sm-12 col-md-6 col-lg-6">
                                                                        <label for="corele_cli">Tipo Usuario</label>
                                                                        <input type="email" style="cursor:not-allowed" class="form-control" Readonly id="corele_cli" value="<?php echo $_SESSION["rol"] ?>">
                                                                        </div>
                                                                        <div class="form-group col-12 col-sm-12 col-md-6 col-lg-6">
                                                                        <label for="corele_cli">Celular</label>
                                                                        <input type="email" style="cursor:not-allowed" class="form-control" Readonly id="corele_cli" value="<?php echo $_SESSION["celular"] ?>">
                                                                        </div>
                                                                                                                                                <button class="mt-3 float-left btn btn-danger btn-icon-split" funcion="" id="btn-guardar">
                                                                                <span class="icon text-white-50">
                                                                                <i class="fas fa-save"></i>
                                                                                </span>
                                                                                <span class="text">Guardar</span>
                                                                        </button>
                                                                </div>
                                                        </form>
                                
                                                </div>
                                        </div>   
                                </div>
                                <div class="tab-pane fade" id="list-security" role="tabpanel" aria-labelledby="list-security-list">
                                        <div class="card mb-3" >
                                                <div class="card-header border-bottom-danger">Cambio de Contraseña</div>
                                                <div class="card-body">
                                                        <form>
                                                                <div class="form-row">
                                                                        <div class="form-group col-12">
                                                                                <label for="nom_cat">Contraseña Actual</label>
                                                                                <input type="password" class="form-control" id="nom_cat">
                                                                        </div>
                                                                        <div class="form-group col-12">
                                                                                <label for="des_cat">Nueva Contraseña</label>
                                                                                <input type="password" class="form-control" id="des_cat">
                                                                        </div>
                                                                        <div class="form-group col-12">
                                                                                <label for="des_cat">Repetir Contraseña</label>
                                                                                <input type="password" class="form-control" id="des_cat">
                                                                        </div>
                                                                </div>

                                                        </form>
                                               
                                                </div>
                                        </div>

                                        <div class="card mb-3">
                                                <div class="card-header border-bottom-danger">Doble Autenticación</div>
                                                <div class="card-body">
                                                        <form>
                                                                <div class="form-row">
                                                                        <div class="form-group col-6">
                                                                                <div class="form-check">
                                                                                        <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios1" value="option1" checked>
                                                                                        <label class="form-check-label" for="exampleRadios1">
                                                                                        Activado
                                                                                        </label>
                                                                                        
                                                                                </div>
                                                                                <br>

                                                                                <div class="form-check">
                                                                                        <input class="form-check-input" type="radio" name="exampleRadios" id="exampleRadios1" value="option1" checked>
                                                                                        <label class="form-check-label" for="exampleRadios1">
                                                                                        Desactivado
                                                                                        </label>
                                                                                </div>
                                                                        </div>
                                                                        <div class="form-group col-6">
                                                                                <label for="des_cat">Celular</label>
                                                                                <input type="text" class="form-control" id="" value="<?php echo $_SESSION["celular"] ?>">
                                                                        </div>
                                                                </div>

                                                        </form>
                                               
                                                </div>
                                        </div>
                                </div>
                                <div class="tab-pane fade" id="list-mywork" role="tabpanel" aria-labelledby="list-mywork-list">
                                <div class="card mb-3">
                                                <div class="card-header border-bottom-danger">Historial de trabajo</div>
                                                <div class="card-body">
                                                        <ul class="list-group">
                                                                <li class="list-group-item">Tarea 1</li>
                                                                <li class="list-group-item">Tarea 1</li>
                                                                <li class="list-group-item">Tarea 1</li>
                                                                <li class="list-group-item">Tarea 1</li>
                                                                <li class="list-group-item">Tarea 1</li>
                                                        </ul>
                                               
                                                </div>
                                        </div>
                                </div>
                        </div>
                </div>
        </div>
</div>
<?php
    require_once 'pie.php'
?>

<script src="../Vista/JS/micuenta.js"></script>

</body>
 
</html>