export default "#define GLSLIFY 1\nuniform float time;\nuniform vec2 resolution;\n\nout vec3 outPosition;\n\nvoid main(){\n    outPosition=position;\n    gl_Position=projectionMatrix*modelViewMatrix*vec4(position,1.);\n}"