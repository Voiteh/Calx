import ceylon.language.meta {
	classDeclaration
}
shared abstract class Priority() of high | medium | low {
	shared actual String string{
		value objectValue = classDeclaration(this).objectValue;
		assert(exists objectValue);
		return objectValue.name;
	}
}
shared object high extends Priority() {}
shared object medium extends Priority() {}
shared object low extends Priority() {}

shared {Priority*} priorities = `Priority`.caseValues;
