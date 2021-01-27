#include <stdio.h>
#include <stdlib.h>
#define FAILED NULL

typedef struct NODE *TREE;
struct NODE {
	char label;
	TREE leftmostChild, rightSibling;
};

TREE makeNode0(char x);
TREE makeNode1(char x, TREE t);
TREE makeNode4(char x, TREE t1, TREE t2, TREE t3, TREE t4);
TREE B();

TREE parseTree; /* holds the result of the parse */
char *nextTerminal; /* current position in input string */

int main()
{
	nextTerminal = "()()"; /* in practice, a string
		of terminals would be read from input */
	parseTree = B();
}

TREE makeNode0(char x)
{
	TREE root;

	// Create tree with node x without right or left children
	root = (TREE) malloc(sizeof(struct NODE));
	root->label = x;
	root->leftmostChild = NULL;
	root->rightSibling = NULL;
	return root;
}

/* Creates node with one child */
TREE makeNode1(char x, TREE t)
{
	TREE root;
	// Creates root node and users funcion makeNode0 to trace single node tree conditions
	root = makeNode0(x);
	root->leftmostChild = t;
	return root;
}

/* Creates node with 2 children */
TREE makeNode2(char x, TREE t1, TREE t2)
{
    TREE root;

    root = makeNode1(x, ta);
    t1->rightSibling = t2;
    return root;
}

/* Creates node with 3 children */
TREE makaeNode3(char x, TREE t1, TREE t2, TREE t3)
{
    TREE root;

    root = makeNode1(x, t1);
    t1->rightSibling = t2;
    t2->rightSibling = t3;
    return root;
}

/* Creates node with 4 children */
TREE makeNode4(char x, TREE t1, TREE t2, TREE t3, TREE t4)
{
	TREE root;

	root = makeNode1(x, t1);
	t1->rightSibling = t2;
	t2->rightSibling = t3;
	t3->rightSibling = t4;
	return root;
}

TREE firstB()
{

}

TREE secondB()
{

}

TREE B()
{
	TREE firstB, secondB;

	if(*nextTerminal == '(') /* follow production 2 */ {
		nextTerminal++;
		firstB = B();
		if(firstB != FAILED && *nextTerminal == ')') {
			nextTerminal++;
			secondB = B();
			if(secondB == FAILED)
				return FAILED;
			else
				return makeNode4('B',
					makeNode0('('),
					firstB,
					makeNode0(')'),
					secondB);
		}
		else /* first call to B failed */
			return FAILED;
	}
	else /* follow production 1 */
		return makeNode1('B', makeNode0('e'));
}
