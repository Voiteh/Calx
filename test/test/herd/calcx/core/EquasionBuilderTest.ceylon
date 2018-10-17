import ceylon.test {
	test
}
import herd.calcx.core.api {
	equasionBuilder,
	Parent,
	Data,
	Expression,
	Computable,
	sum,
	Group
}

shared class EquasionBuilderTest() {
	
	shared test
	void shouldCreateEmptyEquasion() {
		value eq = equasionBuilder.build;
		assert (eq.children.empty);
	}
	
	shared test
	void shouldCreateAGroup() {
		value eq = equasionBuilder.appender.group(Group(true)).close.build;
		assert (eq.children.size == 1);
		assert (is Parent parent = eq.children.first);
	}
	shared test
	void shouldCreateSimpleValueInEquasion() {
		value eq = equasionBuilder.appender.numeric(12.03).close.build;
		assert (eq.children.size == 1);
		assert (is Data data = eq.children.first);
		assert (is Float float = data.item, float == 12.03);
	}
	shared test
	void shouldCreateSimpleEquasion() {
		value eq = equasionBuilder.appender
			.numeric(12.03)
			.operator(sum)
			.numeric(10)
			.close
			.build;
		assert (eq.children.size == 3);
		assert (is Data first = eq.children.first, is Float firstData = first.item, firstData == 12.03);
		assert (is Data last = eq.children.last, is Float lastData = last.item, lastData == 10.0);
		assert (exists sumExpression = eq.children.find((Expression element) => element is Computable));
	}
	shared test
	void shouldCreateEquasionWithAGroup() {
		value eq = equasionBuilder.appender.group(Group(true))
			.numeric(12).operator(sum).numeric(10)
			.group(Group(false))
			.operator(sum).numeric(4)
			.close.build;
		assert (eq.children.size == 3);
		assert (is Parent group = eq.children.first);
		assert (group.children.size == 3);
		assert (is Data last = eq.children.last, is Float lastData = last.item, lastData == 4.0);
	}
}
