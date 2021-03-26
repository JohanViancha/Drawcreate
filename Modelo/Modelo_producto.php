<?php


require_once '../Configuracion/conexion.php';

class Modelo_producto {


    function listar_productos($estado){

        try{
            $conexion = new conexion();
            $mbd = $conexion->conectar();

            $sentencia = $mbd->prepare("select * from listar_productos(?)");
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


    function agregar_producto($codigo,$nombre,$categoria){

        $conexion = new conexion();

        $mbd = $conexion->conectar();

        $resultado = false;
        

        $sentencia = $mbd->prepare("select * from agregar_producto(?,?,?)");
        $sentencia->bindParam(1,  $codigo, PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(2,  $nombre, PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(3,  $categoria, PDO::PARAM_INT, 4000); 
  
        //Si se ejecuto
        if($sentencia->execute()){

            $resultado = true;
            
        }

        return  $resultado;




    }

}