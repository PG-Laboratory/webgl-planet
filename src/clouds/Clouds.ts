import {
  IcosahedronGeometry,
  Mesh,
  ShaderMaterial,
  UniformsLib,
  UniformsUtils,
  Vector2,
} from 'three';
import type { SceneObject } from './../SceneObject';
import frag from './cloudsFrag.glsl';
import vert from './cloudsVert.glsl';
import { activeConfig } from '../config';

export class Clouds implements SceneObject {
  object3D: Mesh;
  material: ShaderMaterial;

  constructor() {
    this.material = new ShaderMaterial({
      uniforms: UniformsUtils.merge([
        UniformsLib['lights'],
        {
          time: { value: 0.0 },
          resolution: { value: new Vector2() }, // TODO fix
          opacity: { value: activeConfig.clouds.opacity },
        },
      ]),
      vertexShader: vert,
      fragmentShader: frag,
      transparent: true,
      lights: true,
      // wireframe: true,
    });

    const geometry = new IcosahedronGeometry(1.1, 100);
    this.object3D = new Mesh(geometry, this.material);
  }

  update(time: number) {
    this.material.uniforms.time.value = time;
    this.material.uniforms.opacity.value = activeConfig.clouds.opacity;
  }
}
