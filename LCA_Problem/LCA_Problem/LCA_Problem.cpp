// LCA_Problem.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <vector>
#include <sstream>
#include <queue>
#include <string>
#include <stack>
using namespace std;
vector<int>valuesNode;
int numberNode;
struct Node {
    int data = NULL;
    vector<Node*>child;
    Node* parent = NULL;
};
Node* newNode(int newData, Node* parent) {
    Node* temp = new Node;
    temp->data = newData;
    temp->parent = parent;
    return temp;
}
Node* searchNodo(Node* root, int value) {
    if (root == NULL) {
        return NULL;
    }
    queue <Node*>q;
    q.push(root);
    while (!q.empty()) {
        int n = q.size();
        while (n > 0) {
            Node* p = q.front();
            q.pop();
            if (p->data == value) {
                return p;
            }
            else {
                for (int i = 0; i < p->child.size(); i++)
                    q.push(p->child[i]);
                n--;
            }
        }
    }
}
vector<int> getAncestor(Node* root){
    vector<int> ancestors;
    ancestors.push_back(root->data);
    while (root->parent!= NULL) {
        ancestors.push_back(root->parent->data);
        Node* temp = root->parent;
        root = temp;
    }
    return ancestors;
}
int firstCoincidence(vector<int>A, vector<int>B) {
    for (int i : A) {
        for (int j : B) {
            if (i == j)
                return i;
        }
    }
    return NULL;
}

void LowestCommonAncestor(Node* root) {
    cout << "Input Specification\nFirst line : N(The number of nodes, 2 <= N <= 50, 000)\nNext N - 1 lines : two nodes connected on the tree are given.\nN + 1 th line : M(The number of pairs to process LCA, 1 <= M <= 10, 000)\nNext M lines : each line represents two nodes to get the LCA\n";
    string input;
    getline(cin, input);
    for (int i = 0; i < stoi(input) - 1; i++) {
        string line;
        getline(cin, line);
        int posDelimiter = line.find(" ");
        int A = stoi(line.substr(0, posDelimiter));
        int B = stoi(line.substr(posDelimiter + 1, line.size()));
        if (i == 0) {
            root = newNode(A, NULL);
            (root->child).push_back(newNode(B, root));
            valuesNode.push_back(B);
        }
        Node* searchA = searchNodo(root, A);
        Node* searchB = searchNodo(root, B);
        if (searchA == NULL && searchB != NULL) {
            valuesNode.push_back(A);
            searchA = newNode(A, searchB);
            searchB->child.push_back(searchA);
        }
        else if (searchA != NULL && searchB == NULL) {
            valuesNode.push_back(B);
            searchB = newNode(B, searchA);
            searchA->child.push_back(searchB);
        }
    }
    string numData;
    getline(cin, numData);
    Node* NodeA;
    Node* NodeB;
    vector<int>answer;
    for (int i = 0; i < stoi(numData); i++){
        string lineData;
        getline(cin, lineData);
        int posDelimiter = lineData.find(" ");
        int A = stoi(lineData.substr(0, posDelimiter));
        int B = stoi(lineData.substr(posDelimiter + 1, lineData.size()));
        NodeA = searchNodo(root, A);
        NodeB = searchNodo(root, B);
        if (NodeA != NULL && NodeB != NULL){
            vector<int>ancestorA = getAncestor(NodeA);
            vector<int>ancestorB = getAncestor(NodeB);
            answer.push_back( firstCoincidence(ancestorA, ancestorB) );
        }else
        {
            answer.push_back(INT_MAX);
        }
        
        
    }
    for (int i : answer) {
        if (i == INT_MAX) {
            cout << "Node not found\n";
        }else {
            cout << i << "\n";
        }
            
    }
}

int main()
{
    while (true) {
        Node* root{};
        LowestCommonAncestor(root);
    }
}