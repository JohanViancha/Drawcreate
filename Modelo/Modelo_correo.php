<?php


require_once '../Configuracion/conexion.php';

class Modelo_correo{


    function buscar_menconf($codigo){

        try{
            
            $conexion = new conexion();
            $mbd = $conexion->conectar();
      

            $sentencia = $mbd->prepare("select * from buscar_menconf(?)");
            $sentencia->bindParam(1,  $codigo, PDO::PARAM_INT, 4000); 
      
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetchAll(PDO::FETCH_OBJ);

            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }

       
        return json_encode($resultado[0]);
    }


}