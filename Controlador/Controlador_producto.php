<?php

    require_once '../Modelo/Modelo_producto.php';
  

   $funcion = $_POST['funcion'];

 
   switch($funcion){
       case 'listar_productos':
            $modelo_producto = new Modelo_producto();
            $estado = $_POST['estado'];
            $resultado = $modelo_producto->listar_productos($estado);
            echo $resultado;
        break;

        case 'agregar_producto':
            $modelo_producto = new Modelo_producto();
            $categoria = $_POST['categoria'];
            $nombre = $_POST['nombre'];
            $codigo = $_POST['codigo'];
            $resultado = $modelo_producto->agregar_producto($codigo,$nombre,$categoria);

            echo $resultado;
        break;



    

   }
  