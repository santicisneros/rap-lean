@EndUserText.label: 'Acreedores projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_ACREEDORES
 provider contract transactional_query
  as projection on ZI_ACREEDORES
{
  key Id,
      AcreedorId,
      AcreedorNombre,
      FacturaDeudaId,
      MontoDeuda,
      CurrencyCode,
      Type,
      Status,
      FechaEmision,
      FechaVenc,
      CreatedBy,
      CreatedAt,
      LastChangeBy,
      LastChangedAt,
      /* Associations */
      _Type
}
