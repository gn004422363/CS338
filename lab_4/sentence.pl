nouns(boy). /* nouns */
nouns(girl).
nouns(dog).
nouns(cat).
verbs(sees). /* verbs */
verbs(pets).
article(a). /* article */
article(the).
noun_phrase([X,Y]):-article(X),nouns(Y).
verb_phrase([X|Y]):-verbs(X),noun_phrase(Y).
sentence([X,Y|Z]):-noun_phrase([X,Y]),verb_phrase(Z).
