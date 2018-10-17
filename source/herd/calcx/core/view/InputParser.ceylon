import herd.calcx.core.api {
	Group,
	Operator,
	sum,
	subtraction,
	multiplication,
	division
}

shared alias Input => Float|Integer|Operator|Group;
shared class InputParser() {
	
	
	shared Float|Integer|ParseException parseNumber(String val) {
		if (val.contains(dot.character)) {
			return Float.parse(val);
		}
		return Integer.parse(val);
	}
	shared Operator|ParseException parseOperator(String val) {
		KnownCharacter? character = knownCharacters.find((KnownCharacter elem) => elem.matchesFirstFrom(val));
		switch (character)
		case (plus) {
			return sum;
		}
		case (minus) {
			return subtraction;
		}
		case (slash) {
			return division;
		}
		case (star) {
			return multiplication;
		}
		else {
			return ParseException("Unparsable operator ``val``");
		}
	}
	shared Group|ParseException parseGroup(String val) {
		KnownCharacter? character = knownCharacters.find((KnownCharacter elem) => elem.matchesFirstFrom(val));
		switch (character)
		case (openBrace) {
			return Group(true);
		}
		case (closeBrace) {
			return Group(false);
		}
		else {
			return ParseException("Unparsable group ``val``");
		}
	}
	shared Input|ParseException parseInput(String input) {
		if (is Operator op = parseOperator(input)) {
			return op;
		} else if (is Group grp = parseGroup(input)) {
			return grp;
		} else if (is Integer|Float nmbr = parseNumber(input)) {
			return nmbr;
		}
		return ParseException("Unparsable expression ``input``");
	}
}
