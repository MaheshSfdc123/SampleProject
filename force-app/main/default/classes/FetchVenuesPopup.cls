public with sharing class FetchVenuesPopup {

  /*
  * description:-,
  * Author:-Mahesh Anne
  */
   
  public list<WrapperVenue> lstWrapperVenue{get;set;}
  public String opportunityId;
  Map<Id, WrapperVenue> mapSelectedVenues{get;set;}
  Public Integer size{get;set;} 
  
  public FetchVenuesPopup(Apexpages.StandardSetController controller) {
      size=10;
        mapSelectedVenues=new  Map<Id, WrapperVenue>();
        opportunityId  = ApexPages.CurrentPage().getparameters().get('id');
       getVenues();
       }
    public ApexPages.StandardSetController setCon {
      get {
          if(setCon == null) {                
              setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT id,Name,Name__c,VenuesOpportunies__c FROM Venue__c]));
              setCon.setPageSize(size);  
                 }            
          return setCon;

      }
      set;
  }
  public List<WrapperVenue> getVenues() {
       lstWrapperVenue = new List<WrapperVenue>();
            for (Venue__c ven : (List<Venue__c>)setCon.getRecords()) {
                if(mapSelectedVenues!=null && mapSelectedVenues.containsKey(ven.Id)){
                lstWrapperVenue.add(mapSelectedVenues.get(ven.Id));
                }
                else{
                    lstWrapperVenue.add(new WrapperVenue(ven));
                }
            }
       return lstWrapperVenue;
  }
    public Boolean hasNext {
   get {
   return setCon.getHasNext();
   }
  set;
  }
  public Boolean hasPrevious {
get {
 return setCon.getHasPrevious();
}
set;
}
  
  public void first() {
 setCon.first();
 getVenues();
}
public void last() {
setCon.last();
 getVenues();
}
  public void previous() {
   setCon.previous();
 getVenues();
}


     public void next() {
 setCon.next();
 getVenues();
}

  public void addVenues(){
       list<Venue__c> addVeuneLst=new list<Venue__c>();
              for (WrapperVenue cw : lstWrapperVenue) {
                if (cw.isSeleted==true) {
                  cw.venue.VenuesOpportunies__c=opportunityId;
                 addVeuneLst.add(cw.venue);
                }
                    else{
                       cw.venue.VenuesOpportunies__c=null;
                        addVeuneLst.add(cw.venue);
                  } 
                   }          
     update addVeuneLst;
  }
  public class WrapperVenue{
      public String opportunityId=ApexPages.CurrentPage().getparameters().get('id');
      public List<Venue__c> lstVenue=[select id, name,name__c,VenuesOpportunies__c from Venue__c
                                      where VenuesOpportunies__c=: opportunityId];
       public Boolean isSeleted{get;set;}
      public Venue__c venue{get;set;}
      public WrapperVenue(Venue__c ven){
          this.venue = ven;
       
          if(lstVenue.contains(this.venue)){
              isSeleted=true;}
          else{
              isSeleted=false; 
          }   
      }
  }
}