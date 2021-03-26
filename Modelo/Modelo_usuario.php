<?php


require_once '../Configuracion/conexion.php';

class Modelo_usuario {


    function listar_usuarios($estado){

        try{
            
            $conexion = new conexion();
            $mbd = $conexion->conectar();
      

            $sentencia = $mbd->prepare("select * from listar_usuarios(?)"); 
            $sentencia->bindParam(1,  $esado, PDO::PARAM_STR, 4000); 
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = $sentencia->fetchAll(PDO::FETCH_OBJ);

            }
    

        }catch(PDOException $Exception ){

            print_r('Error' . $Exception->getMessage);

        }
 
        return json_encode($resultado);
    }




    
    function cambiarestado_usuario($id_usu,$estado){

        $conexion = new conexion();

        $mbd = $conexion->conectar();

        $resultado = false;
        

        $sentencia = $mbd->prepare("select * from cambiarestado_usuario(?,?)");
        $sentencia->bindParam(1,  $id_usu, PDO::PARAM_INT, 4000); 
        $sentencia->bindParam(2,  $estado, PDO::PARAM_BOOL, 4000); 
  
        //Si se ejecuto
        if($sentencia->execute()){

            $resultado = true;
            
        }


        return  $resultado;




    }




    function agregar_usuario($datos_usuario){
        try{
            //$datos_usuario= array("0","af","fasf","afassffff","afsaf","Masculino","1234456","2","Cedula","fsasf");
            $password = password_hash($datos_usuario[6],PASSWORD_DEFAULT);

            $conexion = new conexion();

            $mbd = $conexion->conectar();

            $resultado = false;
            

            $sentencia = $mbd->prepare("select * from agregar_usuario(?,?,?,?,?,?,?,?,?)");
            $sentencia->bindParam(1,  $datos_usuario[1], PDO::PARAM_INT, 4000); 
            $sentencia->bindParam(2,  $datos_usuario[2], PDO::PARAM_STR, 4000); 
            $sentencia->bindParam(3,  $datos_usuario[3], PDO::PARAM_STR, 4000); 
            $sentencia->bindParam(4,  $datos_usuario[4], PDO::PARAM_STR, 4000); 
            $sentencia->bindParam(5,  $datos_usuario[5], PDO::PARAM_STR, 4000); 
            $sentencia->bindParam(6,  $password, PDO::PARAM_STR, 4000); 
            $sentencia->bindParam(7,  $datos_usuario[7], PDO::PARAM_INT, 4000); 
            $sentencia->bindParam(8,  $datos_usuario[8], PDO::PARAM_STR, 4000); 
            $sentencia->bindParam(9,  $datos_usuario[9], PDO::PARAM_STR, 4000); 
    
            //Si se ejecuto
            if($sentencia->execute()){

                $resultado = true;
                
            }

        }catch(PDOException $Exception ){
            print_r($Exception);
        }

        print_r($resultado);

  }





  function modificar_usuario($datos_usuario){
    try{
       
        $conexion = new conexion();

        $mbd = $conexion->conectar();

        $resultado = false;
        

        $sentencia = $mbd->prepare("select * from modificar_usuario(?,?,?,?,?,?,?,?,?)");
        $sentencia->bindParam(1,  $datos_usuario[0], PDO::PARAM_INT, 4000); 
        $sentencia->bindParam(2,  $datos_usuario[1], PDO::PARAM_INT, 4000); 
        $sentencia->bindParam(3,  $datos_usuario[2], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(4,  $datos_usuario[3], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(5,  $datos_usuario[4], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(6,  $datos_usuario[5], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(7,  $datos_usuario[7], PDO::PARAM_INT, 4000); 
        $sentencia->bindParam(8,  $datos_usuario[8], PDO::PARAM_STR, 4000); 
        $sentencia->bindParam(9,  $datos_usuario[9], PDO::PARAM_STR, 4000); 

        //Si se ejecuto
        if($sentencia->execute()){

            $resultado = true;
            
        }

    }catch(PDOException $Exception ){
        print_r($Exception);
    }

    print_r($resultado);

}


}