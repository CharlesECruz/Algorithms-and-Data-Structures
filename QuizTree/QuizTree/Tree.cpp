// QuizTree.cpp : This file contains the 'main' function. Program execution begins and ends there.


#include <iostream>
#include <vector>
#include <sstream>
#include <queue>
#include <string>
using namespace std;
//
//struct Node {
//    int data;
//    vector<Node *>child;
//};
Node* newNode(int newData)
{
    Node* temp = new Node;
    temp->data = newData;
    return temp;
}
Node* searchNodo(Node* root,int value) {
    if (root == NULL) {
        return NULL;
    }
    queue <Node*>q;
    q.push(root);
    while (!q.empty()){
        int n = q.size();
        while(n > 0){
            Node* p = q.front();
            q.pop();
            if (p->data == value){
                return p;
            }else {
                for (int i = 0; i < p->child.size(); i++)
                    q.push(p->child[i]);
                n--;
            }
        }
    }
}
void printParents(Node* root) {

    queue<Node*> q;
    q.push(root);
    //Put the child of the first 
    /*Node* firstNode = q.front();
    q.pop();
    for (int i = 0; i < firstNode->child.size(); i++)
        q.push(firstNode->child[i]);*/
    while (!q.empty()) {
        int size = q.size();
        while (size > 0) {
            Node* currentNode = q.front();
            q.pop();
            
            for (int i = 0; i < currentNode->child.size(); i++) {
                cout << currentNode->data << "\n";
                q.push(currentNode->child[i]);
            }   
            size--;
        }
    }

}
void receiveInputPrintParents(Node * root) {
    cout << "Input Specification\nFirstline: N(# of nodes, 2 <= N <= 100, 000)'n N - 1 lines : A B(edge from node A to B, space - separated)\n";
    string input;
    getline(cin, input);
    for (int i = 0; i < stoi(input) - 1; i++) {
        string line;
        getline(cin, line);
        int posDelimiter = line.find(" ");
        int A = stoi(line.substr(0, posDelimiter));
        int B = stoi(line.substr(posDelimiter + 1, line.size()));
        if (i == 0) {
            root = newNode(A);
            (root->child).push_back(newNode(B));
        } 
        Node* searchA = searchNodo(root, A);
        Node* searchB = searchNodo(root, B);
        if (searchA == NULL && searchB != NULL) {
            searchA = newNode(A);
            searchB->child.push_back(searchA);
        }else if (searchA != NULL && searchB == NULL) {
            searchB = newNode(B);
            searchA ->child.push_back(searchB);
        }
    }
    
    printParents(root);
}