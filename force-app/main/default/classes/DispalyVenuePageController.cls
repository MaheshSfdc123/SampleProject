public with sharing class DispalyVenuePageController {
    publi String Availability;
    public String Availability{get;set;}
    public Id id=ApexPages.currentPage().getParameters().get('VenueId');
    public List<Venue__c> getRecordsFromSearch(){
     List<Venue__c> fetchCityRecords=[SELECT id, City__c,Capacity__c,Type__c,Mailing_State_Province_Code__c,Name,Price__c,Name__c ,
                                       (SELECT id,Start_Date__c,End_Date__c FROM VenueBookings__r)
                                      FROM Venue__c 
                                      WHERE ID =:id ];
                                      if (fetchCityRecords!=Null) {
                                        Availability='Booked';
                                        
                                    } else {
                                        Availability='Available';
                                    }
    return fetchCityRecords;
}

}
