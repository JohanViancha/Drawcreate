<?php


require_once '../Configuracion/conexion.php';

class Modelo_compra {


    function listar_compras(){

        try{
            $conexion = new conexion();
            $mbd = $conexion->conectar();

            $sentencia = $mbd->prepare("select * from listar_compras()");
      
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetchAll(PDO::FETCH_OBJ);

            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }

       
        return json_encode($resultado);
    }



    function mostrar_detallecompra($id){

        try{
            $conexion = new conexion();
            $mbd = $conexion->conectar();

            $sentencia = $mbd->prepare("select * from mostrar_detallecompra(?)");
            $sentencia->bindParam(1,  $id);
      
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetchAll(PDO::FETCH_OBJ);

            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }

       
        return json_encode($resultado);
    }




    function agregar_compra($total,$proveedor,$usuario,$detalle,$id_producto){

        try{
            $conexion = new conexion();
            $mbd = $conexion->conectar();
            $resultado = "";
            $sentencia = $mbd->prepare("select * from agregar_compra(?,?,?)");
            $sentencia->bindParam(1,  $total);
            $sentencia->bindParam(2,  $proveedor);
            $sentencia->bindParam(3,  $usuario);
      
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetch()['agregar_compra'];
                foreach ($detalle as $key => $value) {

                    $sentencia_detalle = $mbd->prepare("select * from agregar_detallecompra(?,?,?,?,?)");
                    $sentencia_detalle->bindParam(1,  $resultado); 
                    $sentencia_detalle->bindParam(2,  $id_producto[$key]);
                    $sentencia_detalle->bindParam(3,  $detalle[$key][5]);
                    $sentencia_detalle->bindParam(4,  $detalle[$key][2]);
                    $sentencia_detalle->bindParam(5,  $detalle[$key][3]);
                    $sentencia_detalle->execute();
                }

               
              
            }else{

                $resultado = "No entro";
            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }

       
        return json_encode($resultado);
    }



}