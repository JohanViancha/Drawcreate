<?php
     
  require_once '../Modelo/Modelo_permiso.php';
  

   $funcion = $_POST['funcion'];

   switch($funcion){

        case 'listar_permisos':
          $modelo_permiso = new Modelo_permiso();
          $resultado = $modelo_permiso->listar_permisos();
          echo $resultado;
      break;

   }
  