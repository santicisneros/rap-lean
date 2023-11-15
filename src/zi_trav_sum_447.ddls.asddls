@AbapCatalog.sqlViewName: 'ZCDS_TRV_OP_447 '
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ej TRAVEL con SUM - AVG - OPER'
define view ZI_TRAV_SUM_447 as select from /DMO/I_Agency

inner join /dmo/travel as Travel 
on Travel.agency_id = /DMO/I_Agency.AgencyID

{   
    key /DMO/I_Agency.AgencyID,
    /DMO/I_Agency.Name,
    
    sum ( Travel.total_price ) as SumPerAgency,
    @Semantics.currencyCode
    Travel.currency_code,
    
    max (  Travel.total_price ) as MaxPerAgency,
    
    avg( Travel.total_price ) as AvgPerAgency,
    
    count(*) as SelesPerAgency 
         
    //@Semantics.currencyCode 
    //Travel.currency_code
    /* Associations */
}
group by
/DMO/I_Agency.AgencyID,
/DMO/I_Agency.Name,
Travel.currency_code



