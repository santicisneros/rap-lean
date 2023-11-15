@EndUserText.label: 'Sales order projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_SOH_447
  provider contract transactional_query // contrato para que se visualice como api, todos los objetos pueden tener api
  as projection on ZI_SOH_447
{
  key SoId,
      SalesOrg,
      Div,
      DistCh,
      CreatedBy,
      CreatedDt
}
