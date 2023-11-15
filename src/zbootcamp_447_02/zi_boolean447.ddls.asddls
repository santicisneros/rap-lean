@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ej BOOLEAN Interface view entity'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_BOOLEAN447
  as select from zaboolean447
{
  @Search.defaultSearchElement: true
  @EndUserText.label: 'Sensitive' // este label aparece para el campo type 
  key type  as Type,
      value as Value
}
