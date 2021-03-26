var table;


$(document).ready(function() {
    ocultar_formulario();


});


$("#btn-guardar").click(function(e) {
    e.preventDefault();

    var nombre = $("#nom_cli").val();
    var tipdoc = $("#tipdoc_cli option:selected").html();
    var numdoc = $("#numdoc_cli").val();
    var genero = $("#gen_cli option:selected").val();
    var corcli = $("#corele_cli").val();
    var celcli = $("#cel_cli").val();
    var dircli = $("#dir_cli").val();
    var ide = $("#form-agregar").attr('secuencia');


    if (nombre == "" || numdoc == "" || genero == "" || corcli == "" || celcli == "" || dircli == "") {
        Swal.fire(
            'Debe ingresar todos los datos del cliente',
            'Todos los campos son obligatorios',
            'warning'
        );
    } else {

        let datos_persona = [ide, nombre, numdoc, genero, 'Cliente', corcli, tipdoc, celcli, dircli];
        var funcion = $("#btn-guardar").attr('funcion');

        if (funcion == 'agregar') {
            console.log(datos_persona);
            agregar_cliente(datos_persona);
        } else if (funcion == 'modificar') {

            modificar_cliente(datos_persona);
        }
    }

});

$("#btn-agregar").click(function(e) {
    e.preventDefault();
    mostrar_formulario();
    $("#btn-guardar").attr('funcion', 'agregar');

});

$("#btn-cancelar").click(function(e) {
    e.preventDefault();

    var nombre = $("#nom_cli").val();
    var numdoc = $("#numdoc_cli").val();
    var corcli = $("#corele_cli").val();
    var celcli = $("#cel_cli").val();
    var dircli = $("#dir_cli").val();

    if ($("#btn-guardar").attr('funcion') == "agregar") {

        if (nombre != "" || numdoc != "" || corcli != "" || celcli != "" || dircli != "") {
            Swal.fire({
                title: '¿Esta seguro que desea cancelar el registro del proveedor?',
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
    $("#form-agregar").attr("hidden", false);
    $("#btn-guardar").show();
    $("#btn-cancelar").show();
    $("#btn-agregar").hide();
    $("#collapseExample").hide();
    $('.tabla_cliente').hide();
    $("#ruta-nombre").html("Agregar Cliente");
    $("#texto-filtro").hide();
    table.destroy();

}

function ocultar_formulario() {
    listar_clientes();
    $("#form-agregar").attr("hidden", true);
    $("#btn-agregar").show();
    $("#btn-guardar").hide();
    $("#btn-cancelar").hide();
    $("#collapseExample").show();
    $('.tabla_cliente').show();
    $("#ruta-nombre").html("Ventas / Clientes");
    $("#texto-filtro").show();
    $("#nom_cli").attr('readonly', false).css('cursor', '');
    $("#tipdoc_cli").attr('disabled', false).css('cursor', '');
    $("#gen_cli").attr('disabled', false).css('cursor', '');
    $("#numdoc_cli").attr('readonly', false).css('cursor', '');
    $("#corele_cli").attr('readonly', false).css('cursor', '');
    $("#cel_cli").attr('readonly', false).css('cursor', '');
    $("#dir_cli").attr('readonly', false).css('cursor', '');
    limpiar();
    table.ajax.reload();
}


function agregar_cliente(datos_persona) {

    console.log(datos_persona);
    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_persona.php",
        data: { funcion: 'agregar_persona', datos_persona: datos_persona },
        dataType: "",
        success: function(response) {

            console.log(response);
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

//Filtros
$('#fil_nom_cli').keyup(function() {
    table.draw();
});

$('#fil_numdoc_cli').keyup(function() {
    table.draw();
});

$('#fil_corele_cli').keyup(function() {
    table.draw();
});


$.fn.dataTable.ext.search.push(
    function(settings, data, dataIndex) {
        var nom_cli = $('#fil_nom_cli').val();
        var numdoc_cli = $('#fil_numdoc_cli').val();
        var corele_cli = $("#fil_corele_cli").val();
        var nombre = data[1];
        var numerodocumento = data[3];
        var correo = data[4];

        if ((nom_cli == "" && numdoc_cli == "" && corele_cli == "") ||
            (nombre.toUpperCase().indexOf(nom_cli.toUpperCase()) >= 0) && (numdoc_cli == "") && (corele_cli == "") ||
            (nom_cli == "") && (numerodocumento.indexOf(numdoc_cli) >= 0) && (corele_cli == "") ||
            (nom_cli == "") && (numdoc_cli == "") && (correo.toUpperCase().indexOf(corele_cli.toUpperCase()) >= 0) ||
            (nombre.toUpperCase().indexOf(nom_cli.toUpperCase()) >= 0) && (numerodocumento.indexOf(numdoc_cli) >= 0) && (corele_cli == "") ||
            (nom_cli == "") && (numerodocumento.indexOf(numdoc_cli) >= 0) && (correo.toUpperCase().indexOf(corele_cli.toUpperCase()) >= 0) ||
            (nombre.toUpperCase().indexOf(nom_cli.toUpperCase()) >= 0) && (numdoc_cli == "") && (correo.toUpperCase().indexOf(corele_cli.toUpperCase()) >= 0) ||
            (nombre.toUpperCase().indexOf(nom_cli.toUpperCase()) >= 0) && (numerodocumento.indexOf(numdoc_cli) >= 0) && (correo.toUpperCase().indexOf(corele_cli.toUpperCase()) >= 0)) {
            return true;
        }
        return false;
    }
);


function listar_clientes() {
    table = $('#tb_cli').DataTable({
        responsive: true,
        "deferRender": true,
        dom: "Bfrtip",
        order: [1, 'asc'],

        buttons: [
            { extend: 'copy', className: 'btn-gris', text: '<i stytle="color:white" class="fas fa-copy"></i>', title: 'Lista de Clientes', titleAttr: 'Copiar en el portapapeles' },
            { extend: 'csv', className: 'btn-gris', text: '<i class="fa fa-file-csv"></i>', titleAttr: 'Exportar a CSV', exportOptions: { columns: [1, 2, 3, 4, 5] }, title: 'Lista de Clientes' },
            { extend: 'excel', className: 'btn-gris', messageTop: 'Este informe muestra una lista con la información de todos los de clientes.', text: '<i class="fas fa-file-excel"></i>', titleAttr: 'Exporta a Excel', autoFilter: true, exportOptions: { columns: [1, 2, 3, 4, 5] }, title: 'Lista de Clientes' },
            { extend: 'pdf', className: 'btn-gris', text: '<i class="fas fa-file-pdf"></i>', messageTop: 'Este informe muestra una lista con la información de todos los clientes.', titleAttr: 'Exportar a PDF', exportOptions: { columns: [1, 2, 3, 4, 5] }, title: 'Lista de Clientes' },
            { extend: "print", className: 'btn-gris', title: "Lista de Clientes", text: '<i class="fas fa-print"></i>', exportOptions: { columns: [1, 2, 3, 3, 4, 5] }, titleAttr: "Imprimir" },
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
            url: '../Controlador/Controlador_persona.php',

            dataSrc: "",
            //Especificamos el tipo
            type: 'POST',
            //Especificamos el tipo de dato
            dataType: 'json',
            //Se envia la variable
            data: { funcion: 'listar_personas', tipo: 'Cliente' }

        },


        columns: [{
                data: "ide",
                "render": function(data, type, row, meta) {
                    var opciones = `<button onClick="mostrar_cliente(${data},'${row.nombre}','${row.tipodocumento}','${row.documento}','${row.genero}','${row.correo}','${row.celular}','${row.direccion}','modificar')" class="mb-1 float-left ml-2 btn btn-danger rounded-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-pen-square"></i>
                    </i></span></button> <button onClick="mostrar_cliente(${data},'${row.nombre}','${row.tipodocumento}','${row.documento}','${row.genero}','${row.correo}','${row.celular}','${row.direccion}','mostrar')" class="mb-1 float-left ml-2 btn btn-danger rounded-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-search"></i>
                    </i></span></button>`;
                    return opciones;
                }
            },
            { data: "nombre" },
            { data: "tipodocumento" },
            { data: "documento" },
            { data: "correo" },
            { data: "celular" }

        ]




    });


}



function modificar_cliente(datos_persona) {

    console.log(datos_persona);
    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_persona.php",
        data: { funcion: 'modificar_persona', datos_persona: datos_persona },
        dataType: "json",
        success: function(response) {
            if (response) {

                console.log(response);
                Swal.fire(
                    'El cliente ha sido modificado exitosamente',
                    '',
                    'success'
                )


            } else {
                Swal.fire(
                    'Error al tratar de modificar el cliente',
                    '¡Comuniquese con el area de soporte!',
                    'error'
                )

            }

        },

        error: function(response) {
            Swal.fire(
                'Error al tratar de modificar el cliente',
                '¡Comuniquese con el area de soporte!',
                'error'
            )
        }


    });
    table.ajax.reload();

    ocultar_formulario();
}


function mostrar_cliente(id_cli, nombre, tipodocumento, documento, genero, correo, celular, direccion, accion) {
    mostrar_formulario();
    if (accion == 'mostrar') {
        $("#btn-guardar").hide();
        $("#nom_cli").attr('readonly', true).css('cursor', 'not-allowed');
        $("#tipdoc_cli").attr('disabled', true).css('cursor', 'not-allowed');
        $("#gen_cli").attr('disabled', true).css('cursor', 'not-allowed');
        $("#numdoc_cli").attr('readonly', true).css('cursor', 'not-allowed');
        $("#corele_cli").attr('readonly', true).css('cursor', 'not-allowed');
        $("#cel_cli").attr('readonly', true).css('cursor', 'not-allowed');
        $("#dir_cli").attr('readonly', true).css('cursor', 'not-allowed');
        $("#ruta-nombre").text("Ver Cliente");
    } else {
        $("#ruta-nombre").text("Modificar Cliente");
        $("#btn-guardar").attr('funcion', 'modificar');

    }

    $("#form-agregar").attr('secuencia', id_cli);
    $("#nom_cli").val(nombre);
    $("#tipdoc_cli option[value='" + tipodocumento + "']").attr("selected", true);
    $("#gen_cli option[value=" + genero + "]").attr("selected", true);
    $("#numdoc_cli").val(documento);
    $("#corele_cli").val(correo);
    $("#cel_cli").val(celular);
    $("#dir_cli").val(direccion);

}


function limpiar() {

    $("#nom_cli").val("");
    $("#numdoc_cli").val("");
    $("#tipdoc_cli option[value='Cedula de Ciudadania']").attr("selected", true);
    $("#Masculino option[value='Masculino']").attr("selected", true);
    $("#corele_cli").val("");
    $("#cel_cli").val("");
    $("#dir_cli").val("");
    $("#tipdoc_cli option[value='Cedula de Ciudadania']").attr("selected", true);
    $("#gen_cli option[value='Masculino']").attr("selected", true);


}