var table;


$(document).ready(function() {
    ocultar_formulario();
});

$("#btn-guardar").click(function(e) {
    e.preventDefault();
    var nombre = $("#nom_cat").val();
    var descripcion = $("#des_cat").val();

    if (nombre != '') {
        if ($(this).attr('funcion') == 'modificar') {
            modificar_categoria($("#nom_cat").attr('secuencia'), nombre, descripcion);
        } else {
            agregar_categoria(nombre, descripcion);
        }
    } else {
        Swal.fire(
            'El campo de nombre es obligatorio',
            'Por favor ingrese un nombre',
            'info'
        )
    }

});


$("#btn-agregar").click(function(e) {
    e.preventDefault();
    $("#est_cat option[value='Activo'").attr("selected", true);
    mostrar_formulario();

    $("#btn-guardar").attr('funcion', 'agregar');

});


$("#btn-cancelar").click(function(e) {
    e.preventDefault();

    ocultar_formulario();

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
    table.clear();
    $("#form-agregar").attr("hidden", false);
    $("#btn-guardar").show();
    $("#btn-cancelar").show();
    $("#btn-agregar").hide();
    $("#collapseExample").hide();
    $('.tabla_categoria').hide();
    $("#ruta-nombre").html("Agregar Categoria");
    $("#texto-filtro").hide();
    table.destroy();

}

function ocultar_formulario() {
    $("#form-agregar").attr("hidden", true);
    $("#btn-agregar").show();
    $("#btn-guardar").hide();
    $("#btn-cancelar").hide();
    $("#collapseExample").show();
    $('.tabla_categoria').show();
    $("#ruta-nombre").html("Inventario / Categoria");
    $("#texto-filtro").show();
    listar_categorias();
    table.ajax.reload();
    $("#tb_cat_wrapper #tb_cat_filter").hide();
    limpiar();
}




$.fn.dataTable.ext.search.push(
    function(settings, data, dataIndex) {
        var nom_cat = $('#fil_nom_cat').val();
        var est_cat = $("#fil_est_cat option:selected").val();
        var nombre = data[1];
        var estado = data[3];

        if ((est_cat == "Todos" && nom_cat == "") ||
            (est_cat == "Todos" && nombre.toUpperCase().indexOf(nom_cat.toUpperCase()) >= 0) ||
            (est_cat == estado && nom_cat == "") ||
            (est_cat == estado && nombre.toUpperCase().indexOf(nom_cat.toUpperCase()) >= 0)) {
            return true;
        }
        return false;
    }
);

//Filtros
$('#fil_nom_cat').keyup(function() {
    table.draw();
});

$('#fil_est_cat').change(function() {
    table.draw();
});

function listar_categorias() {
    table = $('#tb_cat').DataTable({
        responsive: true,
        "deferRender": true,
        dom: "Bfrtip",
        order: [1, 'asc'],

        buttons: [
            { extend: 'copy', className: 'btn-gris', text: '<i stytle="color:white" class="fas fa-copy"></i>', title: 'Lista de Categorias de Productos', titleAttr: 'Copiar en el portapapeles' },
            { extend: 'csv', className: 'btn-gris', text: '<i class="fa fa-file-csv"></i>', titleAttr: 'Exportar a CSV', exportOptions: { columns: [1, 2, 3] }, title: 'Lista de Categorias de Productos' },
            { extend: 'excel', className: 'btn-gris', messageTop: 'Este informe muestra una lista con la información de todas las categorias de producto.', text: '<i class="fas fa-file-excel"></i>', titleAttr: 'Exporta a Excel', autoFilter: true, exportOptions: { columns: [1, 2, 3] }, title: 'Lista de Categorias de Productos' },
            { extend: 'pdf', className: 'btn-gris', text: '<i class="fas fa-file-pdf"></i>', messageTop: 'Este informe muestra una lista con la información de todas las categorias de producto.', titleAttr: 'Exportar a PDF', exportOptions: { columns: [1, 2, 3] }, title: 'Lista de Categorias de Productos' },
            { extend: "print", className: 'btn-gris', title: "Listado de Categorias de Productos", text: '<i class="fas fa-print"></i>', exportOptions: { columns: [1, 2, 3] }, titleAttr: "Imprimir" },
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
            url: '../Controlador/Controlador_categoria.php',

            dataSrc: "",
            //Especificamos el tipo
            type: 'POST',
            //Especificamos el tipo de dato
            dataType: 'json',
            //Se envia la variable
            data: { funcion: 'listar_categorias', estado: 0 }

        },


        columns: [{
                data: "id_cat",
                "render": function(data, type, row, meta) {
                    var opciones = `<button onClick="mostrar_categoria(${data},'${row.nombre}','${row.descripcion}',${row.estado})" class="mb-1 float-left ml-2 btn btn-danger btn-icon-split"><span class="icon text-white-50"><i class="fas fa-pen-square"></i>
                    </i></span></button>`;
                    if (row.estado == true) {

                        opciones = opciones + `<button onClick="cambiarestado_categoria(${data},false);" class="float-left ml-2 btn btn-danger btn-icon-split"><span class="icon text-white-50"><i class="fas fa-toggle-off"></i>
                        </span></button>`;
                    } else {
                        opciones = opciones + `<button onClick="cambiarestado_categoria(${data},true);" class="float-left ml-2 btn btn-danger btn-icon-split"><span class="icon text-white-50"><i class="fas fa-toggle-on"></i>
                        </span></button>`;

                    }
                    return opciones;
                }
            },
            { data: "nombre" },
            { data: "descripcion" },
            {
                data: "estado",
                "render": function(data, type, row, meta) {
                    return data ? estado = 'Activo' : estado = 'Inactivo';

                }

            }

        ]




    });


}

function cambiarestado_categoria(id_cat, estado) {
    var est = '';
    estado ? est = 'activar' : est = 'inactivar';
    Swal.fire({
        title: '¿Esta seguro que desea ' + est + ' esta categoria?',
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
                url: "../Controlador/Controlador_categoria.php",
                data: { funcion: 'cambiarestado_categoria', id_cat: id_cat, estado: estado },
                dataType: "json",
                success: function(response) {
                    if (response) {
                        Swal.fire(
                            'El estado de la cateogria ha sido cambiado exitosamente',
                            '',
                            'success'
                        )

                        table.ajax.reload();
                    } else {
                        Swal.fire(
                            'Error al tratar de cambiar el estado de la categoria',
                            '¡Comuniquese con el area de soporte!',
                            'error'
                        )

                    }

                },
                error: function() {

                    Swal.fire(
                        'Error al tratar de cambiar el estado de la categoria',
                        '¡Comuniquese con el area de soporte!',
                        'error'
                    )
                }
            });
        } else {
            Swal.fire(

                'Se ha cancelado el cambio de estado de la categoria',
                '',
                'error'
            )
        }
    });


}




function mostrar_categoria(id_cat, nombre, descripcion, estado) {
    estado ? estado = 'Activo' : estado = 'Inactivo';
    $("#nom_cat").attr('secuencia', id_cat);
    $("#nom_cat").val(nombre);
    $("#des_cat").val(descripcion);
    $("#est_cat option[value=" + estado + "]").attr("selected", true);
    mostrar_formulario();
    $("#ruta-nombre").html("Modificar Categoria");
    $("#btn-guardar").attr('funcion', 'modificar');

}

function limpiar() {
    $("#nom_cat").attr('secuencia', '');
    $("#nom_cat").val('');
    $("#des_cat").val('');
}

function modificar_categoria(id_cat, nombre, descripcion) {
    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_categoria.php",
        data: { funcion: 'modificar_categoria', id_cat: id_cat, nombre: nombre, descripcion: descripcion },
        dataType: "json",
        success: function(response) {
            if (response) {

                console.log(response);
                Swal.fire(
                    'La categoria ha sido modificada exitosamente',
                    '',
                    'success'
                )

                table.ajax.reload();
            } else {
                Swal.fire(
                    'Error al tratar de modificar la categoria',
                    '¡Comuniquese con el area de soporte!',
                    'error'
                )

            }

        },

        error: function(response) {
            Swal.fire(
                'Error al tratar de modificar la categoria',
                '¡Comuniquese con el area de soporte!',
                'error'
            )
        }

    });

    ocultar_formulario();
}





function agregar_categoria(nombre, descripcion) {
    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_categoria.php",
        data: { funcion: 'agregar_categoria', nombre: nombre, descripcion: descripcion },
        dataType: "",
        success: function(response) {
            if (response) {

                console.log(response);
                Swal.fire(
                    'La categoria ha sido agregada exitosamente',
                    '',
                    'success'
                )

            } else {
                Swal.fire(
                    'Error al tratar de agregar la categoria',
                    '¡Comuniquese con el area de soporte!',
                    'error'
                )

            }

        },

        error: function(response) {
            console.log(response);
            Swal.fire(
                'Error al tratar de agregar la categoria',
                '¡Comuniquese con el area de soporte!',
                'error'
            )
        }

    });
    ocultar_formulario();
}