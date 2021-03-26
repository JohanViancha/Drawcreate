var table;
var tablepro;
let productosag;
let ideproductosag;

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
    var cliente = $("#cli_ven option:selected").val();

    agregar_venta(total, cliente);


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
    var ide = $("#pro_ven option:selected").val();
    var producto = $("#pro_ven option:selected").html();
    var cantidad = parseInt($("#canpro_ven").val());
    var precio = $("#pro_ven option:selected").attr("precio");
    var iva = $("#pro_ven option:selected").attr("iva");
    var stock = parseInt($("#sto_ven").val());

    if (!isNaN(cantidad) && cantidad > 0) {
        if (cantidad > stock) {

            Swal.fire(
                'La cantidad no debe ser mayor al stock',
                '',
                'warning'
            ).then(() => {
                $("#canpro_ven").addClass('borde-advertencia');
            });

        } else {
            var resultado = agregar_producto(ide, producto, cantidad, precio, iva);
            if (!resultado) {
                Swal.fire(
                    'Ya se agrego el producto ' + producto,
                    '¡No se puede agregar mas de una vez el mismo producto!',
                    'warning'
                )
            } else {

            }
        }
        $("#canpro_ven").val("");
    } else {

        Swal.fire(
            'El campo de cantidad no es valido',
            '¡Ingrese la cantidad del producto que desea llevar!',
            'warning'
        )
    }



});



$("#btn-cancelar").click(function(e) {
    e.preventDefault();
    $("#tbpro_venmos tr").remove();
    ocultar_formulario();

    tablepro.destroy();

});

$("#pro_ven").change(function(e) {
    e.preventDefault();

    $("#sto_ven").val($("#pro_ven option:selected").attr("stock"));
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

    $("#sto_ven").val($("#pro_ven option:selected").attr("stock"));
    $("#form-agregar").attr("hidden", false);
    $("#btn-guardar").show();
    $("#btn-cancelar").show();
    $("#btn-agregar").hide();
    $("#collapseExample").hide();
    $('.tabla_venta').hide();
    $("#ruta-nombre").html("Agregar Venta");
    $("#texto-filtro").hide();
    listarpro_agre();
    listar_productos();
    listar_clientes();
    table.destroy();

    if ($("#btn-guardar").attr("accion") == 'mostrar') {
        $(".tabla_productoventa").hide();
        // tablepro.destroy();
        $("#tbpro_venmos").show();
    } else {
        //listarpro_agre();
        $(".tabla_productoventa").show();
        $("#tbpro_venmos").hide();

    }
}

function ocultar_formulario() {
    $("#form-agregar").attr("hidden", true);
    $("#btn-agregar").show();
    $("#btn-guardar").hide();
    $("#btn-cancelar").hide();
    $("#collapseExample").show();
    $('.tabla_venta').show();
    $("#ruta-nombre").html("Venta / Ventas ");
    $("#texto-filtro").show();
    listar_ventas();
    table.ajax.reload();
    limpiar();
}



//Filtros
$('#fil_num_ven').keyup(function() {
    table.draw();
});

$('#fil_fecini_ven').change(function() {
    table.draw();
});

$('#fil_fecfin_ven').change(function() {
    table.draw();
});

$('#fil_est_ven').change(function() {
    table.draw();
});


$.fn.dataTable.ext.search.push(
    function(settings, data, dataIndex) {
        var num = $('#fil_num_ven').val();
        var fecini = $('#fil_fecini_ven').val();
        var fecfin = $('#fil_fecfin_ven').val();
        var est = $("#fil_est_ven option:selected").html();
        var numero = data[1];
        var fecha = data[2];
        var estado = data[6];

        if ((num == "") && (fecini == "" && fecfin == "") && (est == 'Todos') ||
            (numero.indexOf(num) >= 0) && (fecini == "" && fecfin == "") && (est == 'Todos') ||
            (num == "") && (fecha >= fecini && fecha <= fecfin) && (est == "Todos") ||
            (num == "") && (fecini == "" && fecfin == "") && (est == estado) ||
            (numero.indexOf(num) >= 0) && (fecha >= fecini && fecha <= fecfin) && (est == "Todos") ||
            (num == "") && (fecini == "" && fecfin == "") && (est == estado) ||
            (numero.indexOf(num) >= 0) && (fecini == "" && fecfin == "") && (est == "Todos") ||
            (numero.indexOf(num) >= 0) && (fecha >= fecini && fecha <= fecfin) && (est == estado)) {
            return true;
        }
        return false;
    }
);





function listar_ventas() {
    table = $('#tb_ven').DataTable({
        responsive: true,
        "deferRender": true,
        dom: "Bfrtip",
        order: [2, 'desc'],

        buttons: [
            { extend: 'copy', className: 'btn-gris', text: '<i stytle="color:white" class="fas fa-copy"></i>', title: 'Lista de Ventas', titleAttr: 'Copiar en el portapapeles' },
            { extend: 'csv', className: 'btn-gris', text: '<i class="fa fa-file-csv"></i>', titleAttr: 'Exportar a CSV', exportOptions: { columns: [1, 2, 3, 4, 5, 6] }, title: 'Lista de Clientes' },
            { extend: 'excel', className: 'btn-gris', messageTop: 'Este informe muestra una lista con la información de todos las ventas.', text: '<i class="fas fa-file-excel"></i>', titleAttr: 'Exporta a Excel', autoFilter: true, exportOptions: { columns: [1, 2, 3, 4, 5, 6] }, title: 'Lista de Ventas' },
            { extend: 'pdf', className: 'btn-gris', text: '<i class="fas fa-file-pdf"></i>', messageTop: 'Este informe muestra una lista con la información de todas las ventas.', titleAttr: 'Exportar a PDF', exportOptions: { columns: [1, 2, 3, 4, 5, 6] }, title: 'Lista de Ventas' },
            { extend: "print", className: 'btn-gris', title: "Lista de Ventas", text: '<i class="fas fa-print"></i>', exportOptions: { columns: [1, 2, 3, 3, 4, 5, 6] }, titleAttr: "Imprimir" },
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
            url: '../Controlador/Controlador_venta.php',

            dataSrc: "",
            //Especificamos el tipo
            type: 'POST',
            //Especificamos el tipo de dato
            dataType: 'json',
            //Se envia la variable
            data: { funcion: 'listar_ventas' }

        },


        columns: [{
                data: "ide",
                "render": function(data, type, row, meta) {
                    var opciones = "";
                    var est = "";
                    var icono = "";
                    var anu = `<button onClick="cambiarestado_venta(${data},'A')" class="mb-1 float-left ml-2 btn btn-danger btn-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-times-circle"></i></span></button>`;
                    var vis = `<button onClick="mostrar_venta(${data},'${row.fecha}','${row.total}','${row.cliente}')" class="mb-1 float-left ml-2 btn btn-circle btn-danger btn-icon-split"><span class="icon text-white"><i class="fas fa-search"></i>
                    </span></button>`;
                    var pag = `<button onClick="cambiarestado_venta(${data},'P')" class="mb-1 float-left ml-2 btn btn-danger btn-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-hand-holding-usd"></i>
                    </span></button>`;
                    if (row.estado == 'D') {

                        opciones = anu + vis + pag;

                    } else if (row.estado == 'P') {
                        opciones = vis;
                    } else if (row.estado == 'A' || row.estado == 'F') {

                        opciones = vis;
                    } else {
                        opciones = vis;
                    }

                    return opciones;
                }
            },
            { data: "ide" },
            { data: "fecha" },
            { data: "total" },
            { data: "cliente" },
            { data: "usuario" },
            {
                data: "estado",
                "render": function(data, type, row, meta) {
                    var estado = '';
                    if (data == 'D') {
                        estado = 'Digitada';
                    } else if (data == 'P') {
                        estado = 'Pagada';
                    } else if (data == 'A') {
                        estado = 'Anulada';
                    } else {
                        estado = 'Facturada';
                    }
                    return estado;
                }
            }

        ]




    });


}


function listar_clientes() {


    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_persona.php",
        data: { funcion: 'listar_personas', tipo: 'Cliente' },
        dataType: "json",
        success: function(response) {
            if (response) {
                response.forEach(element => {

                    $('#cli_ven').append(`<option value=${element["ide"]}>${element["nombre"]}</option>`);


                });

            }
        },

        error: function(response) {
            console.log("No se puedieron listar los clientes en el filtro")
        }

    });

}





function agregar_venta(total, cliente) {

    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_venta.php",
        data: { funcion: 'agregar_venta', total: total, cliente: cliente, detalle: productosag, id_producto: ideproductosag },
        dataType: "",
        success: function(response) {
            Swal.fire(
                'La veenta ha sido registrada exitosamente',
                '',
                'success'
            )

        },

        error: function(response) {
            console.log("No se puedo agregar la venta")
        }

    });

    ocultar_formulario();



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

                    $('#pro_ven').append(`<option precio='${element["precio"]}' stock=${element["stock"]} iva=${element["iva"]} value=${element["ide"]}>${element["nombre"]}</option>`);


                });

            }
        },

        error: function(response) {
            console.log("No se puedieron listar los clientes en el filtro")
        }

    });

}



function listarpro_agre() {

    tablepro = $('#tbpro_ven').DataTable({
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



function cambiarestado_venta(id_ven, estado) {
    var est = '';
    if (estado == 'P') {

        est = 'pagada'
    } else if (estado == 'A') {
        est = 'anulada';
    }
    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_venta.php",
        data: { funcion: 'cambiarestado_venta', id_ven: id_ven, estado: estado },
        dataType: "",
        success: function(response) {
            console.log(response);
            Swal.fire(
                'La venta ha sido ' + est,
                '',
                'success'
            )

            table.ajax.reload();
        },
        error: function() {


        }
    });

}

function agregar_producto(ide, producto, cantidad, precio, iva) {
    var resultado = false;

    if (ideproductosag.indexOf(ide) == -1) {
        var button = `<button id=${ide} class="btn-quitar mb-1 float-left ml-2 btn btn-danger rounded-circle btn-icon-split"><span class="icon text-white"><i class="fas fa-trash-alt"></i>
        </i></span></button>`;
        productosag.push([button, producto, cantidad, precio, (iva * 100), precio * cantidad, ((precio * cantidad) * iva) + (precio * cantidad)]);
        ideproductosag.push(ide);
        tablepro.destroy();
        listarpro_agre();
        calcular_total();
        resultado = true;
    }

    return resultado;
}


function calcular_total() {
    var total = 0;
    productosag.forEach(element => {
        total = total + element[6];
    });
    $("#total_pagar").html(total);
}

function mostrar_venta(ide, fecha, total, cliente) {
    $("#btn-guardar").attr("accion", "mostrar");
    mostrar_formulario();
    $(".ag_pro").hide();
    $("#cli_ven").attr('disabled', true).css('cursor', 'not-allowed');
    $("#fec_ven").attr('readonly', true).css('cursor', 'not-allowed');
    $("#text-productos").html('Productos agregados');
    $("#fc-ven").removeAttr("hidden");
    $("#fec_ven").val(fecha);
    $("#total_pagar").html(total);

    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_venta.php",
        data: { funcion: 'mostrar_detalleventa', ide: ide },
        dataType: "json",
        success: function(response) {

            var cont = 0;
            var contendor = $("#tbpro_venmos").html();
            response.forEach(element => {
                var nuevo_producto = '<tr>' +
                    '<td>' + element["producto"] + '</td>' +
                    '<td>' + element["cantidad"] + '</td>' +
                    '<td>' + element["precio"] + '</td>' +
                    '<td>' + element["iva"] + '</td>' +
                    '<td> ' + element["subtotal"] + '</td>' +
                    '<td>' + element["total"] + '</td>' +
                    '</tr>';
                $("#tbpro_venmos").append(nuevo_producto);

            });



        },

        error: function(response) {

            console.log('Error al tratar de mostrar el detalle de la venta');

        }

    });

}



function generar_factura(ide, fecha, cliente) {
    var $elementoParaConvertir = '';

    $.ajax({
        type: "POST",
        url: "../Controlador/Controlador_venta.php",
        data: { funcion: 'mostrar_detalleventa', ide: ide },
        dataType: "json",
        success: function(response) {


            elementoParaConvertir = `<!DOCTYPE html>
                    <html lang="en">
                    
                    <head>
                        <meta charset="UTF-8">
                        <title>Document</title>
                        <link href="css/bootstrap.css" rel="stylesheet" />
                        <style>
                            @import url(http://fonts.googleapis.com/css?family=Bree+Serif);
                            body,
                            h1,
                            h2,
                            h3,
                            h4,
                            h5,
                            h6 {
                                font-family: 'Bree Serif', serif;
                            }
                        </style>
                    </head>
                    
                    <body>
                        <div class="container">
                            <div class="row">
                    
                                <div class="col-xs-6">
                                    <h1>
                                        <a href=" "><img alt="" src="image/logo.png" /> Unity 3D </a>
                                    </h1>
                                </div>
                                <div class="col-xs-6 text-right">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4>NIT :
                                                <a href="#">N&uacute;mero de NIT</a>
                                            </h4>
                                            <h4>AUTORIZACI&Oacute;N :
                                                <a href="#">N&uacute;mero de Aut.</a>
                                            </h4>
                                        </div>
                                        <div class="panel-body">
                                            <h4>FACTURA :
                                                <a href="#">N&uacute;mero de FACTURA</a>
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                    
                                <hr />
                    
                    
                                <h1 style="text-align: center;">FACTURA</h1>
                    
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4>La Paz, <a href="#">30</a> de <a href="#">abril</a> de 201<a href="#">4</a>
                    
                                                </h4>
                                            </div>
                                            <div class="panel-body">
                    
                    
                                                <h4>Comprador :
                                                    <a href="#">${cliente}</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    NIT/CI :
                                                    <a href="#">5345550</a>
                                                </h4>
                    
                                            </div>
                                        </div>
                                    </div>
                    
                                </div>
                                <pre></pre>
                                <table class="table table-bordered" id="factura_detalle">
                                    <thead>
                                        <tr>
                                            <th style="text-align: center;">
                                                <h4>Cantidad</h4>
                                            </th>
                                            <th style="text-align: center;">
                                                <h4>Concepto</h4>
                                            </th>
                                            <th style="text-align: center;">
                                                <h4>Precio unitario</h4>
                                            </th>
                                            <th style="text-align: center;">
                                                <h4>Total</h4>
                                            </th>
                    
                                        </tr>
                                    </thead>
                                    <tbody><tr>
                                            <td style="text-align: center;">1</td>
                                            <td><a href="#"> Asesoramiento de inseminaci&oacute;n vacuna </a></td>
                                            <td class=" text-right ">28500</td>
                                            <td class=" text-right ">28500</td>
                    
                                        </tr>
                                     < /tbody>`;

            response.forEach(element => {
                var nuevo_producto = '<tr>' +
                    '<td>' + element["cantidad"] + '</td>' +
                    '<td>' + element["producto"] + '</td>' +
                    '<td>' + element["precio"] + '</td>' +
                    '<td>' + element["total"] + '</td>' +
                    '</tr>';
                $elementoParaConvertir = $elementoParaConvertir + nuevo_producto;

            });





            $elementoParaConvertir = $elementoParaConvertir + `< / table > <pre > < /pre><div class = "row" >
                        <
                        div class = "col-xs-4" >
                        <
                        h1 >
                        <
                        a href = " " > < img alt = ""
                    src = "image/qr.png" / > < /a> < /
                        h1 > <
                        /div> <
                    div class = "col-xs-8" >

                        <
                        div class = "panel panel-info"
                    style = "text-align: right;" >
                        <
                        h6 > "LA ALTERACI&Oacute;N, FALSIFICACI&Oacute;N O COMERCIALIZACI&Oacute;N ILEGAL DE ESTE DOCUMENTO ESTA PENADO POR LA LEY" < /h6> < /
                        div >

                        </div> </div >

                        </div> </div >

                 <script src = "../vendor/jquery/jquery.min.js" > < /script>

                    < script src = "../vendor/html2pdf/dist/html2pdf.bundle.min.js" > < /script>


                    <script src = "JS/prueba.js" > < /script>


                    </body></html>`;
        }

    });

    html2pdf()
        .set({
            margin: 1,
            filename: 'venta.pdf',
            image: {
                type: 'jpeg',
                quality: 0.98
            },
            html2canvas: {
                scale: 3, // A mayor escala, mejores gráficos, pero más peso
                letterRendering: true,
            },
            jsPDF: {
                unit: "in",
                format: "a3",
                orientation: 'portrait' // landscape o portrait
            }
        })
        .from($elementoParaConvertir)
        .save()
        .catch(err => console.log(err));

}




function limpiar() {

    $("#total_pagar").html("");
    $("#tbpro_ven").empty();
    productosag = Array();
    ideproductosag = Array();
    $("#pro_ven").val($("#pro_ven option:first").val());
    $("#cli_ven").val($("#cli_ven option:first").val());
    $("#cli_ven").attr('disabled', false).css('cursor', '');
    $("#fec_ven").attr('readonly', false).css('cursor', '');
    $("#text-productos").html('Agregar Productos');
    $(".ag_pro").show();
    $("#fc-ven").attr("hidden");
    $('#cli_ven option').remove();
    $('#pro_ven option').remove();
}