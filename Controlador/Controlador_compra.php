<?php
     
  require_once '../Modelo/Modelo_compra.php';
  

   $funcion = $_POST['funcion'];

   switch($funcion){

        case 'listar_compras':
          $modelo_compra = new Modelo_compra();
          $resultado = $modelo_compra->listar_compras();
          echo $resultado;
      break;

      case 'agregar_compra':
        session_start();
        $modelo_compra = new Modelo_compra();
        $total = $_POST["total"];
        $proveedor = $_POST["proveedor"];
        $detalle = $_POST["detalle"];
        $id_producto = $_POST["id_producto"];
        $resultado = $modelo_compra->agregar_compra($total,$proveedor,$_SESSION["id_usuario"],$detalle,$id_producto);
        echo $resultado;
    break;
    

    case 'mostrar_detallecompra':
      session_start();
      $modelo_compra = new Modelo_compra();
      $ide = $_POST["ide"];
      $resultado = $modelo_compra->mostrar_detallecompra($ide);
      echo $resultado;
  break;



   }
  