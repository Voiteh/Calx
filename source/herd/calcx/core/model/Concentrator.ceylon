import ceylon.collection {
	ArrayList,
	MutableList
}
import herd.calcx.core.api {
	Handle,
	Priority,
	priorities,
	Data,
	high,
	Expression,
	Computable,
	Mutator,
	Parent
}

shared abstract class Concentrator(parent) of Equasion | Gathering satisfies Computable & Parent {
	shared formal Integer level;
	shared actual Priority priority => high;
	shared default Concentrator? parent;
	shared actual MutableList<Expression> children = ArrayList<Expression>();
	
	Integer? childIndex(Expression expr) {
		return children.indexesWhere((Expression element) => expr == element).first;
	}
	
	shared actual Handle handle = object satisfies Handle {
		
		shared actual Expression? left(Expression center) {
			if (exists find = outer.childIndex(center)) {
				return children.get(find - 1);
			}
			return null;
		}
		
		shared actual Expression? right(Expression center) {
			if (exists find = outer.childIndex(center)) {
				return children.get(find + 1);
			}
			return null;
		}
	};
	shared actual Data compute {
		value executors = children.narrow<Computable>().sequence();
		for (value priority in priorities) {
			value byPriority = executors.filter((Computable element) => element.priority == priority);
			for (value element in byPriority) {
				value result = element.compute;
				switch (element)
				case (is Calculator) {
					if (exists left = element.handle.left(element)) {
						children.remove(left);
					}
					if (exists right = element.handle.right(element)) {
						children.remove(right);
					}
				}
				case (is Concentrator) {
					children.removeAll(element.children);
				}
				else {
					throw Exception("Unhandled case ``element``");
				}
				children.replace(element, result);
			}
		}
		assert (is Data first = children.first);
		assert(is Data last=children.last);
		assert(first==last);
		return first;
	}
	shared actual Expression.Builder builder => object satisfies Expression.Builder {
		shared actual Mutator appender => Appender(outer);
		
		shared actual Computable&Parent build => outer;
	};
	shared actual String string => "Priority: ``priority``, Level: ``level``, Children: ``children.string``";
}
shared class Gathering(parent) extends Concentrator(parent) {
	shared actual Concentrator parent;
	shared actual Integer level = parent.level + 1;
}

shared class Equasion() extends Concentrator(null) {
	shared actual Null parent = null;
	shared actual Integer level = 0;
}