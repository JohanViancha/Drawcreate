$(document).ready(function() {


    $('#btningresar').click(function(e) {
        e.preventDefault();

        iniciar_session();

    });

    $("#button-addon2").mousedown(function() {


        $("#password").attr("type", "text");

    });


    $("#button-addon2").mouseup(function() {



        $("#password").attr("type", "password");

    });

    function iniciar_session() {

        var email = $("#email").val();
        var password = $("#password").val();

        if (email == '' || password == '') {
            Swal.fire({
                position: 'center',
                icon: 'warning',
                title: 'Por favor ingrese todos los datos',
                text: 'El campo de contraseña y/o usuario están vacios',
                timer: 5000
            });
        } else {
            $.ajax({
                type: "POST",
                url: "Controlador/Controlador_login.php",
                data: { funcion: 'iniciar_sesion', email: email, password: password },
                dataType: "json",
                success: function(response) {
                    if (response['id_usuario'] < 0) {

                        Swal.fire({
                            position: 'center',
                            icon: 'warning',
                            title: response['nombre'],
                            text: response['apellido'],
                            timer: 5000
                        });



                        if (response['id_usuario'] == -3) {


                            if (localStorage.getItem(email) != null) {
                                localStorage.setItem(email, parseInt(localStorage.getItem(email)) + 1);

                                if (localStorage.getItem(email) == 5) {

                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: response['nombre'],
                                        text: 'El usuario podría ser bloqueado por exceder intentos fallidos, solo tiene dos intentos más',
                                        timer: 5000
                                    });
                                } else if (localStorage.getItem(email) == 7) {

                                    setTimeout(function() { bloquear_usuario(email); }, 3000);


                                }
                            } else {

                                localStorage.setItem(email, 1);
                            }



                        }


                    } else {

                        localStorage.clear();
                        window.location.href = 'Vista/micuenta.php';
                    }
                },
                error: function(response) {

                    console.log(response);
                }
            });
        }


    }


    function bloquear_usuario(email) {


        $.ajax({
            type: "POST",
            url: "Controlador/Controlador_login.php",
            data: { funcion: 'bloquear_usuario', email: email },
            dataType: "json",
            success: function(response) {

                if (response['bloquear_usuario'] == true) {
                    Swal.fire({
                        position: 'center',
                        icon: 'error',
                        title: 'Por seguridad el usuario ' + email + ' ha sido bloqueado',
                        text: 'Por favor comuniquese con el administrador del sistema',
                        timer: 8000
                    });
                } else {
                    console.log(response);

                }




            },
            errro: function(response) {
                console.log(response);
            }
        });

    }
});