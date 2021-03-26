var table;


$(document).ready(function() {

    ocultar_formulario();
});

$("#btn-agregar").click(function(e) {
    e.preventDefault();
    mostrar_formulario();

    $("#btn-guardar").attr('funcion', 'agregar');


});

$("#btn-guardar").click(function(e) {
    e.preventDefault();

    var nombre = $("#nom_rol").val();
    var ide = $("#form-agregar").attr("secuencia");
    var permisos = Array();
    $("#list-permisos li").each(function(index, element) {

        if ($(this).children().prop('checked')) {
            permisos.push(parseInt($(this).children().val()));


        }

    });

    if ($("#btn-guardar").attr('funcion') == 'agregar') {

    } else {
        modificar_rol(parseInt(ide), nombre, permisos);
    }

});


$("#btn-cancelar").click(function(e) {
    e.preventDefault();

    ocultar_formulario();

});

function mostrar_formulario() {
    $("#form-agregar").attr("hidden", false);
    $("#btn-guardar").show();
    $("#btn-cancelar").show();
    $("#btn-agregar").hide();
    $("#collapseExample").hide();
    $(".tabla_rol").hide();
    $("#ruta-nombre").html("Agregar Rol");
    $("#texto-filtro").hide();
    $("#permisos").show();
    table.destroy();

}

function ocultar_formulario() {
    limpiar();
    $("#form-agregar").attr("hidden", true);
    $("#btn-agregar").show();
    $("#btn-guardar").hide();
    $("#btn-cancelar").hide();
    $("#collapseExample").show();
    $(".tabla_rol").show();
    $("#ruta-nombre").html("Sesión / Rol");
    $("#permisos").hide();
    listar_roles();
    table.ajax.reload();

}

function limpiar() {
    $('#list-permisos').empty();
    $("#nom_rol").val("");
    $("#form-agregar").attr("secuencia", 0);
    $("#est_rol option[value='Activo']").attr("selected", true);
}


function listar_roles() {
    table = $('#tb_rol').DataTable({
        responsive: true,
        "deferRender": true,
        dom: "Bfrtip",
        order: [1, 'asc'],

        buttons: [
            { extend: 'copy', className: 'btn-gris', text: '<i stytle="color:white" class="fas fa-copy"></i>', title: 'Lista de Roles', titleAttr: 'Copiar en el portapapeles' },
            { extend: 'csv', className: 'btn-gris', text: '<i class="fa fa-file-csv"></i>', titleAttr: 'Exportar a CSV', exportOptions: { columns: [1, 2] }, title: 'Lista de Categorias de Productos' },
            { extend: 'excel', className: 'btn-gris', messageTop: 'Este informe muestra una lista con la información de los roles del usuario.', text: '<i class="fas fa-file-excel"></i>', titleAttr: 'Exporta a Excel', autoFilter: true, exportOptions: { columns: [1, 2] }, title: 'Lista de Roles' },
            { extend: 'pdf', className: 'btn-gris', text: '<i class="fas fa-file-pdf"></i>', messageTop: 'Este informe muestra una lista con la información de los roles del usuario.', titleAttr: 'Exportar a PDF', exportOptions: { columns: [1, 2] }, title: 'Lista de Roles' },
            { extend: "print", className: 'btn-gris', title: "Lista de Roles", text: '<i class="fas fa-print"></i>', exportOptions: { columns: [1, 2] }, titleAttr: "Imprimir" },
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
            url: '../Controlador/Controlador_rol.php',

            dataSrc: "",
            //Especificamos el tipo
            type: 'POST',
            //Especificamos el tipo de dato
            dataType: 'json',
            //Se envia la variable
            data: { funcion: 'listar_roles', estado: 0 }

        },

        columns: [{
                data: "ide",
                "render": function(data, type, row, meta) {

                    return `<button onClick="mostrar_rol(${data},'${row["nombre"]}','${row["estado"]}','${row["permisos"]}','modificar')"class="mb-1 float-left ml-2 btn btn-danger btn-icon-split"><span class="icon text-white-50"><i class="fas fa-pen-square"></i>
                    </i></span></button> <button onClick="mostrar_rol(${data},'${row["nombre"]}','${row["estado"]}','${row["permisos"]}','mostrar')" class="mb-1 float-left ml-2 btn btn-danger btn-icon-split"><span class="icon text-white-50"><i class="fas fa-search"></i>
                    </i></span></button>`;
                }
            },
            { data: "nombre" },
            {
                data: "estado",
                "render": function(data, type, row, meta) {
                    return data ? estado = 'Activo' : estado = 'Inactivo';

                }

            }

        ]




    });


}


function modificar_rol(ide, nombre, permisos) {
    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_rol.php",
        data: { funcion: 'modificar_rol', ide: ide, nombre: nombre, permisos: permisos },
        dataType: "",
        success: function(response) {
            console.log(response);
            Swal.fire(
                'Se realizo la modificación del rol',
                '',
                'success'
            )
        },

        error: function(response) {
            Swal.fire(
                'Error al tratar de modificar el rol',
                '¡Comuniquese con el area de soporte!',
                'error'
            )
        }

    });

    ocultar_formulario();
}



function mostrar_rol(id, nombre, estado, permisos, opcion) {

    console.log(permisos);
    $("#btn-guardar").attr('funcion', 'modificar');
    mostrar_formulario();
    if (estado) { estado == 'Activo' } else { estado == 'Inactivo' }
    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_permiso.php",
        data: { funcion: 'listar_permisos' },
        dataType: "json",
        success: function(response) {
            console.log(response);
            $("#nom_rol").val(nombre);
            $("#form-agregar").attr("secuencia", id);
            $("#est_rol option[value=" + estado + "]").attr("selected", true);
            response.forEach(element => {
                var check = '';
                if (permisos.indexOf(element["ide"]) > 0) {
                    check = 'checked';
                    $("#nom_rol").removeAttr('disabled');
                }

                if (opcion == 'mostrar') {

                    check = check + ' disabled';
                    $("#nom_rol").attr('disabled');
                }

                $('#list-permisos').append(`<li class="list-group-item"> <input type="checkbox" value="${element["ide"]}" ${check}>  ${element["nombre"]}</li>`);
            });
        },

        error: function(response) {
            Swal.fire(
                'Error al tratar de agregar mostrar el rol',
                '¡Comuniquese con el area de soporte!',
                'error'
            )
        }

    });
}