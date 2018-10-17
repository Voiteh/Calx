shared abstract class KnownCharacter(shared Character character)
		of plus | minus | slash | star | dot | openBrace | closeBrace {
	
	shared Boolean matches(Character char) {
		return character == char;
	}
	shared Boolean matchesFirstFrom(String str) {
		if (exists first = str.first) {
			return matches(first);
		}
		return false;
	}
	
	shared actual String string = character.string;
}
shared object plus extends KnownCharacter('+') {}
shared object minus extends KnownCharacter('-') {}
shared object slash extends KnownCharacter('/') {}
shared object star extends KnownCharacter('*') {}
shared object dot extends KnownCharacter('.') {}
shared object openBrace extends KnownCharacter('(') {}
shared object closeBrace extends KnownCharacter(')') {}

shared KnownCharacter[] knownCharacters = `KnownCharacter`.caseValues;
