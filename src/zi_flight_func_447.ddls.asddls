@AbapCatalog.sqlViewName: 'ZCDS_FLI_F_447'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ej FLIGHT para assoc travel'
define view ZI_FLIGHT_FUNC_447 as select from /dmo/flight
{
    key carrier_id as CarrierId,
    key connection_id as ConnectionId,
    key flight_date as FlightDate,
    price as Price,
    currency_code as CurrencyCode,
    plane_type_id as PlaneTypeId,
    seats_max as SeatsMax,
    seats_occupied as SeatsOccupied,
    (seats_max - seats_occupied) as SeatsAvailable,
    $session.system_date  as TodaysDate
     
}
//where flight_date <= $session.system_date 
