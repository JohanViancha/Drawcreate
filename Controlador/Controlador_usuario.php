<?php
     
  require_once '../Modelo/Modelo_usuario.php';
  

   $funcion = $_POST['funcion'];

   switch($funcion){

        case 'listar_usuarios':
          $estado = $_POST['estado']; 
          $modelo_usuario = new Modelo_usuario();
          $resultado = $modelo_usuario->listar_usuarios($estado);
          echo $resultado;
      break;

      case 'agregar_usuario':
        $datos_usuario = $_POST['datos_usuario']; 
        $modelo_usuario = new Modelo_usuario();
        $resultado = $modelo_usuario->agregar_usuario($datos_usuario);
        echo $resultado;
    break;

    case 'modificar_usuario':
      $datos_usuario = $_POST['datos_usuario']; 
      $modelo_usuario = new Modelo_usuario();
      $resultado = $modelo_usuario->modificar_usuario($datos_usuario);
      echo $resultado;
  break;

  case 'cambiarestado_usuario':

    $id_usu = $_POST['id_usu'];
    $estado = $_POST['estado'];
    $modelo_usuario = new Modelo_usuario();

    $resultado = $modelo_usuario->cambiarestado_usuario($id_usu,$estado);

    echo $resultado;
break;

   }
  