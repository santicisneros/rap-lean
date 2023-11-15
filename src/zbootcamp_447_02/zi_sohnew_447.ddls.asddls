@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ej SOH NEW Interface view entity'
define root view entity ZI_SOHNEW_447
  as select from zasohnew447
  association to ZI_INV_TYPE447 as _Type on $projection.Type = _Type.Type
  //composition of target_data_source_name as _association_name
{
  key so_id           as SoId,
      sale_id         as SaleId,
      client_id       as ClientId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price     as TotalPrice,
      currency_code   as CurrencyCode,
      status          as Status,
       @Consumption.valueHelpDefinition: 
      [{ entity: {
      name: 'ZI_INV_TYPE447',
      element: 'Type'}
       }]
      type            as Type,
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      _Type // Make association public
}
