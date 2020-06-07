// we want to iterate the following function
// and find out if it diverges.

// f(z) = z^2 + c
// z starts at 0
// where c is a number in the complex plane
// and z is the previous iteration result


#define ITERATIONS 100

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
    
    // complex number in complex plane
    // (x is real, y is imaginary)
    
    float s = iTime * iTime;
    vec2 c = vec2(uv.x * 3.5 - 2.0, uv.y * 2.0 - 1.0);
    
    // complex number for accumlated result
    // (x is real, y is imaginary)
    vec2 z = vec2(0.0, 0.0);
    
    int i = 0;
    while (i < ITERATIONS)
    {
        // z^2 = (a + bi)^2
        //     = (a + bi) * (a + bi)
        //     = (a^2 + 2abi - b^2)
        
        // real part = a^2 + b^2 + c.real
        float real = z.x * z.x - z.y * z.y + c.x;
        
        // complex part = 2ab
        float imag = 2.0 * z.x * z.y + c.y;
        
        // assign for next iteration
        z.x = real;
        z.y = imag;
        
        // break if bounds exceeded
        if (z.x * z.x + z.y * z.y > 2.0) break;
        ++i;
    }
    
    fragColor = vec4(float(i) / float(ITERATIONS), 0.0, 0.0, 1.0);
}