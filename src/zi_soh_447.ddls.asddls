@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ej SOH Interface view entity'
define root view entity ZI_SOH_447
  as select from zasoh447
  //composition of target_data_source_name as _association_name
{
  key so_id      as SoId,
      sales_org  as SalesOrg,
      div        as Div,
      dist_ch    as DistCh,
      created_by as CreatedBy,
      created_dt as CreatedDt
      //    _association_name // Make association public
}
