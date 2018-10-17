shared class CharacterInfo(Character character) {
	KnownCharacter? knownCharacter=knownCharacters.find((KnownCharacter elem) => elem.character==character);
	shared Boolean number = character.digit || (if(exists knownCharacter, knownCharacter==dot) then true else false);
	shared Boolean group =  if(exists knownCharacter, knownCharacter==openBrace || knownCharacter==closeBrace) then true else false;
	shared Boolean operator = if (exists knownCharacter, knownCharacter==plus || knownCharacter==minus || knownCharacter==slash|| knownCharacter==star) then true else false;
	shared actual String string = character.string;
}
