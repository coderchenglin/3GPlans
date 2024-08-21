//
//  main.cpp
//  算法题1
//
//  Created by chenglin on 2024/8/18.
//


//
//#include <iostream>
//#include <vector>
//#include <queue>
//#include <map>
//
//using namespace std;
//
//void findModuleOrder(int n, vector<pair<int, int>>& dependencies) {
//    // 邻接表表示依赖关系
//    map<int, vector<int>> adjList;
//    // 入度表
//    map<int, int> indegree;
//
//    // 初始化邻接表和入度表
//    for (auto& dep : dependencies) {
//        int u = dep.first;
//        int v = dep.second;
//        adjList[v].push_back(u); // v -> u
//        indegree[u]++;           // u 的入度加1
//        if (indegree.find(v) == indegree.end()) {
//            indegree[v] = 0; // 初始化v的入度为0
//        }
//    }
//
//    // 使用优先队列（最小堆）来实现字典序的最小排序
//    priority_queue<int, vector<int>, greater<int>> pq;
//
//    // 将入度为0的节点加入队列
//    for (auto& entry : indegree) {
//        if (entry.second == 0) {
//            pq.push(entry.first);
//        }
//    }
//
//    // 结果向量
//    vector<int> result;
//
//    while (!pq.empty()) {
//        int current = pq.top();
//        pq.pop();
//        result.push_back(current);
//
//        // 遍历当前节点的所有邻居，减少入度
//        for (int neighbor : adjList[current]) {
//            indegree[neighbor]--;
//            if (indegree[neighbor] == 0) {
//                pq.push(neighbor);
//            }
//        }
//    }
//
//    // 输出结果
//    for (int module : result) {
//        cout << module << " ";
//    }
//    cout << endl;
//}
//
//int main() {
//    int n;
//    cin >> n;
//
//    vector<pair<int, int>> dependencies(n);
//    for (int i = 0; i < n; ++i) {
//        int u, v;
//        cin >> u >> v;
//        dependencies[i] = {u, v};
//    }
//
//    findModuleOrder(n, dependencies);
//
//    return 0;
//}

//#include <iostream>
//#include <vector>
//#include <queue>
//#include <map>
//
//using namespace std;
//
//void findModuleOrder(int n, vector<pair<int, int>>& dependencies) {
//    // 邻接表表示依赖关系
//    map<int, vector<int>> adjList;
//    // 入度表
//    map<int, int> indegree;
//
//    // 初始化邻接表和入度表
//    for (auto& dep : dependencies) {
//        int u = dep.first;
//        int v = dep.second;
//        adjList[v].push_back(u); // v -> u
//        indegree[u]++;           // u 的入度加1
//        if (indegree.find(v) == indegree.end()) {
//            indegree[v] = 0; // 初始化v的入度为0
//        }
//    }
//
//    // 使用优先队列（最小堆）来实现字典序的最小排序
//    priority_queue<int, vector<int>, greater<int>> pq;
//
//    // 将入度为0的节点加入队列
//    for (auto& entry : indegree) {
//        if (entry.second == 0) {
//            pq.push(entry.first);
//        }
//    }
//
//    // 结果向量
//    vector<int> result;
//
//    while (!pq.empty()) {
//        int current = pq.top();
//        pq.pop();
//        result.push_back(current);
//
//        // 遍历当前节点的所有邻居，减少入度
//        for (int neighbor : adjList[current]) {
//            indegree[neighbor]--;
//            if (indegree[neighbor] == 0) {
//                pq.push(neighbor);
//            }
//        }
//    }
//
//    // 输出结果
//    for (int module : result) {
//        cout << module << " ";
//    }
//    cout << endl;
//}
//
//int main() {
//    int n;
//    cin >> n;
//
//    vector<pair<int, int>> dependencies;
//    for (int i = 0; i < n; ++i) {
//        int u, v;
//        cin >> u >> v;
//        dependencies.push_back({u, v});
//    }
//
//    findModuleOrder(n, dependencies);
//
//    return 0;
//}

//int main() {
//    // 测试样例1
//    int n1 = 2;
//    vector<pair<int, int>> dependencies1 = {{1, 2}, {2, 3}};
//    cout << "测试样例1:" << endl;
//    findModuleOrder(n1, dependencies1); // 输出应为 "3 2 1"
//
//    // 测试样例2
//    int n2 = 5;
//    vector<pair<int, int>> dependencies2 = {{3, 2}, {4, 2}, {5, 3}, {6, 4}, {5, 4}};
//    cout << "测试样例2:" << endl;
//    findModuleOrder(n2, dependencies2); // 输出应为 "2 3 4 5 6"
//
//    // 测试样例3（无依赖）
//    int n3 = 0;
//    vector<pair<int, int>> dependencies3 = {};
//    cout << "测试样例3:" << endl;
//    findModuleOrder(n3, dependencies3); // 输出应为空行
//
//    return 0;
//}





//二
//
//#include <iostream>
//#include <vector>
//using namespace std;
//
//int minStations(vector<int>& stations, int D) {
//    int n = stations.size();
//    int current_position = 0;  // 起点
//    int stations_count = 0;
//    int i = 0;
//
//    while (current_position < stations[n - 1]) {
//        int last_position = current_position;
//        // 寻找在当前续航距离D内能到达的最远的中继站点
//        while (i < n && stations[i] <= current_position + D) {
//            last_position = stations[i];
//            i++;
//        }
//
//        // 如果没有可以到达的站点，说明无法到达终点
//        if (last_position == current_position) {
//            return -1;
//        }
//
//        // 更新当前位置为选中的站点
//        current_position = last_position;
//        stations_count++;
//    }
//
//    return stations_count;
//}
//
//int main() {
//    int n, D;
//    cin >> n;
//
//    vector<int> stations(n);
//    for (int i = 0; i < n; i++) {
//        cin >> stations[i];
//    }
//
//    cin >> D;
//
//    int result = minStations(stations, D);
//    cout << result << endl;
//
//    return 0;
//}

#include <iostream>
#include <vector>

using namespace std;

int minStations(vector<int>& stations, int D) {
    int n = stations.size();
    int currentPos = 0;  // 当前所在位置（起点）
    int count = 0;       // 需要经过的中继站点数量
    int lastReachable = 0; // 上一个最远能到达的位置

    while (lastReachable < n - 1) {
        int nextPos = currentPos;
        // 尽量往前跳跃，选择最远的能够到达的中继站点
        while (nextPos < n && stations[nextPos] <= stations[currentPos] + D) {
            lastReachable = nextPos;
            nextPos++;
        }
        if (lastReachable == currentPos) {
            // 如果位置没有前进，表示无法到达终点
            return -1;
        }
        // 更新当前位置并增加中继站点数量
        currentPos = lastReachable;
        count++;
    }

    return count;
}

int main() {
    int n, D;
    cin >> n;
    vector<int> stations(n);
    for (int i = 0; i < n; i++) {
        cin >> stations[i];
    }
    cin >> D;

    int result = minStations(stations, D);
    cout << result << endl;

    return 0;
}
