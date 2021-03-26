<?php


require_once '../Configuracion/conexion.php';

class Modelo_persona {

    function agregar_persona($datos_persona){

        $conexion = new conexion();

        $mbd = $conexion->conectar();

        $resultado = false;
        

        $sentencia = $mbd->prepare("select * from agregar_persona(?,?,?,?,?,?,?,?)");
        $sentencia->bindParam(1,  $datos_persona[1], PDO::PARAM_INT, 4000); 
        $sentencia->bindParam(2,  $datos_persona[2], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(3,  $datos_persona[3], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(4,  $datos_persona[4], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(5,  $datos_persona[5], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(6,  $datos_persona[6], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(7,  $datos_persona[7], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(8,  $datos_persona[8], PDO::PARAM_STR, 4000); 
  
        //Si se ejecuto
        if($sentencia->execute()){

            $resultado = true;
            
        }

        return  $resultado;

    }

    function modificar_persona($datos_persona){

        $conexion = new conexion();

        $mbd = $conexion->conectar();

        $resultado = false;
        

        $sentencia = $mbd->prepare("CALL modificar_persona(?,?,?,?,?,?,?,?)");
        $sentencia->bindParam(1,  $datos_persona[0], PDO::PARAM_INT, 4000); 
        $sentencia->bindParam(2,  $datos_persona[1], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(3,  $datos_persona[2], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(4,  $datos_persona[3], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(5,  $datos_persona[5], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(6,  $datos_persona[6], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(7,  $datos_persona[7], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(8,  $datos_persona[8], PDO::PARAM_STR, 4000); 
  
        //Si se ejecuto
        if($sentencia->execute()){

            $resultado = true;
            
        }

        return  $resultado;


    
    }



    function listar_personas($tipo){

        try{
            
            $conexion = new conexion();
            $mbd = $conexion->conectar();
      

            $sentencia = $mbd->prepare("select * from listar_personas(?)"); 
            $sentencia->bindParam(1,  $tipo, PDO::PARAM_STR, 4000); 
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetchAll(PDO::FETCH_OBJ);

            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }
 
        return json_encode($resultado);
    }

}