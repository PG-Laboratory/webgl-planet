import { Sky } from './sky/Sky';
import { Application } from './Application';
import { Terrain } from './terrain/Terrain';
import { Water } from './water/Water';

const sky = new Sky();
const terrain = new Terrain();
const water = new Water();

const application = new Application();
application.addSceneObject(sky);
application.addSceneObject(terrain);
application.addSceneObject(water);
application.start();

// addSlider({
//   parentId: 'camera-setting',
//   value: defaultConfig.test.speed,
//   label: 'Testing speed',
//   min: 0,
//   max: 0.1,
//   onChange: (newVal) => (defaultConfig.test.speed = newVal),
// });

// addSlider({
//   parentId: 'camera-setting',
//   value: defaultConfig.test.zoom,
//   label: 'Zoom',
//   min: 0.5,
//   max: 5,
//   onChange: (newVal) => (defaultConfig.test.zoom = newVal),
// });
