@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ejercicio TRAV NEW con agency seat'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_TRAV_NEW_447 as select from /dmo/travel        as travel

    inner join   /dmo/booking       as Booking     on travel.customer_id = Booking.customer_id

    inner join   /dmo/flight        as Flight      on  Booking.carrier_id    = Flight.carrier_id
                                                   and Booking.connection_id = Flight.connection_id

    inner join   ZI_FLIGHT_FUNC_447 as Flight_Func on  Booking.carrier_id    = Flight_Func.CarrierId
                                                   and Booking.connection_id = Flight_Func.ConnectionId

{
//  key travel.travel_id           as TravelId,
    key travel.agency_id           as AgencyId,
//      Flight.carrier_id          as CarrierID,
//      Flight.connection_id       as ConnectionID,
      Flight.flight_date         as FlightDate,
      Flight.seats_occupied      as SeatsOcupied,
      Flight.seats_max           as SeatsMax,
      Flight_Func.SeatsAvailable as SeatsAvailable,

      case when Flight.seats_occupied = Flight.seats_max
      then 'X' else ''
      end                        as FullyBooked,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      travel.total_price         as TotalPrice,

      case
      when Flight_Func.SeatsAvailable  <= 10
      then fltp_to_dec( cast( travel.total_price as abap.fltp ) * 1.5 as abap.dec(16,2) )
      else cast( travel.total_price as abap.dec(16,2) )
      end                        as LastTicketsPrice,
      
      dats_days_between(Flight_Func.TodaysDate, Flight.flight_date ) as DaysToFlight,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      travel.booking_fee         as BookingFee,
      travel.currency_code       as CurrencyCode,
      travel.description         as Description,
      travel.status              as Status
      /* Associations */
}
where
 travel.status = 'P' and
Flight.flight_date >= $session.system_date 
