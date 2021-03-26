$(document).ready(function() {


});

$("#recuperar").click(function(e) {
    e.preventDefault();

    var correo = $("#correo").val();
    if (correo == "") {

        Swal.fire(
            'Debe ingresar un correo electronico',
            '',
            'warning'
        )

    } else {

        recuperar_password(correo);
    }

});


function recuperar_password(correo) {
    var password = Math.round(Math.random() * 99999999);

    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_recuperar.php",
        data: { funcion: 'recuperar_password', correo: correo, password: password },
        dataType: "",
        success: function(response) {
            console.log(response);
            if (response == 1) {
                Swal.fire(
                    'Hemos enviado al correo un constraseña temporal para que puedas ingresar al sistema',
                    '¡Recuerda que esa clave debes cambiarla',
                    'success'
                )
            } else if (response == 2) {

                Swal.fire(
                    'No hemos podido recuperar tu constraseña',
                    '¡Comuniquese con el area de soporte!',
                    'warning'
                )

            } else {
                Swal.fire(
                    'No hay usuario registrado con el correo ' + correo,
                    '',
                    'error'
                )
            }


        },
        error: function() {

        }
    });

}