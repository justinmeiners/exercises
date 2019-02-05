/* Mandlebrot explained. By Justin Meiners (2017) 

The image is written to standard out in the PPM format. You can pipe the results into a file like so:

    ./mandelbrot > out.ppm

  https://en.wikipedia.org/wiki/Mandelbrot_set 
  */
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

/* the input c is a complex coordinate in the plane
ca is the real part. cb is imaginary.
n is the number of iterations */
int mandelbrot(double ca, double cb, int n)
{
    /* We want to iterate the following function
    and find out if it diverges or is bounded

    f(z) = z^2 + c
    z starts at 0
    where c is a number in the complex plane
    and z is the previous iteration result

    z is complex number 
    which stores the result of the previous iteration */
    double za = 0.0;
    double zb = 0.0;
    
    int i = 0;
    while (i < n)
    {
        /* z^2 = (a + bi)^2
               = (a + bi) * (a + bi)
               = (a^2 + 2abi - b^2) */
        double real = (za * za - zb * zb) + ca;
        double imag = (2.0 * za * zb) + cb;

        /* save result for next iteration */
        za = real;
        zb = imag;

        /* if we have exceeded the bounds we are done */
        if (za * za + zb * zb > 2.0) break; 
        ++i;
    }

    return i;
}

/* The pallete is used to assign colors to pieces, based on how fast they diverge. This particular pallete was taken from this link: 
  https://stackoverflow.com/questions/16500656/which-color-gradient-is-used-to-color-mandelbrot-in-wikipedia */

unsigned char pallete[] = {
    60, 30, 15,
    25, 7, 26,
    9, 1, 47,
    4, 4, 73,
    0, 7, 100,
    12, 44, 138,
    24, 82, 177,
    57, 125, 209,
    134, 181, 229,
    211, 236, 248,
    241, 233, 191,
    248, 201, 95,
    255, 170, 0,
    204, 128, 0,
    153, 87, 0,
    106, 42, 3,
};

/* populates result with a color from the pallete */
void sample_pallete(int it, int n, unsigned char* result)
{
    int color_count = sizeof(pallete) / sizeof(pallete[0]) / 3;
 
    if (it < n && it > 0)
    {
        int index = it % color_count;

        for (int i = 0; i < 3; ++i)
            result[i] = pallete[index * 3 + i];
    }
    else
    {
        for (int i = 0; i < 3; ++i)
            result[i] = 0;
    }
}

int main(int argc, const char* argv[])
{
    int w = 512;
    int h = 512;
    int max_iterations = 500;

    /* we will use the PPM file format since it is so easy to write.
    write the header "P6 width height component_max " */
    fprintf(stdout, "P6 %i %i %i\n", w, h, UCHAR_MAX);

    /* iterate through every pixel */
    for (int y = 0; y < h; ++y)
    {
        for (int x = 0; x < w; ++x)
        {
            /* normalized coordinates */
            double nx = x / (double)w;
            double ny = y / (double)h;

            /* scale for nice mandlebrot viewing */
            double cx = nx * 3.0 - 2.0;
            double cy = ny * 3.0 - 1.5;

            /* it is the number of iterations it took to diverge */
            int it = mandelbrot(cx, cy, max_iterations);

            /* write RGB components out */
            unsigned char comps[3];
            sample_pallete(it, max_iterations, comps);
            fwrite(comps, sizeof(comps[0]), 3, stdout);
        }
    }
    return 0;
}
