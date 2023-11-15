@EndUserText.label: 'SOH NEW projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_SOHNEW_447 
provider contract transactional_query
  as projection on ZI_SOHNEW_447
{
  key SoId,
      SaleId,
      ClientId,
      TotalPrice,
      CurrencyCode,
      Status,
      Type,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _Type
}
