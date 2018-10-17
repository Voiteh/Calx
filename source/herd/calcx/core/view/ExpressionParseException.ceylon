shared class ExpressionParseException(expression,index,cause) extends Exception("Parsing expression ``expression`` faild",cause){
	
	shared Integer index;
	shared String expression;
	Exception cause;
	
}