#include <stdio.h>
#include <stdlib.h>

typedef struct Node
{
	struct Node *next;
	int data;
} Node;
typedef struct
{
	Node *head;
} List;
extern Node *get_two_thirds_node(List *);

int main(void)
{
	int n;
	scanf("%d", &n);

	Node *nodes = malloc(n * sizeof(Node));
	for (int i = 0; i < n; ++i)
	{
		nodes[i].next = (i + 1 < n) ? &nodes[i + 1] : NULL;
		nodes[i].data = i;
	}

	List list = {nodes};
	Node *res = get_two_thirds_node(&list);

	printf("%d\n", res ? res->data : -1);
}