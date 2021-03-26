<?php

    require_once 'menu.php';


?>
<?php
    
    require_once 'encabezado.php';

?>


<div class="container-fluid mb-5">

    <!-- Page Heading -->
    <h1 class="mb-4 text-gray-800"><b>Permisos</b></h1>
    <h5 class="text-danger" id="ruta-nombre">Sesion / Permisos </h5>

    <br>

    <div class="col-xl-12 table-responsive tabla_permiso p-0">
        <table class="table table-striped" style="width:100%" id="tb_perm">
            <thead>
                <tr style="background:#434343">
                <th class="text-white" >#</th>
                <th class="text-white">Nombre</th>
                <th class="text-white">Descripción</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

</div>
<br>


<?php
    require_once 'pie.php'
?>

<script src="../Vista/JS/permiso.js"></script>

</body>
 
</html>