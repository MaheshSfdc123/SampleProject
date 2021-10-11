public class FetchVenuesPopup{
 
  //variable used in page.
  Public Integer size{get;set;}
  Public Integer noOfRecords{get; set;}
  public List<SelectOption> paginationSizeOptions{get;set;}
  public static final Integer QUERY_LIMIT = 10000;
  public static final Integer PAGE_SIZE = 5;
  
  public List <WrapperVenue> lstWrapperVenue {get;set;}
  Map<Id, WrapperVenue> mapHoldingSelectedRecords{get;set;}
  
  //constructor calling init method.
  public FetchVenuesPopup(){
    mapHoldingSelectedRecords = new Map<Id, WrapperVenue>();
    init();
  
  }
  
 //Init method which queries the records from standard set controller.
  public void init() {
      lstWrapperVenue = new List<WrapperVenue>();
  for (Venue__c ven : (List<Venue__c>)setCon.getRecords()) {
  if(mapHoldingSelectedRecords != null && mapHoldingSelectedRecords.containsKey(ven.id)){
      lstWrapperVenue.add(mapHoldingSelectedRecords.get(ven.id));
  
  }
 else{
  lstWrapperVenue.add(new WrapperVenue(ven, false));
  }
  }
  }
  
  /** Instantiate the StandardSetController from a query locater*/
  public ApexPages.StandardSetController setCon {
  get {
  if(setCon == null) {
    setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id,Name,Name__c,VenuesOpportunies__c
               FROM Venue__c LIMIT : QUERY_LIMIT ]));
  
    // sets the number of records to show in each page view
    setCon.setPageSize(PAGE_SIZE);
  }
    return setCon;
  }
  set;
  }
  
  /** indicates whether there are more records after the current page set.*/
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
  
  /** returns the page number of the current page set*/
  public Integer pageNumber {
  get {
    return setCon.getPageNumber();
  }
  set;
  }
  
  /** return total number of pages for page set*/
    Public Integer getTotalPages(){
      Decimal totalSize = setCon.getResultSize();
      Decimal pageSize = setCon.getPageSize();
      Decimal pages = totalSize/pageSize;
      return (Integer)pages.round(System.RoundingMode.CEILING);
  }
  
  /** returns the first page of the page set*/
  public void first() {
      addVenues();
    setCon.first();
    init();
  }
 public void last() {
  addVenues();
    setCon.last();
    init();
  }
  
  /** returns the previous page of the page set*/
  public void previous() {
      addVenues();
    setCon.previous();
    init();
  }
  
  /** returns the next page of the page set*/
  public void next() {
      addVenues();
    setCon.next();
    init(); 
  }
  
  //This is the method which manages to remove the deselected records, and keep the records which are selected in map.
  private void addVenues() {
  for(WrapperVenue wrp : lstWrapperVenue){
   if(wrp.isSelected){
      mapHoldingSelectedRecords.put(wrp.venue.id, wrp);
   }
 if(wrp.isSelected == false && mapHoldingSelectedRecords.containsKey(wrp.venue.id)){
      mapHoldingSelectedRecords.remove(wrp.venue.id);
   }
  }
  }
  
  public Boolean isSelected {get;set;}
  public Venue__c venue {get;set;}
  public WrapperVenue(Venue__c venj, Boolean boo) {
     this.venue = venj;
     this.isSelected = boo;
  }
}