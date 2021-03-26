<?php

require_once '../Configuracion/conexion.php';

class Modelo_login {


    function iniciar_sesion($email,$password){

        try{
            
            $conexion = new conexion();
            $mbd = $conexion->conectar();
            $resultado = "";
            //$pass = password_hash($password,PASSWORD_DEFAULT);
            $sentencia = $mbd->prepare("select * from iniciar_sesion(?,?)");
            $sentencia->bindParam(1,  $email, PDO::PARAM_STR, 4000); 
            $sentencia->bindParam(2,  $password, PDO::PARAM_STR, 4000); 
      
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetchAll(PDO::FETCH_OBJ);

            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }

       
        return json_encode($resultado[0]);
    }


    function bloquear_usuario($email){

        try{
            
            $conexion = new conexion();
            $mbd = $conexion->conectar();


            $sentencia = $mbd->prepare("select * from bloquear_usuario(?)");
            $sentencia->bindParam(1,  $email, PDO::PARAM_STR, 4000); 
      
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetchAll(PDO::FETCH_OBJ);

            }

            else{

                $resultado = false;

            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }

        $conexion->desconectar();
        return json_encode($resultado[0]);
    }


}