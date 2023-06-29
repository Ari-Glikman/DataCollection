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
Class Sample.DBExpansion.Data.GlobalAnalysisInfo Extends %Persistent
{

Property GlobalName As %String(MAXLEN = 200);

Property ClassName As %String(MAXLEN = 200);

Property AllocatedMB As %Float;

Property UsedMB As %Float;

Property MetaDataID As %Integer;

Index MetaDataIDIndex On MetaDataID;

ForeignKey DBAnalysisInfoFK(MetaDataID) References Sample.DBExpansion.Data.DBAnalysisInfo() [ OnDelete = cascade ];

// this instead of a one to many relationship

Storage Default
{
<Data name="GlobalAnalysisInfoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>GlobalName</Value>
</Value>
<Value name="3">
<Value>ClassName</Value>
</Value>
<Value name="4">
<Value>AllocatedMB</Value>
</Value>
<Value name="5">
<Value>UsedMB</Value>
</Value>
<Value name="6">
<Value>TimeStamp</Value>
</Value>
<Value name="7">
<Value>MetaDataID</Value>
</Value>
</Data>
<DataLocation>^Sample.DBE95BC.GlobalAnaly9E3AD</DataLocation>
<DefaultData>GlobalAnalysisInfoDefaultData</DefaultData>
<ExtentSize>148</ExtentSize>
<IdLocation>^Sample.DBE95BC.GlobalAnaly9E3AD</IdLocation>
<IndexLocation>^Sample.DBE95BC.GlobalAnaly9E3AI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(1,10,20,30,40,50,60,70,80,90,100,110,120,130,139,148),$lb(1,0,0,0,0,0,0,0,0,0,1,1,1,2,1),$lb(822083584,0,805306368,825229312,842006528,842006528,858783744,858783744,875560960,875560960,892338176,892338176,909115392,909115392,925892608,925892608,942669824,942669824,959447040,959447040,825241600,808452096,825229312,825229312,842006528,842006528,858783744,805306368,956301312,859373568,876085248,825505792))</Histogram>
<Selectivity>1</Selectivity>
</Property>
<Property name="AllocatedMB">
<AverageFieldSize>3.99</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(.008,.008,.008,.008,.008,.008,.008,.008,.008,.008,.008,.016,.039,.13,1.1,57),$lb(4,4,4,4,4,4,4,4,4,4,2,2,1,0,0),$lb(774910008,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,808976384,825622528,825622528,859373568,808663296,825425920,774976256,825110784,825110784,892796928,892796928))</Histogram>
<OutlierSelectivity>.695946:.008</OutlierSelectivity>
<Selectivity>1.2669%</Selectivity>
</Property>
<Property name="ClassName">
<AverageFieldSize>8.08</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," "," "," "," "," "," "," "," "," "," ARITESTING.DEMOTABLEELAD.CLS"," CINEMA.REVIEW.CLS"," FCE.CURRENCYORDER.CLS"," SAMPLE.DBEXPANSION.DATA.DBANALYSISINFO.CLS"," USER.PATIENTDATA.CLS"),$lb(2,2,2,2,2,2,2,2,2,2,1,1,1,1,1),$lb(536870912,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1095911764,1095911764,1128877637,1128877637,1178813742,1178813742,1396788560,1396788560,1431520594,542462789))</Histogram>
<OutlierSelectivity>.736486:</OutlierSelectivity>
<Selectivity>1.1457%</Selectivity>
</Property>
<Property name="GlobalName">
<AverageFieldSize>19.05</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" ALLOCATEDMB"," BARE.BSQW.2"," CINEMAOOFILMCATEGORYI"," DEEPSEE.FOLDERITEMI"," ENS.ACTIVITY.DATA.SECONDSI"," ENS.BUSINESSPROCESSI"," ENS.CONFIGURATION"," ENS.QUEUE"," ENS.UTIL.LOGI"," ENSHL7.SEGMENT"," FCE.BRANCHD"," HS.FHIRMETA.STORAGE.RSRCD"," HS.XF.VALUESET"," SAMPLE.COMPANYI"," SIMPLE.HUMANI"," ZIPCODEDATA"),$lb(1,1,1,1,5,5,5,5,4,1,1,4,1,2,1),$lb(541150284,1095519311,1111577157,1111577157,1128877637,1128877637,1145390416,1145390416,1162761006,1094931529,1112888137,1112888137,1129270854,1129270854,1364542805,1364542805,1431587148,777344073,1212954414,1162761032,1178813742,1178813742,1213410886,1179142482,1480994390,1213410904,1396788560,1095585868,1229803596,1397312848,1514754115,542787920))</Histogram>
<Selectivity>0.6757%</Selectivity>
</Property>
<Property name="MetaDataID">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),$lb(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),$lb(822083584,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,822083584))</Histogram>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="TimeStamp">
<AverageFieldSize>21</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb("2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39","2023-04-20 09:16:39"),$lb(20,20,20,20,20,20,20,20,20,20,20,20,20,20,20),$lb(842019379,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,842019379))</Histogram>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="UsedMB">
<AverageFieldSize>3.08</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(0,0,0,0,0,0,0,.001,.001,.003,.005,.014,.032,.11,.89,49),$lb(1,1,1,1,1,1,0,4,3,3,2,2,1,1,0),$lb(805306368,0,0,0,0,0,0,0,0,0,0,0,0,805306368,774910001,0,0,822083584,855638016,855638016,889192448,808779776,825491456,825491456,858914816,808661504,825294848,825294848,943259648,775436544,876150784,876150784))</Histogram>
<OutlierSelectivity>.452703:0</OutlierSelectivity>
<Selectivity>1.1898%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-8</BlockCount>
</SQLMap>
<SQLMap name="MetaDataIDIndex">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Sample.DBE95BC.GlobalAnaly9E3AS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
