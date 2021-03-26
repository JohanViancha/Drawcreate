$(document).ready(function() {

    $("#cerrar_sesion").click(function(e) {
        e.preventDefault();

        $.ajax({
            type: "POST",
            url: "../Controlador/Controlador_login.php",
            data: { funcion: 'cerrar_sesion' },
            success: function(response) {

                window.location.href = '../index.html';
            },

            error: function(response) {
                Swal.fire(
                    'No se pudo cerrar la sesión',
                    '¡Comuniquese con el area de soporte!',
                    'error'
                )
            }

        });
    });
});