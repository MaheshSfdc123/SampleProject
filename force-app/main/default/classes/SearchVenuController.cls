public class SearchVenuController {
    
   
    public Integer seatsCapacity {get;set;}
    public Integer durationInMins {get;set;}
    public String VenueId{get;set;}
    public DateTime storeTime{get;set;}
    public Venue__c venue{get;set;}
    public Contact aContact {get;set;}
    public List<Venue__c> venueResultList {get;set;}
    public SearchVenuController(){
     this.aContact=new Contact();
      this.aContact.MailingCountryCode='IN';
        this.venue=new Venue__c();
        
    }
    public  PageReference searchForVenues(){
        displayVenues();
       return null;
    }
    public PageReference dispalyVenues(){
        PageReference pr=Page.DisplayVenuePage;
        pr.getParameters().put('VenueId',VenueId);
        return pr;
    }

    public List<Venue__c> displayVenues(){
        venueResultList = new List<Venue__c>();  
         String Query='SELECT id, name,State__c,City__c, Capacity__c,Name__c, Book_Time_Duration__c,Mailing_State_Province_Code__c FROM Venue__c ';
        if(aContact.MailingStateCode!=Null){
           Query=Query+'WHERE Mailing_State_Province_Code__c=\''+aContact.MailingStateCode+'\'';
            if(aContact.MailingStateCode!=Null && seatsCapacity!=0){
               Query=Query+'AND Capacity__c>='+seatsCapacity;
               if(durationInMins!=0){
                   Query=Query+'AND Book_Time_Duration__c='+durationInMins;
               }
            }
      }
        else if(aContact.MailingStateCode==Null && seatsCapacity!=0){
            Query=Query+'WHERE Capacity__c>='+seatsCapacity;
            if(durationInMins!=0){
               Query=Query+'AND Book_Time_Duration__c'+durationInMins;
            }
        }
        else{
         Query=Query+'WHERE Book_Time_Duration__c='+durationInMins;
        }
        venueResultList=Database.query(Query);
        return venueResultList;
        
       
    } 
    //abcd efgh ijk
   /* venueResultList = [SELECT id, name,State__c, Capacity__c, Book_Time_Duration__c,Mailing_State_Province_Code__c 
                          FROM Venue__c 
                          WHERE Mailing_State_Province_Code__c=:aContact.MailingStateCode OR
                          Capacity__c=:seatsCapacity OR Book_Time_Duration__c=:durationInMins ];
       return venueResultList;   */ 
}