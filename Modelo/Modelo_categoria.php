<?php


require_once '../Configuracion/conexion.php';

class Modelo_categoria {


    function listar_categorias($estado){

        try{
            
            $conexion = new conexion();
            $mbd = $conexion->conectar();
      

            $sentencia = $mbd->prepare("select * from listar_categorias(?)");
            $sentencia->bindParam(1,  $estado, PDO::PARAM_INT, 4000); 
      
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetchAll(PDO::FETCH_OBJ);

            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }

       
        return json_encode($resultado);
    }




    function cambiarestado_categoria($id_cat,$estado){

        $conexion = new conexion();

        $mbd = $conexion->conectar();

        $resultado = false;
        

        $sentencia = $mbd->prepare("select * from cambiarestado_categoria(?,?)");
        $sentencia->bindParam(1,  $id_cat, PDO::PARAM_INT, 4000); 
        $sentencia->bindParam(2,  $estado, PDO::PARAM_BOOL, 4000); 
  
        //Si se ejecuto
        if($sentencia->execute()){

            $resultado = true;
            
        }


        return  $resultado;




    }



    function modificar_categoria($id_cat,$nombre,$descripcion){

        $conexion = new conexion();

        $mbd = $conexion->conectar();

        $resultado = false;
        

        $sentencia = $mbd->prepare("select * from modificar_categoria(?,?,?)");
        $sentencia->bindParam(1,  $id_cat, PDO::PARAM_INT, 4000); 
        $sentencia->bindParam(2,  $nombre, PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(3,  $descripcion, PDO::PARAM_STR, 4000); 
  
        //Si se ejecuto
        if($sentencia->execute()){

            $resultado = true;
            
        }

        return  $resultado;




    }


    function agregar_categoria($nombre,$descripcion){

        $conexion = new conexion();

        $mbd = $conexion->conectar();

        $resultado = false;
        

        $sentencia = $mbd->prepare("select * from agregar_categoria(?,?)");
        $sentencia->bindParam(1,  $nombre, PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(2,  $descripcion, PDO::PARAM_STR, 4000); 
  
        //Si se ejecuto
        if($sentencia->execute()){

            $resultado = true;
            
        }

        return  $resultado;


    }
}