@AbapCatalog.sqlViewName: 'ZCDS_FLIGHT_447'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Ejercicio FLIGHT'
define view ZI_FLIGHT_447 as select from /DMO/I_Flight 

association [1] to /DMO/I_Connection as _Connection  // con association
on $projection.ConnectionID = _Connection.ConnectionID 
and $projection.AirlineID = _Connection.AirlineID 

association [1..1] to /DMO/I_Airport as _Airport // con association
on $projection.departureairport = _Airport.AirportID


{
    key /DMO/I_Flight.AirlineID as AirlineID,  // con association
    key /DMO/I_Flight.ConnectionID as ConnectionID,
    key /DMO/I_Flight.FlightDate as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    /DMO/I_Flight.Price,
    /DMO/I_Flight.CurrencyCode,
    /DMO/I_Flight.PlaneType,
    /DMO/I_Flight.MaximumSeats,
    /DMO/I_Flight.OccupiedSeats,
    /* Associations */
    ///DMO/I_Flight._Airline, // estas son las propias asociaciones que trae la tabla y puedo llamar directamente y usar esas asociaciones
    ///DMO/I_Flight._Connection,
    ///DMO/I_Flight._Currency,
    _Connection.DepartureAirport,
    _Connection._DepartureAirport.Name as DepartureName,
    _Connection._DepartureAirport.City as DepartureCity,
    _Connection.DestinationAirport,
    _Connection._DestinationAirport.Name as DestinationName,
    _Connection._DestinationAirport.City as DestinationCity,
    _Connection._DepartureAirport,
    _Airport // EXPOSED ASSOCIATION CON ASOCIACIONES
    
}
