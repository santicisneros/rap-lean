@AbapCatalog.sqlViewName: 'ZDCS_PRUEBA_447'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Prueba'
define view ZI_PRUEBA_447 as select from ztfactura447
{
    key id_factura as IdFactura,
    id_cliente as IdCliente,
    importe_total as ImporteTotal,
    moneda as Moneda,
    creado_por as CreadoPor,
    creado_fecha as CreadoFecha
}
