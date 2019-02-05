/*  Created by: Justin Meiners (2017) 
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

static inline int Int_Compare(const void *a, const void* b)
{
    return ( *(int*)a - *(int*)b ); 
}

#define BINARY_SEARCH(T, CMP) \
\
static inline T* BinarySearch_##T(const T* key, const T* sortedList, size_t count) \
{  \
    size_t start = 0; \
    size_t end = count; \
    while (start < end)  \
    { \
        size_t mid = start + (end - start) / 2; \
        int cmp = CMP(key, sortedList + mid); \
        if (cmp > 0) \
            start = mid + 1; \
        else if (cmp < 0) \
            end = mid; \
        else \
            return (T*)(sortedList + mid); \
    } \
    return NULL; \
}

BINARY_SEARCH(int, Int_Compare);

int main(int argc, const char* argv[])
{
    clock_t start, end;
    int count = 5000000;
    int range = 10000000;

    int* list = malloc(count * sizeof(int));
    int* toFind = malloc(range * sizeof(int));
    int* found = malloc(range * sizeof(int));

    start = clock();

    for (int i = 0; i < count; ++i)
        list[i] = rand() % range;

    for (int i = 0; i < range; ++i)
        toFind[i] = rand() % range;
 
    // sort the list for searching
    qsort(list, count, sizeof(int), Int_Compare);

    end = clock();
    printf("sorting done %f\n", (end-start)/(double)CLOCKS_PER_SEC);

    start = clock();    
    for (int i = 0; i < range; ++i)
    {
        int* v = BinarySearch_int(toFind + i, list, count);
        found[i] = (v) ? *v : 0;
    }
    end = clock();

    // do something with the result so compiler doesnt optimize it away
    // also convfirm they are working the same
    unsigned long sum = 0;
    for (int i = 0; i < range; ++i)
        sum += found[i];
    printf("%lu \n", sum);

    printf("custom time: %f\n", (end-start)/(double)CLOCKS_PER_SEC);

    start = clock();    
    for (int i = 0; i < range; ++i)
    {
        int* v = bsearch(toFind + i, list, count, sizeof(int), Int_Compare);
        found[i] = (v) ? *v : 0;
    }
    end = clock();

    printf("bsearch time: %f\n", (end-start)/(double)CLOCKS_PER_SEC);

    sum = 0;
    for (int i = 0; i < range; ++i)
        sum += found[i];
    printf("%lu \n", sum);

    return 1;
}
