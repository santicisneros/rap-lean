@AbapCatalog.sqlViewName: 'ZCDS_FACT_CL_447'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ej Factura cliente inner join'
define view ZI_FACTURA_447 as select from ztfactura447

//PRUEBA BASICA DE left outer join E inner join
left outer join ztcliente447
    on ztfactura447.id_cliente = ztcliente447.id_cliente

//right outer join ztcliente447
//    on ztfactura447.id_cliente = ztcliente447.id_cliente
    
//inner join ztcliente447
//    on ztfactura447.id_cliente = ztcliente447.id_cliente    
{
    key ztfactura447.id_factura as IdFactura,
    ztfactura447.id_cliente as IdCliente,
    @Semantics.amount.currencyCode: 'moneda'
    ztfactura447.importe_total as ImporteTotal,    
    ztfactura447.moneda as Moneda,
    ztfactura447.creado_por as CreadoPor,
    ztfactura447.creado_fecha as CreadoFecha,
    ztcliente447.creado_por as CreadoPorCl,
    ztcliente447.nombre as NombreCliente
}
