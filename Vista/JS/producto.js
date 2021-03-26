var table;


$(document).ready(function() {

    ocultar_formulario();

});

$("#btn-agregar").click(function(e) {
    e.preventDefault();

    mostrar_formulario();

});

$("#btn-cancelar").click(function(e) {
    e.preventDefault();

    ocultar_formulario();

});

$("#btn-guardar").click(function(e) {
    e.preventDefault();

    var categoria = $("#cat_pro option:selected").val();
    var nombre = $("#nom_pro").val();
    var codigo = $("#cod_pro").val();
    agregar_producto(codigo, nombre, categoria);
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
    $('.tabla_producto').hide();
    $("#ruta-nombre").html("Agregar Producto");
    $("#texto-filtro").hide();
    table.destroy();
    listar_categorias(1);

}

function ocultar_formulario() {
    limpiar();
    $("#tb_pro").css('cursor', 'pointer');
    listar_categorias(0);
    $("#form-agregar").attr("hidden", true);
    $("#btn-agregar").show();
    $("#btn-guardar").hide();
    $("#btn-cancelar").hide();
    $("#collapseExample").show();
    $('.tabla_producto').show();
    $("#ruta-nombre").html("Inventario / Producto");
    $("#texto-filtro").show();
    listar_productos(0);
    table.ajax.reload();
    $("#tb_pro_wrapper #tb_pro_filter").hide();

}


//Filtros
$.fn.dataTable.ext.search.push(
    function(settings, data, dataIndex) {
        var nom_pro = $('#fil_nom_pro').val();
        var cod_pro = $('#fil_cod_pro').val();
        var cat_pro = $("#fil_cat_pro option:selected").html();
        var codigo = data[1];
        var nombre = data[2];
        var categoria = data[3];

        console.log(cat_pro);

        if ((nom_pro == "" && cod_pro == "" && cat_pro == "Todos") ||
            (nombre.toUpperCase().indexOf(nom_pro.toUpperCase()) >= 0) && (cod_pro == "") && (cat_pro == "Todos") ||
            (nom_pro == "") && (codigo.indexOf(cod_pro) >= 0) && (cat_pro == "Todos") ||
            (nom_pro == "") && (cod_pro == "") && (cat_pro == categoria) ||
            (nombre.toUpperCase().indexOf(nom_pro.toUpperCase()) >= 0) && (codigo.indexOf(cod_pro) >= 0) && (cat_pro == "Todos") ||
            (nom_pro == "") && (codigo.indexOf(cod_pro) >= 0) && (cat_pro == categoria) ||
            (nombre.toUpperCase().indexOf(nom_pro.toUpperCase()) >= 0) && (cod_pro == "") && (cat_pro == categoria) ||
            (nombre.toUpperCase().indexOf(nom_pro.toUpperCase()) >= 0) && (codigo.indexOf(cod_pro) >= 0) && (cat_pro == categoria)) {
            return true;
        }
        return false;
    }
);


//Filtros
$('#fil_nom_pro').keyup(function() {
    table.draw();
});

$('#fil_cod_pro').keyup(function() {
    table.draw();
});

$('#fil_mar_pro').change(function() {
    table.draw();
});

$('#fil_cat_pro').change(function() {
    table.draw();
});

$('#fil_stock1_pro').keyup(function() {
    table.draw();
});

$('#fil_stock2_pro').keyup(function() {
    table.draw();
});


function listar_categorias(estado) {


    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_categoria.php",
        data: { funcion: 'listar_categorias', estado: estado },
        dataType: "json",
        success: function(response) {
            if (response) {
                response.forEach(element => {
                    if (estado == 0) {
                        $('#fil_cat_pro').append(`<option value=${element["id_cat"]}>${element["nombre"]}</option>`);

                    } else {
                        $('#cat_pro').append(`<option value=${element["id_cat"]}>${element["nombre"]}</option>`);

                    }
                });

            }
        },

        error: function(response) {
            console.log("No se puedieron listar las categorias en el filtro")
        }

    });

}

function listar_productos() {
    table = $('#tb_pro').DataTable({
        responsive: true,
        "deferRender": true,
        dom: "Bfrtip",
        order: [0, 'asc'],

        buttons: [
            { extend: 'copy', className: 'btn-gris', text: '<i stytle="color:white" class="fas fa-copy"></i>', title: 'Lista de Productos', titleAttr: 'Copiar en el portapapeles' },
            { extend: 'csv', className: 'btn-gris', text: '<i class="fa fa-file-csv"></i>', titleAttr: 'Exportar a CSV', exportOptions: { columns: [1, 2, 3, 4, 5, 6] }, title: 'Lista de Productos' },
            { extend: 'excel', className: 'btn-gris', messageTop: 'Este informe muestra una lista con la información de todos los producto.', text: '<i class="fas fa-file-excel"></i>', titleAttr: 'Exporta a Excel', autoFilter: true, exportOptions: { columns: [1, 2, 3, 4, 5, 6] }, title: 'Lista de Productos' },
            { extend: 'pdf', className: 'btn-gris', text: '<i class="fas fa-file-pdf"></i>', messageTop: 'Este informe muestra una lista con la información de todos los producto.', titleAttr: 'Exportar a PDF', exportOptions: { columns: [1, 2, 3, 4, 5, 6] }, title: 'Lista de Productos' },
            { extend: "print", className: 'btn-gris', title: "Listado de Productos", text: '<i class="fas fa-print"></i>', exportOptions: { columns: [1, 2, 3, 4, 5, 6] }, titleAttr: "Imprimir" },
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
            url: '../Controlador/Controlador_producto.php',

            dataSrc: "",
            //Especificamos el tipo
            type: 'POST',
            //Especificamos el tipo de dato
            dataType: 'json',
            //Se envia la variable
            data: { funcion: 'listar_productos', estado: 0 }

        },


        columns: [
            { data: "ide" },
            { data: "codigo" },
            { data: "nombre" },
            { data: "categoria" },
            { data: "precio" },
            {
                data: "stock",
                "render": function(data, type, row, meta) {
                    if (data <= 5) {

                        return `<span class="hint--bottom hint--error" data-hint="¡Stock insuficiente!">${data}</span>`;
                    } else {
                        return data;
                    }


                }
            },
            {
                data: "iva",
                "render": function(data, type, row, meta) {

                    return Math.round(data * 100) + '%';
                }
            },


        ],
        "createdRow": function(row, data, dataIndex) {

            if (data["stock"] <= 5) {
                $(row).addClass('parpadeo_fondo');
            }
        }

    });

}







function agregar_producto(codigo, nombre, categoria) {

    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_producto.php",
        data: { funcion: 'agregar_producto', codigo: codigo, nombre: nombre, categoria: categoria },
        dataType: "json",
        success: function(response) {
            if (response) {

                console.log(response);
                Swal.fire(
                    'El producto ha sido agregada exitosamente',
                    '',
                    'success'
                )

            } else {
                Swal.fire(
                    'Error al tratar de agregar el producto',
                    '¡Comuniquese con el area de soporte!',
                    'error'
                )

            }

        },

        error: function(response) {
            console.log(response);
            Swal.fire(
                'Error al tratar de agregar el producto',
                '¡Comuniquese con el area de soporte!',
                'error'
            )
        }

    });
    ocultar_formulario();
}


function limpiar() {
    $("#nom_pro").val("");
    $("#cod_pro").val("");
    $('#cat_pro').empty();
}