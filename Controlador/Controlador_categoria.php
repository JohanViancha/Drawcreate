<?php

    require_once '../Modelo/Modelo_categoria.php';
  

   $funcion = $_POST['funcion'];

 
   switch($funcion){
       case 'listar_categorias':
            $modelo_categoria = new Modelo_categoria();
            $estado = $_POST['estado'];
            $resultado = $modelo_categoria->listar_categorias($estado);
            echo $resultado;
        break;


        case 'cambiarestado_categoria':

            $id_cat = $_POST['id_cat'];
            $estado = $_POST['estado'];
            $modelo_categoria = new Modelo_categoria();

            $resultado = $modelo_categoria->cambiarestado_categoria($id_cat,$estado);

            echo $resultado;
        break;


        case 'modificar_categoria':

            $id_cat = $_POST['id_cat'];
            $nombre = $_POST['nombre'];
            $descripcion = $_POST['descripcion'];

            $modelo_categoria = new Modelo_categoria();

            $resultado = $modelo_categoria->modificar_categoria($id_cat,$nombre,$descripcion);

            echo $resultado;
        break;


        case 'agregar_categoria':

            $nombre = $_POST['nombre'];
            $descripcion = $_POST['descripcion'];

            $modelo_categoria = new Modelo_categoria();

            $resultado = $modelo_categoria->agregar_categoria($nombre,$descripcion);

            echo $resultado;
        break;

   }
  