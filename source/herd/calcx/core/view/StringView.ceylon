import herd.calcx.core.api {
	Expression,
	Data
}
import herd.calcx.core.model {
	Concentrator,
	Calculator,
	Sum,
	Subtraction,
	Multiplication,
	Division,
	Gathering,
	Equasion
}

shared class StringView(Expression expression) {
	
	{StringView*} children;
	
	switch (expression)
	case (is Concentrator) {
		children = expression.children.map((Expression element) => StringView(element));
	}
	else {
		children = {};
	}
	
	shared actual String string {
		StringBuilder builder = StringBuilder();
		switch (expression)
		case (is Concentrator) {
			builder.append(openConcentrator(expression));
			children.each((StringView element) => builder.append(element.string));
			builder.append(closeConcentrator(expression));
		}
		case (is Calculator) {
			builder.append(calculatorString(expression));
		}
		case (is Data) {
			switch (data = expression.item)
			case (is Float) {
				if (data.fractionalPart == 0.0) {
					builder.append(data.integer.string);
				} else {
					builder.append(data.string);
				}
			}
			else {
				throw Exception("unknown data `` if (exists data) then data.string else "null" ``");
			}
		}
		else {
			throw Exception("``expression`` not handled");
		}
		return builder.string;
	}
}
String openConcentrator(Concentrator concentrator) {
	switch (concentrator)
	case (is Equasion) {
		return "";
	}
	case (is Gathering) {
		return openBrace.string;
	}
}
String closeConcentrator(Concentrator concentrator) {
	switch (concentrator)
	case (is Equasion) {
		return "";
	}
	case (is Gathering) {
		return closeBrace.string;
	}
}
String calculatorString(Calculator calculator) {
	switch (calculator)
	case (is Sum) {
		return plus.string;
	}
	case (is Subtraction) {
		return minus.string;
	}
	case (is Multiplication) {
		return star.string;
	}
	case (is Division) {
		return slash.string;
	}
}