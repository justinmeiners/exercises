// Helpful Websites:
// [Rendering Worlds With Two Triangles](http://www.iquilezles.org/www/material/nvscene2008/nvscene2008.htm")
// [Raymarching Distance Fields](http://9bitscience.blogspot.com/2013/07/raymarching-distance-fields_14.html)

float g_epsilon = 0.002;
float g_max = 50.0;

float sdPlane( vec3 p)
{
return p.y;
}

float sdSphere( vec3 p, float s )
{
return length(p)-s;
}

float sdBox( vec3 p, vec3 b )
{
vec3 d = abs(p) - b;
return min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0));
}


float smin( float a, float b, float k )
{
float h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 );
return mix( b, a, h ) - k*h*(1.0-h);
}

float distanceField(vec3 p)
{
float d = 1000.0;
float dt = 0.0;
dt = sdPlane(p);
d = min(d, dt);

dt = sdSphere(vec3(mod(p.x, 1.0) - 0.5, p.y + 0.25 - cos(p.x) * .2, mod(p.z, 1.0) - 0.5), 0.5);
d = smin(d, dt, 0.1);

dt = sdBox(p, vec3(0.5, 2.0, 0.5));
d = min(d, dt);

return d;
}


vec4 raytrace(vec3 ro, vec3 rd)
{
vec4 color = vec4(0.4 * rd.x, 0.4 * (rd.x + 1.0) / 2.0, 1.0, 1.0);

float t = 0.0;
const int maxSteps = 60;
for(int i = 0; i < maxSteps; ++i)
{
vec3 p = ro + rd * t;
float d = distanceField(p);


if (d < g_epsilon || d > g_max)
{
color = vec4(0.0, float(i) / 32.0, 0.0, 1.0);
break;
}

t += d;
}

return color;
}

mat3 setCamera( in vec3 ro, in vec3 ta, float cr )
{
vec3 cw = normalize(ta-ro);
vec3 cp = vec3(sin(cr), cos(cr),0.0);
vec3 cu = normalize( cross(cw,cp) );
vec3 cv = normalize( cross(cu,cw) );
return mat3( cu, cv, cw );
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
vec2 uv = (fragCoord.xy / iResolution.xy) * 2.0 - 1.0;
uv.x *= iResolution.x/iResolution.y;

float time = 15.0 + iTime;

vec3 ro = vec3( -0.8+3.5*cos(0.5*time), 3.0, 0.8 + 3.5*sin(0.5*time) );
vec3 ta = vec3( 0.0, -0.4, 0.0 );

// camera-to-world transformation
mat3 ca = setCamera( ro, ta, 0.0 );

// ray direction
vec3 rd = ca * normalize( vec3(uv.xy,2.0) );

fragColor = raytrace(ro, rd);
}

