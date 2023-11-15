@AbapCatalog.sqlViewName: 'ZCDS_TRAV_N_447'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ejercicio Travel con Views'
define view ZI_TRAVEL_N447 as select from /DMO/I_Travel_U

association [1] to /DMO/I_Customer as _Customerdmo
    on $projection.CurrencyID = _Customerdmo.CustomerID

association [0..1] to /DMO/I_Travel_Status_VH_Text as _TravelStatus_VH_Text 
                        on $projection.Status = _TravelStatus_VH_Text.TravelStatus 
                        and _TravelStatus_VH_Text.Language = $session.system_language
        
{
    key TravelID,
    AgencyID as AgencyID,
    CustomerID as CurrencyID,
    _Customerdmo.FirstName as Name,
    _Customerdmo.LastName as Last_Name,
    _Customerdmo.City as City,
    _Customerdmo.CountryCode as CountryCode,
    /DMO/I_Travel_U.BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice as TotalPrice,
    CurrencyCode as CurrencyCode,
    Status as Status,
    _TravelStatus_VH_Text.Text      as Text,
    /* Associations */
    _Agency,
    _Booking,
    _Currency,
    _Customer,
    _TravelStatus,
    _Customerdmo
    // Make association public

}
    where Status = 'P'
