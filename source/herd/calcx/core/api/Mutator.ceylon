
shared interface Mutator {
	
	shared formal Expression.Builder close;
	throws (`class ParseException`)
	shared formal Mutator numeric(Float|Integer data);
	throws (`class ParseException`)
	shared formal Mutator operator(Operator operator);
	throws (`class ParseException`)
	shared formal Mutator group(Group groupView);
	throws (`class ParseException`)
	shared formal Mutator remove;
}
