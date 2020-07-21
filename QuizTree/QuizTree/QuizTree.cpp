// QuizTree.cpp : This file contains the 'main' function. Program execution begins and ends there.
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
    int data;
    vector<Node *>child;
    Node* parent;
};
Node* newNode(int newData, Node * parent) {
    Node* temp = new Node;
    temp->data = newData;
    temp->parent = parent;
    return temp;
}
Node* searchNodo(Node* root,int value) {
    if (root == NULL){
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
    sort(valuesNode.begin(), valuesNode.end());
    for (int i = 0; i < valuesNode.size(); i++) {
        cout<<searchNodo(root, valuesNode[i])->parent->data<<"\n";
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
            root = newNode(A,NULL);
            (root->child).push_back(newNode(B,root));
            valuesNode.push_back(B);
        } 
        Node* searchA = searchNodo(root, A);
        Node* searchB = searchNodo(root, B);
        if (searchA == NULL && searchB != NULL) {
            valuesNode.push_back(A);
            searchA = newNode(A,searchB);
            searchB->child.push_back(searchA);
        }else if (searchA != NULL && searchB == NULL) {
            valuesNode.push_back(B);
            searchB = newNode(B,searchA);
            searchA ->child.push_back(searchB);
        }
    }
    printParents(root);
}

int minDistance(vector<int> cost, vector<bool> check){
    int min = INT_MAX;
    int min_index {};

    for (int i = 0; i < numberNode; i++)
        if (check[i] == false && cost[i] <= min)
            min = cost[i], min_index = i;

    return min_index;
}


int dijkstra(vector<vector<int>>graph, int posNode)
{
    vector<int> distances(numberNode,INT_MAX);
    vector<bool>checkNodes(numberNode,false);
    
    distances[posNode] = 0;

    // Find shortest path for all vertices 
    for (int count = 0; count < numberNode - 1; count++) {
        int min = minDistance(distances, checkNodes);

        // Mark the picked vertex as processed 
        checkNodes[min] = true;

        // Update dist value of the adjacent vertices of the picked vertex. 
        for (int currentNode = 0; currentNode < numberNode; currentNode++)

            // Update dist[v] only if is not in sptSet, there is an edge from 
            // u to v, and total weight of path from src to  v through u is 
            // smaller than current value of dist[v] 
            if (!checkNodes[currentNode] && graph[min][currentNode] && distances[min] != INT_MAX && distances[min] + graph[min][currentNode] < distances[currentNode]) {
                distances[currentNode] = distances[min] + graph[min][currentNode];
            }           
    }
    return distances[distances.size()-1] * -1;
}

void receiveInputDiametre() {
    cout << "Trees are given as input.\nFirst line : V(the number of vertices, 2 <= V <= 100, 000)\nNext V lines : each vertex number followed by two integers representing the information of the connected edges.\nFormat : V V1 D1 V2 D2 … - 1  (-1 at the end of each line)\nV1 : connected vertex from V\nD1 : distance from vertex V to V1\n(All distances, 1 <= D1, D2, … <= 10, 000)\n";
    string input;
    getline(cin, input);
    numberNode = stoi(input);
    vector<vector<int>>myGraph(numberNode,vector<int>(numberNode,0)); // matrix that contains each edge and weight according with the node
    for (int i = 0; i < numberNode; i++) {
        string line;
        getline(cin, line);
        vector<string>tokens;
        stringstream check1(line);
        string intermediate;
        while (getline(check1, intermediate, ' ')){
            tokens.push_back(intermediate);
        }
        for (int j = 1; j < tokens.size() - 1; j+=2) {
            if (tokens[j] != "-1" && tokens[j+1] != "-1") {
                myGraph[i][stoi(tokens[j])-1] = stoi(tokens[j + 1])*-1;
            }
        }  
    }
    //Print the matrix of weight
    /*for (int i = 0; i < numberNode; i++)
    {
        for (int j = 0; j < numberNode; j++)
        {
            cout << myGraph[i][j];
        }
        cout << "\n";
    }*/

    int maxDistance = INT_MIN;
    for (int i = 0; i < numberNode; i++) {
        int temp = dijkstra(myGraph, i);
        if (temp > maxDistance) {
            maxDistance = temp;
        }
    }
    cout << maxDistance;
}




int main()
{
    while (true){
        Node* root{};
        receiveInputPrintParents(root);
        receiveInputDiametre();
    }  
}