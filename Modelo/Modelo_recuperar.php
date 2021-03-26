<?php


require_once '../Configuracion/conexion.php';

class Modelo_recuperar{


    function recuperar_password($correo,$password){

        try{
            
            $conexion = new conexion();
            $mbd = $conexion->conectar();
            //$pass = password_hash($password,PASSWORD_DEFAULT);

            $sentencia = $mbd->prepare("select * from recuperar_password(?,?)");
            $sentencia->bindParam(1,  $correo, PDO::PARAM_STR, 4000); 
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


}