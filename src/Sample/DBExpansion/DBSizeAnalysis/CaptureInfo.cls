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
Class Sample.DBExpansion.DBSizeAnalysis.CaptureInfo Extends %RegisteredObject
{

/// pass by reference an address for the function to return a value to, will be used by the <Method>RetrieveData()</Method>
/// the parameter passed by reference will be filled with the ID of the newly inserted DB statistics
/// this ID will be the MetaDataID of the globals inserted into the globals table in <Method>PopulateGlobalTable</Method>, and hence the MetaID parameter passed as in <Method>RetrieveData()</Method>
/// <br>
/// <br>
/// updates the <CLASS> Sample.DBExpansion.Data.DBAnalysisInfo </CLASS> class / <method> Sample_DBExpansion_Data.DBAnalysisInfo </method> table
ClassMethod PopulateDBTable(ByRef rowID As %Integer) As %Status
{
		/// take the newest time
		&sql(Select TOP 1 TimeStampEnd Into :timeStampEnd From Sample_DBExpansion_Data.DBAnalysisInfo ORDER BY TimeStampEnd DESC)
		if (SQLCODE < 0) //0 or 100 is okay here since there may be no data in table
	     	{
		 		set status = $$$ERROR($$$GeneralError, "TimeRetrieval Failed, sqlcode: "_SQLCODE_" Message: "_$GET(%msg))    
		 		return status
		 }
		set newAmountMsgs = ##class(Sample.DBExpansion.Util.Helper).getNewMessageNum(timeStampEnd)
		set stampStart = $ZDATETIME($HOROLOG,3)
		
		set DBstatement=##class(%SQL.Statement).%New()
	    	set DBstatus=DBstatement.%PrepareClassQuery("%SYS.DatabaseQuery", "FreeSpace")
	    
	    	do ##class(%SYS.Namespace).GetNSInfo($NAMESPACE, .dbinfo)
	    	set directory = dbinfo("Directory")
	    	#dim DBresultset As %SQL.StatementResult
		set DBresultset=DBstatement.%Execute($lb(directory)) 
		/// set DBresultset=DBstatement.%Execute("*") // this is to execute on all databases
		
		if (DBresultset.%SQLCODE '=0) ///output error
		{

			set status = $$$ERROR($$$GeneralError, "%Execute failed, sqlcode: "_SQLCODE_" Message: "_$GET(%msg))    		 		
			return status
		}
		
		while DBresultset.%Next(){//for each database if * is enabled above
		
			set allocatedSize = DBresultset.%Get("Size")
			set unusedSpace = DBresultset.%Get("Available")
			// check units... convert everything to MB for now (GB->MB)
			if ($FIND(allocatedSize, "GB") > 0) 
			{
				set allocatedSize = allocatedSize*1000 //i think this should be 1024 but it matches the sql results with 1000
			}
			if ($FIND(unusedSpace, "GB") > 0)
			{
				set unusedSpace = unusedSpace*1000
			}
		
			set usedSize = allocatedSize-unusedSpace
		
		
		
			&sql(INSERT INTO Sample_DBExpansion_Data.DBAnalysisInfo 
			(DatabaseName, DBAllocatedSize, DBUsedSize, TimeStampStart, NewMessagesCountSinceLastRun)
		     	VALUES(:directory, :allocatedSize, :usedSize, :stampStart, :newAmountMsgs))
	     
	     		if (SQLCODE '=0)
	     		{
		 	set status = $$$ERROR($$$GeneralError, "DB Insert Failed, sqlcode: "_SQLCODE_" Message: "_$GET(%msg))    		 		
			return status
		 	}
	     
		}
		
		set rowID = %ROWID
		return $$$OK
}

/// pass as parameters the metaID of globals that will be added to table (one more than previously exisitng, or 1 if no globals in table), as well as whether to run in 'fast' mode (=1) (no usedMB) or 'slow' mode (=0) (get usedMB), Number of globals to capture (-1 for all), note that it captures in alphabetical order
/// <br>
/// <br>
/// called by <method>RetrieveData()</method>
/// <br>
/// <br>
/// updates the <CLASS> Sample.DBExpansion.Data.GlobalAnalysisInfo </CLASS> class / <method> Sample_DBExpansion_Data.GlobalAnalysisInfo </method> table
/// <br>
/// returns status as error or $$$OK
ClassMethod PopulateGlobalTable(MetaID As %Integer, Fast As %Boolean = 0, NumGlobalsToGet As %Integer = -1) As %Status
{
		set globalCount = 0
		do ##class(%SYS.Namespace).GetNSInfo($NAMESPACE, .dbinfo)
	    set directory = dbinfo("Directory")
	    
		set statement=##class(%SQL.Statement).%New()
   		set status=statement.%PrepareClassQuery("%SYS.GlobalQuery","Size")

    	set resultset=statement.%Execute(directory,,,,,Fast)
    	
    	
    	if (resultset.%SQLCODE '=0) ///output error
		{
			set status = $$$ERROR($$$GeneralError, "%Execute failed, sqlcode: "_SQLCODE_" Message: "_$GET(%msg))    		 		
			return status
		}
    
    	//note that globals with same name will appear multiple times in table, hence the timestamp to differentiate and for comparison in task2
       	while (resultset.%Next() && ((globalCount < NumGlobalsToGet) || (NumGlobalsToGet = -1))) { //iterate thru globals, insert into table, if numGlobalsToGet = -1 then get all
       	
			set globalCount = globalCount+1
			set globalName = resultset.%Get("Name")
		    set allocMB = resultset.%Get("Allocated MB")	    
		    set usedMB = resultset.%Get("Used MB")    
			set className = "" //don't want to rewrite classname that was previously written if no classname found, wipe variable

			#dim %sqlcontext As %SQLProcContext 
			set %sqlcontext = ""
			do ##class(%ExtentMgr.Util).GlobalUses("^"_globalName)	
			if (%sqlcontext.%Next())
			{
				set className = %sqlcontext.%Get("UsedByExtent")
			}
      		//// get class name ^^^ 	
	    	&sql(Insert into Sample_DBExpansion_Data.GlobalAnalysisInfo(ClassName, GlobalName, AllocatedMB, UsedMB, MetaDataID)
	    	 VALUES (:className, :globalName, :allocMB, :usedMB, :MetaID))
   	     	if (SQLCODE '=0)
	     	{
		 		set status = $$$ERROR($$$GeneralError, "Global Insert Failed for global: "_globalName_" sqlcode: "_SQLCODE_" Message: "_$GET(%msg))    		 		
				return status
		 	}	
		}
		
		set dbNewestEntry = ##class(Sample.DBExpansion.Data.DBAnalysisInfo).%OpenId(MetaID)
		set dbNewestEntry.NumOfGlobals = globalCount
		set dbNewestEntry.FastFlag = Fast
		set dbNewestEntry.TimeStampEnd = $ZDATETIME($HOROLOG,3) 
		set saveStatus = dbNewestEntry.%Save()
		if $$$ISERR(saveStatus)
			{
				set status = $$$ERROR($$$GeneralError, "GlobalCount Save Failed, sqlcode: "_SQLCODE_" Message: "_$GET(%msg))    		 		
				return status
			}
		return $$$OK
}

/// parameter: whether to run in 'fast' mode (=1) (no usedMB) or 'slow' mode (=0) (get usedMB)
/// note that fast mode will return 0s in the usedMB field
ClassMethod RetrieveData(Fast As %Boolean, numGlobalsToGet As %Integer = -1) As %Status
{
		set st = ..PopulateDBTable(.currID)
		if $$$ISOK(st)
		{
			set st = ..PopulateGlobalTable(currID,Fast, numGlobalsToGet)
		}
		return st
}

}
