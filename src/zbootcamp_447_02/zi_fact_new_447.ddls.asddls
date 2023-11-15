@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS new Fact Interface view entity'
define root view entity ZI_FACT_NEW_447
  as select from zafactura_447
  association to ztcliente447 as _Cliente on $projection.ClientId = _Cliente.id_cliente
  //composition of target_data_source_name as _association_name
  association to ZI_INV_TYPE447 as _Type on $projection.Type = _Type.Type
{
  key mykey           as Mykey,
      invoice_id      as InvoiceId,
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
      description     as Description,
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      _Cliente, // Make association public
      _Type
}
