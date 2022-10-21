public with sharing class truckList {
    @AuraEnabled(Cacheable=true)
    public static List<Truck__c> search(){
       
        List<Truck__c> truckList =  [SELECT Id,Name,Truck_Type__c,Image__c,Maximum_Load__c,Total_Cost__c FROM Truck__c LIMIT 10];
       for(Integer i = 0 ; i< truckList.size();i++)
       {
        truckList[i].Image__c =  fetchImageUrl(truckList[i].Image__c);
       }
        
    return truckList;
    }
    public  static string fetchImageUrl(String imageRichText){
        Matcher imgMatcher = Pattern.compile( '<img(.+?)>' ).matcher(imageRichText);
        String img = '';
        while (imgMatcher.find()){                
            String imageTag = imgMatcher.group();
            img = imageTag.substringBetween(' src="', '"' );
            System.debug('img ===>' + img);
        }
        return img.unescapeHtml4();
    }

  
}
