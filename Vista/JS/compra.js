var table;
var tablepro;
let productosag = Array();
let ideproductosag = Array();

$(document).ready(function() {
    ocultar_formulario();

});


$("#btn-agregar").click(function(e) {
    e.preventDefault();
    $("#btn-guardar").attr("accion", "agregar");
    mostrar_formulario();

});


$("#btn-guardar").click(function(e) {
    e.preventDefault();

    console.log(productosag);

    var total = $("#total_pagar").html();
    var proveedor = $("#prov_com option:selected").val();

    agregar_compra(total, proveedor);


});


$(document).on('click', '.btn-quitar', function(e) {
    e.preventDefault();

    var ide = $(this).attr("id");
    var i = ideproductosag.indexOf(ide);

    if (i !== -1) {
        ideproductosag.splice(i, 1);
        productosag.splice(i, 1);
    }

    tablepro.destroy();
    calcular_total();
    listarpro_agre();
});

$("#btn-agregar-producto").click(function(e) {
    e.preventDefault();
    var ide = $("#pro_com option:selected").val();
    var producto = $("#pro_com option:selected").html();
    var cantidad = parseInt($("#canpro_com").val());
    var iva = parseInt($("#ivapro_com").val());
    var precio = parseInt($("#prepro_com").val());

    if ((!isNaN(cantidad) && cantidad > 0) && (!isNaN(precio) && precio > 0) && (!isNaN(iva) && iva >= 0)) {
        var resultado = agregar_producto(ide, producto, cantidad, precio, iva);
        if (!resultado) {
            Swal.fire(
                'Ya se agrego el producto ' + producto,
                '¡No se puede agregar mas de una vez el mismo producto!',
                'warning'
            )
        }
        $("#canpro_ven").val("");
    } else {

        Swal.fire(
            'El campo de cantidad, precio y/o iva no es valido',
            '',
            'warning'
        )
    }



});



$("#btn-cancelar").click(function(e) {
    e.preventDefault();
    $("#tbpro_commos tr").remove();
    ocultar_formulario();
    tablepro.destroy();
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
    $('.tabla_compra').hide();
    $("#ruta-nombre").html("Agregar Compra");
    $("#texto-filtro").hide();
    listarpro_agre();
    listar_proveedores();
    listar_productos();
    table.destroy();
    if ($("#btn-guardar").attr("accion") == 'mostrar') {
        $(".tabla_productocompra").hide();
        // tablepro.destroy();
        $("#tbpro_commos").show();
    } else {
        //listarpro_agre();
        $(".tabla_productocompra").show();
        $("#tbpro_commos").hide();

    }
}

function ocultar_formulario() {
    $("#form-agregar").attr("hidden", true);
    $("#btn-agregar").show();
    $("#btn-guardar").hide();
    $("#btn-cancelar").hide();
    $("#collapseExample").show();
    $('.tabla_compra').show();
    $("#ruta-nombre").html("Compras / Compras ");
    $("#texto-filtro").show();
    listar_compras();
    limpiar();
}



//Filtros
$('#fil_num_com').keyup(function() {
    table.draw();
});

$('#fil_fecini_com').change(function() {
    table.draw();
});

$('#fil_fecfin_com').change(function() {
    table.draw();
});

$.fn.dataTable.ext.search.push(
    function(settings, data, dataIndex) {
        var num = $('#fil_num_com').val();
        var fecini = $('#fil_fecini_com').val();
        var fecfin = $('#fil_fecfin_com').val();
        var numero = data[1];
        var fecha = data[2];

        if ((num == "") && (fecini == "" && fecfin == "") ||
            (numero.indexOf(num) >= 0) && (fecini == "" && fecfin == "") ||
            (num == "") && (fecha >= fecini && fecha <= fecfin) ||
            (numero.indexOf(num) >= 0) && (fecha >= fecini && fecha <= fecfin)) {
            return true;
        }
        return false;
    }
);



function listar_compras() {

    table = $('#tb_com').DataTable({
        responsive: true,
        "deferRender": true,
        dom: "Bfrtip",
        order: [2, 'desc'],

        buttons: [
            { extend: 'copy', className: 'btn-gris', text: '<i stytle="color:white" class="fas fa-copy"></i>', title: 'Lista de Compras', titleAttr: 'Copiar en el portapapeles' },
            { extend: 'csv', className: 'btn-gris', text: '<i class="fa fa-file-csv"></i>', titleAttr: 'Exportar a CSV', exportOptions: { columns: [1, 2, 3, 4, 5] }, title: 'Lista de Compras' },
            { extend: 'excel', className: 'btn-gris', messageTop: 'Este informe muestra una lista con la información de todas las compras.', text: '<i class="fas fa-file-excel"></i>', titleAttr: 'Exporta a Excel', autoFilter: true, exportOptions: { columns: [1, 2, 3, 4, 5] }, title: 'Lista de compras' },
            { extend: 'pdf', className: 'btn-gris', text: '<i class="fas fa-file-pdf"></i>', messageTop: 'Este informe muestra una lista con la información de todas las compras.', titleAttr: 'Exportar a PDF', exportOptions: { columns: [1, 2, 3, 4, 5] }, title: 'Lista de compras' },
            { extend: "print", className: 'btn-gris', title: "Lista de Compras", text: '<i class="fas fa-print"></i>', exportOptions: { columns: [1, 2, 3, 4, 5] }, titleAttr: "Imprimir" },
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
            url: '../Controlador/Controlador_compra.php',

            dataSrc: "",
            //Especificamos el tipo
            type: 'POST',
            //Especificamos el tipo de dato
            dataType: 'json',
            //Se envia la variable
            data: { funcion: 'listar_compras' }

        },


        columns: [{
                data: "ide",
                "render": function(data, type, row, meta) {
                    return `<button onClick="mostrar_compra(${data},'${row.fecha}','${row.total}','${row.proveedor}')" class="mb-1 float-left ml-2 btn btn-circle btn-danger btn-icon-split"><span class="icon text-white"><i class="fas fa-search"></i></span></button>`

                }
            },
            { data: "ide" },
            { data: "fecha" },
            { data: "total" },
            { data: "proveedor" },
            { data: "usuario" }
        ]

    });


}


function agregar_compra(total, proveedor) {
    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_compra.php",
        data: { funcion: 'agregar_compra', total: total, proveedor: proveedor, detalle: productosag, id_producto: ideproductosag },
        dataType: "",
        success: function(response) {
            console.log(response);
            Swal.fire(
                'La compra ha sido registrada exitosamente',
                '',
                'success'
            )

        },

        error: function(response) {
            console.log("No se puedo agregar la compra")
        }

    });

    ocultar_formulario();



}





function listar_proveedores() {


    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_persona.php",
        data: { funcion: 'listar_personas', tipo: 'Proveedor' },
        dataType: "json",
        success: function(response) {
            if (response) {
                response.forEach(element => {

                    $('#prov_com').append(`<option value = ${element["ide"]}> ${element["nombre"]} </option>`);


                });

            }
        },

        error: function(response) {
            console.log("No se puedieron listar los proveedores en el filtro")
        }

    });

}



function listar_productos() {


    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_producto.php",
        data: { funcion: 'listar_productos', estado: 1 },
        dataType: "json",
        success: function(response) {
            if (response) {
                response.forEach(element => {

                    $('#pro_com').append(`<option value=${element["ide"]}>${element["nombre"]}</option>`);


                });

            }
        },

        error: function(response) {
            console.log("No se puedieron listar los productos");
        }

    });

}



function listarpro_agre() {


    tablepro = $('#tbpro_com').DataTable({
        "ordering": false,
        bFilter: false,
        bInfo: false,
        "lengthChange": false,
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
        data: productosag,
        columns: [
            { title: "Opcion" },
            { title: "Producto" },
            { title: "Cantidad" },
            { title: "Precio ($)" },
            { title: "Iva (%)" },
            { title: "Subtotal ($)" },
            { title: "Total ($)" }
        ]
    });


}

function agregar_producto(ide, producto, cantidad, precio, iva) {
    var resultado = false;

    console.log(ideproductosag.indexOf(ide));
    if (ideproductosag.indexOf(ide) == -1) {
        var button = `<button id=${ide} class="btn-quitar mb-1 float-left ml-2 btn btn-danger rounded-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-trash-alt"></i>
        </i></span></button>`;
        productosag.push([button, producto, cantidad, precio, iva, precio * cantidad, ((precio * cantidad) * iva) + (precio * cantidad)]);
        ideproductosag.push(ide);
        tablepro.destroy();
        listarpro_agre();
        calcular_total();
        resultado = true;
    }

    return resultado;
}



function mostrar_compra(ide, fecha, total, proveedor) {
    $("#btn-guardar").attr("accion", "mostrar");
    mostrar_formulario();
    $(".ag_pro").hide();
    $("#prov_com").attr('disabled', true).css('cursor', 'not-allowed');
    $("#fec_ven").attr('readonly', true).css('cursor', 'not-allowed');
    $("#text-productos").html('Productos agregados');
    $("#fc-ven").removeAttr("hidden");
    $("#fec_ven").val(fecha);
    $("#total_pagar").html(total);

    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_compra.php",
        data: { funcion: 'mostrar_detallecompra', ide: ide },
        dataType: "json",
        success: function(response) {
            console.log(response);
            var contendor = $("#tbpro_commos").html();
            response.forEach(element => {
                var nuevo_producto = '<tr>' +
                    '<td>' + element["producto"] + '</td>' +
                    '<td>' + element["cantidad"] + '</td>' +
                    '<td>' + element["precio"] + '</td>' +
                    '<td>' + element["iva"] + '</td>' +
                    '<td> ' + element["subtotal"] + '</td>' +
                    '<td>' + element["total"] + '</td>' +
                    '</tr>';
                console.log(nuevo_producto);

                $("#tbpro_commos").append(nuevo_producto);

            });



        },

        error: function(response) {

            console.log('Error al tratar de mostrar el detalle de la compra');

        }

    });

}





function calcular_total() {
    var total = 0;
    productosag.forEach(element => {
        total = total + element[6];
    });
    $("#total_pagar").html(total);
}


function limpiar() {

    $("#total_pagar").html("");
    $("#tbpro_com").empty();
    productosag = Array();
    ideproductosag = Array();
    $("#pro_com").val($("#pro_ven option:first").val());
    $("#prov_com").val($("#cli_ven option:first").val());
    $("#prov_com").attr('disabled', false).css('cursor', '');
    $("#fec_com").attr('readonly', false).css('cursor', '');
    $("#text-productos").html('Agregar Productos');
    $(".ag_pro").show();
    $("#fec_com").attr("hidden");
    $('#prov_com option').remove();
    $('#pro_com option').remove();
    $("#pro_com option:selected").val();
    $("#pro_com option:selected").html();
    $("#canpro_com").val("");
    $("#ivapro_com").val("");
    $("#prepro_com").val("");
}