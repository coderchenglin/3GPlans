//
//  main.cpp
//  最长公共子串，返回字符串
//
//  Created by chenglin on 2024/8/22.
//
//
//#include <iostream>
//#include <vector>
//#include <algorithm>
//
//using namespace std;
//
//void Lcss(char str1[], char str2[]) {
//    // 创建一个二维数组 dp，用于存储最长公共子串的长度
//    vector<vector<int>> dp(strlen(str1), vector<int>(strlen(str2), 0));
//
//    // 对 dp 矩阵的第一列赋值
//    for (int i = 0; i < strlen(str1); i++) {
//        if (str2[0] == str1[i])
//            dp[i][0] = 1; // 如果匹配，将 dp[i][0] 设为 1
//        else
//            dp[i][0] = 0; // 否则设为 0
//    }
//
//    // 对 dp 矩阵的第一行赋值
//    for (int j = 0; j < strlen(str2); j++) {
//        if (str1[0] == str2[j])
//            dp[0][j] = 1; // 如果匹配，将 dp[0][j] 设为 1
//        else
//            dp[0][j] = 0; // 否则设为 0
//    }
//
//    // 填充 dp 矩阵
//    for (int i = 1; i < strlen(str1); i++) {
//        for (int j = 1; j < strlen(str2); j++) {
//            if (str1[i] == str2[j]) {
//                dp[i][j] = dp[i-1][j-1] + 1; // 如果匹配，继承对角线的值并加 1
//            } else {
//                dp[i][j] = 0; // 如果不匹配，设为 0
//            }
//        }
//    }
//
//    // 找出 dp 矩阵中的最大值，即最长公共子串的长度
//    int maxLen = dp[0][0];
//    for (int i = 0; i < strlen(str1); i++) {
//        for (int j = 0; j < strlen(str2); j++) {
//            maxLen = max(maxLen, dp[i][j]); // 更新最大值
//        }
//    }
//
//    cout << maxLen << endl; // 输出最长公共子串的长度
//}
//
//int main() {
//    char str1[] = "abcde";
//    char str2[] = "abfde";
//    Lcss(str1, str2); // 调用 Lcss 函数
//    return 0;
//}

#include <iostream>
#include <vector>
#include <algorithm>

//using namespace std;
//
//void backtrack(vector<int>& nums, vector<vector<int>>& result, vector<int>& tempList, vector<bool>& used) {
//    if (tempList.size() == nums.size()) {
//        result.push_back(tempList);
//        return;
//    }
//
//    for (int i = 0; i < nums.size(); i++) {
//        if (used[i]) continue; // 如果数字已经被使用，跳过
//        if (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) continue; // 跳过重复的数字
//
//        used[i] = true;
//        tempList.push_back(nums[i]);
//        backtrack(nums, result, tempList, used);
//        used[i] = false;
//        tempList.pop_back(); // 回溯
//    }
//}
//
//vector<vector<int>> permuteUnique(vector<int>& nums) {
//    vector<vector<int>> result;
//    vector<int> tempList;
//    vector<bool> used(nums.size(), false);
//    sort(nums.begin(), nums.end()); // 先排序
//    backtrack(nums, result, tempList, used);
//    return result;
//}
//
//int main() {
//    vector<int> nums = {1, 2, 3, 3};
//    vector<vector<int>> result = permuteUnique(nums);
//
//    for (const auto& permutation : result) {
//        for (int num : permutation) {
//            cout << num << " ";
//        }
//        cout << endl;
//    }
//
//    return 0;
//}

//#include <iostream>
//#include <vector>
//#include <algorithm>
//
//using namespace std;
//
//// 回溯函数，用于生成所有不重复的排列
//void backtrack(vector<int>& nums, vector<vector<int>>& result, vector<int>& tempList, vector<bool>& used) {
//    if (tempList.size() == nums.size()) {  // 如果当前排列的长度等于输入数字的长度
//        result.push_back(tempList);        // 将当前排列加入结果集
//        return;                            // 结束当前递归
//    }
//
//    for (int i = 0; i < nums.size(); i++) {  // 遍历每一个数字
//        if (used[i]) continue;               // 如果数字已经被使用，跳过
//        if (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) continue;  // 跳过重复的数字
//
//        used[i] = true;                      // 标记当前数字已被使用
//        tempList.push_back(nums[i]);         // 将当前数字加入当前排列
//        backtrack(nums, result, tempList, used);  // 递归处理下一个数字
//        used[i] = false;                     // 回溯，撤销当前数字的使用标记
//        tempList.pop_back();                 // 回溯，移除当前排列的最后一个数字
//    }
//}
//
//// 主函数，生成所有不重复的排列
//vector<vector<int>> permuteUnique(vector<int>& nums) {
//    vector<vector<int>> result;              // 存储所有不重复的排列
//    vector<int> tempList;                    // 临时存储当前的排列
//    vector<bool> used(nums.size(), false);   // 标记每个数字是否被使用
//    sort(nums.begin(), nums.end());          // 先对数字排序，以便于处理重复数字
//    backtrack(nums, result, tempList, used); // 开始回溯
//    return result;                           // 返回所有的排列结果
//}
//
//int main() {
//    vector<int> nums = {1, 1, 2};            // 输入数字数组，包含重复数字
//    vector<vector<int>> result = permuteUnique(nums);  // 生成所有不重复的排列
//
//    for (const auto& permutation : result) {  // 遍历并输出所有排列
//        for (int num : permutation) {
//            cout << num << " ";              // 输出排列中的每个数字
//        }
//        cout << endl;                        // 每个排列输出完后换行
//    }
//
//    return 0;                                // 返回0，结束程序
//}


using namespace std;

string compressString(string S) {
    if (S.length() == 0) {
        return S;
    }
    
    string ans = "";
    int cnt = 1;
    char ch = S[0];
    
    for (int i  = 1; i < S.length(); i++) {
        if (ch == S[i]) {
            cnt++;
        } else {
            ans += ch + to_string(cnt);
            ch = S[i];
            cnt = 1;
        }
    }
    
    ans += ch + to_string(cnt);
    
    return ans.length() >= S.length() ? S : ans;
}
