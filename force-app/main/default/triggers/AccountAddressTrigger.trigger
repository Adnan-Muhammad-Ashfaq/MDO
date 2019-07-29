trigger AccountAddressTrigger on Account (after insert, before insert, before update) 
{
    if(trigger.isAfter && trigger.isinsert)
    {
        set<id> setOfAcc = new Set<id>();
        for(Account a:Trigger.new)
        {
            setOfAcc.add(a.id);
        }
        SendAccountUsingRestApi.createAccount(setOfAcc); 
    }   
    
    if(trigger.isbefore && (trigger.isinsert || trigger.isupdate))
    {
        for(Account a:Trigger.new)
        {
            if(a.Match_Billing_Address__c == true)
            {
                a.ShippingPostalCode = a.BillingPostalCode;
            }
        }
    }   
}