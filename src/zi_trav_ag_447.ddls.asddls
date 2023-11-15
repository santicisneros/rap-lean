@AbapCatalog.sqlViewName: 'ZCDS_TRAV_SEAT'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ejercicio TRAV con agency seat'
define view ZI_TRAV_AG_447
  as select from /dmo/travel        as travel

    inner join   /dmo/booking       as Booking     on travel.travel_id = Booking.travel_id

    inner join   /dmo/flight        as Flight      on  Booking.carrier_id    = Flight.carrier_id
                                                   and Booking.connection_id = Flight.connection_id

    inner join   ZI_FLIGHT_FUNC_447 as Flight_Func on  Booking.carrier_id    = Flight_Func.CarrierId
                                                   and Booking.connection_id = Flight_Func.ConnectionId

{
  key travel.travel_id           as TravelId,
  key travel.agency_id           as AgencyId,
      Flight.carrier_id          as CarrierID,
      Flight.connection_id       as ConnectionID,
      Flight.flight_date         as FlightDate,
      dats_days_between(Flight_Func.TodaysDate, Flight.flight_date ) as DaysToFlight,
      Flight.seats_occupied      as SeatsOcupied,
      Flight.seats_max           as SeatsMax,
      Flight_Func.SeatsAvailable as SeatsAvailable,
      
      //ejemplo de elemento que no este en una de las dos tablas de la union
      Flight_Func.TodaysDate  as TodaysDate,

      case when Flight.seats_occupied = Flight.seats_max
      then 'Fully Booked'
      when Flight.seats_occupied < Flight.seats_max
      then 'Available Seats'
      else 'Oversold'
      end                        as FlightSeatsLeft,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      travel.total_price         as TotalPrice,
      travel.currency_code       as CurrencyCode
      
      //    funciona con view entity. igual tener en cuenta cast y la funcion para ambiar el tipo de dato. seguir tablita
      //      case
      //      when Flight_Func.SeatsAvailable  <= 10
      //      then fltp_to_dec( cast( travel.total_price as abap.fltp ) * 1.5 as abap.dec(16,2) )
      //      else cast( travel.total_price as abap.dec(16,2) )
      //      end                        as LastTicketsPrice,

      //      @Semantics.amount.currencyCode: 'CurrencyCode'
      //      travel.booking_fee         as BookingFee,
      //
      //      travel.description         as Description,
      //      travel.status              as Status
      /* Associations */
}
where
  travel.status = 'P'
  and Flight.flight_date <= $session.system_date 
  //and Flight_Func.SeatsAvailable = 0

union select from zttravel447        as TravelTable

  left outer join /dmo/booking       as Booking     on TravelTable.travel_id = Booking.travel_id

  left outer join /dmo/flight        as Flight      on  Booking.carrier_id    = Flight.carrier_id
                                                    and Booking.connection_id = Flight.connection_id

  left outer join ZI_FLIGHT_FUNC_447 as Flight_Func on  Booking.carrier_id    = Flight_Func.CarrierId
                                                    and Booking.connection_id = Flight_Func.ConnectionId

{

  key TravelTable.travel_id      as TravelId,
  key TravelTable.agency_id      as AgencyId,
        Flight.carrier_id          as CarrierID,
      Flight.connection_id       as ConnectionID,
      Flight.flight_date         as FlightDate,
      dats_days_between(Flight_Func.TodaysDate, Flight.flight_date ) as DaysToFlight,
      Flight.seats_occupied      as SeatsOcupied,
      Flight.seats_max           as SeatsMax,
      Flight_Func.SeatsAvailable as SeatsAvailable,
      
      //ejemplo de elemento que no este en una de las dos tablas de la union
      Flight_Func.TodaysDate  as TodaysDate,

      case when Flight.seats_occupied = Flight.seats_max
      then 'Fully Booked'
      when Flight.seats_occupied < Flight.seats_max
      then 'Available Seats'
      else 'Oversold'
      end                        as FlightSeatsLeft,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      TravelTable.total_price    as TotalPrice,
      TravelTable.currency_code  as CurrencyCode

      
      
      //    funciona con view entity. igual tener en cuenta cast y la funcion para ambiar el tipo de dato. seguir tablita
      //      case
      //      when Flight_Func.SeatsAvailable  <= 10
      //      then fltp_to_dec( cast( travel.total_price as abap.fltp ) * 1.5 as abap.dec(16,2) )
      //      else cast( travel.total_price as abap.dec(16,2) )
      //      end                        as LastTicketsPrice,

      //      @Semantics.amount.currencyCode: 'CurrencyCode'
      //      TravelTable.booking_fee         as BookingFee,
      //      TravelTable.currency_code       as CurrencyCode,
      //      TravelTable.description         as Description,
      //      TravelTable.overall_status              as Status
      /* Associations */

}

//
