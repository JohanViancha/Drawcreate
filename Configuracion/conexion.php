<?php


require_once 'variable_conexion.php';




class Conexion{




   function conectar(){

        try {
            $mbd = new PDO(MOTOR_BD.':host='.SERVIDOR.';dbname='.NOMBRE_BD, USUARIO_BD, CLAVE_BD);
            
        } catch (PDOException $e) {
            print "¡Error!: " . $e->getMessage() . "<br/>";
        }

        return $mbd;

   }

   function desconectar($mbd){
         $mbd = null;
   }



}