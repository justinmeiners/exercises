#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int prime_sieve(int* start, int* end)
{
    int count = (int)(end - start);
    memset(start, 0, sizeof(int) * count);

    for (int p = 1; p < count; ++p)
    {
        if (start[p] == 1) continue;

        int stride = (p + 1);
        for (int n = p + stride; n < count; n += stride)
            start[n] = 1;
   }
   
   int i = 0;
   for (int n = 1; n < count; ++n)
   {
        if (start[n] == 0)
        {
            start[i] = n + 1;
            ++i;
        }
   }

   return i;
}


int main(int argc, const char* argv[])
{
    int* buffer = malloc(sizeof(int) * 100);
    int* end = buffer + 100;

    int count = prime_sieve(buffer, end);


    for (int i = 0; i < count; ++i)
    {
        printf("%i\n", buffer[i]);
    }

    return 1;
}
