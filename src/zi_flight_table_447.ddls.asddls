@AbapCatalog.sqlViewName: 'ZCDS_FLI_T_447'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ejercicio FLIGHT con Flight Table'
define view ZI_FLIGHT_TABLE_447 as select from /dmo/flight as flight

left outer join /dmo/connection as Connection  // con join
on flight.carrier_id = Connection.carrier_id 
and flight.connection_id = Connection.connection_id

left outer join /dmo/airport as AirportDeparture  // con join
on Connection.airport_from_id = AirportDeparture.airport_id

left outer join /dmo/airport as AirportDestination  // con join
on Connection.airport_to_id = AirportDestination.airport_id

{
    key flight.carrier_id as CarrierId,
    key flight.connection_id as ConnectionId,
    key flight.flight_date as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    flight.price as Price,
    flight.currency_code as CurrencyCode,
    flight.plane_type_id as PlaneTypeId,
    flight.seats_max as SeatsMax,
    flight.seats_occupied as SeatsOccupied,
    
    Connection.airport_from_id as AirportDepartureId,
    AirportDeparture.name as Airport_Departure_Name,
    AirportDeparture.city as Airport_Departure_City,
    
    Connection.airport_to_id as AirportDestinationId,
    AirportDestination.name as Aiport_Destination_Name,
    AirportDestination.city as Aiport_Destination_City
}
