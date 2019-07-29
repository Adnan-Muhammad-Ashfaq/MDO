trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) 
{
    list<Task> lstOfTask = new List<Task>();
    for(Opportunity opp : trigger.new)
    {
        if(opp.StageName == 'Closed Won')
        {
            Task t= new Task();
            t.subject = 'Follow Up Test Task';
            t.WhatId = opp.id;
            lstOfTask.add(t);
        }
    }
    insert lstOfTask;
}