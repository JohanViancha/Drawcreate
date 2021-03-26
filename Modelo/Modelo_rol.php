<?php


require_once '../Configuracion/conexion.php';

class Modelo_rol {


    function listar_roles($estado){

        try{
            $conexion = new conexion();
            $mbd = $conexion->conectar();

            $sentencia = $mbd->prepare("select * from listar_roles(?)");
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


    function modificar_rol($ide, $nombre, $permisos){

        try{
            $conexion = new conexion();
            $mbd = $conexion->conectar();
            $resultado = "";

            $sentencia = $mbd->prepare("select * from modificar_rol(?,?)");
            $sentencia->bindParam(1,  $ide, PDO::PARAM_INT, 4000);
            $sentencia->bindParam(2,  $nombre, PDO::PARAM_STR, 4000);

            //Si se ejecuto
            if($sentencia->execute()){

                foreach ($permisos as $key => $value) {

                    $sentencia_detalle = $mbd->prepare("select * from agregar_detallerol(?,?)");
                    $sentencia_detalle->bindParam(1, $ide); 
                    $sentencia_detalle->bindParam(2,  $permisos[$key]);
                    if($sentencia_detalle->execute()){
                        $resultado = "Ejecuto";
                    }
                }


            }


        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }


        return $resultado;
   }



    /*function mostrar_rol($id){

        try{
            $conexion = new conexion();
            $mbd = $conexion->conectar();

            $sentencia = $mbd->prepare("select * from mostrar_rol(?)");
            $sentencia->bindParam(1,  $id, PDO::PARAM_INT, 4000);
      
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetchAll(PDO::FETCH_OBJ);

            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }

       
        return json_encode($resultado);
    }*/

}