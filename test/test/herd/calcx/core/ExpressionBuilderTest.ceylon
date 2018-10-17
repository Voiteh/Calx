import ceylon.test {
	test
}
import herd.calcx.core.api {
	expressionBuilder,
	subtraction,
	Data,
	Computable,
	open,
	sum,
	close,
	division
}


shared class ExpressionBuilderTest() {
	
	
	shared test void shouldBuildSimpleExpression(){
		value expression=expressionBuilder.appender.numeric(25).operator(subtraction).numeric(10).close.build;
		assert(is Data first=expression.children.first,is Float firstValue=first.item,firstValue==25.0);
		assert(is Computable second=expression.children.rest.first,second.string=="-");
		assert(is Data third=expression.children.rest.rest.first,is Float thirdValue=third.item,thirdValue==10.0);
	}
	
	shared test void shouldComputeSimpleExpression(){
		Data compute = expressionBuilder.appender.group(open)
				.numeric(13).operator(sum).numeric(8)
				.group(close)
				.operator(division).numeric(7)
				.close.build.compute;
		assert(is Float result=compute.item,result==3.0);
		
	}
	
	
	
}