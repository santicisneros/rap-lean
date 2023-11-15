@EndUserText.label: 'Fact new projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define root view entity ZC_FACT_NEW_447
  provider contract transactional_query
  as projection on ZI_FACT_NEW_447
{
  key Mykey,
      InvoiceId,
      ClientId,
      TotalPrice,
      CurrencyCode,
      Status,
      Type,
      Description,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _Cliente,
      _Type
}
