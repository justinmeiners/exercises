#include <stdio.h>

main()
{
    int lower = 0;
    int upper = 300;
    int step = 20;

    float faren, celcius;
    faren = lower;

    printf("deg C\tdeg F\n");
    printf("-------------\n");
    while (celcius <= upper)
    {
        faren = ((9.0 / 5.0) * celcius) + 32.0;

        printf("%3.0f\t%6.1f\n", celcius, faren);
        celcius = celcius + step;
    }
}

