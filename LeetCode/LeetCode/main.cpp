//
//  main.cpp
//  LeetCode
//
//  Created by chenglin on 2024/4/26.
//

#include <iostream>
#include "vector"
#include <iomanip>
#include "string"
#include <cstring>
#include <unordered_map>
#include <unordered_set>

using namespace std;

#pragma mark 输入输出

//int main() {
//
////    cout << "hello, world" << endl;
////    string name;
////    cout << "Enter your name:";
////    cin >> name;
////    cout << "Hello, " << name << "!" << endl;
//
////    string line;
////    cout << "Enter a sentence: ";
////    getline(cin, line); //读取一整行数据 不受空格影响  //第一个参数
////    getline(cin, line); //覆盖存入
////    cout << "You entered: " << line << endl;
//
//    double pi = 3.14159;
//    cout << fixed << std::setprecision(2);
//
////    string str;
////    while(cin >> str) {
////        cout << str << endl;
////        if (getchar() == '\n')
////            break;
////    }
//
//
//
//    return 0;
//}

#include <sstream>

//检测整数数组中是否存在重复元素
bool containsDuplicate(vector<int> &nums) {
    unordered_set<int> seen;
    for (int num : nums) {
        if (seen.find(num) != seen.end()) {
            return true;
        }
        seen.insert(num);
    }
    
    return false;
}

//int main() {
//
////    int arr[5];
////    int arr[5] = {1, 2, 3, 4, 5};
////    int value = arr[2];
////    for (int i = 0; i < 5; i++) {
////        cout << arr[i] << " ";
////    }
////
////    int sum = 0;
////    for (int i = 0; i < 5; i++) {
////        sum += arr[i];
////    }
////
////    int max = arr[0];
////    for (int i = 1; i < 5; i++) {
////        if (arr[i] > max) {
////            max = arr[i];
////        }
////    }
//
////    char str1[10] = "Hello";
////    string str1 = "Hello";
////    string str2 = "World";
//
//    //字符串连接
////    string result = str1 + " " + str2; //这个不能用于C语言数组
//
////    unsigned long length1 = strlen(str1);  //size_t 类型 //strlen()方法，1.要包含cstring头文件 2.这个方法用于c语言以null结尾的数组，不能用于string类型变量
////    int length2 = str2.length();  //这个用于string类型变量
//
//    //字符串比较
////    if (str1 == str2) {
////        //...
////    }
//
//    //字符串的逆序
////    cout << str1 << endl;
////    reverse(str1, str1 + length1);   //反转字符数组 //这地方传两个迭代器，str1是一个指针，指向字符串开头，str1 + length1指向字符串末尾，指针也是一种迭代器
////    cout << str1 << endl;
//
////    reverse(str2.begin(), str2.end()); //反转string对象
//
//
//
//#pragma mark stringstream类
////    stringstream ss;
////
////    //将整数转换为字符串
////    int number = 42;
////    ss << number; //operator<< 用于向stringstream对象中写入数据
////    string str = ss.str(); //str()返回stringstream对象中保存的字符串
////    cout << "str = " << str << endl;
////
////    //将字符串转换为浮点数
////    string floatStr = "3.14";
////    float floatValue;
////    ss.clear();  //清除错误状态和内部缓冲区
////    ss.str(floatStr); //将ss对象中保存的字符串，设置为floatStr
////    ss >> floatValue;  //operator>> 用于从stringstream对象中读取数据
////    cout << "String to float: " << floatValue << endl;
//
////    str(): 返回 stringstream 对象中保存的字符串。
////    str(const string& s): 将 stringstream 对象中保存的字符串设置为 s。
////    clear(): 清除错误状态和内部缓冲区。
////    operator<<：用于向 stringstream 对象中写入数据。
////    operator>>：用于从 stringstream 对象中读取数据。
//
//
//    //字符串分割
////    string s = "apple, banana, orange";
////    stringstream ss1(s);  //stringstream是标准库的一个类
////    string token;
////    vector<string> tokens;
////    while (getline(ss1, token, ',')) { //getline函数，第三个参数默认是'\n'，这是一个可选参数，表示行的分隔符。当遇到分隔符时，getline函数停止读取
////        tokens.push_back(token);
////    }
////
//    // vector<string> 两种循环遍历方式
////    for (size_t i = 0; i < tokens.size(); i++) {
////        cout << tokens[i] << endl;
////    }
////
////    for (const auto& str : tokens) {
////        cout << str << endl;
////    }
//
////    //字符串的查找和替换
////    string sentence = "I love coding!";
////    if (sentence.find("love") != string::npos) { //当在字符串中使用一些查找或匹配函数（如 find()、rfind()、find_first_of()、find_last_of() 等）时，如果未找到所需的子串或字符，这些函数通常会返回 std::string::npos。
////        cout << "Found 'love' at position " << sentence.find("love");
////    }
////    sentence.replace(2, 4, "hate");
//
//    //replace函数原型：
//    //std::string& replace(size_t pos, size_t count, const std::string& str);
////    pos：这是一个 size_t 类型的参数，表示替换操作的起始位置（索引）。即从字符串的哪个位置开始进行替换。如果 pos 大于字符串的长度，则替换会失败。
////
////    count：这是一个 size_t 类型的参数，表示要替换的字符数。即替换操作涉及的字符数量。如果 count 大于从起始位置 pos 开始的可用字符数，则替换会截断并覆盖到字符串的结尾。
////
////    str：这是一个 const std::string& 类型的参数，表示用于替换的字符串。即要将原字符串中的一部分内容替换为新的字符串 str。
//
//
////    vector<int> nums; //声明一个空的向量
////    vector<int> nums = {1, 4, 3, 5, 2}; //声明并初始化向量
////
////    nums.push_back(6);
////    int value = nums[2];
////    for (int i = 0; i < nums.size(); i++) {
////        cout << nums[i] << " ";
////    }
////    //向量排序
////    sort(nums.begin(), nums.end());  //默认升序排序
////
////    //查找元素
////    auto it = find(nums.begin(), nums.end(), 3); // 在向量中查找元素3
////    if (it != nums.end()) {  //end()会指向对象最后一个元素的后一个元素的迭代器
////        cout << "Element found at index " << distance(nums.begin(), it);
////    }
//
//    //向量的各种声明方式：
////    vector<int> vec;
////    vector<vector<int>> vec1(10);
////    vector<int> vec2(10, 1);
////    vector<int> tmp(vec2.begin(), vec2.end());
////
////    int n[] = {1, 2, 3, 4, 5};
////    vector<int> tmp1(n, n + 5); //这地方传的是迭代器（指针，地址）
////    vector<int> tmp2(&n[1], &n[4]); //传迭代器（指针，地址）
////
////    vec2.push_back(8);
////    auto it = vec2.begin() + 2;
////    vec2.insert(it, 9);
////    vec.erase(vec.begin(), vec.end());
////    cout << vec.size();
////    sort(vec2.begin(), vec2.end());
////    auto it2 = find(vec2.begin(), vec2.end(), 3);
////    if (it2 != vec2.end()) {
////        //找到了
////    }
////    //it2迭代器转下标
////    int index = it2 - vec2.begin();
//
//#pragma mark 哈希表
////    unordered_map<int, int> map;
////    unordered_map<int, int> map = {{1, 1}, {2, 2}, {3, 3}};
////    map[4] = 4;
////    map[2] = 5;
////    auto it = map.find(2);
////
////    if (it != map.end()) {
////        cout << it -> first << endl;
////        cout << it -> second << endl;
////    }
//
//    //1. 存储与查找
////    unordered_map<string, string> dictionary;
////    //向哈希表中插入键值对
////    dictionary["apple"] = "苹果";
////    dictionary["banana"] = "香蕉";
////    dictionary["orange"] = "橙子";
////
////    //用户输入英文单词
////    string word;
////    cout << "Enter an English word: " << endl;
////    cin >> word;
////
////    //查找并输出中文翻译
////    auto it = dictionary.find(word);
////    if (it != dictionary.end()) {
////        cout << "Translation: " << it->second << endl;
////    } else {
////        cout << "Translation not found" << endl;
////    }
//
//    //计数与统计
////    string text = "This is a sample text. It contains some sample words.";
////
////    unordered_map<string, int> wordCount;
////    //将文本分割成单词并统计出现次数
////    stringstream ss(text);
////    string word;
////    while (ss >> word) {
//////        cout << "word = " << word << endl;
////        //删除标点符号
////        for (char &c : word) {
////            if (!isalpha(c)) {
////                c = ' ';
////            }
////        }
////
////        //统计单词出现次数
////        if (!word.empty()) {
////            wordCount[word]++;
////        }
////
////    }
////
////    for (const auto &pair : wordCount) {
////        cout << pair.first << ": " << pair.second << endl;
////    }
//
//    //3.检测重复元素
//
//    vector<int> nums = {1, 2, 3, 4, 5, 1};
//    if (containsDuplicate(nums)) {  //函数实现在最上面，main函数前面
//        cout << "Array contains duplicate elements." << endl;
//    } else {
//        cout << "Array does not contain duplicate elements." << endl;
//    }
//
//    return 0;
//}
//
//
//
//
//
//
//
//////二分查找函数
////int binarySearch(const std::vector<int>& arr, int left, int right, int target) {
////
////    while(left <= right) {
////        int mid = left + (right - left) / 2;
////
////        if (arr[mid] > target) {
////            right = mid - 1;
////        } else if (arr[mid] < target) {
////            left = mid + 1;
////        } else {
////            return mid;
////        }
////    }
////
////    return -1;
////}
////
////
////
////int main(int argc, const char * argv[]) {
////    // insert code here...
////
////    std::vector<int> arr = {2, 5, 8, 12, 16, 23, 38, 56, 72, 91};
////        int target = 23;
////
////        int result = binarySearch(arr, 0, arr.size() - 1, target);
////
////        if (result == -1)
////            std::cout << "目标值 " << target << " 未找到。\n";
////        else
////            std::cout << "目标值 " << target << " 在索引 " << result << " 处。\n";
////
////
////    return 0;
////}


struct ListNode {
    int val;
    ListNode *next;
    
    ListNode(int x) : val(x), next(nullptr) {} //这是一个类的构造函数的定义
};

struct ListNode2 {
    int val;
    ListNode2 *prev;
    ListNode2 *next;
    
    ListNode2(int x) : val(x), prev(nullptr), next(nullptr) {}
};

//int main() {
//
//    ListNode *head = new ListNode(1);
//    head->next = new ListNode(2);
//    head->next->next = new ListNode(3);
//
//    //遍历链表
//    ListNode *current = head;
//    while (current != nullptr) {
//        cout << current->val << " ";
//        current = current->next;
//    }
//    cout << endl;
//
//    //清理链表内存
//    while (head != nullptr) {
//        ListNode *tmp = head;
//        head = head->next;
//        delete tmp;
//    }
//
//    while (current != nullptr) {
//        cout << current->val << " ";
//        current = current->next;
//    }
//    cout << endl;
//
//    return 0;
//}


//单链表反转链表
//ListNode* reverseLinkedList(ListNode *head) {
//    ListNode *prev = nullptr;
//    ListNode *current = head;
//    while (current != nullptr) {
//        ListNode* nextTemp = current->next;
//        ListNode* next = prev;
//        prev = current;
//        current = nextTemp;
//    }
//    return prev; //返回新的头节点
//}

//ListNode* mergeTwoLists(ListNode *l1, ListNode *l2) {
//
//    ListNode *dummy = new ListNode(0);
//    ListNode *tail = dummy;
//    while (l1 != nullptr && l2 != nullptr) {
//        if (l1->val < l2->val) {
//            tail->next = l1;
//            l1 = l1->next;
//        } else {
//            tail->next = l2;
//            l2 = l2->next;
//        }
//        tail = tail->next;
//    }
//
//}


#pragma mark unordered_map

//#include <iostream>
//#include <unordered_map>
//#include <vector>
//
////1.统计元素出现次数
////将每个元素作为键，元素的出现次数作为值
//void countOccurrences(const vector<int>& nums) {
//    unordered_map<int, int> countMap;
//
//    for (int num : nums) {
//        countMap[num]++;
//    }
//
//    for (const auto& pair : countMap) {
//        cout << "Element: " << pair.first << "，Count: " << pair.second << endl;
//    }
//}
//
////2.存储索引以便快速查找和匹配
//void findPairsWithSum(const vector<int>& nums, int target) {
//
//    unordered_map<int, int> indexMap;
//
//    for (int i = 0; i < nums.size(); i++) {
//        int complement = target - nums[i];
//        if (indexMap.count(complement) > 0) {
//            cout << "Pair found: " << complement << " + " << nums[i] << " = " << target << endl;
//            cout << "Indices: " << indexMap[complement] << ", " << endl;
//        }
//
//        indexMap[nums[i]] = i;
//    }
//}
//
////3.存储映射关系
//void countCharacterFrequency(const string& str) {
//    unordered_map<char, int> frequencyMap;
//
//    for (char c : str) {
//        frequencyMap[c]++;
//    }
//
//    for (const auto& pair : frequencyMap) {
//        cout << "Character: " << pair.first << ", Frequency: " << pair.second << endl;
//    }
//}



//int main() {
    
//    vector<int> nums =  {1, 2, 1, 3, 2, 1, 4, 5, 4, 2};
//    countOccurrences(nums);

//    vector<int> nums1 = {2, 4, 6, 8, 10};
//    int target = 12;
//    findPairsWithSum(nums1, target);
    
//    std::string str = "hello, world!";
//    countCharacterFrequency(str);
    
//    unordered_map<int, string> myMap;
    
//    // 插入元素
//    myMap.insert(make_pair(1, "apple"));
//    myMap.emplace(2, "banana");
//    myMap.insert({3, "orange"});
//    myMap[4] = "grape";
    
//    //删除操作
//    myMap.erase(3);  //传的是key值
//    myMap.erase(myMap.find(2)); //传的是迭代器
//    myMap.clear();
    
//    //访问元素
//    cout << "Value at key 1: " << myMap.at(3) << endl;
//    cout << "Value at key 2: " << myMap[4] << endl;
//
//    auto it = myMap.find(3);
//    if (it != myMap.end()) {
//        cout << "Value at key 3: " << it->second << endl;
//    } else {
//        cout << "Key 3 not found" << endl;
//    }
//
//    cout << "Count of key 4: " << myMap.count(4) << endl;
//
//    //大小和容量
//    cout << "Size of map: " << myMap.size() << endl;
//    cout << "Is map empty: " << (myMap.empty() ? "YES" : "NO") << endl;
//
//    //迭代器操作
//    cout << "Map elements: ";
//    for (auto& pair : myMap) {
//        cout << "(" << pair.first << ", " << pair.second << ") ";
//    }
//    cout << endl;
//
//    //清空容器
//    myMap.clear();
    
    
//    return 0;
//}


#pragma mark unordered_set

#include <iostream>
#include <unordered_set>
#include <vector>

using namespace std;

//vector<int> findTwoSum(const vector<int>& nums, int target) {
//
//    unordered_set<int> complements;
//
//    for (const auto& num : nums) {
//        int complement = target - num;
//        if (complements.count(complement) > 0) {
//            return {complement, num};
//        } else {
//            complements.insert(num);
//        }
//    }
//
//    return {};
//}
//
//int main () {
//    vector<int> nums = {2, 7, 11, 15};
//    int target = 9;
//
//    vector<int> result = findTwoSum(nums, target);
//    if (result.size() == 2) {
//        cout << "找到两个数的和等于目标值： " << result[0] << "和" << result[1] << endl;
//    } else {
//        cout << "无法找到符合条件的两个数" << endl;
//    }
//}


//int main() {
//
//    unordered_set<int> mySet;
//
//    //插入元素
//    mySet.insert(1);
//    mySet.insert(2);
//    mySet.insert(3);
//
//    cout << "unordered_set内容： ";
//    for (auto it = mySet.begin(); it != mySet.end(); ++it) {
//        cout << *it << " ";
//    }
//    cout << endl;
//
//    //检查元素是否存在
//    if (mySet.count(2)) {
//        cout << "2存在于unordered_set中" << endl;
//    } else {
//        cout << "2不存在于unordered_set中" << endl;
//    }
//
//    mySet.erase(2);
//
//    for (const auto& elem : mySet) {
//        cout << elem << " ";
//    }
//    cout << endl;
//
//    mySet.clear();
//
//    if (mySet.empty()) {
//        cout << "unordered_set为空" << endl;
//    } else {
//        cout << "unordered_set不为空" << endl;
//    }
//
//    return 0;
//}



//int main() {
//
//    vector<int> numbers = {1, 2, 3, 4, 1, 2, 5, 6, 3, 4};
//    unordered_set<int> uniqueNumbers;
//
//    //1.使用unordered_set去重
//    for (const auto& num : numbers) {
//        uniqueNumbers.insert(num);
//    }
//
//    cout << "去重后的元素： ";
//    for (const auto& num : uniqueNumbers) {
//        cout << num << " ";
//    }
//    cout << endl;
//
//    //2.查找和快速查询
//    unordered_set<int> mySet = {2, 4, 6, 8, 10};
//
//    //使用unordered_set
//    int target = 6;
//    auto it = mySet.find(target);
//    if (it != mySet.end()) {
//        //找到了
//    } else {
//        //没找到
//    }
//
//    return 0;
//}


//3.缓存
//class Cache {
//private:
//    unordered_set<int> data_;
//
//public:
//    void AddData(int value) {
//        data_.insert(value);
//        cout << "已添加数据：" << value << endl;
//    }
//
//    bool IsDataCached(int value) {
//        return (data_.count(value) > 0);
//    }
//};
//
//int main() {
//
//    Cache myCache;
//
//    myCache.AddData(10);
//    myCache.AddData(20);
//    myCache.AddData(30);
//
//    int value = 20;
//    if (myCache.IsDataCached(value)) {
//        cout << "数据" << value << "已存在缓存中" << endl;
//    } else {
//        cout << "数据" << value << "不在缓存中" << endl;
//    }
//
//    return 0;
//}

//4.集合运算

//int main() {
//
//    unordered_set<int> set1 = {1, 2, 3, 4, 5};
//    unordered_set<int> set2 = {4, 5, 6, 7, 8};
//
//    //并集
//    unordered_set<int> unionSet;
//    for (const auto& num : set1) {
//        unionSet.insert(num);
//    }
//    for (const auto& num : set2) {
//        unionSet.insert(num);
//    }
//
//    //交集
//    unordered_set<int> intersectionSet;
//    for (const auto& num : set1) {
//        if (set2.count(num) > 0) {
//            intersectionSet.insert(num); //set2里面有，就往里面插
//        }
//    }
//
//    //差集
//    unordered_set<int> differenceSet;
//    for (const auto& num : set1) {
//        if (set2.count(num) == 0) {
//            differenceSet.insert(num);  //set2里面没有，就往里面插
//        }
//    }
//}


//5.哈希表实现

//class MyHashTable {
//private:
//    unordered_set<string> hashTable_;
//
//public:
//    void Insert(const string& key) {
//        hashTable_.insert(key);
//        cout << "已插入键： " << key << endl;
//    }
//
//    void Remove(const string& key) {
//        hashTable_.erase(key);
//        cout << "已移除键： " << key << endl;
//    }
//
//    void PrintTable() const {
//        cout << "哈希表内容：";
//        for (const auto& key : hashTable_) {
//            cout << key << " ";
//        }
//        cout << endl;
//    }
//
//}


////三数取中
//class Solution {
//public:
//    vector<vector<int>> threeSum(vector<int>& nums) {
//        vector<vector<int>> result;
//        sort(nums.begin(), nums.end());
//
//        for (int i = 0; i < nums.size(); i++) {
//            if (nums[i] > 0) {
//                break;
//            }
//            if (i > 0 && nums[i] == nums[i - 1]) {
//                //三元组元素a去重
//                continue;
//            }
//            unordered_set<int> set;
//            for (int j = i + 1; j < nums.size(); j++) {
//                if (j > i + 2 && nums[j] == nums[j - 1] && nums[j - 1] == nums[j - 2]) {
//                    continue;
//                }
//                int c = 0 - (nums[i] + nums[j]);
//                if (set.find(c) != set.end()) {
//                    result.push_back({nums[i], nums[j], c});
//                    set.erase(c);
//                } else {
//                    set.insert(nums[j]);
//                }
//            }
//        }
//        return result;
//    }
//};
//

//int main() {
//
//    Solution sol; //首先创建类的实例
//    vector<int> nums = {-4, -1, -1, -1, 0, 1, 2};
//
//    vector<vector<int>> result = sol.threeSum(nums);
//
//    //输出结果
//    for (auto triplet : result) {
//        cout << "[";
//        for (int num : triplet) {
//            cout << num << " ";
//        }
//        cout << "]" << endl;
//    }
//
//    return 0;
//}


//#include <iostream>
//#include <string>
//
//void trimAndCondense(std::string& s) {
//    int n = s.length();
//
//    // 去除首部空格
//    int left = 0;
//    while (left < n && s[left] == ' ') {
//        left++;
//    }
//
//    // 去除尾部空格
//    int right = n - 1;
//    while (right >= 0 && s[right] == ' ') {
//        right--;
//    }
//
//    // 合并单词间空格
//    int idx = 0;
//    bool space = false;
//    while (left <= right) {
//        if (s[left] != ' ') {
//            s[idx++] = s[left++];
//            space = false;
//        } else if (s[left] == ' ' && !space) {
//            s[idx++] = s[left++];
//            space = true;
//        } else {
//            left++;
//        }
//    }
//
//    // 截断多余字符
//    s = s.substr(0, idx);
//}
//
//int main() {
//    std::string s = "  hello  world  ";
//    trimAndCondense(s);
//    std::cout << s << std::endl;
//
//    return 0;
//}

//
////63.不同路径（二）
//#include <iostream>
//#include <vector>
//
//using namespace std;
//
//class Solution {
//public:
//    int uniquePathsWithObstacles(vector<vector<int>>& obstacleGrid) {
//        int m = obstacleGrid.size();
//        int n = obstacleGrid[0].size();
//
//        if (obstacleGrid[m - 1][n - 1] == 1 || obstacleGrid[0][0] == 1)
//            return 0;
//
//        vector<vector<int>> dp(m, vector<int>(n, 0));
//
//        for (int i = 0; i < m && obstacleGrid[i][0] == 0; i++)
//            dp[i][0] = 1;
//
//        for (int j = 0; j < n && obstacleGrid[0][j] == 0; j++)
//            dp[0][j] = 1;
//
//        for (int i = 1; i < m; i++) {
//            for (int j = 1; j < n; j++) {
//                //数组obstacleGrid[i][j]中是1的地方，保持dp[i][j]为0
//                if (obstacleGrid[i][j] == 1)
//                    continue; //保持的[i][j]为0
//
//                dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
//            }
//        }
//
//        printDP(dp); // 打印 dp 数组
//
//        return dp[m - 1][n - 1];
//    }
//
//private:
//    void printDP(vector<vector<int>>& dp) {
//        int m = dp.size();
//        int n = dp[0].size();
//
//        cout << "DP Array:" << endl;
//        for (int i = 0; i < m; i++) {
//            for (int j = 0; j < n; j++) {
//                cout << dp[i][j] << " ";
//            }
//            cout << endl;
//        }
//    }
//};
//
//int main() {
//    // Test Case
//    vector<vector<int>> obstacleGrid = {
//        {0, 0, 0},
//        {0, 1, 0},
//        {0, 0, 0}
//    };
//
//    Solution sol;
//    int uniquePaths = sol.uniquePathsWithObstacles(obstacleGrid);
//    cout << "Number of Unique Paths: " << uniquePaths << endl;
//
//    return 0;
//}


////416 分割等和子集
//#include <iostream>
//#include <vector>
//#include <numeric> // for std::accumulate
//
//using namespace std;
//
//class Solution {
//public:
//    bool canPartition(vector<int>& nums) {
//        int sum = accumulate(nums.begin(), nums.end(), 0);
//
//        if (sum % 2 == 1)
//            return false;
//
//        int target = sum / 2;
//        vector<int> dp(target + 1, 0);
//
//        // 打印初始状态的 dp 数组
//        printDP(dp);
//
//        for (int i = 0; i < nums.size(); i++) {
//            for (int j = target; j >= nums[i]; j--) {
//                dp[j] = max(dp[j], dp[j - nums[i]] + nums[i]);
//
//                // 打印当前步骤的 dp 数组
//                printDP(dp);
//            }
//        }
//
//        return dp[target] == target;
//    }
//
//private:
//    void printDP(vector<int>& dp) {
//        cout << "DP Array: ";
//        for (int num : dp) {
//            cout << num << " ";
//        }
//        cout << endl;
//    }
//};
//
//int main() {
//    // Test Case
//    vector<int> nums = {7, 8, 5, 3, 13, 9, 5};
//
//    Solution sol;
//    bool canPartitioned = sol.canPartition(nums);
//    if (canPartitioned) {
//        cout << "The array can be partitioned into two subsets with equal sum." << endl;
//    } else {
//        cout << "The array cannot be partitioned into two subsets with equal sum." << endl;
//    }
//
//    return 0;
//}


#pragma mark 01背包问题

//二维dp数组

//i:物品下标
//j:背包容量
//weight[i]:下标为i的物品的重量
//value[i]:下标为i的物品的价值
//dp[i][j]:容量为j的背包，在下标为0-i的物品中任选，可以装的最大价值

//for (int i = 1; i < weight.size(); i++) {
//    for (int j = 0; j <= bagweight; j++) {
//        if (j < weight[i])
//            dp[i][j] = dp[i - 1][j];
//        else
//            dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - weight[i]] + value[i]);
//    }
//}



//一维dp数组

//i:物品下标
//j:背包容量
//weight[i]:下标为i的物品的重量
//value[i]:下标为i的物品的价值
//dp[j]:容量为j的背包，在下标为0-i的物品中任选，可以装的最大价值

//for (int i = 0; i < weight.size(); i++) {
//    for (int j = bagweight; j >= weight[i]; j--) {
//        dp[j] = max(dp[j], dp[j - weight[i]] + value[i]);
//    }
//}

#pragma mark 完全背包

//和01背包的区别：
//对于一维数组，01背包需要先遍历物品，里面嵌套重量，并且重量需要反向遍历，保证每个物品只装入一次
//而完全背包两种嵌套方式都可以（一般先遍历物品），重量需要正向遍历，因为每个物品可以装入多次

//for (int i = 0; i < weight.size(); i++) {
//    for (int j = weight[i]; j <= bagWeight; j++) {
//        dp[j] = max(dp[j], dp[j - weight[i]] + value[i]);
//    }
//}
//
//for (int j = 0; j <= bagWeight; j++) {
//    for (int i = 0; i < weight.size(); i++) {
//        if (j - weight[i] >= 0)
//            dp[j] = max(dp[j], dp[j - weight[i]] + value[i]);
//    }
//    cout << endl;
//}



//#include <iostream>
//#include <vector>
//
//using namespace std;
//
//void printDP(vector<int>& dp) {
//    cout << "DP Array: ";
//    for (int num : dp) {
//        cout << num << " ";
//    }
//    cout << endl;
//}
//
//// 先遍历物品，在遍历背包
//void test_CompletePack() {
//    vector<int> weight = {1, 3, 4};
//    vector<int> value = {15, 20, 30};
//    int bagWeight = 4;
//    vector<int> dp(bagWeight + 1, 0);
//    for(int i = 0; i < weight.size(); i++) { // 遍历物品
//        for(int j = weight[i]; j <= bagWeight; j++) { // 遍历背包容量
//            dp[j] = max(dp[j], dp[j - weight[i]] + value[i]);
//            printDP(dp);
//        }
////        printDP(dp);
//    }
//    cout << dp[bagWeight] << endl;
//}
//
//int main() {
//    test_CompletePack();
//}


//
//#include <iostream>
//#include <vector>
//#include <cmath>
//
//using namespace std;
//
//class Solution {
//public:
//    int findTargetSumWays(vector<int>& nums, int S) {
//        int sum = 0;
//        for (int i = 0; i < nums.size(); i++) {
//            sum += nums[i];
//        }
//
//        if (abs(S) > sum) {
//            return 0; // 此时没有方案
//        }
//
//        if ((S + sum) % 2 == 1) {
//            return 0; // 此时没有方案
//        }
//
//        int bagSize = (S + sum) / 2;
//        vector<int> dp(bagSize + 1, 0);
//        dp[0] = 1;
//
//        // 打印初始状态的 dp 数组
//        printDP(dp);
//
//        for (int i = 0; i < nums.size(); i++) {
//            for (int j = bagSize; j >= nums[i]; j--) {
//                dp[j] += dp[j - nums[i]];
//
//                printf("dp[%d] = %d\n", j, dp[j]);
//                // 打印当前步骤的 dp 数组
//                printDP(dp);
//            }
//        }
//
//        return dp[bagSize];
//    }
//
//private:
//    void printDP(vector<int>& dp) {
//        cout << "DP Array: ";
//        for (int num : dp) {
//            cout << num << " ";
//        }
//        cout << endl;
//    }
//};
//
//int main() {
//    // Test Case
//    vector<int> nums = {1, 1, 1, 1, 1};
//    int targetSum = 3;
//
//    Solution sol;
//    int ways = sol.findTargetSumWays(nums, targetSum);
//    cout << "Number of ways to achieve target sum: " << ways << endl;
//
//    return 0;
//}

//
//#include <iostream>
//#include <vector>
//
//using namespace std;
//
//class Solution {
//public:
//    int change(int amount, vector<int>& coins) {
//        vector<int> dp(amount + 1, 0);
//        dp[0] = 1;
//
//        // 打印初始状态的 dp 数组
//        printDP(dp);
//
////        for (int j = 0; j <= amount; j++) { // 遍历背包容量
////            for (int i = 0; i < coins.size(); i++) { // 遍历物品
////                if (j - coins[i] >= 0) dp[j] += dp[j - coins[i]];
////
////                printf("j = %d, dp[j - coin[i]] = %d\n", j, dp[j - coins[i]]);
////
////                // 打印当前步骤的 dp 数组
////                printDP(dp);
////            }
////        }
//
//
//        for (int i = 0; i < coins.size(); i++) { // 遍历物品
//            for (int j = coins[i]; j <= amount; j++) { // 遍历背包
//                dp[j] += dp[j - coins[i]];
//                printf("j = %d, dp[j - coin[i]] = %d\n", j, dp[j - coins[i]]);
//
//                // 打印当前步骤的 dp 数组
//                printDP(dp);
//            }
//        }
//
//        return dp[amount];
//    }
//
//private:
//    void printDP(vector<int>& dp) {
//        cout << "DP Array: ";
//        for (int num : dp) {
//            cout << num << " ";
//        }
//        cout << endl;
//    }
//};
//
//int main() {
//    // Test Case
//    int amount = 5;
//    vector<int> coins = {1, 2, 5};
//
//    Solution sol;
//    int ways = sol.change(amount, coins);
//    cout << "Number of ways to make up amount: " << ways << endl;
//
//    return 0;
//}

//#include <istream>
//#include "stack"
//
//using namespace std;
//
//int main() {
//    stack<int> myStack;
//
//    myStack.push(10);
//    myStack.push(20);
//    myStack.push(30);
//
//    cout << "Top element: " << myStack.top() << endl;
//
//    myStack.pop();
//
//    if (myStack.empty()) {
//        //
//    } else {
//        //
//    }
//
//    return 0;
//}



//#pragma mark 堆
//
//#include <iostream>
//#include <vector>
//#include <algorithm>
//
//using namespace std;
//
//int main() {
//
//    vector<int> maxHeap = {4, 10, 3, 5, 1};
//
//    make_heap(maxHeap.begin(), maxHeap.end());
//    cout << "Max heap: ";
//    for (const auto& num : maxHeap) {
//        cout << num << " ";
//    }
//
//    maxHeap.push_back(15);
//    push_heap(maxHeap.begin(), maxHeap.end());
//
//    cout << "After insertion, max heap: ";
//    for (const auto& num : maxHeap) {
//        cout << num << " ";
//    }
//    cout << endl;
//
//    //这是删除堆顶元素的一套组合拳
//    pop_heap(maxHeap.begin(), maxHeap.end());//这个方法将堆顶元素与最后一个元素交换，并通过下滤操作，重新成堆，然后堆顶元素就到了容器的末尾，但是容器本身的大小并没有改变
//    maxHeap.pop_back(); //用于移除容器中最后一个元素
//
//    cout << "After deletion of root, max heap: ";
//    for (const auto& num : maxHeap) {
//        cout << num << " ";
//    }
//    cout << endl;
//
//
//    return 0;
//}

#include <iostream>
#include <vector>

void maxHeapifyBottomUp(std::vector<int>& arr, int n, int i) {
    int largest = i; // 当前节点的索引
    int left = 2 * i + 1; // 左子节点的索引
    int right = 2 * i + 2; // 右子节点的索引

    // 找到当前节点、左子节点和右子节点中的最大值
    if (left < n && arr[left] > arr[largest]) {
        largest = left;
    }
    if (right < n && arr[right] > arr[largest]) {
        largest = right;
    }

    // 如果最大值不是当前节点，交换并递归调整
    if (largest != i) {
        std::swap(arr[i], arr[largest]);
        // 递归调整交换后的子树
        maxHeapifyBottomUp(arr, n, largest);
    }
}

void buildMaxHeapBottomUp(std::vector<int>& arr) {
    int n = arr.size();

    // 从最后一个非叶子节点开始，依次向上堆化
    for (int i = n / 2 - 1; i >= 0; --i) {
        maxHeapifyBottomUp(arr, n, i);
        for (int num : arr) {
            std::cout << num << " ";
        }
        std::cout << std::endl;
    }
}

int main() {
//    std::vector<int> arr = {4, 10, 3, 5, 1};
    std::vector<int> arr = {8, 17, 4, 10, 15, 9, 3, 1, 7, 12, 6, 19, 14, 5, 11};

    
    std::cout << "Original array: ";
    for (int num : arr) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    buildMaxHeapBottomUp(arr);

//    std::cout << "Max heap after bottom-up heapify: ";
//    for (int num : arr) {
//        std::cout << num << " ";
//    }
//    std::cout << std::endl;

    return 0;
}
//堆排序
//1.向下建堆
//2.从最后一个非叶子节点（i = n / 2 - 1），从后往前，下滤    O（n/2）
//3.每一次下滤都会保证，以i为头结点的树，是一个大堆。（最大时间复杂度是头节点向下过滤，时间复杂度为O（logN）
//4.一直遍历到整个树的头节点，这样就保证了整棵树都是大堆
//5.所以整体的时间复杂度为： （N * logN）
