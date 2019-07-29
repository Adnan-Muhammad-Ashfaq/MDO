public class GetAmazonOrdersUtility
{
    //NOT BEING USED
    @future(callout=true)
    public static void GetOrderList()
    {
        //Current time in GMT ISO 8601
        String timestamp = datetime.now().formatGMT('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
        timestamp = EncodingUtil.urlEncode(timestamp,'UTF-8');
        
        string xml = '';
        
        //Amazon Variables
        String action = 'ListOrders';
        String version = '2013-09-01';
        String signatureVersion = '2';
        String signatureMethod = 'HmacSHA256';
        String marketplaceId1= 'ATVPDKIKX0DER'; //(Amazon.com)
        String marketplaceId2= 'A2EUQ1WTGCTBG2'; //(Amazon.ca)
        String marketplaceId3= 'A1AM78C64UM0Y8'; //(Amazon.com.mx)
        //String fulfillmentChannel = 'MFN';
        String sellerId = 'A1U22OMXPNR0ZX';
        String endpoint = 'https://mws.amazonservices.com/Orders/2013-09-01';
        String accessKey = 'AKIAIIPYVMUNYP5YGGDQ';
        String amazonSecretKey = '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'; // /rWMxpkpLr0
        
        
        
        //Construct a query string with the query information
        String queryString = 'AWSAccessKeyId=' + accessKey + 
            '&Action=' + action  +
            '&LastUpdatedAfter=2018-04-01T00%3A00%3A00Z' + 
            '&MarketplaceId.Id.1=' + marketplaceId1  +
            '&MarketplaceId.Id.2=' + marketplaceId2  +
            '&MarketplaceId.Id.3=' + marketplaceId3  +
            '&SellerId=' + SellerId +
            '&SignatureMethod=' + SignatureMethod  +
            '&SignatureVersion=' + SignatureVersion  +
            '&Timestamp=' + timestamp  +
            '&Version=' + version ;
        
        String stringtoSign = 'POST' + '\n' +
            'mws.amazonservices.com' + '\n' +
            '/Orders/2013-09-01' + '\n' +
            queryString;
        
        //Covert query string to signature using Amazon secret key as key
        Blob mac = Crypto.generateMac('HMacSHA256', blob.valueof(stringtoSign),blob.valueof(amazonSecretKey));
        String signature = EncodingUtil.base64Encode(mac);
        system.debug(signature);
        signature = EncodingUtil.urlEncode(signature,'UTF-8');//'4%2FO%2BJe%2BVIJ%2BVbMcsYypDAkv7xSC%2FLo3gmtY4gR%2FGL9k%3D';
        
        System.debug(signature);
        
        HttpRequest req = new HttpRequest();    
        //            '&OrderStatus.Status.1=Shipped'+
        
        req.setEndpoint(endpoint +'?AWSAccessKeyId=' + accessKey +
                        '&Action=' + action +
                        '&SellerId=' + sellerId +
                        '&SignatureVersion=2' +
                        '&Timestamp=' + timestamp +
                        '&Version=' + version +
                        '&Signature=' + signature +
                        '&SignatureMethod='+ signatureMethod +
                        '&LastUpdatedAfter=2018-04-01T00%3A00%3A00Z' +
                        '&MarketplaceId.Id.1=' + marketplaceId1  +
                        '&MarketplaceId.Id.2=' + marketplaceId2  +
                        '&MarketplaceId.Id.3=' + marketplaceId3);
        system.debug('SYA :: '+req);
        req.setMethod('POST');
        
        integer status;
        
        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            System.debug(res.getStatus());
            System.debug(res.getStatusCode());
            status = res.getStatusCode();
            System.debug(res.getBody());
            xml = res.getBody();
        } 
        catch(System.CalloutException e) 
    {
            System.debug(e);
        }
        
        system.debug('SYA :: xml ::'+xml);
      
        if(status == 200)
        {
            Dom.Document doc = new Dom.Document();
            doc.load(xml);
            system.debug('xmnl --- '+xml);
            //Retrieve the root element for this document.
            Dom.XMLNode ordDtls = doc.getRootElement().getChildElements()[0].getChildElements()[0];//.getChildElements()[0];//.getChildElement('ListOrdersResult',null);//.getChildElement('Orders',null);
            system.debug('RS :: Order details'+ordDtls);
            //        List<Dom.XMLNode> OrderDetailId= ordDtls.getChildElements();
            //        system.debug('RS :: OrderDetailId'+OrderDetailId);
            
            // Alternatively, loop through the child elements.
            // This prints out all the elements of the address
            //list<AmazonOrder__c> amzOrdToInsert= new List<AmazonOrder__c>();
            //List<FConnect__Service_Order__c> LstOfAmazonInsert=new List<FConnect__Service_Order__c>();
            
            //if(true)return;
            Set<String> amzIDs = new Set<String>();
            
            //Getting all IDs
            for(Dom.XMLNode child : ordDtls.getChildElements()) 
            {
                amzIDs.add(child.getChildElement('AmazonOrderId',child.getNamespace()).getText());
            }
            
          //  map<string,FConnect__Service_Order__c > amzRecMap = new map<string,FConnect__Service_Order__c >();
           /* for(FConnect__Service_Order__c amz :  [select id,AmazonOrderId__c from FConnect__Service_Order__c where AmazonOrderId__c = : amzIDs])
            {
                amzRecMap.put(amz.AmazonOrderId__c, amz);
            }*/
           // FConnect__Service_Order__c AmzOrder;
           // FConnect__Service_Order__c AmzOrderToAdd; 
            
            //Getting data and upsert
            for(Dom.XMLNode child : ordDtls.getChildElements()) 
            {
                //System.debug('RS :: child text '+child.getChildElement('AmazonOrderId',null).getText());
                system.debug('SYA :: child :: '+child);
                
                /*if(amzRecMap.get(child.getChildElement('AmazonOrderId',child.getNamespace()).getText()) <> null)
                {
                    //amzOrd = amzRecMap.get(child.getChildElement('AmazonOrderId',child.getNamespace()).getText());
                    AmzOrder = amzRecMap.get(child.getChildElement('AmazonOrderId',child.getNamespace()).getText());
                }else
                {
                   // AmzOrder= new  FConnect__Service_Order__c();
                }*/
                
                
                //AmzOrderToAdd = amzOrderListDataSet(AmzOrder, child);
                
                //system.debug('SYA :: amzOrd ::'+AmzOrder);
                
                try{
                    //LstOfAmazonInsert .add(AmzOrderToAdd);  
                }
                catch(Exception ex)
                {
                    system.debug('SYA:: ex ::' + ex);
                }
            }   
            
            try
            {
               // upsert LstOfAmazonInsert;
            }
            catch(exception ex)
            {
                system.debug('SYA :: Error:: '+ex);
            }
        }
    }
    }