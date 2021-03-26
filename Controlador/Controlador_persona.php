<?php
     
  require_once '../Modelo/Modelo_persona.php';
  

   $funcion = $_POST['funcion'];

   switch($funcion){
       case 'agregar_persona':
           $datos_persona = $_POST['datos_persona']; 
           $modelo_persona = new Modelo_persona();
           $resultado = $modelo_persona->agregar_persona($datos_persona);

            echo $resultado;
        break;

        case 'listar_personas':
          $tipo = $_POST['tipo']; 
          $modelo_persona = new Modelo_persona();
          $resultado = $modelo_persona->listar_personas($tipo);
          echo $resultado;
      break;

      case 'modificar_persona':
        $datos_persona = $_POST['datos_persona']; 
        $modelo_persona = new Modelo_persona();
        $resultado = $modelo_persona->modificar_persona($datos_persona);
        echo $resultado;
    break;

   }
  