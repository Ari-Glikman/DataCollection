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
Class Sample.DBExpansion.Test.CaptureTest Extends %UnitTest.TestCase
{

Method OnBeforeAllTests() As %Status
{
		
	return $$$OK
}

/// test the getNewMessageNum function
Method TestMessageIncreaseCount()
{
	set timebeforeMsgsAdded = $ZDATETIME($HOROLOG,3)
	
	// add x new messages 7 days in the future
	for i = 1:1:16
	{
		set newmsgheader = ##class(Ens.MessageHeader).%New()
		set newmsgheader.TimeCreated = $ZDATETIME($HOROLOG+7,3) /// 10 days in the future, to not get confused with current stats
		set st = newmsgheader.%Save()
		if st'=1 
		{
			do $$$AssertEquals(st, 1)	//alert that saving message header failed only if fails... should not happen
		}		
	}
	set numNewMsgs = ##class(Sample.DBExpansion.Util.Helper).getNewMessageNum(timebeforeMsgsAdded)
	
	// count messages since last db entry 
	// assert that this count is x 
	do $$$AssertEquals(16,numNewMsgs)
}

/// test the <Method>PopulateDBTable</Method> function
Method TestPopDBTable()
{
	set st = ##class(Sample.DBExpansion.DBSizeAnalysis.CaptureInfo).PopulateDBTable(.MetaID)
	do $$$AssertEquals(st, 1) ///test that populate db table works...

	///check that there is something in the table....
	set query = "SELECT * FROM Sample_DBExpansion_Data.DBAnalysisInfo WHERE ID = ?" //get all unique globalnames   
	set statement = ##class(%SQL.Statement).%New()
	set status = statement.%Prepare(query)
	set resultset = statement.%Execute(MetaID)
	do $$$AssertEquals(resultset.%SQLCODE, 0)
	&sql(DELETE FROM Sample_DBExpansion_Data.DBAnalysisInfo WHERE ID = :MetaID)
	do $$$AssertEquals(SQLCODE, 0) /// test that we can delete the table from db
}

Method TestPopGlobalTable()
{
	set st = ##class(Sample.DBExpansion.DBSizeAnalysis.CaptureInfo).PopulateDBTable(.MetaID)
	do $$$AssertEquals(st, 1) ///test that populate db table works...
	
	///check that there is something in the table....
	set query1 = "SELECT * FROM Sample_DBExpansion_Data.DBAnalysisInfo WHERE ID = ?" //get all unique globalnames   
	set statement1 = ##class(%SQL.Statement).%New()
	set status1 = statement1.%Prepare(query1)
	set resultset1 = statement1.%Execute(MetaID)
	do $$$AssertEquals(resultset1.%SQLCODE, 0)
	
	set st = ##class(Sample.DBExpansion.DBSizeAnalysis.CaptureInfo).PopulateGlobalTable(MetaID,0,1)
	do $$$AssertEquals(st,1)
	
	///check that there is something in the table....
	set query2 = "SELECT * FROM Sample_DBExpansion_Data.GlobalAnalysisInfo WHERE MetaDataID = ?" //get all unique globalnames   
	set statement2 = ##class(%SQL.Statement).%New()
	set status2 = statement2.%Prepare(query2)
	set resultset2 = statement2.%Execute(MetaID)
	do $$$AssertEquals(resultset2.%SQLCODE, 0)
	set count = 0
	while resultset2.%Next()
	{
		set count = count + 1
	}
	do $$$AssertEquals(count, 1)
	
	set count = 0
	
	//check that there is ten more results
	set st = ##class(Sample.DBExpansion.DBSizeAnalysis.CaptureInfo).PopulateGlobalTable(MetaID,0,10)
	do $$$AssertEquals(st,1)
	
	///check that there is something in the table....
	set query3 = "SELECT * FROM Sample_DBExpansion_Data.GlobalAnalysisInfo WHERE MetaDataID = ?" //get all unique globalnames   
	set statement3 = ##class(%SQL.Statement).%New()
	set status3 = statement3.%Prepare(query3)
	set resultset3 = statement3.%Execute(MetaID)
	do $$$AssertEquals(resultset3.%SQLCODE, 0)
	while resultset3.%Next()
	{
		set count = count + 1
	}
	do $$$AssertEquals(count,11)
	
	//delete...
	&sql(DELETE FROM Sample_DBExpansion_Data.DBAnalysisInfo WHERE ID = :MetaID)
	do $$$AssertEquals(SQLCODE, 0) /// test that we can delete the table from db
	&sql(SELECT globalName INTO :myGlobalName FROM Sample_DBExpansion_Data.GlobalAnalysisInfo WHERE MetaDataID = :MetaID)
	do $$$AssertEquals(SQLCODE, 100) /// here we are testing that the foreign key works... delete of DB deletes associated globals
}

/// Run by <B>RunTest</B> once after all test methods in the test class are run. Can be used to tear down a test environment that was set up by <B>OnBeforeAllTests</B> See example in <b>OnBeforeAllTests</b>. 
Method OnAfterAllTests() As %Status
{
    
	set today = $ZDATETIME($HOROLOG,3)
	//delete msg headers...
	&sql(DELETE FROM ENS.MessageHeader WHERE DATEDIFF('dd',:today,TimeCreated) >=1 )
	RETURN $$$OK
}

}
