public with sharing class Nuvolar_FlightCreatorController {
    @AuraEnabled
    public static String saveFlightRecord(String departureAirportId, String arrivalAirportId) {
        Map<Id, Airport__c> airportMap = new Map<Id, Airport__c>([SELECT Id, Name, Location__Latitude__s, Location__Longitude__s FROM Airport__c WHERE Id IN (:departureAirportId, :arrivalAirportId)]);
        ResponseWrapper response = new ResponseWrapper();
        if(airportMap != null && airportMap.size() > 0){
            Decimal distance = Nuvolar_FlightCreatorController.calculateDistance(
                airportMap.get(departureAirportId).Location__Latitude__s,
                airportMap.get(departureAirportId).Location__Longitude__s,
                airportMap.get(arrivalAirportId).Location__Latitude__s,
                airportMap.get(arrivalAirportId).Location__Longitude__s
            );
            Flight__c flight = new Flight__c(Departure_Airport__c=departureAirportId, Arrival_Airport__c=arrivalAirportId, Distance__c=distance);
            try{
                insert flight;
                response.Id = flight.Id;
                response.DepartureName = airportMap.get(departureAirportId).Name;
                response.ArrivalName = airportMap.get(arrivalAirportId).Name;
                response.Distance = flight.Distance__c.setScale(2);
            } catch(Exception ex){
                //insert Log_Recording__c(Class__c='Nuvolar_FlightCreatorController', Method__c='saveFlightRecord', Exception__c=ex.getMessage(), Trace__c=ex.getStackTraceString);
                response.Error = ex.getMessage();
            }
        }
        return JSON.serialize(response);
    }

    public class ResponseWrapper {
        String Id;
        String DepartureName;
        String ArrivalName;
        Decimal Distance;
        String Error;
    }

    @AuraEnabled
    public static Decimal calculateDistance(Decimal latitude1, Decimal longitude1,Decimal latitude2, Decimal longitude2) {
        Integer earthRadius = 6371 * 1000; // in meters
        // Transform coordinates from degrees to radians
        Decimal latitudeRadians1 = latitude1 * Math.PI/180;
        Decimal latitudeRadians2 = latitude2 * Math.PI/180;
        // Latitude and longitude differences in radians
        Decimal latitudeDelta = (latitude2 - latitude1) * Math.PI/180;
        Decimal longitudeDelta = (longitude2 - longitude1) * Math.PI/180;
        Decimal a = Math.sin(latitudeDelta/2) * Math.sin(latitudeDelta/2) +
        Math.cos(latitudeRadians1) * Math.cos(latitudeRadians2) *
        Math.sin(longitudeDelta/2) * Math.sin(longitudeDelta/2);
        Decimal arc = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        Decimal distance = earthRadius * arc; // in metres
        return distance;
    }
}