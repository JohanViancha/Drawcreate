var table;


$(document).ready(function() {
    ocultar_formulario();
});



$("#btn-guardar").click(function(e) {
    e.preventDefault();


    var nombre = $("#nom_prov").val();
    var numdoc = $("#numdoc_prov").val();
    var corcli = $("#corele_prov").val();
    var celcli = $("#cel_prov").val();
    var dircli = $("#dir_prov").val();
    var ide = $("#form-agregar").attr('secuencia');

    if (nombre == "" || numdoc == "" || corcli == "" || celcli == "" || dircli == "") {
        Swal.fire(
            'Debe ingresar todos los datos del proveedor',
            'Los campos obligatorios',
            'warning'
        )
    } else {
        let datos_persona = [ide, nombre, numdoc, 'No aplica', 'Proveedor', corcli, 'NIT', celcli, dircli];

        var funcion = $("#btn-guardar").attr('funcion');


        if (funcion == 'agregar') {

            agregar_proveedor(datos_persona);
        } else if (funcion == 'modificar') {

            modificar_proveedor(datos_persona);
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

    var nombre = $("#nom_prov").val();
    var numdoc = $("#numdoc_prov").val();
    var corcli = $("#corele_prov").val();
    var celcli = $("#cel_prov").val();
    var dircli = $("#dir_prov").val();

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
    $('.tabla_proveedor').hide();
    $("#ruta-nombre").html("Agregar Proveedor");
    $("#texto-filtro").hide();
    table.destroy();

}

function ocultar_formulario() {
    $("#form-agregar").attr('secuencia', 0);
    limpiar();
    $("#form-agregar").attr("hidden", true);
    $("#btn-agregar").show();
    $("#btn-guardar").hide();
    $("#btn-cancelar").hide();
    $("#collapseExample").show();
    $('.tabla_proveedor').show();
    $("#ruta-nombre").html("Compra / Proveedores ");
    $("#texto-filtro").show();
    $("#nom_prov").attr('readonly', false).css('cursor', '');
    $("#numdoc_prov").attr('readonly', false).css('cursor', '');
    $("#corele_prov").attr('readonly', false).css('cursor', '');
    $("#cel_prov").attr('readonly', false).css('cursor', '');
    $("#dir_prov").attr('readonly', false).css('cursor', '');
    listar_proveedores();
    table.ajax.reload();
}






function agregar_proveedor(datos_persona) {
    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_persona.php",
        data: { funcion: 'agregar_persona', datos_persona: datos_persona },
        dataType: "",
        success: function(response) {

            console.log(response);
            Swal.fire(
                'Se ha registrado correctamente el proveedor',
                '',
                'success'
            )
        },

        error: function(response) {
            Swal.fire(
                'Error al tratar de agregar el proveedor',
                '¡Comuniquese con el area de soporte!',
                'error'
            )
        }

    });
    ocultar_formulario();
}


//Filtros
$('#fil_nom_prov').keyup(function() {
    table.draw();
});

$('#fil_numdoc_prov').keyup(function() {
    table.draw();
});

$('#fil_corele_prov').keyup(function() {
    table.draw();
});


$.fn.dataTable.ext.search.push(
    function(settings, data, dataIndex) {
        var nom_prov = $('#fil_nom_prov').val();
        var numdoc_prov = $('#fil_numdoc_prov').val();
        var corele_prov = $('#fil_corele_prov').val();
        var nombre = data[1];
        var numerodocumento = data[3];
        var correo = data[4];

        if ((nom_prov == "" && numdoc_prov == "" && corele_prov == "") ||
            (nombre.toUpperCase().indexOf(nom_prov.toUpperCase()) >= 0) && (numdoc_prov == "") && (corele_prov == "") ||
            (nom_prov == "") && (numerodocumento.indexOf(numdoc_prov) >= 0) && (corele_prov == "") ||
            (nom_prov == "") && (numdoc_prov == "") && (correo.toUpperCase().indexOf(corele_prov.toUpperCase()) >= 0) ||
            (nombre.toUpperCase().indexOf(nom_prov.toUpperCase()) >= 0) && (numerodocumento.indexOf(numdoc_prov) >= 0) && (corele_prov == "") ||
            (nom_prov == "") && (numerodocumento.indexOf(numdoc_prov) >= 0) && (correo.toUpperCase().indexOf(corele_prov.toUpperCase()) >= 0) ||
            (nombre.toUpperCase().indexOf(nom_prov.toUpperCase()) >= 0) && (numdoc_prov == "") && (correo.toUpperCase().indexOf(corele_prov.toUpperCase()) >= 0) ||
            (nombre.toUpperCase().indexOf(nom_prov.toUpperCase()) >= 0) && (numerodocumento.indexOf(numdoc_prov) >= 0) && (correo.toUpperCase().indexOf(corele_prov.toUpperCase()) >= 0)) {
            return true;
        }
        return false;
    }
);



function listar_proveedores() {
    table = $('#tb_prov').DataTable({
        responsive: true,
        "deferRender": true,
        dom: "Bfrtip",
        order: [1, 'asc'],

        buttons: [
            { extend: 'copy', className: 'btn-gris', text: '<i stytle="color:white" class="fas fa-copy"></i>', title: 'Lista de Proveedores', titleAttr: 'Copiar en el portapapeles' },
            { extend: 'csv', className: 'btn-gris', text: '<i class="fa fa-file-csv"></i>', titleAttr: 'Exportar a CSV', exportOptions: { columns: [1, 2, 3, 4, 5] }, title: 'Lista de Proveedores' },
            { extend: 'excel', className: 'btn-gris', messageTop: 'Este informe muestra una lista con la información de todos los de proveedores.', text: '<i class="fas fa-file-excel"></i>', titleAttr: 'Exporta a Excel', autoFilter: true, exportOptions: { columns: [1, 2, 3, 4, 5] }, title: 'Lista de Proveedores' },
            { extend: 'pdf', className: 'btn-gris', text: '<i class="fas fa-file-pdf"></i>', messageTop: 'Este informe muestra una lista con la información de todos los proveedores.', titleAttr: 'Exportar a PDF', exportOptions: { columns: [1, 2, 3, 4, 5] }, title: 'Lista de Proveedores' },
            { extend: "print", className: 'btn-gris', title: "Lista de Proveedores", text: '<i class="fas fa-print"></i>', exportOptions: { columns: [1, 2, 3, 4, 5] }, titleAttr: "Imprimir" },
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
            data: { funcion: 'listar_personas', tipo: 'Proveedor' }

        },


        columns: [{
                data: "ide",
                "render": function(data, type, row, meta) {
                    var opciones = `<button onClick="mostrar_proveedor(${data},'${row.nombre}','${row.documento}','${row.correo}','${row.celular}','${row.direccion}','Modificar');" class="mb-1 float-left ml-2 btn btn-danger rounded-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-pen-square"></i>
                </i></span></button>  <button onClick="mostrar_proveedor(${data},'${row.nombre}','${row.documento}','${row.correo}','${row.celular}','${row.direccion}','Mostrar');" class="mb-1 float-left ml-2 btn btn-danger rounded-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-search"></i>`;
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



function modificar_proveedor(datos_persona) {

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
                    'El proveedor ha sido modificado exitosamente',
                    '',
                    'success'
                )


            } else {
                Swal.fire(
                    'Error al tratar de modificar el proveedor',
                    '¡Comuniquese con el area de soporte!',
                    'error'
                )

            }

        },

        error: function(response) {
            Swal.fire(
                'Error al tratar de modificar el proveedor',
                '¡Comuniquese con el area de soporte!',
                'error'
            )
        }


    });
    table.ajax.reload();

    ocultar_formulario();
}


function mostrar_proveedor(id_prov, nombre, documento, correo, celular, direccion, accion) {
    mostrar_formulario();
    if (accion == 'Mostrar') {
        $("#btn-guardar").hide();
        $("#nom_prov").attr('readonly', true).css('cursor', 'not-allowed');;
        $("#numdoc_prov").attr('readonly', true).css('cursor', 'not-allowed');
        $("#corele_prov").attr('readonly', true).css('cursor', 'not-allowed');
        $("#cel_prov").attr('readonly', true).css('cursor', 'not-allowed');
        $("#dir_prov").attr('readonly', true).css('cursor', 'not-allowed');
        $("#ruta-nombre").text("Ver Proveedor");
    } else {
        $("#ruta-nombre").text("Modificar Proveedor");
        $("#btn-guardar").attr('funcion', 'modificar');

    }

    $("#form-agregar").attr('secuencia', id_prov);
    $("#nom_prov").val(nombre);
    $("#numdoc_prov").val(documento);
    $("#corele_prov").val(correo);
    $("#cel_prov").val(celular);
    $("#dir_prov").val(direccion);

}


function limpiar() {
    $("#nom_prov").val("");
    $("#numdoc_prov").val("");
    $("#corele_prov").val("");
    $("#cel_prov").val("");
    $("#dir_prov").val("");

}