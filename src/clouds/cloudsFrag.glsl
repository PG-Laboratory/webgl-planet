uniform float time;
uniform float opacity;
uniform float amount;
uniform float warp;
uniform float smoothness;
uniform vec3 color;

in vec3 outPosition;
in vec3 outNormal;

#pragma glslify:psrdnoise=require(./../commonShader/psrdnoise3-min.glsl)

#if NUM_DIR_LIGHTS>0
struct DirectionalLight{
    vec3 direction;
    vec3 color;
};
uniform DirectionalLight directionalLights[NUM_DIR_LIGHTS];
#endif

vec3 diffuse(vec3 normal){
    vec3 lightDir=directionalLights[0].direction;
    vec3 lightColor=directionalLights[0].color;
    vec3 norm=normalize(normal);
    float diff=max(dot(norm,lightDir),0.);
    return diff*lightColor;
}

void main(){
    // https://stegu.github.io/psrdnoise/3d-tutorial/3d-psrdnoise-tutorial-04.html
    vec3 v=2.*vec3(outPosition);
    vec3 period=vec3(0.);
    vec3 gradient;
    vec3 gradientSum=vec3(0.);
    float alpha=.1*time;
    float amp=1.;
    float scale=.7;
    float noise=0.;
    
    float maxOffset=0.;
    
    for(float i=0.;i<7.;i++){
        noise+=amp*psrdnoise(scale*v+warp*gradientSum,period,scale*alpha,gradient);
        gradientSum+=amp*gradient;
        maxOffset+=amp;
        amp*=mix(.9,.1,smoothness);
        scale*=2.;
    }
    
    float offsetFromMax=.4;
    float minEdge=mix(maxOffset-.001-offsetFromMax,-maxOffset,amount);
    float transition=smoothstep(minEdge,maxOffset-offsetFromMax,noise);
    
    float a=opacity*transition;
    
    gl_FragColor=vec4(color*diffuse(outNormal),a);
}