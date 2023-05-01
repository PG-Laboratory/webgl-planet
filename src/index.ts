import { Sky } from './sky/Sky';
import { Application } from './Application';
import { Terrain } from './terrain/Terrain';
import { Water } from './water/Water';
import { GUI } from './gui';
import { Clouds } from './clouds/Clouds';
import { Atmosphere } from './atmosphere/Atmosphere';

const sky = new Sky();
const terrain = new Terrain();
const water = new Water();
const clouds = new Clouds();
const atmosphere = new Atmosphere();

const application = new Application();
application.addSceneObject(sky);
application.addSceneObject(terrain);
application.addSceneObject(water);
application.addSceneObject(clouds);
application.addSceneObject(atmosphere);
application.start();

//@ts-ignore
document.getElementsByClassName('loading-screen')[0].style.opacity = 0;

const gui = new GUI();
