import { LightningElement, track } from 'lwc';
import insertFlightRecord from '@salesforce/apex/Nuvolar_FlightCreatorController.saveFlightRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class FlightForm extends LightningElement {
    @track departureAirportName;
    @track arrivalAirportName;
    @track flightDistance;

    @track departureAirportId;
    @track arrivalAirportId;

    handleDepartureChange(event) {
        this.departureAirportId = event.detail;
        if(event.detail !== null && event.detail !== undefined){
            this.departureAirportId = event.detail;
        } else {
            this.departureAirportId = null;
        }
    }

    handleArrivalChange(event) {
        this.arrivalAirportId = event.detail;
        if(event.detail !== null && event.detail !== undefined){
            this.arrivalAirportId = event.detail;
        } else{
            this.arrivalAirportId = null;
        }
    }

    handleDepartureDelete(){
        this.departureAirportId = null;
    }

    handleArrivalDelete(){
        this.arrivalAirportId = null;
    }

    saveFlight() {
        if(this.arrivalAirportId !== null && this.arrivalAirportId !== undefined && this.departureAirportId !== null && this.departureAirportId !== undefined){
            insertFlightRecord({ "departureAirportId": this.departureAirportId, "arrivalAirportId": this.arrivalAirportId})
            .then( response => {
                console.log('TEST => ' + response)
                let responseObj = JSON.parse(response);
                console.log('TEST => ' + response)
                if(responseObj.Error == null || responseObj.Error == ''){

                    this.showToastMessage('Success', 'Flight saved!', 'success');
                    this.departureAirportName = responseObj.DepartureName;
                    this.arrivalAirportName = responseObj.ArrivalName;
                    this.flightDistance = responseObj.Distance;
                } else {
                    this.showToastMessage('Error', responseObj.Error, 'error');
                }
            })
            .catch(error => {
                this.showToastMessage('Error', error.body.message , 'error');
            });
        } else {
            this.showToastMessage('Warning', 'Please select both airports before saving your flight', 'warning');
        }
    }

    showToastMessage(title, message, variant){
        const event = new ShowToastEvent({
            variant,
            title,
            message
        })
        this.dispatchEvent(event);
    }
}