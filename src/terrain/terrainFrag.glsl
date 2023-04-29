uniform float time;
uniform vec2 resolution;

in vec3 outPosition;
in vec3 outNormal;
in vec3 fragPos;
in vec2 uvInterpolated;

// Some hard coded values that are very much subject to change
// eventually
// vec3 lightPos = vec3(3.0, 2.0, 6.0);
vec3 lightPos=10.*vec3(3.,2.,1.);
// vec3 lightPos = vec3(6.0, 0.0, 0.0);
vec3 lightColor=vec3(1.,1.,1.);
vec3 objColor=vec3(.57,.76,.23);
float ambientFactor=0.;

vec3 ambient(){
    return ambientFactor*lightColor;
}

vec3 diffuse(vec3 normal){
    vec3 norm=normalize(normal);
    vec3 lightDir=normalize(lightPos-fragPos);
    float diff=max(dot(norm,lightDir),0.);
    return diff*lightColor;
}

void main(){
    vec3 result=(ambient()+diffuse(outNormal))*objColor;
    // result *= sin(time);
    gl_FragColor=vec4(result,1.);
    
    // gl_FragColor = vec4(0.5 * outNormal + 0.5, 1.0);
}