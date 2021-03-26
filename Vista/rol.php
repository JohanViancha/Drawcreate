<?php

    require_once 'menu.php';


?>
<?php
    
    require_once 'encabezado.php';

?>


<div class="container-fluid mb-5">

    <!-- Page Heading -->
    <h1 class="mb-4 text-gray-800"><b>Roles</b></h1>
    <h5 class="text-danger" id="ruta-nombre">Sesion / Roles </h5>

    <button hidden class="float-right btn btn-danger btn-icon-split mb-3" id="btn-agregar">
        <span class="icon text-white-50">
            <i class="fas fa-plus-square"></i>
        </span>
        <span class="text">Agregar Rol</span>
    </button>
    
    <br>

    <div class="col-xl-12 table-responsive tabla_rol p-0">
        <table class="table table-striped" style="width:100%" id="tb_rol">
            <thead>
                <tr style="background:#434343">
                <th class="text-white" >#</th>
                <th class="text-white">Nombre</th>
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
                    <label for="nom_rol" class="text-white">Nombre</label>
                    <input type="text" class="form-control" id="nom_rol">
                </div>
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-3">
                    <label for="est_rol" class="text-white">Estado</label>
                    <select id="est_rol" disabled="true" style="cursor:not-allowed" class="form-control">
                        <option value="Activo">Activo</option>
                        <option value="Inactivo">Inactivo</option>
                    </select>
                </div>

                <div class="form-group col-12 col-sm-12 col-md-12 col-lg-6" id="permisos">
                    <label  class="text-white">Lista de Permisos</label>
                    <ul class="list-group" id="list-permisos">
                            
                    </ul>
                </div>
            </div>
        </form>
    </div>

    <button class="mt-3 float-left btn btn-danger btn-icon-split" funcion="" id="btn-guardar">
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

<script src="../Vista/JS/rol.js"></script>

</body>
 
</html>