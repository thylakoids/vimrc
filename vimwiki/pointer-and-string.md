``` c++
const n = 10;
const int *p = &n; //valid
int const *p = &n; //invalid
const int const *p = &n;


int arr2[3][4] = {{1,2,3,4}, {5,6,7,8}, {9,10,11,12}};
int (*arr2)[4] // pointer to array of 4 int
int *arr2[4] // array of 4 pointer to int      int* arr2[4]
```
