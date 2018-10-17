import herd.calcx.core.api {
	Mutator,
	expressionBuilder,
	Parent,
	Group,
	Operator,
	Computable
}

shared class ExpressionBuilderFacade() {
	
	variable value appender = expressionBuilder.appender;
	Mutator innerAppend(Input input) {
		
		switch (input)
		case (is Float|Integer) {
			return appender.numeric(input);
		}
		case (is Operator) {
			return appender.operator(input);
		}
		case (is Group) {
			return appender.group(input);
		}
	}
	shared void append(Input input) {
		appender = innerAppend(input);
	}
	shared Computable&Parent build => appender.close.build;
}
