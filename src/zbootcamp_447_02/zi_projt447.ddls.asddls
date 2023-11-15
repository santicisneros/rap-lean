@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ej PROJ Interface view entity'
define root view entity ZI_PROJT447
  as select from zaproj447
  association to ZI_BOOLEAN447 as _Boolean on $projection.IsSensitive = _Boolean.Type
{
  key id              as Id,
      project_id      as ProjectId,
      description     as Description,
      @Consumption.valueHelpDefinition: 
      [{ entity: {
      name: 'ZI_BOOLEAN447',
      element: 'Type'}
       }]
      is_sensitive    as IsSensitive,
      status          as Status,
      begin_date      as BeginDate,
      end_date        as EndDate,
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      _Boolean // make associantions public
}
