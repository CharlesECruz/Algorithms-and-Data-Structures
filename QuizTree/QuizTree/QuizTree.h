#pragma once
#include "QuizTree.cpp"

void receiveInput();
Node* newNode(int newData, Node* parent);
int main();
Node* searchNodo(Node* root, int value);
void printParents(Node* root);
void receiveInputPrintParents(Node* root);
int minDistance(vector<int> dist, vector<bool> sptSet);