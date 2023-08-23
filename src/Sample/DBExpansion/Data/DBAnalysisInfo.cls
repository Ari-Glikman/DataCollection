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
/// this is the table that will store history of statistics for the desired database
Class Sample.DBExpansion.Data.DBAnalysisInfo Extends %Persistent
{

Property DatabaseName As %String(MAXLEN = 200);

Property TimeStampStart As %TimeStamp;

Property TimeStampEnd As %TimeStamp;

Index TimeStampEndIndex On TimeStampEnd;

Property NumOfGlobals As %Integer;

/// as string since this will have units after the number
Property DBAllocatedSize As %String;

/// will be calculated as DB Size - DB Available Space
Property DBUsedSize As %Decimal;

Property NewMessagesCountSinceLastRun As %Integer;

/// indicates whether the corresponding globals in the <Method>Sample.DBExpansion.Data.GlobalAnalysisInfo</Method> were retrieved with usedMB or without (=0)
/// FastFlag = 1 means that they were retrieved in fast mode (no UsedMB), FastFlag = 0 indicates that the UsedMB field was retrieved as well
Property FastFlag As %Boolean;

ClassMethod GetTimeStampEnd(id As %String) As %TimeStamp
{
    set obj = ..%OpenId(id) //check obj exists..

    return obj.TimeStampEnd
}

Storage Default
{
<Data name="DBAnalysisInfoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DatabaseName</Value>
</Value>
<Value name="3">
<Value>TimeStampStart</Value>
</Value>
<Value name="4">
<Value>TimeStampEnd</Value>
</Value>
<Value name="5">
<Value>NumOfGlobals</Value>
</Value>
<Value name="6">
<Value>DBAllocatedSize</Value>
</Value>
<Value name="7">
<Value>DBUsedSize</Value>
</Value>
<Value name="8">
<Value>NewMessagesCountSinceLastRun</Value>
</Value>
<Value name="9">
<Value>FastFlag</Value>
</Value>
</Data>
<DataLocation>^Sample.DBEx95BC.DBAnalysisInfoD</DataLocation>
<DefaultData>DBAnalysisInfoDefaultData</DefaultData>
<ExtentSize>1</ExtentSize>
<IdLocation>^Sample.DBEx95BC.DBAnalysisInfoD</IdLocation>
<IndexLocation>^Sample.DBEx95BC.DBAnalysisInfoI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="DBAllocatedSize">
<AverageFieldSize>7</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="DBUsedSize">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="DatabaseName">
<AverageFieldSize>51</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="NewMessagesCountSinceLastRun">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="NumOfGlobals">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="TimeStampEnd">
<AverageFieldSize>21</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="TimeStampStart">
<AverageFieldSize>21</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Sample.DBEx95BC.DBAnalysisInfoS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
