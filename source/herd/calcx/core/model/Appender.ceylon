import herd.calcx.core.api {
	Mutator,
	Data,
	Expression,
	Operator,
	sum,
	subtraction,
	division,
	multiplication,
	Group
}

shared class Appender(Concentrator current, Mutator? parent = null) satisfies Mutator {
	
	shared actual Mutator group(Group group) {
		switch (group.open)
		case (true) {
			Concentrator concentrator;
			concentrator = Gathering(current);
			current.children.add(concentrator);
			return Appender(concentrator, this);
		}
		case (false) {
			assert (exists parent);
			return parent;
		}
	}
	
	shared actual Mutator numeric(Float|Integer data) {
		Data wholeData = NumericData(data, current.handle);
		current.children.add(wholeData);
		return this;
	}
	shared actual Mutator operator(Operator operator) {
		switch (operator)
		case (sum) {
			current.children.add(Sum(current.handle));
		}
		case (subtraction) {
			current.children.add(Subtraction(current.handle));
		}
		case (multiplication) {
			current.children.add(Multiplication(current.handle));
		}
		case (division) {
			current.children.add(Division(current.handle));
		}
		
		return this;
	}
	shared actual Mutator remove {
		if (current.children.empty) {
			assert (exists parent = current.parent);
			parent.children.remove(current);
			if (exists mutator = this.parent) {
				return mutator;
			}
			throw ParseException("Can't delete Equasion element");
		} else {
			current.children.deleteLast();
			return this;
		}
	}
	shared actual Expression.Builder close => ancestor(current).builder;
	
	Concentrator ancestor(Concentrator current) {
		if (exists parent = current.parent) {
			return ancestor(parent);
		}
		return current;
	}
}
