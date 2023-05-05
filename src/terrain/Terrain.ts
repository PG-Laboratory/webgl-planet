import {
  Color,
  IcosahedronGeometry,
  Mesh,
  ShaderMaterial,
  UniformsLib,
  UniformsUtils,
  Vector2,
} from 'three';
import type { SceneObject } from './../SceneObject';
import vert from './terrainVert.glsl';
import frag from './terrainFrag.glsl';
import { activeConfig } from '../config';

export class Terrain implements SceneObject {
  object3D: Mesh;
  material: ShaderMaterial;

  constructor(highPolygonMode = false) {
    this.material = new ShaderMaterial({
      uniforms: UniformsUtils.merge([
        UniformsLib['lights'],
        {
          time: { value: 0.0 }, // TODO Fix time
          resolution: { value: new Vector2() }, // TODO Also fix
          heightOffsetScale: { value: activeConfig.terrain.offsetScale },
          numOctaves: { value: activeConfig.terrain.numOctaves },
          baseFreq: { value: activeConfig.terrain.baseFreq },
          exponent: { value: activeConfig.terrain.exponent },
          lacunarity: { value: activeConfig.terrain.lacunarity },
          persistance: { value: activeConfig.terrain.persistance },
          absInvert: { value: activeConfig.terrain.absInvert },
          waterHeight: { value: activeConfig.water.height },
          landColor: { value: new Color() },
          sandColor: { value: new Color() },
          snowColor: { value: new Color() },
          mountainColor: { value: new Color() },
        },
      ]),
      vertexShader: vert,
      fragmentShader: frag,
      lights: true,
      wireframe: activeConfig.terrain.wireframe,
    });
    const geometry = new IcosahedronGeometry(1, highPolygonMode ? 300 : 100);
    this.object3D = new Mesh(geometry, this.material);
  }

  update(time: number) {
    this.material.uniforms.heightOffsetScale.value =
      activeConfig.terrain.offsetScale;
    this.material.uniforms.numOctaves.value = activeConfig.terrain.numOctaves;
    this.material.uniforms.baseFreq.value = activeConfig.terrain.baseFreq;
    this.material.uniforms.exponent.value = activeConfig.terrain.exponent;
    this.material.uniforms.lacunarity.value = activeConfig.terrain.lacunarity;
    this.material.uniforms.persistance.value = activeConfig.terrain.persistance;
    this.material.uniforms.absInvert.value = activeConfig.terrain.absInvert;
    this.material.uniforms.waterHeight.value = activeConfig.water.height;
    this.material.wireframe = activeConfig.terrain.wireframe;

    this.material.uniforms.landColor.value.set(activeConfig.terrain.landColor);
    this.material.uniforms.sandColor.value.set(activeConfig.terrain.sandColor);
    this.material.uniforms.snowColor.value.set(activeConfig.terrain.snowColor);
    this.material.uniforms.mountainColor.value.set(
      activeConfig.terrain.mountainColor,
    );
  }
}
