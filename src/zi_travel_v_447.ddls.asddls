@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ej Travel Interface view entity'
define root view entity ZI_TRAVEL_V_447
  as select from zttravel447
  //composition of target_data_source_name as _association_name
{
        
  key mykey           as Mykey, 
      travel_id       as TravelId,
      agency_id       as AgencyId,
      customer_id     as CustomerId,
      begin_date      as BeginDate,
      end_date        as EndDate,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      booking_fee     as BookingFee,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      total_price     as TotalPrice,
      currency_code   as CurrencyCode,
      description     as Description,
      overall_status  as OverallStatus,
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt
//      _association_name // Make association public
}
