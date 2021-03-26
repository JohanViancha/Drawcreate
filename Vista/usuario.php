<?php

    require_once 'menu.php';


?>
<?php
    
    require_once 'encabezado.php';

?>


<div class="container-fluid mb-5">

    <!-- Page Heading -->
    <h1 class="mb-4 text-gray-800"><b>Usuarios</b></h1>
    <h5 class="text-danger" id="ruta-nombre">Sesión / Usuarios</h5>

    <button class="float-right btn btn-danger btn-icon-split" id="btn-agregar">
        <span class="icon text-white-50">
            <i class="fas fa-plus-square"></i>
        </span>
        <span class="text">Agregar Usuario</span>
    </button>
    <br>

    <span role="button" class="mt-4 text-dark h5" id="texto-filtro"><i class="fas fa-filter text-danger"></i> <a data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample"> Filtros</a></span>

    <div class="collapse mb-4 mt-2 show" id="collapseExample">
        <div class="card card-body" style="background:#434343">
        <form>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label for="nom_cat" class="text-white">Nombre</label>
                    <input type="text" class="form-control" id="nom_cat">
                </div>
                <div class="form-group col-md-4">
                    <label for="est_cat" class="text-white">Estado</label>
                    <select id="est_cat" class="form-control">
                        <option selected class="alert alert-danger">Todos</option>
                        <option>Activo</option>
                        <option>Inactivo</option>
                    </select>
                </div>
            </div>
            </form>
        </div>
    </div>


    <div class="col-xl-12 table-responsive tabla_usuario">
        <table class="table table-striped" style="width:100%" id="tb_usu">
            <thead>
                <tr style="background:#434343">
                <th class="text-white" >Opciones</th>
                <th class="text-white">Nombre</th>
                <th class="text-white">Tipo Documento</th>
                <th class="text-white">N° Documento</th>
                <th class="text-white">Correo Electronico</th>
                <th class="text-white">Rol</th>
                <th class="text-white">Estado</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>


    <div class="card card-body mt-3" secuencia="0" id="form-agregar" hidden="true" style="background:#434343">
        <form>
            <div class="form-row">
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-3">
                    <label for="nom_usu" class="text-white">Nombres</label>
                    <input type="text" class="form-control" id="nom_usu">
                </div>
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-3">
                    <label for="ape_usu" class="text-white">Apellidos</label>
                    <input type="text" class="form-control" id="ape_usu">
                </div>
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-3">
                    <label for="tipdoc_usu" class="text-white">Tipo Documento</label>
                    <select id="tipdoc_usu" class="form-control">
                        <option value="Cedula de Ciudadania">Cedula de Ciudadania</option>
                        <option value="Tarjeta de Identidad">Tarjeta de Identidad</option>
                        <option value="Documento de Extranjeria">Documento de Extranjeria</option>
                    </select>
                </div>
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-3">
                    <label for="numdoc_usu" class="text-white">Numero Documento</label>
                    <input type="text" class="form-control" id="numdoc_usu">
                </div>
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-3">
                    <label for="gen_usu" class="text-white">Genero</label>
                    <select id="gen_usu" class="form-control">
                        <option value="Masculino">Masculino</option>
                        <option value="Femenino">Femenino</option>
                        <option value="Otros">Otros</option>
                    </select>
                </div>
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-3">
                    <label for="corele_usu" class="text-white">Correo Electronico</label>
                    <input type="email" class="form-control" id="corele_usu" require>
                </div>
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-3">
                    <label for="cel_usu" class="text-white">Celular</label>
                    <input type="email" class="form-control" id="cel_usu">
                </div>
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-3">
                    <label for="rol_usu" class="text-white">Rol</label>
                    <select id="rol_usu" class="form-control">
                
                    </select>
                </div>
            </div>
        </form>
    </div>

    <button class="mt-3 float-left btn btn-danger btn-icon-split" id="btn-guardar">
        <span class="icon text-white-50">
            <i class="fas fa-save"></i>
        </span>
        <span class="text">Guardar</span>
    </button>

    
    <button class="mt-3 float-left btn btn-secondary ml-2 btn-icon-split" id="btn-cancelar">
        <span class="icon text-white-50">
            <i class="fas fa-window-close"></i>
        </span>
        <span class="text">Cancelar</span>
    </button>
</div>
<br>



<?php
    require_once 'pie.php'
?>

<script src="../Vista/JS/usuario.js"></script>