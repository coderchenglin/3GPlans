//
//  main.cpp
//  快速排序
//
//  Created by chenglin on 2024/8/20.
//

//#include <iostream>
//
//
//using namespace std;
//
//void swap(int &a, int &b) {
//    int temp = a;
//    a = b;
//    b = temp;
//}
//
////三数取中法
//int Getmid(vector<int> &a, int left, int right) {
//    int mid = (left + right)>>1;
//    if(a[left] < a[mid])
//        if(a[mid] < a[right])
//        return mid;                      //mid为中间值
//        else
//        if(a[left] < a[right])
//            return right;                //right为中间值
//        else
//            return left;                 //left为中间值
//    else
//        if(a[mid] > a[right])
//        return mid;                      //mid为中间值
//        else
//        if(a[left] > a[right])
//            return right;                //right为中间值
//        else
//            return left;                 //left为中间值
//}
//
//
////前后指针法：
////int partition(vector<int> &arr, int low, int high) {
////    int pos = Getmid(arr, low, high);
////    swap(arr[pos], arr[high]);
////
////    int pivot = arr[high]; //选择最后一个元素作为枢轴
////    int i = low - 1;  // i是比枢轴小的元素的索引
////
////    for (int j = low; j < high; j++) {
////        //如果当前元素小于等于枢轴
////        if (arr[j] < pivot) {
////            i++;
////            swap(arr[i], arr[j]);
////        }
////    }
////    swap(arr[i + 1], arr[high]);
////    return i + 1;
////
////}
//
//
////左右指针法：
////int partition(vector<int> &arr, int left, int right) {
////    int pos = Getmid(arr, left, right);
////    swap(arr[pos], arr[left]);
////
////    int i = left;
////    int j = right;
////    int key = arr[left];
////
////    while (i != j) {
////        while (i < j && arr[j] >= key)  //向左找到小于基准值的值的下标
////            j--;
////        while (i < j && arr[i] <= key)  //向右找到大于基准值的值的下标
////            i++;
////        swap(arr[i], arr[j]);
////    }
////
////    swap(arr[left], arr[i]);
////    return i;
////}
//
//
////挖坑法
////先将基准值的值记录下来，因为后面会挖坑，直接覆盖掉基准值，等到i，j相遇后，那个坑就用来填此基准值
//int partition(vector<int> &arr, int left, int right) {
//    int pos = Getmid(arr, left, right);
//    swap(arr[pos], arr[left]);
//
//    int i = left;
//    int j = right;
//    int key = arr[left];
//
//    while (i != j) {
//        while (i < j && arr[j] >= key) { //必须先动右边的，因为取的基准值在左边
//            j--;  //向左寻找知道找到比基准值小的
//        }
//        arr[i] = arr[j];  //挖坑，填入比基准值小的值
//
//        while (i < j && arr[i] <= key) { //再动左边的
//            i++;  //向右寻找知道找到比基准值答的
//        }
//        arr[j] = arr[i]; //挖坑
//    }
//
//    //i等于j时跳出循环，下标为i的位置即为合适的插入位置
//    arr[i] = key; //在i，j相遇的位置填入基准值
//    return i;
//}
//
//
//void quickSort(vector<int> &arr, int low, int high) {
//    if (low < high) {
//        int pi = partition(arr, low, high);
//        //递归调用对左子数组和右子数组进行排序
//        quickSort(arr, low, pi - 1);
//        quickSort(arr, pi + 1, high);
//    }
//}
//
//int main(int argc, const char * argv[]) {
//
//    vector<int> arr = {1, 7, 8, 9, 1, 10};
//    int n = arr.size();
//    quickSort(arr, 0, n - 1);
//    cout << "Sorted array: ";
//    for (int i = 0; i < n; i++) {
//        cout << arr[i] << " ";
//    }
//    cout << endl;
//
//    return 0;
//}

#include <iostream>

using namespace::std;

int getMid(vector<int> &a, int left, int right) {
    int mid = (left + right) >> 1;
    if ((a[left] < a[mid]) ^ (a[left] < a[right]))
        return left;
    else if ((a[right] < a[mid]) ^ (a[right] < a[left]))
        return right;
    else
        return mid;
}

int partition(vector<int> &a, int left, int right) {
    int pos = getMid(a, left, right);
    swap(a[pos], a[left]);
    
    int i = left;
    int j = right;
    int key = a[left];
    
    while (i != j) {
        while (i < j && a[j] >= key) {
            j--;
        }
        while (i < j && a[i] <= key) {
            i++;
        }
        swap(a[i], a[j]);
    }
    
    swap(a[i], a[left]);
    return i;
}

void quickSort(vector<int> &a, int left, int right) {
    if (left >= right) {
        return;
    }
    
    int i = partition(a, left, right);
    quickSort(a, left, i - 1);
    quickSort(a, i + 1, right);
}

void show(vector<int> &v){
    for(auto &x : v) {
        cout<<x<<" ";
    }
    cout<<endl;
}

int main(int argc, char* argv[]){
    vector<int> v;
    srand((int)time(0));
    int n = 50;
    while(n--)
    v.push_back(rand() % 100 + 1);
    show(v);

    quickSort(v, 0, v.size() - 1);

    cout<<endl<<endl;
    show(v);
}

