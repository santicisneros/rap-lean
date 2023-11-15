@EndUserText.label: 'Porject projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_PROJT447
provider contract transactional_query
  as projection on ZI_PROJT447
{
  key Id,
      ProjectId,
      Description,
      IsSensitive,
      Status,
      BeginDate,
      EndDate,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _Boolean
}
