import {merge} from "../snowpack/pkg/lodash.js";
const defaultConfig = {
  terrain: {
    offsetScale: 0.3,
    numOctaves: 8,
    lacunarity: 2,
    persistance: 0.5,
    baseFreq: 1.2,
    exponent: 3,
    wireframe: false,
    absInvert: false
  },
  atmosphere: {
    opacity: 0.2,
    wireframe: false,
    color: "#eeeeee"
  },
  clouds: {
    opacity: 1,
    height: 1.1
  },
  water: {
    height: 1.035
  },
  camera: {
    autoRotate: false
  }
};
export class ConfigIntValMeta {
  constructor(min, max, label) {
    this.min = min;
    this.max = max;
    this.label = label;
  }
}
export class ConfigFloatValMeta {
  constructor(min, max, label) {
    this.min = min;
    this.max = max;
    this.label = label;
  }
}
export class ConfigBoolValMeta {
  constructor(label) {
    this.label = label;
  }
}
export class ConfigColorValMeta {
  constructor(label) {
    this.label = label;
  }
}
export const configMetaData = {
  terrain: {
    offsetScale: new ConfigFloatValMeta(1e-3, 1, "Offset scale"),
    numOctaves: new ConfigIntValMeta(1, 10, "Number of octaves"),
    lacunarity: new ConfigFloatValMeta(1.1, 3, "Lacunarity"),
    persistance: new ConfigFloatValMeta(0.1, 0.7, "Persistance"),
    baseFreq: new ConfigFloatValMeta(0.5, 4, "Fundamental frequency"),
    exponent: new ConfigFloatValMeta(0.01, 5, "Exponent"),
    wireframe: new ConfigBoolValMeta("Wireframe"),
    absInvert: new ConfigBoolValMeta("Abs invert")
  },
  atmosphere: {
    wireframe: new ConfigBoolValMeta("Wireframe"),
    opacity: new ConfigFloatValMeta(0, 1, "Opacity"),
    color: new ConfigColorValMeta("Color")
  },
  clouds: {
    opacity: new ConfigFloatValMeta(0, 1, "Opacity"),
    height: new ConfigFloatValMeta(0.9, 1.3, "Height")
  },
  water: {
    height: new ConfigFloatValMeta(0.98, 1.1, "Height")
  },
  camera: {
    autoRotate: new ConfigBoolValMeta("Auto-rotate")
  }
};
function cloneConfig(config) {
  return JSON.parse(JSON.stringify(config));
}
export let activeConfig = cloneConfig(defaultConfig);
export function loadPreset(preset) {
  activeConfig = merge(cloneConfig(defaultConfig), cloneConfig(preset));
}
export const presets = new Map();
presets.set("Default", defaultConfig);
presets.set("Water debug", {
  terrain: {
    offsetScale: 0,
    numOctaves: 1,
    wireframe: false
  },
  atmosphere: {
    wireframe: false,
    opacity: 0
  },
  clouds: {
    opacity: 0
  }
});
presets.set("No clouds or atmosphere", {
  atmosphere: {
    opacity: 0
  },
  clouds: {
    opacity: 0
  }
});
