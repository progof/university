import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';

const N = 40;

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.shadowMap.enabled = true; 
document.body.appendChild(renderer.domElement);


const controls = new OrbitControls(camera, renderer.domElement);


const wallGeometry = new THREE.PlaneGeometry(20, 20);  
const wallMaterial = new THREE.MeshPhongMaterial({ color: 0xffff00 });
const wall = new THREE.Mesh(wallGeometry, wallMaterial);
wall.position.z = -3; 
wall.receiveShadow = true;
scene.add(wall);

const pointLight = new THREE.PointLight(0xffffff, 1, 100);
pointLight.position.set(0, 5, 5);
pointLight.castShadow = true;
scene.add(pointLight);

const ambientLight = new THREE.AmbientLight(0x404040, 2); 
scene.add(ambientLight);

const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
directionalLight.position.set(5, 10, 7.5);
directionalLight.castShadow = true;
scene.add(directionalLight);

const sphereGeometry = new THREE.SphereGeometry(0.2, 32, 32);
const sphereMaterial = new THREE.MeshPhongMaterial({ color: 0x0000ff, shininess: 100 });

const radius = 3; 
const angleStep = (2 * Math.PI) / N;

for (let i = 0; i < N; i++) {
    const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
    sphere.position.x = radius * Math.cos(i * angleStep);
    sphere.position.y = radius * Math.sin(i * angleStep);
    sphere.position.z = 0;
    sphere.castShadow = true; 
    scene.add(sphere);
}

camera.position.set(0, 5, 10);
camera.lookAt(0, 0, 0);

function animate() {
    requestAnimationFrame(animate);
    controls.update(); 
    renderer.render(scene, camera);
}

animate();
