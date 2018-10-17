import herd.calcx.core.view {
	ExpressionParser,
	ExpressionParseException
}
import ceylon.test {
	test
}
shared class ExpressionParserRainyTest() {
	
	
	
	value expressionParser = ExpressionParser();
	
	
	
	shared test
	void shouldIndicateErrorOnBeggining(){
		assert(is ExpressionParseException error = expressionParser.parse("a123"));
		assert(error.index==0);
	}
	
	shared test
	void shouldIndicateErrorOnSpecificIndex(){
		value expression="12.0+-2+b-20";
		assert(exists invalidSymbol = expression.indexed.find((Integer->Character element) => element.item=='b'));
		assert(is ExpressionParseException parse = expressionParser.parse(expression));
		assert(parse.index==invalidSymbol.key);
	}
	
}