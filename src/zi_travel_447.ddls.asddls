@AbapCatalog.sqlViewName: 'ZCDS_TRAVEL_447'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ejercicio Travel'
define view ZI_TRAVEL_447 as select from zttravel447
  association [1..1] to /DMO/I_Agency   as _Agency   on zttravel447.agency_id = _Agency.AgencyID // or $projection.city is not initial //concardinalidad de uno a muchos no de uno a uno
  association [1..1] to /DMO/I_Customer as _Customer on $projection.CustomerId = _Customer.CustomerID
  //association [0..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency
{
  key mykey               as Mykey,
      travel_id           as TravelId,
      agency_id           as AgencyId,
      customer_id         as CustomerId,
      begin_date          as BeginDate,
      end_date            as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee         as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price         as TotalPrice,

//      case when sum( total_price ) < 0 then 'DEBIT'
//      when sum( total_price ) > 0 then 'CREDIT'
//      end                 as DEBIT_CREDIT_STATUS,

      sum ( total_price ) as DebitStatus,
      currency_code       as CurrencyCode,
      description         as Description,
      overall_status      as OverallStatus,
      @Semantics.user.createdBy: true
      created_by          as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at          as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by     as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at     as LastChangedAt,
      @Semantics.dateTime: true
      _Agency.CountryCode,
      _Agency.Name, // agrego el name de la agency, todo desde la view de agency
      //_Agency.City, lo agrego y activo tratando de traer 1 a muchos
      //_Agency._Country, // esta disponibilizando una asocion de una asociacion
      _Agency, // Make association public
      _Customer.City // traigo la ciudad de la association
      //_Currency
}

group by
  mykey,
  travel_id,
  agency_id,
  customer_id,
  begin_date,
  end_date,
  booking_fee,
  total_price,
  currency_code,
  description,
  overall_status,
  created_by,
  created_at,
  last_changed_by,
  last_changed_at,
  _Agency.CountryCode,
  _Agency.Name,
  _Customer.City
