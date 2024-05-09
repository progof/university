import * as THREE from 'three';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);


const canvas = document.createElement('canvas');
canvas.width = 128;
canvas.height = 128;
const ctx = canvas.getContext('2d');
for (let y = 0; y < 8; y++) {
    for (let x = 0; x < 8; x++) {
        if ((x + y) % 2 === 0) {
            ctx.fillStyle = 'white';
        } else {
            ctx.fillStyle = 'black';
        }
        ctx.fillRect(x * 16, y * 16, 16, 16); 
    }
}
const texture = new THREE.CanvasTexture(canvas);

const floorGeometry = new THREE.PlaneGeometry(8, 8, 64, 64); 

const floorMaterial = new THREE.MeshBasicMaterial({ map: texture });


const floor = new THREE.Mesh(floorGeometry, floorMaterial);
floor.rotation.x = -Math.PI / 2.0;
floor.position.y = -1.0;
floor.receiveShadow = true;
scene.add(floor);


const geometry = new THREE.BoxGeometry(1, 1, 1);
const material = new THREE.MeshBasicMaterial({ color: 0x00ff00 });
const cube = new THREE.Mesh(geometry, material);
scene.add(cube);

camera.position.z = 5;

function animate() {
    requestAnimationFrame(animate);

    cube.rotation.x += 0.01;
    cube.rotation.y += 0.01;

    renderer.render(scene, camera);
}

animate();

