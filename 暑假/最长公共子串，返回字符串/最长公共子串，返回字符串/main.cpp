//
//  main.cpp
//  最长公共子串，返回字符串
//
//  Created by chenglin on 2024/8/22.
//

#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

void Lcss(char str1[], char str2[]) {
    // 创建一个二维数组 dp，用于存储最长公共子串的长度
    vector<vector<int>> dp(strlen(str1), vector<int>(strlen(str2), 0));

    // 对 dp 矩阵的第一列赋值
    for (int i = 0; i < strlen(str1); i++) {
        if (str2[0] == str1[i])
            dp[i][0] = 1; // 如果匹配，将 dp[i][0] 设为 1
        else
            dp[i][0] = 0; // 否则设为 0
    }

    // 对 dp 矩阵的第一行赋值
    for (int j = 0; j < strlen(str2); j++) {
        if (str1[0] == str2[j])
            dp[0][j] = 1; // 如果匹配，将 dp[0][j] 设为 1
        else
            dp[0][j] = 0; // 否则设为 0
    }

    // 填充 dp 矩阵
    for (int i = 1; i < strlen(str1); i++) {
        for (int j = 1; j < strlen(str2); j++) {
            if (str1[i] == str2[j]) {
                dp[i][j] = dp[i-1][j-1] + 1; // 如果匹配，继承对角线的值并加 1
            } else {
                dp[i][j] = 0; // 如果不匹配，设为 0
            }
        }
    }

    // 找出 dp 矩阵中的最大值，即最长公共子串的长度
    int maxLen = dp[0][0];
    for (int i = 0; i < strlen(str1); i++) {
        for (int j = 0; j < strlen(str2); j++) {
            maxLen = max(maxLen, dp[i][j]); // 更新最大值
        }
    }

    cout << maxLen << endl; // 输出最长公共子串的长度
}

int main() {
    char str1[] = "abcde";
    char str2[] = "abfde";
    Lcss(str1, str2); // 调用 Lcss 函数
    return 0;
}
