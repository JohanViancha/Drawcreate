<?php

    require_once 'menu.php';


?>
<?php
    
    require_once 'encabezado.php';

?>


<div class="container-fluid mb-5">

    <!-- Page Heading -->
    <h1 class="mb-4 text-gray-800"><b>Compras</b></h1>
    <h5 class="text-danger" id="ruta-nombre">Compras / Compras</h5>

    <button class="float-right btn btn-danger btn-icon-split" id="btn-agregar">
        <span class="icon text-white-50">
            <i class="fas fa-plus-square"></i>
        </span>
        <span class="text">Agregar Compra</span>
    </button>
    <br>

    <span role="button" class="mt-4 text-dark h5" id="texto-filtro"><i class="fas fa-filter text-danger"></i> <a data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample"> Filtros</a></span>

    <div class="collapse mb-4 mt-2 show" id="collapseExample">
        <div class="card card-body" style="background:#434343">
        <form>
            <div class="form-row">
            <div class="form-group col-md-4">
                    <label for="fil_num_com" class="text-white">N° Compra</label>
                    <input type="text" class="form-control" id="fil_num_com">
                </div>
                <div class="form-group col-md-4">
                    <label for="fil_fecini_com" class="text-white">Fecha Inicial</label>
                    <input type="date" class="form-control" id="fil_fecini_com">
                </div>

                <div class="form-group col-md-4">
                    <label for="fil_fecfin_com" class="text-white">Fecha Final</label>
                    <input type="date" class="form-control" id="fil_fecfin_com">
                </div>
            </div>
            </form>
        </div>
    </div>


    <div class="col-xl-12 table-responsive tabla_compra">
        <table class="table table-striped" style="width:100%" id="tb_com">
            <thead>
                <tr style="background:#434343">
                <th class="text-white">Opciones</th>
                    <th class="text-white">N° Compra</th>
                    <th class="text-white">Fecha y Hora</th>
                    <th class="text-white">Total Venta</th>
                    <th class="text-white">Proveedor</th>
                    <th class="text-white">Usuario Registró</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>


    <div class="card card-body mt-3" id="form-agregar" hidden="true" style="background:#434343">
        <form>
            <div class="form-row">
            <div class="form-group col-6">
                <label for="prov_com" class="text-white">Proveedor</label>
                <select id="prov_com" class="form-control">
                </select>
            </div>
           
            <div class="form-group col-12">
            <hr class="sidebar-divider col-12 pr-0 bg-white">
            <span class="text-white" id="text-productos">Agregar Productos</span>
            </div>

            <div class="form-group col-6 ag_pro">
                <label for="pro_com" class="text-white">Producto</label>
                <select id="pro_com" class="form-control">
                </select>
            </div>

            <div class="form-group col-2 ag_pro">
                <label for="prepro_com_com" class="text-white">Precio $</label>
                <input id="prepro_com" type ="number"  class="form-control">
            </div>

            <div class="form-group col-2 ag_pro">
                <label for="prepro_com_com" class="text-white">Iva %</label>
                <input id="ivapro_com" type ="number"  class="form-control">
            </div>

            <div class="form-group col-2 ag_pro">
                <label for="canpro_com" class="text-white">Cantidad</label>
                <input type="number" class="form-control" id="canpro_com">
            </div>

            <div class="form-group col-2 text-center ag_pro">
                <button class="btn btn-danger btn-icon-split" id="btn-agregar-producto">
                    <span class="icon text-white-50">
                        <i class="fas fa-check"></i>
                    </span>
                    <span class="text">Agregar</span>
                </button>
             </div>


            <div class="col-xl-12 table-responsive tabla_productocompra p-0">
        <table class="table table-striped bg-white p-0" style="width:100%" id="tbpro_com">
            <thead>
                <tr style="background:#434343">
                <th class="text-white" >Opcion</th>
                <th class="text-white">Producto</th>
                <th class="text-white">Cantidad</th>
                <th class="text-white">Precio</th>
                <th class="text-white">Iva</th>
                <th class="text-white">Subtotal</th>
                <th class="text-white">Total</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <div class="col-xl-12 table-responsive p-0">
        <table class="table table-striped bg-white" style="width:100%" id="tbpro_commos">
            <thead>
                <tr style="background:#434343">
                <th class="text-white">Producto</th>
                <th class="text-white">Cantidad</th>
                <th class="text-white">Precio</th>
                <th class="text-white">Iva</th>
                <th class="text-white">Subtotal</th>
                <th class="text-white">Total</th>
                </tr>
            </thead>
            <tbody>


            </tbody>
        </table>
    </div>

    <div class="form-group col-md-12 mt-3 ">
                 <span class ="h5 text-white text ml-3 float-right" id="total_pagar"><strong> 0</strong></span>
                   <span class ="h5 text-white text float-right"> Total a pagar &nbsp $</span>
                    
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

<script src="../Vista/JS/compra.js"></script>