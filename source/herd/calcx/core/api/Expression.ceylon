import herd.calcx.core.model {
	Equasion
}

shared interface Expression of Computable | Data {
	shared formal Handle handle;
	
	shared interface Builder {
		shared formal Computable&Parent build;
		shared formal Mutator appender;
	}
	
	shared default Builder builder => Equasion().builder;
}

shared interface Data satisfies Expression {
	shared formal Anything item;
	shared actual String string{
		return if(exists it =item) then it.string else "null";
	}
}

shared interface Computable satisfies Expression {
	shared formal Priority priority;
	shared formal Data compute;
}
shared Expression.Builder expressionBuilder => Equasion().builder;