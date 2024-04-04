import * as THREE from 'three';

const scene = new THREE.Scene();
scene.background = new THREE.Color(0xE4E6E7); 
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
let renderer;

renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.shadowMap.enabled = true;
document.body.appendChild(renderer.domElement);

// Added ligth
const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
directionalLight.position.set(1, 1, 1).normalize();
directionalLight.castShadow = true; 
scene.add(directionalLight);
directionalLight.position.set(0, 1, 1);

// Added point light
const pointLight = new THREE.PointLight(0xF609F6, 0.5);
pointLight.position.set(0, 2, 0); 
scene.add(pointLight);


const geometry = new THREE.BoxGeometry();
const material = new THREE.MeshLambertMaterial({ color: 0x57C211 });
const cube = new THREE.Mesh(geometry, material);
scene.add(cube);
cube.castShadow = true;


camera.position.z = 5;

const floorGeometry = new THREE.PlaneGeometry(15, 15, 55, 50);
const floorMaterial = new THREE.MeshLambertMaterial({ color: 0x9B979B, side: THREE.DoubleSide });  //  wireframe: true 
const floorMesh = new THREE.Mesh(floorGeometry, floorMaterial);
floorMesh.rotation.x = -Math.PI / 2;
floorMesh.position.y = -1.5; 
floorMesh.receiveShadow = true; 
scene.add(floorMesh);

// Function to move the cube in a circle
function moveInCircle(radius, time) {
    const x = radius * Math.cos(time);
    const z = radius * Math.sin(time);
    return { x, z };
}

// Add a shining blue sphere moving up and down
const sphereGeometry = new THREE.SphereGeometry(0.5, 32, 32);
const sphereMaterial = new THREE.MeshPhongMaterial({ color: 0x0000ff, shininess: 100 });
const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
scene.add(sphere);
sphere.castShadow = true;

let sphereUp = true;
let spherePosY = 0;

function animateSphere() {
    if (sphereUp) {
        spherePosY += 0.01;
    } else {
        spherePosY -= 0.01;
    }
    if (spherePosY >= 2) {
        sphereUp = false;
    } else if (spherePosY <= 0) {
        sphereUp = true;
    }
    sphere.position.y = spherePosY;
}

// Add a yellow torus with cyclic scaling
const torusGeometry = new THREE.TorusGeometry(0.5, 0.2, 16, 100);
const torusMaterial = new THREE.MeshLambertMaterial({ color: 0xffff00 });
const torus = new THREE.Mesh(torusGeometry, torusMaterial);
scene.add(torus);
torus.castShadow = true;

let torusScaleUp = true;

function animateTorus() {
    if (torusScaleUp) {
        torus.scale.x += 0.01;
        torus.scale.y += 0.01;
        torus.scale.z += 0.01;
    } else {
        torus.scale.x -= 0.01;
        torus.scale.y -= 0.01;
        torus.scale.z -= 0.01;
    }
    if (torus.scale.x >= 2) {
        torusScaleUp = false;
    } else if (torus.scale.x <= 0.2) {
        torusScaleUp = true;
    }
}

const animate = function (time) {
    requestAnimationFrame(animate);

    // Move cube in a circle with radius 2
    const { x, z } = moveInCircle(2, time * 0.002); // Decreased multiplier for slower movement
    cube.position.set(x, 0, z);

    animateSphere();
    animateTorus();

    renderer.render(scene, camera);
};

animate();
