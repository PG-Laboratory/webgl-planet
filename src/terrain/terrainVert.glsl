uniform float time;
uniform vec2 resolution;
uniform float heightOffsetScale;
uniform float baseFreq;
uniform float persistance;
uniform float lacunarity;
uniform float exponent;
uniform bool absInvert;
uniform int numOctaves;

out vec3 outNormal;
out float radialOffset;
out vec3 localPos;

#pragma glslify:snoise=require(./../commonShader/noise3D)

float sampleHeight(vec3 pos){
    float heightOffset=0.;
    float amp=1.;
    float freq=baseFreq;
    float normalizeFactor=0.;
    for(int i=0;i<numOctaves;++i){
        if(absInvert){
            heightOffset+=amp*(1.-abs(snoise(freq*pos)));
        }else{
            float noise=.5+.5*snoise(freq*pos);
            heightOffset+=amp*noise;
        }
        normalizeFactor+=amp;
        amp*=persistance;
        freq*=lacunarity;
    }
    heightOffset/=normalizeFactor;
    return heightOffsetScale*pow(heightOffset,exponent);
}

void main(){
    radialOffset=sampleHeight(position);
    
    vec3 n=normalize(position);
    
    // Sample height near the point to calculate gradient using
    // the triangle method
    float offsetLength=.001;
    vec3 tangent1=normalize(cross(n,vec3(1.,0.,.01)));
    vec3 tangent2=normalize(cross(tangent1,n));
    vec3 tangent3=normalize(-(tangent1+tangent2));
    vec3 p1=normalize(position+tangent1*offsetLength);
    vec3 p2=normalize(position+tangent2*offsetLength);
    vec3 p3=normalize(position+tangent3*offsetLength);
    vec3 s1=(1.+sampleHeight(p1))*p1;
    vec3 s2=(1.+sampleHeight(p2))*p2;
    vec3 s3=(1.+sampleHeight(p3))*p3;
    vec3 v1=s1-s3;
    vec3 v2=s2-s3;
    outNormal=normalMatrix*normalize(cross(v2,v1));
    
    localPos=position;
    
    gl_Position=projectionMatrix*modelViewMatrix*vec4(position+radialOffset*n,1.);
}