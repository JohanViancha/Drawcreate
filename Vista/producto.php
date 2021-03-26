<?php
    
    require_once 'menu.php';
    require_once 'encabezado.php';
?>


<div class="container-fluid mb-5">

    <!-- Page Heading -->
    <h1 class="mb-4 text-gray-800"><b>Productos</b></h1>
    <h5 class="text-danger" id="ruta-nombre">Inventario / Producto</h5>

    <hr class="sidebar-divider">

    <button class="float-right btn btn-danger btn-icon-split" id="btn-agregar">
        <span class="icon text-white-50">
            <i class="fas fa-plus-square"></i>
        </span>
        <span class="text">Agregar Producto</span>
    </button>
    <br>

    <span role="button" class="mt-4 text-dark h5" id="texto-filtro"><i class="fas fa-filter text-danger"></i> <a data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample"> Filtros</a></span>

    <div class="collapse mb-4 mt-2 show" id="collapseExample">
        <div class="card card-body" style="background:#434343">
        <form>
            <div class="form-row">
            <div class="form-group col-12 col-sm-6 col-md-6 col-lg-5">
                    <label for="fil_cod_pro" class="text-white">Codigo</label>
                    <input type="text" class="form-control" id="fil_cod_pro">
                </div>
                <div class="form-group col-12 col-sm-6 col-md-6 col-lg-5">
                    <label for="fil_nom_pro" class="text-white">Nombre</label>
                    <input type="text" class="form-control" id="fil_nom_pro">
                </div>          
                <div class="form-group col-12 col-sm-12 col-md-12 col-lg-2">
                    <label for="fil_cat_pro" class="text-white">Categoria</label>
                    <select id="fil_cat_pro" class="form-control">
                        <option selected>Todos</option>
                    </select>
                </div>
            </div>
            </form>
        </div>
    </div>


    <div class="col-xl-12 table-responsive tabla_producto p-0">
        <table class="table table-striped" style="width:100%" id="tb_pro">
            <thead>
                <tr style="background:#434343">
                <th class="text-white" >#</th>
                <th class="text-white">Codigo</th>
                <th class="text-white">Nombre</th>
                <th class="text-white">Categoria</th>
                <th class="text-white">Precio</th>
                <th class="text-white">Stock</th>
                <th class="text-white">Iva</th>
                </tr>
            </thead>
            <tbody >
            </tbody>
        </table>
    </div>


    <div class="card card-body mt-3" id="form-agregar" hidden="true" style="background:#434343">
        <form>
            <div class="form-row">
            <div class="form-group col-4">
                    <label for="cod_pro" class="text-white">Codigo</label>
                    <input type="text" class="form-control" id="cod_pro">
                </div>
                <div class="form-group col-5">
                    <label for="nom_pro" class="text-white">Nombre</label>
                    <input type="text" class="form-control" id="nom_pro">
                </div>
                <div class="form-group col-3">
                    <label for="cat_pro" class="text-white">Categoria</label>
                    <select id="cat_pro" class="form-control">
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

<script src="../Vista/JS/producto.js"></script>