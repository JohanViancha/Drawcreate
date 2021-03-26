$(document).ready(function() {

    listar_permisos();
});

function listar_permisos() {
    table = $('#tb_perm').DataTable({
        responsive: true,
        "deferRender": true,
        dom: "Bfrtip",
        order: [0, 'asc'],

        buttons: [
            { extend: 'copy', className: 'btn-gris', text: '<i stytle="color:white" class="fas fa-copy"></i>', title: 'Lista de Permisos', titleAttr: 'Copiar en el portapapeles' },
            { extend: 'csv', className: 'btn-gris', text: '<i class="fa fa-file-csv"></i>', titleAttr: 'Exportar a CSV', exportOptions: { columns: [1, 2] }, title: 'Lista de Categorias de Productos' },
            { extend: 'excel', className: 'btn-gris', messageTop: 'Este informe muestra una lista con la información de los permisos del sistema.', text: '<i class="fas fa-file-excel"></i>', titleAttr: 'Exporta a Excel', autoFilter: true, exportOptions: { columns: [1, 2] }, title: 'Lista de Permisos' },
            { extend: 'pdf', className: 'btn-gris', text: '<i class="fas fa-file-pdf"></i>', messageTop: 'Este informe muestra una lista con la información de los permisos del sistema.', titleAttr: 'Exportar a PDF', exportOptions: { columns: [1, 2] }, title: 'Lista de Permisos' },
            { extend: "print", className: 'btn-gris', title: "Lista de Permisos", text: '<i class="fas fa-print"></i>', exportOptions: { columns: [1, 2] }, titleAttr: "Imprimir" },
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
            url: '../Controlador/Controlador_permiso.php',

            dataSrc: "",
            //Especificamos el tipo
            type: 'POST',
            //Especificamos el tipo de dato
            dataType: 'json',
            //Se envia la variable
            data: { funcion: 'listar_permisos', id: 0 }

        },

        columns: [
            { data: "ide" },
            { data: "nombre" },
            { data: "descripcion" }

        ]




    });


}