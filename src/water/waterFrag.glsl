uniform float time;
uniform vec2 resolution;
uniform vec3 color;

in vec3 outNormal;
in vec3 vertPos;
in vec3 vertWorldPos;

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

vec3 specular(vec3 normal){
    float specularStrength=.5;
    vec3 lightDir=directionalLights[0].direction;
    vec3 lightColor=directionalLights[0].color;
    vec3 viewPos=vec3(0.,0.,0.);
    vec3 viewDir=normalize(viewPos-vertPos);
    vec3 norm=normalize(normal);
    vec3 reflectDir=reflect(-lightDir,norm);
    float spec=pow(max(dot(viewDir,reflectDir),0.),16.);
    return specularStrength*spec*lightColor;
}

void main(){
    // float freqScale=10.;
    // float displaceAmount=.02;
    // vec3 gradient=vec3(0.);
    // float noise=psrdnoise(vertWorldPos*freqScale,vec3(10.),2.*time,gradient);
    
    // vec3 gradientProjOnTangentPlane=gradient-dot(gradient,outNormal)*outNormal;
    // vec3 newNormal=normalize(outNormal-displaceAmount*gradientProjOnTangentPlane);
    
    // vec3 result = diffuse(newNormal) * color + specular(newNormal);
    // gl_FragColor = vec4(result, 0.7);
    
    vec3 result=diffuse(outNormal)*color+specular(outNormal);
    gl_FragColor=vec4(result,1.);
    
    // gl_FragColor = vec4(0.5 + 0.5 * outNormal, 1.0);
}