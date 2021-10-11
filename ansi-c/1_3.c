#include <stdio.h>

main()
{
    int lower = 0;
    int upper = 300;
    int step = 20;

    float faren, celcius;
    faren = lower;

    printf("deg F\tdeg C\n");
    printf("-------------\n");
    while (faren <= upper)
    {
        celcius = (5.0 / 9.0) * (faren - 32.0);

        printf("%3.0f\t%6.1f\n", faren, celcius);
        faren = faren + step;
    }
}

