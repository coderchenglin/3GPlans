//
//  main.cpp
//  leetcode3.无重复字符的最长子串
//
//  Created by chenglin on 2024/7/17.
//

#include <iostream>
#include <string>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        // 哈希集合，记录每个字符是否出现过
        unordered_set<char> occ;
        int n = s.size();
        // 右指针，初始值为 -1，相当于我们在字符串的左边界的左侧，还没有开始移动
        int rk = -1, ans = 0;
        // 枚举左指针的位置，初始值隐性地表示为 -1
        for (int i = 0; i < n; ++i) {
            if (i != 0) {
                // 左指针向右移动一格，移除一个字符
                occ.erase(s[i - 1]);
            }
            while (rk + 1 < n && !occ.count(s[rk + 1])) { //rk没有到头，且rk到下一个元素，在集合occ中不存在
                // 不断地移动右指针
                occ.insert(s[rk + 1]);
                ++rk;
            }
            // 第 i 到 rk 个字符是一个极长的无重复字符子串
            ans = max(ans, rk - i + 1);
        }
        return ans;
    }
};

int main(int argc, const char * argv[]) {
//    // 测试用例 1: 空字符串
//    string s1 = "";
//    Solution sol1;
//    int result1 = sol1.lengthOfLongestSubstring(s1);
//    cout << "Test case 1: " << result1 << endl; // 输出: 0
    
    string s2 = "abcabcbb";
    Solution sol2;
    int result2 = sol2.lengthOfLongestSubstring(s2);
    cout << "Test case 2: " << result2 << endl; // 输出: 3
    
    return 0;
}
