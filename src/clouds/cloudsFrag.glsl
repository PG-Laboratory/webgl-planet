uniform float time;
uniform vec2 resolution;
uniform float opacity;

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
    vec3 v=2.*vec3(outPosition)+time*vec3(.02);
    // vec3 v = 4.0 * vec3(outPosition);
    vec3 p=vec3(0.);
    vec3 g;
    vec3 gsum=vec3(0.);
    float alpha=.01*time;
    float w=1.;
    float s=1.;
    float n=0.;
    
    for(float i=0.;i<5.;i++){
        n+=w*psrdnoise(s*v+.13*gsum,p,s*alpha,g);
        gsum+=w*g;
        w*=.5;
        s*=2.;
    }
    
    // vec3 mixcolor = vec3(0.5 + 0.4 * n);
    // gl_FragColor = vec4(mixcolor, 0.4);
    
    vec3 mixcolor=vec3(1)*diffuse(outNormal);
    gl_FragColor=vec4(mixcolor,opacity*smoothstep(-.2,1.,n));
    // gl_FragColor = vec4(mixcolor, 0.5 + 0.4 * n);
    
    // gl_FragColor = vec4(1.0, 0.0, 0.0, 0.2);
}