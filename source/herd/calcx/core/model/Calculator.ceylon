import herd.calcx.core.api {
	Computable,
	Data,
	Priority,
	low,
	Handle,
	medium,
	Expression
}

shared alias Operand => Float(Float, Float);

shared abstract class Calculator(Handle handle) of Sum | Subtraction | Multiplication | Division satisfies Computable {
	
	shared formal Operand operand;
	
	Float extractData(Expression? input) {
		if (exists Expression inputExpression = input) {
			assert (is Data inputExpression);
			switch (inputExpression)
			case (is NumericData) {
				return inputExpression.item;
			}
			else {
				throw Exception("Expression type not handled ``inputExpression``");
			}
		}
		return 0.float;
	}
	
	shared actual default Data compute {
		Float left = extractData(handle.left(this));
		Float right = extractData(handle.right(this));
		return NumericData(operand(left, right), handle);
	}
	
}
shared class Sum(handle) extends Calculator(handle) {
	shared actual Handle handle;
	
	shared actual Priority priority => low;
	
	shared actual Operand operand = function(Float one, Float two) {
		return one.plus(two);
	};
	shared actual String string => "+";
}

shared class Subtraction(handle) extends Calculator(handle) {
	shared actual Handle handle;
	
	shared actual Priority priority => low;
	
	shared actual String string = "-";
	shared actual Operand operand = function(Float one, Float two) {
		return one.minus(two);
	};

}

shared class Division(handle) extends Calculator(handle) {
	shared actual Handle handle;
	
	shared actual Priority priority = medium;
	
	shared actual Operand operand = function(Float one, Float two) {
		return one.divided(two);
	};
	shared actual String string => "/";
}
shared class Multiplication(handle) extends Calculator(handle) {
	
	shared actual Handle handle;
	shared actual Priority priority = medium;
	
	shared actual Operand operand = function(Float one, Float two) {
		return one.times(two);
	};
	shared actual String string => "*";
}
