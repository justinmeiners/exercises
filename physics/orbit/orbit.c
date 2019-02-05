/* Created by Justin Meiners (2016) */

#include <stdio.h>
#include <math.h>

int main(int argc, const char * argv[])
{
    
    /* constants */
    double gravityConstant = 6.67e-11;
    double radiusEarth = 6.371e6;
    double massEarth = 5.972e24;
    
    /* variables */
    double x = 1.2 * radiusEarth;
    double y = 0.0;
    double vx = 0.0;
    double vy = 9600.0;
    
    /* how many seconds to step forward each iteration */
    double timeFactor = 8.0;
    
    /* how often to print to the screen */
    int printInterval = 250;
    int printCounter = 0;
    
    /* how many iterations to run simulation */
    int simulationTime = 50000;
    
    for (int t = 0; t < simulationTime; t++)
    {
        /* unit vector from earth to object */
        double length = sqrt(x*x + y*y);
        double ex = x / length;
        double ey = y / length;
        
        
        /* a = Gm/r^2*/
        double accelGravity = (gravityConstant * massEarth) / (length * length);
        
    
        /* add acceleration into velocity */
        vx -= ex * accelGravity * timeFactor;
        vy -= ey * accelGravity * timeFactor;
        
        /* modify position */
        x += vx * timeFactor;
        y += vy * timeFactor;
        
        printCounter++;
        
        if (printCounter > printInterval)
        {
            printf("%f, %f\n", x / radiusEarth, y / radiusEarth);
            printCounter = 0;
        }
    }
    
    
    printf("Done\n");
    return 0;
}
