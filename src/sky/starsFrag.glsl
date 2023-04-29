uniform float time;
uniform vec2 resolution;

in vec3 outPosition;
in vec3 outNormal;
in vec3 fragPos;
in vec2 uvInterpolated;

#pragma glslify:snoise=require(./../commonShader/noise3D)

void main(){
    vec3 result=vec3(0.);
    
    // float otherNoiseSample = 0.5 * snoise(0.07 * outPosition) + 0.5;
    // result += 0.1 * otherNoiseSample * vec3(0.9, 0.1, 0.9);
    
    float starNoiseSample=.5*snoise(2.*outPosition)+.5;
    result+=vec3(.8*smoothstep(.88,.99,starNoiseSample));
    
    gl_FragColor=vec4(result,1.);
}