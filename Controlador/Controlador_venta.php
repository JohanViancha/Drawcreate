<?php
     
  require_once '../Modelo/Modelo_venta.php';
  

   $funcion = $_POST['funcion'];

   switch($funcion){

        case 'listar_ventas':
          $modelo_venta = new Modelo_venta();
          $resultado = $modelo_venta->listar_ventas();
          echo $resultado;
      break;

      

       case 'agregar_venta':
          session_start();
          $modelo_venta = new Modelo_venta();
          $total = $_POST["total"];
          $cliente = $_POST["cliente"];
          $detalle = $_POST["detalle"];
          $id_producto = $_POST["id_producto"];
          $resultado = $modelo_venta->agregar_venta($total,$cliente,$_SESSION["id_usuario"],$detalle,$id_producto);
          echo $resultado;
      break;

      case 'cambiarestado_venta':

        $id_ven = $_POST['id_ven'];
        $estado = $_POST['estado'];
        $modelo_venta = new Modelo_venta();
        $resultado = $modelo_venta->cambiarestado_venta($id_ven,$estado);

        echo $resultado;
    break;


    case 'mostrar_detalleventa':

      $id= $_POST['ide'];
      $modelo_venta = new Modelo_venta();
      $resultado = $modelo_venta->mostrar_detalleventa($id);

      echo $resultado;
  break;



   }
  