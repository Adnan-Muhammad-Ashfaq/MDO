/* Created Date: 21/Jul/2018*/
public class ConnectionToMSD365OnPremise
{
    //String clientId='3MVG9YDQS5WtC11q3FMIdg6BBaYLePTQhM1j2lWLlT1K2s.z.Rtl8aARMCyY6YP1AnK3bOx_9AbGf2_oXf1kr';//='3MVG9CEn_O3jvv0x6C3upr2VWmWn9G8xc7i2xWomMovz.zjlrhqd3MgUFivurtTd8TEza2Mhh5FfurzsmIvMI';
    //String clientsecret='8376017774019128669';//='2282613863071175700';
    String username='david.so';//='restoration@org2.com';
    String password='pass@word1';//='resto1234';
    String domain='MANTRUST.NET';
    String endPoint = 'http://192.168.6.208:5555/D365ForSalesDemo';
    
    public class deserializeResponse
    {
        public String id;
        public String access_token;   
    }
    
    public String ReturnAccessToken(ConnectionToMSD365OnPremise Acc)
    {
        String reqbody = 'username='+username+'&password='+password; // String reqbody='{"grant_type":"password","client_id":clientId,"client_secret":clientSecret,"username":username,"password":password}';
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('GET');
        req.setEndpoint(endPoint);
        HttpResponse res=h.send(req);
        System.debug(res.getBody()+'###1203res');
        deserializeResponse resp1=(deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);
        System.debug(resp1+'###1203deserializeresponse');
        return resp1.access_token;
    }
    
}