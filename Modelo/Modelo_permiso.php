<?php


require_once '../Configuracion/conexion.php';

class Modelo_permiso {


    function listar_permisos(){

        try{
            $conexion = new conexion();
            $mbd = $conexion->conectar();

            $sentencia = $mbd->prepare("select * from listar_permisos()");
          
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