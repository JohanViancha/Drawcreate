<?php


require_once '../Configuracion/conexion.php';

class Modelo_venta {


    function listar_ventas(){

        try{
            $conexion = new conexion();
            $mbd = $conexion->conectar();

            $sentencia = $mbd->prepare("select * from listar_ventas()");
      
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetchAll(PDO::FETCH_OBJ);

            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }

       
        return json_encode($resultado);
    }



    function mostrar_detalleventa($id){

        try{
            $conexion = new conexion();
            $mbd = $conexion->conectar();

            $sentencia = $mbd->prepare("select * from mostrar_detalleventa(?)");
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



    function agregar_venta($total,$cliente,$usuario,$detalle,$id_producto){

        try{
            $conexion = new conexion();
            $mbd = $conexion->conectar();
            $resultado = "";
            $sentencia = $mbd->prepare("select * from agregar_venta(?,?,?)");
            $sentencia->bindParam(1,  $total);
            $sentencia->bindParam(2,  $cliente);
            $sentencia->bindParam(3,  $usuario);
      
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetch()['agregar_venta'];
                foreach ($detalle as $key => $value) {

                    $sentencia_detalle = $mbd->prepare("select * from agregar_detalleventa(?,?,?,?)");
                    $sentencia_detalle->bindParam(1,  $resultado); 
                    $sentencia_detalle->bindParam(2,  $id_producto[$key]);
                    $sentencia_detalle->bindParam(3,  $detalle[$key][5]);
                    $sentencia_detalle->bindParam(4,  $detalle[$key][2]);
                    $sentencia_detalle->execute();
                }

               
              
            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }

       
        return json_encode($resultado);
    }



    
    function cambiarestado_venta($id_ven,$estado){

        $conexion = new conexion();

        $mbd = $conexion->conectar();

        $resultado = false;
        

        $sentencia = $mbd->prepare("select * from cambiarestado_venta(?,?)");
        $sentencia->bindParam(1,  $id_ven, PDO::PARAM_INT, 4000); 
        $sentencia->bindParam(2,  $estado); 
  
        //Si se ejecuto
        if($sentencia->execute()){

            $resultado = true;
            
        }

        return  $resultado;

    }




}