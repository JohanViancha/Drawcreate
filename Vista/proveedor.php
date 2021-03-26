<?php

    require_once 'menu.php';


?>
<?php
    
    require_once 'encabezado.php';

?>


<div class="container-fluid mb-5">

    <!-- Page Heading -->
    <h1 class="mb-4 text-gray-800"><b>Proveedores</b></h1>
    <h5 class="text-danger" id="ruta-nombre">Ventas / Cliente</h5>

    <hr class="sidebar-divider">

    <button class="float-right btn btn-danger btn-icon-split" id="btn-agregar">
        <span class="icon text-white-50">
            <i class="fas fa-plus-square"></i>
        </span>
        <span class="text">Agregar Proveedor</span>
    </button>
    <br>

    <span role="button" class="mt-4 text-dark h5" id="texto-filtro"><i class="fas fa-filter text-danger"></i> <a data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample"> Filtros</a></span>

    <div class="collapse mb-4 mt-2 show" id="collapseExample">
        <div class="card card-body" style="background:#434343">
        <form>
            <div class="form-row">
                <div class="form-group col-md-4">
                    <label for="fil_numdoc_prov" class="text-white">Numero Documento</label>
                    <input type="text" class="form-control" id="fil_numdoc_prov">
                </div>

                <div class="form-group col-md-4">
                    <label for="fil_nom_prov" class="text-white">Nombre</label>
                    <input type="text" class="form-control" id="fil_nom_prov">
                </div>

                <div class="form-group col-md-4">
                    <label for="fil_corele_prov" class="text-white">Correo Electronico</label>
                    <input type="text" class="form-control" id="fil_corele_prov">
                </div>
            </div>
            </form>
        </div>
    </div>


    <div class="col-xl-12 table-responsive tabla_proveedor p-0">
        <table class="table table-striped" style="width:100%" id="tb_prov">
            <thead>
                <tr style="background:#434343">
                <th class="text-white"> Opciones</th>
                <th class="text-white">Nombre</th>
                <th class="text-white">Tipo Documento</th>
                <th class="text-white">Numero Documento</th>
                <th class="text-white">Correo Electronico</th>
                <th class="text-white">Celular</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>


    <div class="card card-body mt-3" id="form-agregar" secuencia="0" hidden="true" style="background:#434343">
        <form>
            <div class="form-row">
                <div class="form-group col-12 col-sm-12 col-md-12 col-lg-6">
                    <label for="nom_prov" class="text-white">Nombre</label>
                    <input type="text" class="form-control" id="nom_prov">
                </div>
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-6">
                    <label for="numdoc_prov" class="text-white">NIT</label>
                    <input type="text" class="form-control" id="numdoc_prov">
                </div>
                
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-4">
                    <label for="corele_prov" class="text-white">Correo Electronico</label>
                    <input type="email" class="form-control" id="corele_prov" require>
                </div>
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-4">
                    <label for="cel_prov" class="text-white">Numero Contacto</label>
                    <input type="email" class="form-control" id="cel_prov">
                </div>
                <div class="form-group col-12 col-sm-12 col-md-6 col-lg-4">
                    <label for="dir_prov" class="text-white">Dirección</label>                 
                    <textarea type="text-area" class="form-control" rows="1" id="dir_prov"></textarea>
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

<script src="../Vista/JS/proveedor.js"></script>