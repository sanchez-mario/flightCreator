# Flight Creator

Salesforce LWC to search for airports and create flights, calculating the distance between them.

## Table of Contents

1. [Content](#content)
2. [Script](#script)

## Content

There main LWC is called 'nuvolar_FlightCreator'. This LWC uses the secondary one called 'customLookup' which basically handles the two airport lookup fields. Each of them have their respective Apex controller class. You will also find the metada for the two objects created for the project, 'Airport__c' and 'Flight__c'.

## Script

In order to insert several airports to start testing the Flight Creator you can use the following script:  
  
```
List<Airport__c> airportsToInsert = new List<Airport__c>();

airportsToInsert.add(new Airport__c(
    Name = 'Aeropuerto de Madrid T123',
    IATA__c = 'MAD',
    Location__Latitude__s = -70,
    Location__Longitude__s = 40
));

airportsToInsert.add(new Airport__c(
    Name = 'Aeropuerto de Barcelona',
    IATA__c = 'BCN',
    Location__Latitude__s = -70,
    Location__Longitude__s = 41
));

airportsToInsert.add(new Airport__c(
    Name = 'Aeropuerto de Valencia',
    IATA__c = 'VLC',
    Location__Latitude__s = -70,
    Location__Longitude__s = 42
));

airportsToInsert.add(new Airport__c(
    Name = 'Aeropuerto de Sevilla',
    IATA__c = 'SVQ',
    Location__Latitude__s = -70,
    Location__Longitude__s = 43
));

airportsToInsert.add(new Airport__c(
    Name = 'Aeropuerto de Bilbao',
    IATA__c = 'BIO',
    Location__Latitude__s = -70,
    Location__Longitude__s = 44
));

insert airportsToInsert;
```
