/* Created Date: 5/Jul/2018*/
public class SendContactUsingRestApi
{
    String clientId='3MVG9YDQS5WtC11q3FMIdg6BBaYLePTQhM1j2lWLlT1K2s.z.Rtl8aARMCyY6YP1AnK3bOx_9AbGf2_oXf1kr';//='3MVG9CEn_O3jvv0x6C3upr2VWmWn9G8xc7i2xWomMovz.zjlrhqd3MgUFivurtTd8TEza2Mhh5FfurzsmIvMI';
    String clientsecret='8376017774019128669';//='2282613863071175700';
    string username='adnanaxguru-9jfg@force.com';//='restoration@org2.com';
    String password='axguru123';//='resto1234';
    String accesstoken_url='https://login.salesforce.com/services/oauth2/token';//='https://test.salesforce.com/services/oauth2/token';
    String authurl='https://login.salesforce.com/services/oauth2/authorize';
    String instance_url='ap4';//cs91
    public class deserializeResponse
    {
        public String id;
        public String access_token;   
    }
    
    public String ReturnAccessToken(SendContactUsingRestApi Acc)
    {
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password; // String reqbody='{"grant_type":"password","client_id":clientId,"client_secret":clientSecret,"username":username,"password":password}';
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://ap4.salesforce.com/services/oauth2/token');
        HttpResponse res=h.send(req);
        System.debug(res.getBody()+'###1203res');
        deserializeResponse resp1=(deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);
        System.debug(resp1+'###1203deserializeresponse');
        return resp1.access_token;
    }
    
    @future(callout=true)
    public static void createContact(set<id> setCon)
    {
        List<Contact> lstOfCon =new List<Contact>( [select id,lastname,Account.id,Account.ExternalID__c from Contact where id in: setcon ]);
        
        SendContactUsingRestApi con= new SendContactUsingRestApi();
        String accessToken=con.ReturnAccessToken(con);
        System.debug(accessToken+ ' Access Token ');
        if(accessToken!=null)
        {
            for(Contact a : lstOfcon)
            {
                try
                {
                    String endPoint='https://ap4.salesforce.com/services/data/v32.0/sobjects/Contact';  
                    String jsonstr='{"lastName":"'+a.lastName+'","Account":{"ExternalID__c" : "'+a.Account.ExternalID__c+'"}}';
                    system.debug('jSon -- '+jsonstr);
                    Http h2= new Http();
                    HttpRequest req2= new HttpRequest();
                    req2.setHeader('Authorization','Bearer ' + accessToken);
                    req2.setHeader('Content-Type','application/json');
                    req2.setHeader('accept','application/json');
                    req2.setBody(jsonstr);
                    req2.setMethod('POST');
                    req2.setEndpoint(endPoint);
                    HttpResponse res2=h2.send(req2);
                    System.debug('###1203createresp ======= '+res2);
                    deserializeResponse deresp2=(deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
                    System.debug('###1203createdeser'+deresp2);
                }
                catch(Exception e)
                {
                    system.debug('Exception --- '+e);
                }
            }    
        }
    }
}