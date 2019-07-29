public class TestTreeView
{

public Map<String,Profile> mlis=new Map<String,Profile>();
Public Map<String,String> result{get;set;}
public Map<String,User> mlis1=new Map<String,User>();

//cponstructor

public TestTreeView()
{

    result=new Map<String,String>();
    for(Profile p:[select name from Profile])
    {
        mlis.put(p.name,p);
    }

    system.debug('cons list'+mlis);    
    system.debug(mlis.keyset());

    for(User u:[select name,profile.name from user where profile.name in : mlis.keyset()])
    {
        system.debug('cons list'+u);
        result.put(u.name,u.profile.name);
    }

    system.debug(result);

}

}