import herd.calcx.core.api {
	Expression,
	Parent,
	Computable
}
import ceylon.collection {
	ArrayList
}

shared class ExpressionParser() {
	
	
	
	Boolean newInput(Character? lastChar, Character currentChar) {
		value currentCharInfo = CharacterInfo(currentChar);
		value lastCharInfo = if (exists lastChar) then CharacterInfo(lastChar) else null;
		if (exists lastCharInfo, lastCharInfo.group || lastCharInfo.operator) {
			return true;
		} else if (currentCharInfo.group || currentCharInfo.operator) {
			return true;
		}
		return false;
	}
	
	{String*}|<Integer->ParseException> divide(String expression) {
		value expressions = ArrayList<String>();
		variable value numberBuilder = StringBuilder();
		for (value char in expression.indexed) {
			value currentInfo = CharacterInfo(char.item);
			if(currentInfo.operator||currentInfo.group){
				if(!numberBuilder.empty){
					expressions.add(numberBuilder.string);
					numberBuilder=StringBuilder();
				}
				expressions.add(char.item.string);
			}else if(currentInfo.number){
				numberBuilder.appendCharacter(char.item);
			}
			else{
				value error = ParseException("Unparsable symbol ``char``");
				return char.key->error;
			}
		}
		if(!numberBuilder.empty){
			expressions.add(numberBuilder.string);
		}
		return expressions;
	}
	<Computable&Parent>|<Integer->ParseException> parseDivided({String*} divided) {
		value expressionBuilder = ExpressionBuilderFacade();
		value inputParser = InputParser();
		variable Integer currentIndex=0;
		for(value expr in divided){
			value input = inputParser.parseInput(expr);
			switch(input)
			case (is Input) {
				expressionBuilder.append(input);
				currentIndex+=expr.size;
			}
			case (is ParseException) {
				return currentIndex->input;
			}
		}
		return expressionBuilder.build;
	}
	
	shared <Computable&Parent>|<ExpressionParseException> parse(String expression) {
		
		{String*}|<Integer->ParseException> divided = divide(expression);
		switch(divided)
		case (is {String*}) {
			value result = parseDivided(divided);
			switch (result)
			case (is Computable&Parent) {
				return result;
			}
			case (is Integer->ParseException) {
				return ExpressionParseException(expression, result.key, result.item);
			}
		}
		case (is Integer->ParseException) {
			return ExpressionParseException(expression, divided.key, divided.item);
		}
		
	}
}