import ceylon.test {
	test
}
import herd.calcx.core.api {
	equasionBuilder,
	sum,
	division,
	Group
}
import herd.calcx.core.view {
	StringView
}

shared class StringViewTest() {
	
	shared test
	void shouldCrateSimpleView() {
		value eq = equasionBuilder.appender
			.numeric(12.03).operator(sum).numeric(5)
			.close.build;
		assert (StringView(eq).string == "12.03+5");
	}
	shared test
	void shouldCreateStringViewWithGroup() {
		value eq = equasionBuilder.appender.group(Group(true))
			.numeric(12).operator(sum).numeric(10)
			.group(Group(false))
			.operator(division).numeric(4)
			.close.build;
		assert (StringView(eq).string == "(12+10)/4");
	}
}
