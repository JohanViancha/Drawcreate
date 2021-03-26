<?php session_start(); ?>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>DRAWCREATE</title>

    <!-- Custom fonts for this template-->
    <link href="../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link rel="stylesheet" href="../vendor/datatable/datatables.css">

    <!-- Custom styles for this template-->
    <link href="../css/sb-admin-2.css" rel="stylesheet">
    <link href="../vendor/hint/hint.css" rel="stylesheet">
   
</head>

<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar" style="background:#434343">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                <div class="sidebar-brand-icon">
                <img class="rounded-circle" style="width: 100%" src="../img/logo.png">
                </div>
                <div class="sidebar-brand-text mx-3">DRAWCREATE</div>
            </a>
            

            <!-- Divider -->

            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
           
        
            <!-- Divider -->
            <hr class="sidebar-divider">
            <div class="sidebar-heading">
                Movimientos
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-boxes text-danger"></i>
                    <span>Inventario</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item text-800" href="categoria.php"><i class="fas fa-layer-group text-danger"></i> Categorias</a>
                        <a class="collapse-item" href="producto.php"><i class="fas fa-box-open text-danger"></i></i> Productos</a>
                    </div>
                </div>
            </li>

            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseThree" aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-money-bill text-danger"></i>
                    <span>Ventas</span>
                </a>
                <div id="collapseThree" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="venta.php"><i class="fas fa-cart-arrow-down text-danger"></i> Ventas</a>
                        <a class="collapse-item" href="cliente.php"><i class="fas fa-user-tie text-danger"></i> Clientes</a>
                    </div>
                </div>
            </li>


            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseFour" aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-shopping-basket text-danger"></i>
                    <span>Compras</span>
                </a>
                <div id="collapseFour" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="compra.php"><i class="fas fa-piggy-bank text-danger"></i></i> Compras</a>
                        <a class="collapse-item" href="proveedor.php"><i class="fas fa-truck-loading text-danger"></i> Proveedores</a>
                    </div>
                </div>
            </li>

          
            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <div class="sidebar-heading">
                Seguridad
            </div>

            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseFive" aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-shield-alt text-danger"></i>
                    <span>Sessión</span>
                </a>
                <div id="collapseFive" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="usuario.php"> <i class="fas fa-users text-danger"></i></i> Usuarios</a>
                        <a class="collapse-item" href="rol.php"><i class="fas fa-id-badge text-danger"></i> Roles</a>
                        <a class="collapse-item" href="permiso.php"><i class="fas fa-fw fa-list text-danger"></i> Permisos</a>
                    </div>
                </div>

            </li>

            
        

     



            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">