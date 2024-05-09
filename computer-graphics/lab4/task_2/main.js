import * as THREE from 'three';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

const floorTexture = new THREE.TextureLoader().load('texture_floor.jpeg');
const floorMaterial = new THREE.MeshBasicMaterial({ map: floorTexture });
const floorGeometry = new THREE.PlaneGeometry(8, 8, 64, 64); 
const floor = new THREE.Mesh(floorGeometry, floorMaterial);
floor.rotation.x = -Math.PI / 2.0;
floor.position.y = -1.0;
floor.receiveShadow = true;
scene.add(floor);

const cubeTexture = new THREE.TextureLoader().load('texture_cube.jpeg');
const cubeMaterial = new THREE.MeshBasicMaterial({ map: cubeTexture });
const cubeGeometry = new THREE.BoxGeometry(1, 1, 1);
const cube = new THREE.Mesh(cubeGeometry, cubeMaterial);
scene.add(cube);

const sphereTexture = new THREE.TextureLoader().load('texture_sphere.jpeg');
const sphereMaterial = new THREE.MeshBasicMaterial({ map: sphereTexture });
const sphereGeometry = new THREE.SphereGeometry(0.5, 32, 32);
const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
sphere.position.set(-2, 0, 0);
scene.add(sphere);

const torusTexture = new THREE.TextureLoader().load('texture_torus.png');
const torusMaterial = new THREE.MeshBasicMaterial({ map: torusTexture });
const torusGeometry = new THREE.TorusGeometry(0.5, 0.2, 16, 100);
const torus = new THREE.Mesh(torusGeometry, torusMaterial);
torus.position.set(2, 0, 0);
scene.add(torus);

camera.position.z = 5;

function animate() {
    requestAnimationFrame(animate);

    cube.rotation.x += 0.01;
    cube.rotation.y += 0.01;

    sphere.rotation.x += 0.01;
    sphere.rotation.y += 0.01;

    torus.rotation.x += 0.01;
    torus.rotation.y += 0.01;

    renderer.render(scene, camera);
}

animate();


