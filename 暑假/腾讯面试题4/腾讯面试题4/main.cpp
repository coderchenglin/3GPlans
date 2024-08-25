//
//  main.cpp
//  腾讯面试题4
//
//  Created by chenglin on 2024/8/23.
//

//#include <iostream>
//
//int main(int argc, const char * argv[]) {
//    // insert code here...
//    std::cout << "Hello, World!\n";
//    return 0;
//}

//
//#include <vector>
//#include <string>
//#include <queue>
//#include <functional>
//#include <iostream>
//
//using namespace std;
//
//// TreeNode定义
//struct TreeNode {
//    int weight;
//    TreeNode* left;
//    TreeNode* right;
//    TreeNode(int w) : weight(w), left(nullptr), right(nullptr) {}
//};
//
//class Solution {
//public:
//    TreeNode* huffman(std::string leaf[], double value[], int n) {
//        // 创建优先队列（最小堆）
//        auto cmp = [](TreeNode* a, TreeNode* b) {
//            return a->weight > b->weight;
//        };
//        std::priority_queue<TreeNode*, std::vector<TreeNode*>, decltype(cmp)> pq(cmp);
//
//        // 将所有叶子节点加入优先队列
//        for (int i = 0; i < n; ++i) {
//            pq.push(new TreeNode(value[i]));
//        }
//
//        // 构建哈夫曼树
//        while (pq.size() > 1) {
//            TreeNode* left = pq.top(); pq.pop();
//            TreeNode* right = pq.top(); pq.pop();
//
//            // 创建新节点并累加权重
//            TreeNode* newNode = new TreeNode(left->weight + right->weight);
//            newNode->left = left;
//            newNode->right = right;
//
//            // 将新节点加入队列
//            pq.push(newNode);
//        }
//
//        // 队列中最后剩下的节点就是根节点
//        return pq.top();
//    }
//};
//
//
//
//
//void printTree(TreeNode* root, const std::string& code = "") {
//    if (root == nullptr) return;
//
//    // 如果是叶子节点，输出其权重和编码
//    if (root->left == nullptr && root->right == nullptr) {
//        std::cout << "Leaf node with weight " << root->weight << " and code " << code << std::endl;
//        return;
//    }
//
//    // 递归打印左子树和右子树
//    if (root->left != nullptr) {
//        printTree(root->left, code + "0");
//    }
//    if (root->right != nullptr) {
//        printTree(root->right, code + "1");
//    }
//}
//
////void printTree(TreeNode* root, std::string code = "") {
////    if (!root) return;
////
////    // 如果是叶子节点，输出其权重和编码
////    if (!root->left && !root->right) {
////        cout << "Leaf node with weight " << root->weight << " and code " << code << endl;
////    }
////
////    // 递归打印左子树和右子树
////    printTree(root->left, code + "0");
////    printTree(root->right, code + "1");
////}
//
//
//int main() {
//    // 测试数据
//    std::string leaf[] = {"0", "10", "11"};
//    double value[] = {2.1, 2.0, 2.0};
//    int n = sizeof(value) / sizeof(value[0]);
//
//    // 创建 Solution 对象并构建哈夫曼树
//    Solution solution;
//    TreeNode* root = solution.huffman(leaf, value, n);
//
//    // 打印哈夫曼树的结构
//    printTree(root);
//
//    return 0;
//}
//

//
//#include <iostream>
//#include <vector>
//#include <climits>
//#include <cmath>
//
//using namespace std;
//
//struct Point {
//    int x, y;
//};
//
//int distance(Point a, Point b) {
//    return abs(a.x - b.x) + abs(a.y - b.y);
//}
//
//int main() {
//    int a, b, c, d, n;
//    cin >> a >> b >> c >> d;
//    cin >> n;
//
//    vector<Point> bottles(n);
//    for (int i = 0; i < n; ++i) {
//        cin >> bottles[i].x >> bottles[i].y;
//    }
//
//    int min_cost = INT_MAX;
//
//    for (int i = 0; i < n; ++i) {
//        int cost = 0;
//
//        // 先到达第i个瓶子
//        cost += distance({a, b}, bottles[i]);
//        // 再把瓶子移到目标点
//        cost += distance(bottles[i], {c, d});
//
//        for (int j = 0; j < n; ++j) {
//            if (i == j) continue;
//            // 移动到其他瓶子
//            cost += distance({c, d}, bottles[j]);
//            // 再把其他瓶子放到目标点
//            cost += distance(bottles[j], {c, d});
//        }
//
//        min_cost = min(min_cost, cost);
//    }
//
//    cout << min_cost << endl;
//
//    return 0;
//}

//#include <iostream>
//#include <vector>
//#include <cmath>
//#include <climits>
//
//using namespace std;
//
//// 计算曼哈顿距离的函数
//int manhattan_distance(int x1, int y1, int x2, int y2) {
//    return abs(x1 - x2) + abs(y1 - y2);
//}
//
//int main() {
//    int a, b, c, d;
//    cin >> a >> b >> c >> d;
//
//    int n;
//    cin >> n;
//
//    vector<pair<int, int>> bottles(n);
//    for (int i = 0; i < n; ++i) {
//        cin >> bottles[i].first >> bottles[i].second;
//    }
//
//    int min_cost = INT_MAX;
//
//    for (int i = 0; i < n; ++i) {
//        // 计算从初始位置到瓶子，再到目标位置的总代价
//        int move_to_bottle = manhattan_distance(a, b, bottles[i].first, bottles[i].second);
//        int move_to_target = manhattan_distance(bottles[i].first, bottles[i].second, c, d);
//        int total_cost = move_to_bottle + move_to_target;
//
//        // 更新最小代价
//        min_cost = min(min_cost, total_cost);
//    }
//
//    cout << min_cost << endl;
//
//    return 0;
//}

//#include <iostream>
//#include <vector>
//#include <cmath>
//#include <climits>
//
//using namespace std;
//
//// 计算曼哈顿距离的函数
//int manhattan_distance(int x1, int y1, int x2, int y2) {
//    return abs(x1 - x2) + abs(y1 - y2);
//}
//
//int main() {
//    int a, b, c, d;
//    cin >> a >> b >> c >> d;
//
//    int n;
//    cin >> n;
//
//    vector<pair<int, int>> bottles(n);
//    for (int i = 0; i < n; ++i) {
//        cin >> bottles[i].first >> bottles[i].second;
//    }
//
//    int min_cost = INT_MAX;
//
//    for (int i = 0; i < n; ++i) {
//        int move_to_bottle = manhattan_distance(a, b, bottles[i].first, bottles[i].second);
//        int move_to_target = manhattan_distance(bottles[i].first, bottles[i].second, c, d);
//        int total_cost = move_to_bottle + move_to_target;
//
//        min_cost = min(min_cost, total_cost);
//    }
//
//    cout << min_cost << endl;
//
//    return 0;
//}

//#include <iostream>
//#include <vector>
//#include <cmath>
//#include <climits>
//
//using namespace std;
//
//// 计算曼哈顿距离的函数
//int manhattan_distance(int x1, int y1, int x2, int y2) {
//    return abs(x1 - x2) + abs(y1 - y2);
//}
//
//int main() {
//    int a, b, c, d;
//    cin >> a >> b >> c >> d;
//
//    int n;
//    cin >> n;
//
//    vector<pair<int, int>> bottles(n);
//    for (int i = 0; i < n; ++i) {
//        cin >> bottles[i].first >> bottles[i].second;
//    }
//
//    int min_cost = INT_MAX;
//
//    for (int i = 0; i < n; ++i) {
//        // 计算从初始位置到瓶子，再到目标位置的总代价
//        int move_to_bottle = manhattan_distance(a, b, bottles[i].first, bottles[i].second);
//        int move_to_target = manhattan_distance(bottles[i].first, bottles[i].second, c, d);
//        int total_cost = move_to_bottle + move_to_target;
//
//        // 更新最小代价
//        min_cost = min(min_cost, total_cost);
//    }
//
//    cout << min_cost << endl;
//
//    return 0;
//}

//#include <iostream>
//#include <vector>
//#include <algorithm>
//#include <climits>
//
//using namespace std;
//
//// 计算从(x1, y1)到(x2, y2)的曼哈顿距离
//int manhattanDistance(int x1, int y1, int x2, int y2) {
//    return abs(x1 - x2) + abs(y1 - y2);
//}
//
//int main() {
//    int a, b, c, d;
//    cin >> a >> b >> c >> d;
//
//    int n;
//    cin >> n;
//
//    vector<pair<int, int>> bottles(n);
//    for (int i = 0; i < n; ++i) {
//        cin >> bottles[i].first >> bottles[i].second;
//    }
//
//    int minCost = INT_MAX;
//
//    // 遍历每个瓶子，计算拿起并放置该瓶子的最小代价
//    for (int i = 0; i < n; ++i) {
//        int pickUpCost = manhattanDistance(a, b, bottles[i].first, bottles[i].second);
//        int placeCost = manhattanDistance(bottles[i].first, bottles[i].second, c, d);
//        minCost = min(minCost, pickUpCost + placeCost);
//    }
//
//    cout << minCost << endl;
//
//    return 0;
//}


#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

// 计算曼哈顿距离
int manhattanDistance(int x1, int y1, int x2, int y2) {
    return abs(x1 - x2) + abs(y1 - y2);
}

int main() {
    int a, b, c, d;
    cin >> a >> b >> c >> d;
    
    int n;
    cin >> n;
    
    vector<pair<int, int>> bottles(n);
    for (int i = 0; i < n; ++i) {
        cin >> bottles[i].first >> bottles[i].second;
    }

    // 移动到所有瓶子的最小代价
    int minCost = INT_MAX;

    for (int i = 0; i < n; ++i) {
        int pickUpCost = manhattanDistance(a, b, bottles[i].first, bottles[i].second);
        int placeCost = manhattanDistance(bottles[i].first, bottles[i].second, c, d);
        int currentCost = pickUpCost + placeCost;

        // 计算其他瓶子需要拿起并放下的代价
        for (int j = 0; j < n; ++j) {
            if (i != j) {
                currentCost += 2 * manhattanDistance(bottles[j].first, bottles[j].second, c, d);
            }
        }
        minCost = min(minCost, currentCost);
    }

    cout << minCost << endl;

    return 0;
}
