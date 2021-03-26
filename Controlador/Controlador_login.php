<?php
     
    require_once '../Modelo/Modelo_login.php';
  

   $funcion = $_POST['funcion'];

 
   switch($funcion){
       case 'iniciar_sesion':
            $email = $_POST['email']; 
            $password = $_POST['password']; 

            $modelo_login = new Modelo_login();

            $resultado = $modelo_login->iniciar_sesion($email,$password);

            $datos_usuarios = json_decode($resultado,true);


           session_start();
            $_SESSION["id_usuario"] = $datos_usuarios['id_usuario'];
            $_SESSION["nombre"] =$datos_usuarios['nombre'];
            $_SESSION["apellido"] = $datos_usuarios['apellido'];
            $_SESSION["correo"] = $datos_usuarios['correo'];
            $_SESSION["documento"] = $datos_usuarios['documento'];
            $_SESSION["rol"] = $datos_usuarios['rol'];
            $_SESSION["fecha_registro"] = $datos_usuarios['fecha_registro'];
            $_SESSION["tipo_documento"] = $datos_usuarios['tipo_documento'];
            $_SESSION["genero"] = $datos_usuarios['genero'];
            $_SESSION["celular"] = $datos_usuarios['celular'];
            

            echo $resultado;
        break;

        case 'bloquear_usuario':
            $email = $_POST['email']; 

            $modelo_login = new Modelo_login();

            echo  $modelo_login->bloquear_usuario($email);

        break;

        case 'cerrar_sesion':
            session_destroy();
        break;
   }
  