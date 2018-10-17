import herd.calcx.core.view {
	ExpressionParser
}
import ceylon.test {
	test
}
import herd.calcx.core.api {
	Computable
}
shared class IntegrationTest() {
	
	value expressionParser=ExpressionParser();
	
	shared test
	void shouldComputeSimpleIntegerExpression(){
		assert(is Computable parse = expressionParser.parse("12"));
		assert(is  Float compute = parse.compute.item,compute==12.0);
	}
	
	shared test 
	void shouldComputeSimpleExpression(){
		assert(is Computable parse = expressionParser.parse("12+9/3"));
		assert(is  Float compute = parse.compute.item,compute==15.0);
		
	}
	shared test
	void shouldComputeGroupedExpression(){
		assert(is Computable parse = expressionParser.parse("(12+9)/3"));
		assert(is  Float compute = parse.compute.item,compute==7.0);
	}
	shared test
	void shouldComputeComplexExpression(){
		assert(is Computable parse = expressionParser.parse("(12+9)/((3-2)*3)"));
		assert(is  Float compute = parse.compute.item,compute==7.0);
	}
	shared test
	void shouldComputeAnotherExpression(){
		assert(is Computable parse = expressionParser.parse("(12+1-5)/8"));
		assert(is Float compute = parse.compute.item,compute==1.0);
	}
	
	
	
}