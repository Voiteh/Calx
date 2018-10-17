import ceylon.test {
	test
}
import herd.calcx.core.api {
	expressionBuilder,
	sum,
	division,
	open,
	close
}
import herd.calcx.core.view {
	StringView
}

shared class StringViewTest() {
	
	shared test
	void shouldCrateSimpleView() {
		value eq = expressionBuilder.appender
			.numeric(12.03).operator(sum).numeric(5)
			.close.build;
		assert (StringView(eq).string == "12.03+5");
	}
	shared test
	void shouldCreateStringViewWithGroup() {
		value eq = expressionBuilder.appender.group(open)
			.numeric(12).operator(sum).numeric(10)
			.group(close)
			.operator(division).numeric(4)
			.close.build;
		assert (StringView(eq).string == "(12+10)/4");
	}
}
