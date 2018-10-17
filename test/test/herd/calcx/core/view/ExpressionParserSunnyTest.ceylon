import herd.calcx.core.view {
	ExpressionParser
}
import ceylon.test {
	test
}
import herd.calcx.core.api {
	Expression,
	Parent,
	Data
}

shared class ExpressionParserSunnyTest() {
	
	value expressionParser = ExpressionParser();
	
	shared test
	void shouldParseSimpleInteger() {
		
		assert (is Expression&Parent parse = expressionParser.parse("123"));
		assert (is Data data = parse.children.first);
		assert (is Float number = data.item, number == 123.0);
	}
	
	shared test
	void shouldParseSimpleFloat() {
		assert (is Expression&Parent parse = expressionParser.parse("123.0"));
		assert (is Data data = parse.children.first);
		assert (is Float number = data.item, number == 123.0);
	}
	
	shared test
	void shouldParseSimpleExpression() {
		assert (is Expression&Parent parse = expressionParser.parse("12.3+8-22/5*9"));
		assert (is Data first = parse.children.first);
		assert (is Data last = parse.children.last);
		assert (is Float number = first.item, number == 12.3);
		assert (is Float other = last.item, other == 9.0);
	}
	shared test
	void shouldParseComplexExpression() {
		assert (is Expression&Parent parse = expressionParser.parse("512/(21*(5+2))"));
		assert (is Data first = parse.children.first, is Float firstVal = first.item, firstVal == 512.0);
		assert (is Expression&Parent firstGroup = parse.children.last);
		assert (is Data firstInGroup = firstGroup.children.first, is Float firstInGroupVal = firstInGroup.item, firstInGroupVal == 21.0);
		assert (is Expression&Parent lastGroup = firstGroup.children.last);
		assert (is Data firstInLastGroup = lastGroup.children.first, is Float firstInLastGroupVal = firstInLastGroup.item, firstInLastGroupVal == 5.0);
		assert (is Data lastInLastGroup = lastGroup.children.last, is Float lastInLastGroupVal = lastInLastGroup.item, lastInLastGroupVal == 2.0);
	}
	shared test
	void shouldParseHierarchialGroupExpression() {
		assert (is Expression&Parent parse = expressionParser.parse("((20/(4+1))/4)-4"));
		assert (is Expression&Parent lvlOneGroup = parse.children.first);
		assert (is Data last = parse.children.last, is Float val = last.item, val == 4.0);
		assert (is Expression&Parent lvlTwoGroup = lvlOneGroup.children.first);
		assert (is Data lastInLvlOneGroup = lvlOneGroup.children.last, is Float lvlOneGroupVal = lastInLvlOneGroup.item, lvlOneGroupVal == 4.0);
		assert (is Data levelTwoGroupFirst = lvlTwoGroup.children.first, is Float lvlTwoGroupFirstVal = levelTwoGroupFirst.item, lvlTwoGroupFirstVal == 20.0);
	}
	shared test
	void shouldParseExpression(){
		assert (is Expression&Parent parse = expressionParser.parse("(12+1-5)/8"));
		assert(is Expression&Parent lvlOneGroup=parse.children.first);
		assert(is Data last=parse.children.last);
	}
}
