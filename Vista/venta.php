<?php

    require_once 'menu.php';


?>
<?php
    
    require_once 'encabezado.php';

?>


<div class="container-fluid mb-5">

    <!-- Page Heading -->
    <h1 class="mb-4 text-gray-800"><b>Ventas</b></h1>
    <h5 class="text-danger" id="ruta-nombre">Venta / Ventas</h5>

    <button class="float-right btn btn-danger btn-icon-split" id="btn-agregar">
        <span class="icon text-white-50">
            <i class="fas fa-plus-square"></i>
        </span>
        <span class="text">Agregar Venta</span>
    </button>
    <br>

    <span role="button" class="mt-4 text-dark h5" id="texto-filtro"><i class="fas fa-filter text-danger"></i> <a data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample"> Filtros</a></span>

    <div class="collapse mb-4 mt-2 show" id="collapseExample">
        <div class="card card-body" style="background:#434343">
        <form>
            <div class="form-row">
            <div class="form-group col-md-4">
                    <label for="fil_num_ven" class="text-white">N° Venta</label>
                    <input type="text" class="form-control" id="fil_num_ven">
                </div>
                <div class="form-group col-md-3">
                    <label for="fil_fecini_ven" class="text-white">Fecha Inicial</label>
                    <input type="date" class="form-control" id="fil_fecini_ven">
                </div>

                <div class="form-group col-md-3">
                    <label for="fil_fecfin_ven" class="text-white">Fecha Final</label>
                    <input type="date" class="form-control" id="fil_fecfin_ven">
                </div>

                <div class="form-group col-md-2">
                    <label for="fil_est_ven" class="text-white">Estado</label>
                    <select id="fil_est_ven" class="form-control">
                        <option value="Todos" selected>Todos</option>
                        <option value="D">Digitada</option>
                        <option value="A">Anulada</option>
                        <option value="P">Pagada</option>
                        <option value="F">Facturada</option>
                    </select>
                </div>
            </div>
            </form>
        </div>
    </div>


    <div class="col-xl-12 table-responsive tabla_venta">
        <table class="table table-striped" style="width:100%" id="tb_ven">
            <thead>
                <tr style="background:#434343">
                <th class="text-white" >Opciones</th>
                <th class="text-white">N° Venta</th>
                <th class="text-white">Fecha y Hora</th>
                <th class="text-white">Total Venta</th>
                <th class="text-white">Cliente</th>
                <th class="text-white">Usuario Registró</th>
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
            <div class="form-group col-6">
                <label for="cli_ven" class="text-white">Cliente</label>
                <select id="cli_ven" class="form-control">
                </select>
            </div>

            <div class="form-group col-6" id="fc-ven" hidden>
                <label for="fec_ven" class="text-white">Fecha</label>
                <input type"text" id="fec_ven" class="form-control">
            </div>
           
            <div class="form-group col-12">
            <hr class="sidebar-divider col-12 pr-0 bg-white">
            <span class="text-white" id="text-productos">Agregar Productos</span>
            </div>
        
            <div class="form-group col-6 ag_pro">
                <label for="pro_ven" class="text-white">Producto</label>
                <select id="pro_ven" class="form-control">
                </select>
            </div>

            <div class="form-group col-2 ag_pro">
                <label for="sto_ven" class="text-white">Stock</label>
                <input id="sto_ven" type ="number" readonly style="cursor:not-allowed;" class="form-control">
            </div>

            <div class="form-group col-2 ag_pro">
                <label for="canpro_ven" class="text-white">Cantidad</label>
                <input type="number" class="form-control" id="canpro_ven">
            </div>

            <div class="form-group col-2 text-center ag_pro">
                <button class="mt-3 btn btn-danger ml-2 btn-icon-split" id="btn-agregar-producto">
                    <span class="icon text-white-50">
                        <i class="fas fa-check"></i>
                    </span>
                    <span class="text">Agregar</span>
                </button>
             </div>

        <div class="col-xl-12 table-responsive tabla_productoventa p-0">
        <table class="table table-striped bg-white" style="width:100%" id="tbpro_ven">
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
        <table class="table table-striped bg-white" style="width:100%" id="tbpro_venmos">
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

    <button class="mt-3 float-left btn btn-danger btn-icon-split" accion="" id="btn-guardar">
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

<script src="../Vista/JS/venta.js"></script>