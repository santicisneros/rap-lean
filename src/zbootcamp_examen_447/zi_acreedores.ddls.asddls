@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Acreedores Interface view entity'
define root view entity ZI_ACREEDORES
  as select from zaacreedores
  association to ZI_DEUDATYPE as _Type on $projection.Type = _Type.Type
  //composition of target_data_source_name as _association_name
{
  key id               as Id,
      acreedor_id      as AcreedorId,
      acreedor_nombre  as AcreedorNombre,
      factura_deuda_id as FacturaDeudaId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      monto_deuda      as MontoDeuda,
      currency_code    as CurrencyCode,
      @Consumption.valueHelpDefinition:
      [{ entity: {
      name: 'ZI_DEUDATYPE',
      element: 'Type'}
       }]
      type             as Type,
      status           as Status,
      fecha_emision    as FechaEmision,
      fecha_venc       as FechaVenc,
      @Semantics.user.createdBy: true
      created_by       as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at       as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_change_by   as LastChangeBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at  as LastChangedAt,
      _Type // Make association public
}
