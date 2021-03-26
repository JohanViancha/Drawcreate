<?php

    require_once 'menu.php';


?>
<?php
    
    require_once 'encabezado.php';

?>


<div class="container-fluid mb-5">

    <!-- Page Heading -->
    <h1 class="mb-4 text-gray-800"><b>Categorias Productos</b></h1>
    <h5 class="text-danger" id="ruta-nombre">Inventario / Categoria</h5>
    <hr class="sidebar-divider">

    <button class="float-right btn btn-danger btn-icon-split" id="btn-agregar">
        <span class="icon text-white-50">
            <i class="fas fa-plus-square"></i>
        </span>
        <span class="text">Agregar Categoria</span>
    </button>
    <br>

    <span role="button" class="mt-4 text-dark h5" id="texto-filtro"><i class="fas fa-filter text-danger"></i> <a data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample"> Filtros</a></span>

    <div class="collapse mb-4 mt-2 show" id="collapseExample">
        <div class="card card-body" style="background:#434343">
        <form>
            <div class="form-row">
                <div class="form-group col-md-8">
                    <label for="fil_nom_cat" class="text-white">Nombre</label>
                    <input type="text" class="form-control" id="fil_nom_cat" name="fil_nom_cat">
                </div>

                <div class="form-group col-md-4">
                    <label for="fil_est_cat" class="text-white">Estado</label>
                    <select id="fil_est_cat" class="form-control">
                        <option selected>Todos</option>
                        <option value="Activo">Activo</option>
                        <option value="Inactivo">Inactivo</option>
                    </select>
                </div>
            </div>
            </form>
        </div>
    </div>


    <div class="col-xl-12 table-responsive tabla_categoria p-0">
        <table class="table table-striped" style="width:100%" id="tb_cat">
            <thead>
                <tr style="background:#434343">
                <th class="text-white" ></th>
                <th class="text-white">Nombre</th>
                <th class="text-white">Descripción</th>
                <th class="text-white">Estado</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>


    <div class="card card-body mt-3" id="form-agregar" hidden="true" style="background:#434343">
        <form>
            <div class="form-row">
                <div class="form-group col-12 col-sm-12 col-md-4 col-lg-2">
                    <label for="nom_cat" class="text-white">Nombre</label>
                    <input type="text" class="form-control" id="nom_cat" secuencia="">
                </div>
                <div class="form-group col-12 col-sm-12 col-md-8 col-lg-8">
                    <label for="des_cat" class="text-white">Descripción</label>
                    <input type="text" class="form-control" id="des_cat">
                </div>
                <div class="form-group col-12 col-sm-12 col-md-12 col-lg-2">
                    <label for="est_cat" class="text-white">Estado</label>
                    <select id="est_cat" disabled="true" style="cursor:not-allowed" class="form-control">
                        <option value="Activo">Activo</option>
                        <option value="Inactivo">Inactivo</option>
                    </select>
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

<script src="../Vista/JS/categoria.js"></script>

</body>
 
</html>