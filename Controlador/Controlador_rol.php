<?php
     
  require_once '../Modelo/Modelo_rol.php';
  

   $funcion = $_POST['funcion'];

   switch($funcion){

        case 'listar_roles':
          $modelo_rol = new Modelo_rol();
          $estado = $_POST['estado'];
          $resultado = $modelo_rol->listar_roles($estado);
          echo $resultado;
      break;

      case 'modificar_rol':
        $modelo_rol = new Modelo_rol();
        $ide = $_POST['ide'];
        $nombre = $_POST['nombre'];
        $permisos = $_POST['permisos'];
        $resultado = $modelo_rol->modificar_rol($ide,$nombre,$permisos);
        echo gettype ($permisos);
    break;


   }
  