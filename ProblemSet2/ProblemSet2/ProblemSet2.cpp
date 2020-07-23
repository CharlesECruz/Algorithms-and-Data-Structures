// A C++ Program to detect cycle in a graph 
#include<list> 
#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <map>
using namespace std;

class Graph
{
	int numNodesGraph;
	int cycles = 0;
	list<int>* myEdges;
	bool isCyclic(int v, bool visited[], bool* rs);
public:
	Graph(int V);
	void newEdge(int v, int w);
	int numCycles();
};

Graph::Graph(int V)
{
	this->numNodesGraph = V;
	myEdges = new list<int>[V];
}

void Graph::newEdge(int v, int w)
{
	myEdges[v].push_back(w);
}
bool Graph::isCyclic(int currentNode, bool visited[], bool* nodesMarked)
{
	if (visited[currentNode] == false){
		list<int>::iterator i;
		visited[currentNode] = true;
		nodesMarked[currentNode] = true;
		for (i = myEdges[currentNode].begin(); i != myEdges[currentNode].end(); ++i){
			if (!visited[*i] && isCyclic(*i, visited, nodesMarked))
				return true;
			else if (nodesMarked[*i])
				return true;
		}

	}
	nodesMarked[currentNode] = false;
	return false;
}
int Graph::numCycles()
{
	//using DFS
	int cicles = 0;
	bool* visited = new bool[numNodesGraph];
	bool* nodesMarked = new bool[numNodesGraph];
	for (int i = 0; i < numNodesGraph; i++){
		visited[i] = false;
		nodesMarked[i] = false;
	}
	for (int i = 0; i < numNodesGraph; i++)
		if (isCyclic(i, visited, nodesMarked)) {
			cycles++;
		}
	return cycles;
}
void permutation() {
	vector<int>answer;
	cout << "First line: the number of test cases T\nIn the first row of each test case, the size N of the permutation(2 <= N <= 1000) is given.The second row of each test case will have a permutation of N integers. (space - separated)\n";
	string cases, numNodes;
	getline(cin, cases);
	for (int i = 0; i < stoi(cases); i++) {
		getline(cin, numNodes);
		Graph g(stoi(numNodes));
		string line;
		getline(cin, line);
		vector<string>tokens;
		stringstream check1(line);
		string intermediate;
		while (getline(check1, intermediate, ' ')) {
			tokens.push_back(intermediate);
		}
		for (int i = 0; i < stoi(numNodes); i++) {
			g.newEdge(i, stoi(tokens[i]) - 1);
		}
		answer.push_back(g.numCycles());
	}
	for (int i : answer)
		cout << i << "\n";
}
int nextNumberSequence(int A, int P) {
	int sum = 0;
	while (A > 0) {
		sum += pow((A % 10), P);
		A /= 10;
	}
	return sum;
}







void sequence() {
	vector<int>sequence;
	cout << "On the first line, A (1 <= A <= 9999) and P (1 <= P <= 5)\n";
	string line;
	getline(cin, line);
	int posDelimiter = line.find(" ");
	int A = stoi(line.substr(0, posDelimiter));
	int P = stoi(line.substr(posDelimiter + 1, line.size()));
	sequence.push_back(A);
	while (true){
		int newNumber = nextNumberSequence(sequence[sequence.size()-1], P);
		if (find(sequence.begin(), sequence.end(), newNumber) == sequence.end()){
			sequence.push_back(newNumber);
		}else {
			sequence.push_back(newNumber);
			break;
		}
	}
	int startSequenc;
	
	for (int i = 0; i < sequence.size()-1; i++) {
		if (sequence[i]== sequence[sequence.size()-1]){
			startSequenc = i;
		}
	}
	/*for (int i = 0; i <= startSequenc-1; i++) {
		cout << sequence[i]<<"\n";
	}*/
	cout << startSequenc;
}
int main()
{
	//permutation();
	sequence();
	return 0;
}
