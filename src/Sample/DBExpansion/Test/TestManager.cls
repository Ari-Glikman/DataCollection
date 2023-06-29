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
Class Sample.DBExpansion.Test.TestManager Extends %UnitTest.Manager
{

/// how to run the unit tests:
/// 1) create a file folder "Unit Tests" somewhere on your local computer
/// 2) export the unit test file that you want to test (like CaptureTest) into that folder
/// 3) in terminal, set ^UnitTestRoot = "<folder path for Unit Tests folder>"
/// 4) in terminal: do ##class(Sample.DBExpansion.Test.TestManager).RunTest("Unit Tests", "noload/nodelete")
ClassMethod RunTest(testspec As %String, qspec As %String, ByRef userparam) As %Status
{
	Set sc=..RunTestSuites($g(testspec),.qspec,.userparam)
	If $$$ISERR(sc) Do $system.Status.DisplayError(sc)
	Quit sc
}

}
