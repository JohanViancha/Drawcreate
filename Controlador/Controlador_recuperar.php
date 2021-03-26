<?php
     
  require_once '../Modelo/Modelo_recuperar.php';
  require_once '../Controlador/Controlador_correo.php';
  

   $funcion = $_POST['funcion'];

   switch($funcion){

        case 'recuperar_password':
          $modelo_recuperar = new Modelo_recuperar();
          $correo =  $_POST['correo']; 
          $password =  $_POST['password'];
          
          $resultado = $modelo_recuperar->recuperar_password($correo,$password);
          $nom_usu = json_decode($resultado,true);
          $resultado_correo = false;

        if($resultado != "[]"){
            $controlador_correo = new Controlador_correo();     
            $opciones = array('clave' => $password);
            $resultado_correo = $controlador_correo->enviar_correo($correo, $nom_usu['usuario'],"MEN_REC",$opciones);
            if($resultado_correo){

                $resultado = 1;
            }
            else{
                $resultado = 2;  
            }
          }

          echo $resultado;
      break;



   }
  