<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
require '../vendor/PHPMailer/src/Exception.php';
require '../vendor/PHPMailer/src/PHPMailer.php';
require '../vendor/PHPMailer/src/SMTP.php';

require_once '../Modelo/Modelo_correo.php';

class Controlador_correo {

    function enviar_correo($corr_receptor,$nom_receptor,$cod_men,$opciones){
        $resultado_envio = false;
        // Instantiation and passing `true` enables exceptions
        $mail = new PHPMailer(true);

        try {


            $modelo_correo = new Modelo_correo();
            $resultado = $modelo_correo->buscar_menconf($cod_men);

            $datos_correo = json_decode($resultado,true);

            //Server settings
            $mail->SMTPDebug = 0;                      // Enable verbose debug output
            $mail->isSMTP();                                            // Send using SMTP
            $mail->Host       = $datos_correo['host'];                    // Set the SMTP server to send through
            $mail->SMTPAuth   = true;                                   // Enable SMTP authentication
            $mail->Username   =$datos_correo['corr_emisor'];                     // SMTP username
            $mail->Password   = 'Asdqwe047*342';                               // SMTP password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;        // Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
            $mail->Port       = $datos_correo['puerto'];;                                    // TCP port to connect to, use 465 for `PHPMailer::ENCRYPTION_SMTPS` above

            //Recipients
            $mail->setFrom($datos_correo['corr_emisor'], $datos_correo['nom_emisor']);
            $mail->addAddress($corr_receptor,$nom_receptor);     // Add a recipient
            /*$mail->addAddress('ellen@example.com');               // Name is optional
            $mail->addReplyTo('info@example.com', 'Information');
            $mail->addCC('cc@example.com');
            $mail->addBCC('bcc@example.com');*/

            // Attachments
            /*$mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
            $mail->addAttachment('/tmp/image.jpg', 'new.jpg');*/    // Optional name

            // Content
            $mail->isHTML(true);                                  // Set email format to HTML
            $mail->Subject =$datos_correo['asunto'];
            $mail->Body    = $datos_correo['mensaje'] . $opciones['clave'];

            $mail->send();
            $resultado_envio = true;
        } catch (Exception $e) {
            echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
            $resultado_envio = false;
        }

        return $resultado_envio;
    }
}