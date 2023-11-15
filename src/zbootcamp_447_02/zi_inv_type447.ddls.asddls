@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ej Inv type Interf view entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_INV_TYPE447
  as select from zainvtype447
{
  @Search.defaultSearchElement: true
  @EndUserText.label: 'Type' // este label aparece para el campo type
  key type  as Type,
      value as Value
}
