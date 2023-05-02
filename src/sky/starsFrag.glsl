uniform float time;
uniform vec2 resolution;

in vec3 outPosition;

#pragma glslify:snoise=require(./../commonShader/noise3D)

void main(){
    vec3 result=vec3(0.);
    float starNoiseSample=.5*snoise(2.*30.*normalize(outPosition))+.5;
    result+=vec3(.8*smoothstep(.88,.99,starNoiseSample));
    gl_FragColor=vec4(result,1.);
}