uniform float time;
uniform vec2 resolution;

in vec3 outNormal;
in vec3 fragPos;
in float radialOffset;

vec3 objColor=vec3(.57,.76,.23);
vec3 snowColor=vec3(1.,1.,1.);
float ambientFactor=0.;

#if NUM_DIR_LIGHTS>0
struct DirectionalLight{
    vec3 direction;
    vec3 color;
};
uniform DirectionalLight directionalLights[NUM_DIR_LIGHTS];
#endif

vec3 ambient(){
    vec3 lightColor=directionalLights[0].color;
    return ambientFactor*lightColor;
}

vec3 diffuse(vec3 normal){
    vec3 lightDir=directionalLights[0].direction;
    vec3 lightColor=directionalLights[0].color;
    vec3 norm=normalize(normal);
    float diff=max(dot(norm,lightDir),0.);
    return diff*lightColor;
}

vec3 terrainTexture(){
    if(radialOffset>.065)
    return snowColor;
    else if(radialOffset>.04)
    return objColor;
    else
    return vec3(.1,.1,.9);
}

void main(){
    vec3 result=(ambient()+diffuse(outNormal))*terrainTexture();
    gl_FragColor=vec4(result,1.);
    // gl_FragColor = vec4(terrainTexture(), 1.0);
    // gl_FragColor = vec4(0.5 * outNormal + 0.5, 1.0);
}