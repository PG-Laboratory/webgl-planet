export default "#define GLSLIFY 1\nuniform float time;\nuniform vec2 resolution;\n\nout vec3 outPosition;\nout vec3 outNormal;\n\nvoid main(){\n    outPosition=position;\n    outNormal=normalMatrix*normal;\n    gl_Position=projectionMatrix*modelViewMatrix*vec4(position,1.);\n}"