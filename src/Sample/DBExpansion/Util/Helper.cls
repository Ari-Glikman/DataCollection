/// **********************************************************
/// *                   ** N O T I C E **                    *
/// *                - TEST/DEMO SOFTWARE -                  *
/// * This code is not supported by InterSystems as part     *
/// * of any released product.  It is supplied by            *
/// * InterSystems as a demo/test tool for a specific        *
/// * product and version. The user or customer is fully     *
/// * responsible for the maintenance and testing of this    *
/// * software after delivery, and InterSystems shall bear   *
/// * no responsibility nor liabilities for errors or misuse *
/// * of this code.                                          *
/// **********************************************************
Class Sample.DBExpansion.Util.Helper
{

/// Get properties using macros wrapping direct global references
/// will fill Arr, pass by reference
ClassMethod HasPersistentProperty(className As %String, ByRef Arr As %String)
{
    // Getting properties via macro-wrapped direct global references is harder to read,
    // but is the fastest way to do it.
    set key = ""
    set i = 1
    set myArray(1) = ""

    &sql(SELECT Name INTO :class FROM %Dictionary.CompiledClass Where Upper(ID) Like Upper(:className)) //maybe will get parameter as all upper..
 	
    for {
        set key = $$$comMemberNext(class,$$$cCLASSproperty,key)
        quit:key=""
        set type = $$$comMemberKeyGet(class,$$$cCLASSproperty,key,$$$cPROPtype)
        set origin = $$$comMemberKeyGet(class,$$$cCLASSproperty,key,$$$cPROPorigin)
        set properties(key) = $listbuild(type,origin)
        if ($classmethod(type,"%Extends", "%Persistent"))
        {
	        set Arr(i, "PropertyName") = key
	    	set Arr(i, "PropertyType") = type
 			set i = i+1
	    }
    }
    QUIT $$$OK
}

/// parameter: time to measure new messages from
ClassMethod getNewMessageNum(timeStamp As %TimeStamp) As %Integer
{

	if timeStamp = "" //no prev data, take all
	{
		&sql(SELECT Count(*) INTO :myCount FROM Ens.MessageHeader)
		return myCount
	}
	else
	{
		&sql(SELECT Count(*) INTO :myCount FROM Ens.MessageHeader WHERE DATEDIFF('ss',:timeStamp,TimeCreated)>0)
		return myCount
	}
}

}
