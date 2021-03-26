var table;


$(document).ready(function() {
    ocultar_formulario();
});

$("#btn-guardar").click(function(e) {

    var nombre = $("#nom_usu").val();
    var apellido = $("#ape_usu").val();
    var tipdoc = $("#tipdoc_usu option:selected").html();
    var numdoc = $("#numdoc_usu").val();
    var genero = $("#gen_usu option:selected").val();
    var correo = $("#corele_usu").val();
    var celular = $("#cel_usu").val();
    var rol = $("#rol_usu option:selected").val();
    var ide = $("#form-agregar").attr('secuencia');


    if (nombre == "" || apellido == "" || numdoc == "" || correo == "" || celular == "") {
        Swal.fire(
            'Debe ingresar todos los datos del usuario',
            'Todos los campos son obligatorios',
            'warning'
        );
    } else {

        var pass = Math.round(Math.random() * 99999999);
        let datos_usuario = [ide, nombre, apellido, correo, numdoc, genero, pass, rol, tipdoc, celular];
        var funcion = $("#btn-guardar").attr('funcion');

        if (funcion == 'agregar') {

            agregar_usuario(datos_usuario);
        } else if (funcion == 'modificar') {

            modificar_usuario(datos_usuario);
        }

        ocultar_formulario();
    }




});

$("#btn-agregar").click(function(e) {
    e.preventDefault();

    mostrar_formulario();
    $("#btn-guardar").attr('funcion', 'agregar');

});

$("#btn-cancelar").click(function(e) {
    e.preventDefault();

    var nombre = $("#nom_usu").val();
    var apellido = $("#ape_usu").val();
    var tipdoc = $("#tipdoc_usu option:selected").html();
    var numdoc = $("#numdoc_usu").val();
    var genero = $("#gen_usu option:selected").val();
    var correo = $("#corele_usu").val();
    var celular = $("#cel_usu").val();
    var rol = $("#rol_usu option:selected").val();
    var ide = $("#form-agregar").attr('secuencia');

    if ($("#btn-guardar").attr('funcion') == "agregar") {

        if (nombre != "" || apellido != "" || numdoc != "" || correo != "" || celular != "") {
            Swal.fire({
                title: '¿Esta seguro que desea cancelar el registro del usuario?',
                text: "¡Por favor confirme la cancelación del registro!",
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#e74a3b',
                cancelButtonColor: '#434343',
                confirmButtonText: 'Si, deseo cancelar',
                cancelButtonText: 'No quiero cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    ocultar_formulario();
                }

            });
        } else {
            ocultar_formulario();
        }
    } else {
        ocultar_formulario();
    }


});

$("#text-filtro").click(function(e) {
    e.preventDefault();

    $(this).attr("data-target", "#collapseExample");

    if ($(this).attr("accion") == "volver") {
        ocultar_formulario();
        $(this).attr("data-target", "");

    }

});

function mostrar_formulario() {
    listar_roles();

    $("#form-agregar").attr("hidden", false);
    $("#btn-guardar").show();
    $("#btn-cancelar").show();
    $("#btn-agregar").hide();
    $("#collapseExample").hide();
    $('.tabla_usuario').hide();
    table.destroy();
    $("#ruta-nombre").html("Agregar Usuario");
    $("#texto-filtro").hide();

}

function ocultar_formulario() {
    if ($("#btn-guardar").attr('funcion') == 'mostrar') {
        $("#nom_usu").attr('readonly', false).css('cursor', '');
        $("#ape_usu").attr('readonly', false).css('cursor', '');
        $("#tipdoc_usu").attr('disabled', false).css('cursor', '');
        $("#numdoc_usu").attr('readonly', false).css('cursor', '');
        $("#gen_usu").attr('disabled', false).css('cursor', '');
        $("#corele_usu").attr('readonly', false).css('cursor', '');
        $("#cel_usu").attr('readonly', false).css('cursor', '');
        $("#rol_usu").attr('disabled', false).css('cursor', '');
    }

    $("#form-agregar").attr("hidden", true);
    $("#btn-agregar").show();
    $("#btn-guardar").hide();
    $("#btn-cancelar").hide();
    $("#collapseExample").show();
    $('.tabla_usuario').show();
    $("#ruta-nombre").html("Sesión / Usuarios ");
    $("#texto-filtro").show();
    listar_usuarios();
    table.ajax.reload();
    $("#tb_usu_wrapper #tb_usu_filter").hide();
    limpiar();
}



function agregar_usuario(datos_usuario) {
    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_usuario.php",
        data: { funcion: 'agregar_usuario', datos_usuario: datos_usuario },
        dataType: "",
        success: function(response) {


            Swal.fire(
                'Se ha registrado correctamente el cliente',
                '',
                'success'
            )
        },

        error: function(response) {
            Swal.fire(
                'Error al tratar de agregar el cliente',
                '¡Comuniquese con el area de soporte!',
                'error'
            )
        }

    });
    ocultar_formulario();
}



function listar_usuarios() {
    table = $('#tb_usu').DataTable({
        responsive: true,
        "deferRender": true,
        dom: "Bfrtip",
        order: [1, 'asc'],

        buttons: [
            { extend: 'copy', className: 'btn-gris', text: '<i stytle="color:white" class="fas fa-copy"></i>', title: 'Lista de Usuarios', titleAttr: 'Copiar en el portapapeles' },
            { extend: 'csv', className: 'btn-gris', text: '<i class="fa fa-file-csv"></i>', titleAttr: 'Exportar a CSV', exportOptions: { columns: [1, 2, 3, 4, 5, 6] }, title: 'Lista de Usuarios' },
            { extend: 'excel', className: 'btn-gris', messageTop: 'Este informe muestra una lista con la información de todos los de clientes.', text: '<i class="fas fa-file-excel"></i>', titleAttr: 'Exporta a Excel', autoFilter: true, exportOptions: { columns: [1, 2, 3, 4, 5, 6] }, title: 'Lista de Usuarios' },
            { extend: 'pdf', className: 'btn-gris', text: '<i class="fas fa-file-pdf"></i>', messageTop: 'Este informe muestra una lista con la información de todos los usuarios.', titleAttr: 'Exportar a PDF', exportOptions: { columns: [1, 2, 3, 4, 5, 6] }, title: 'Lista de Usuarios' },
            { extend: "print", className: 'btn-gris', title: "Lista de Usuarios", text: '<i class="fas fa-print"></i>', exportOptions: { columns: [1, 2, 3, 4, 5, 6] }, titleAttr: "Imprimir" },
        ],

        "language": {
            "lengthMenu": "Mostrar _MENU_ registros por pagina",
            "zeroRecords": "No existen registros",
            "info": "",
            "infoEmpty": "",
            "infoFiltered": "",
            "loadingRecords": "Cargando...",
            "search": "Buscar:",
            "paginate": {
                "first": "Primero",
                "last": "Última",
                "next": "Siguiente",
                "previous": "Antes"
            }
        },

        "ajax": {

            //Ubicamos la url AJAX
            url: '../Controlador/Controlador_usuario.php',

            dataSrc: "",
            //Especificamos el tipo
            type: 'POST',
            //Especificamos el tipo de dato
            dataType: 'json',
            //Se envia la variable
            data: { funcion: 'listar_usuarios', estado: 1 }

        },


        columns: [{
                data: "ide",
                "render": function(data, type, row, meta) {
                    var cambiaestado = "";
                    var estado = ""
                    if (row.estado == 'I' || row.estado == 'B') {

                        cambiaestado = `<button onClick="cambiarestado_usuario(${data},'A');" class="float-left ml-2 btn btn-danger rounded-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-toggle-on"></i>
                        </span></button>`;
                    } else {
                        cambiaestado = `<button onClick="cambiarestado_usuario(${data},'I');" class="float-left ml-2 btn btn-danger rounded-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-toggle-off"></i>
                        </span></button>`;
                    }
                    var opciones = `<button onClick="mostrar_usuario('${row.ide}','${row.nombre}','${row.apellido}','${row.tipodocumento}','${row.documento}','${row.genero}','${row.correo}','${row.celular}','${row.ide_rol}','${row.nom_rol}', 'modificar')" class="mb-1 float-left ml-2 btn btn-danger rounded-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-pen-square"></i>
                    </i></span></button> <button onClick="mostrar_usuario('${row.ide}','${row.nombre}','${row.apellido}','${row.tipodocumento}','${row.documento}','${row.genero}','${row.correo}','${row.celular}','${row.ide_rol}','${row.nom_rol}', 'mostrar')" class="mb-1 float-left ml-2 btn btn-danger rounded-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-search"></i>
                    </i></span></button>` + cambiaestado;
                    return opciones;
                }
            },
            {
                data: "nombre",
                "render": function(data, type, row, meta) {

                    return row.nombre + ' ' + row.apellido;
                }
            },
            { data: "tipodocumento" },
            { data: "documento" },
            { data: "correo" },
            { data: "nom_rol" },
            {
                data: "estado",
                "render": function(data, type, row, meta) {

                    var estado = "";

                    if (data == 'A') {
                        estado = "Activo"
                    } else if (data == 'I') {
                        estado = 'Inactivo'
                    } else {
                        estado = 'Bloqueado'
                    }
                    return estado;
                }
            },

        ]

    });


}










function cambiarestado_usuario(id_usu, estado) {
    var est = '';
    if (estado == 'A') {

        est = 'activar';
    } else {
        est = 'inactivar';
    }

    Swal.fire({
        title: '¿Esta seguro que desea ' + est + ' el usuario?',
        text: "¡Por favor confirme el cambio de estado!",
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#e74a3b',
        cancelButtonColor: '#434343',
        confirmButtonText: 'Si, ¡cambialo!',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {

            $.ajax({
                type: "POST",
                url: "../Controlador/Controlador_usuario.php",
                data: { funcion: 'cambiarestado_usuario', id_usu: id_usu, estado: estado },
                dataType: "",
                success: function(response) {
                    if (response) {
                        Swal.fire(
                            'El estado del usuario ha sido cambiado exitosamente',
                            '',
                            'success'
                        )

                        table.ajax.reload();
                    } else {
                        Swal.fire(
                            'Error al tratar de cambiar el estado del usuario',
                            '¡Comuniquese con el area de soporte!',
                            'error'
                        )

                    }

                },
                error: function() {

                    Swal.fire(
                        'Error al tratar de cambiar el estado del usuario',
                        '¡Comuniquese con el area de soporte!',
                        'error'
                    )
                }
            });
        } else {
            Swal.fire(

                'Se ha cancelado el cambio de estado del usuario',
                '',
                'warning'
            )
        }
    });


}










function listar_roles() {

    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_rol.php",
        data: { funcion: 'listar_roles', estado: 1 },
        dataType: "json",
        success: function(response) {
            if (response) {
                response.forEach(element => {

                    $('#rol_usu').append(`<option value=${element["ide"]}>${element["nombre"]}</option>`);

                });
            }
        },

        error: function(response) {
            console.log("No se puedieron listar los roles en el filtro")
        }

    });

}



function mostrar_usuario(id, nombre, apellido, tipodocumento, num_documento, genero, correo, celular, rol_id, rol_nombre, funcion) {
    $("#btn-guardar").attr('funcion', funcion);
    mostrar_formulario();

    if (funcion == 'mostrar') {
        $("#btn-guardar").hide();
        $("#ruta-nombre").text("Ver Cliente");
        $("#nom_usu").attr('readonly', true).css('cursor', 'not-allowed');
        $("#ape_usu").attr('readonly', true).css('cursor', 'not-allowed');
        $("#tipdoc_usu").attr('disabled', true).css('cursor', 'not-allowed');
        $("#numdoc_usu").attr('readonly', true).css('cursor', 'not-allowed');
        $("#gen_usu").attr('disabled', true).css('cursor', 'not-allowed');
        $("#corele_usu").attr('readonly', true).css('cursor', 'not-allowed');
        $("#cel_usu").attr('readonly', true).css('cursor', 'not-allowed');
        $("#rol_usu").attr('disabled', true).css('cursor', 'not-allowed');
    }

    $("#nom_usu").val(nombre);
    $("#ape_usu").val(apellido);
    $("#tipdoc_usu option[value='" + tipodocumento + "']").attr("selected", true);
    $("#numdoc_usu").val(num_documento);
    $("#gen_usu option[value='" + genero + "']").attr("selected", true);
    $("#corele_usu").val(correo);
    $("#cel_usu").val(celular);
    $("#rol_usu option[value='" + rol_id + "']").attr("selected", true);;
    $("#form-agregar").attr('secuencia', id);
}

function modificar_usuario(datos_usuario) {

    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_usuario.php",
        data: { funcion: 'modificar_usuario', datos_usuario: datos_usuario },
        dataType: "json",
        success: function(response) {
            Swal.fire(
                'Se ha registrado correctamente el cliente',
                '',
                'success'
            )

        },

        error: function(response) {
            console.log("No se puedieron listar los roles en el filtro")
        }

    });

}


function limpiar() {
    $("#nom_usu").val("");
    $("#ape_usu").val("");
    $("#tipdoc_usu option[value='Cedula de Ciudadania']").attr("selected", true);
    $("#numdoc_usu").val("");
    $("#gen_usu option[value='Masculino']").attr("selected", true);
    $("#corele_usu").val("");
    $("#cel_usu").val("");
    $("#rol_usu option[value='Administrador']");
    $("#form-agregar").attr('secuencia', 0);
    $('#rol_usu').empty();
}