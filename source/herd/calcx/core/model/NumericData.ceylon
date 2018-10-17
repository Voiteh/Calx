import herd.calcx.core.api {
	Data,
	Handle
}

shared class NumericData(Integer|Float input, handle) satisfies Data {
	shared actual Handle handle;
	shared actual Float item=if(is Integer input) then input.float else input;
	
}
