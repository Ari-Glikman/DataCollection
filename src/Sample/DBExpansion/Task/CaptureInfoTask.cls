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
/// calls <Method> ##class(Sample.DBExpansion.DBSizeAnalysis.CaptureInfo.RetrieveData() </Method>
/// calls <Method> ##class(Sample.DBExpansion.DBSizeAnalysis.CaptureInfo.RetrieveData() </Method>
Class Sample.DBExpansion.Task.CaptureInfoTask Extends %SYS.Task.Definition
{

Parameter TaskName = "Global&Database Size Analysis Capture";

/// a 1 indicates that it will retrieve global information as quick as possible (no retrieval of usedMB, only of allocatedMB)
/// a 0 indicates that it will be slower but more thorough (will retrieve both usedMB and allocatedMB) of globals
Property Fast As %Boolean [ InitialExpression = 0 ];

Method OnTask() As %Status
{
		do ##class(%SYS.System).WriteToConsoleLog("task started")
		set st = ##class(Sample.DBExpansion.DBSizeAnalysis.CaptureInfo).RetrieveData(..Fast)
		if $$$ISERR(st){
			do ##class(%SYS.System).WriteToConsoleLog("task failed: "_st)
		}
		else {
			do ##class(%SYS.System).WriteToConsoleLog("task completed successfully")
		}
		return st
}

}
