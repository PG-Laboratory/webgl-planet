import { Sky } from './sky/Sky';
import { Application } from './Application';
import { Terrain } from './terrain/Terrain';
import { Water } from './water/Water';
import { activeConfig } from './config';
import { addSlider, addSwitch } from './gui';

const sky = new Sky();
const terrain = new Terrain();
const water = new Water();

const application = new Application();
application.addSceneObject(sky);
application.addSceneObject(terrain);
application.addSceneObject(water);
application.start();

//@ts-ignore
document.getElementsByClassName('loading-screen')[0].style.opacity = 0;

addSlider({
  parentId: 'terrain-setting',
  value: activeConfig.terrain.offsetScale,
  label: 'Offset scale',
  min: 0.001,
  max: 0.3,
  onChange: (newVal: number) => (activeConfig.terrain.offsetScale = newVal),
});

addSlider({
  parentId: 'terrain-setting',
  value: activeConfig.terrain.numOctaves,
  label: 'Number of octaves',
  min: 1,
  max: 10,
  onChange: (newVal: number) => (activeConfig.terrain.numOctaves = newVal),
  isDiscrete: true,
});

addSlider({
  parentId: 'terrain-setting',
  value: activeConfig.terrain.baseFreq,
  label: 'Fundamental frequency',
  min: 0.5,
  max: 10,
  onChange: (newVal: number) => (activeConfig.terrain.baseFreq = newVal),
});

addSwitch({
  parentId: 'terrain-setting',
  value: activeConfig.terrain.useExponentiation,
  label: 'Use exponentiation',
  onChange: (newVal) => (activeConfig.terrain.useExponentiation = newVal),
});
