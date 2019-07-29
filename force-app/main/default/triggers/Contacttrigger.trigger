trigger Contacttrigger on Contact (after insert) 
{
    if(trigger.isAfter && trigger.isinsert)
    {
        set<id> setOfCon = new Set<id>();
        for(Contact a:Trigger.new)
        {
            setOfCon.add(a.id);
        }
      
       // SendContactUsingRestApi.createContact(setOfcon); 
    }   
}