import * as THREE from 'three';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

const geometry = new THREE.BoxGeometry(1, 1, 1);
const material = new THREE.MeshBasicMaterial({ color: 0x00ff00 });
const cube = new THREE.Mesh(geometry, material);
scene.add(cube);

camera.position.z = 5;

let animationId;
let animationPaused = false;

function animate() {
    animationId = requestAnimationFrame(animate);

    if (!animationPaused) {
        cube.rotation.x += 0.01;
        cube.rotation.y += 0.01;
    }

    renderer.render(scene, camera);
}

animate();

function toggleAnimation() {
    animationPaused = !animationPaused;
}

function handleKeyPress(event) {
    switch (event.key) {
        case ' ':
            toggleAnimation();
            break;
        case 'ArrowUp':
            cube.rotation.x += 0.2;
            break;
        case 'ArrowDown':
            cube.rotation.x -= 0.2;
            break;
        case 'ArrowLeft':
            cube.rotation.y += 0.2;
            break;
        case 'ArrowRight':
            cube.rotation.y -= 0.2;
            break;
    }
}

window.addEventListener('keydown', handleKeyPress);

function getRandomColor() {
    return Math.random() * 0xffffff;
}

function getRandomSize() {
    return Math.random() * 2 + 1;
}

function getRandomGeometry() {
    const geometries = [
        new THREE.BoxGeometry(getRandomSize(), getRandomSize(), getRandomSize()),
        new THREE.SphereGeometry(getRandomSize(), 32, 32),
        new THREE.ConeGeometry(getRandomSize(), getRandomSize() * 2, 32)
    ];
    const randomIndex = Math.floor(Math.random() * geometries.length);
    return geometries[randomIndex];
}

function addRandomObject() {
    const randomGeometry = getRandomGeometry();
    const randomMaterial = new THREE.MeshBasicMaterial({ color: getRandomColor() });
    const randomObject = new THREE.Mesh(randomGeometry, randomMaterial);
    
    randomObject.position.x = (Math.random() - 0.5) * 10; 
    randomObject.position.y = (Math.random() - 0.5) * 10; 
    randomObject.position.z = (Math.random() - 0.5) * 10; 
    
    scene.add(randomObject);
    
    function animateRandomObject() {
        randomObject.rotation.x += 0.01;
        randomObject.rotation.y += 0.01;
    }
    
    function renderRandomObject() {
        animateRandomObject();
        renderer.render(scene, camera);
        requestAnimationFrame(renderRandomObject);
    }
    
    renderRandomObject();
}

function handleMouseDown(event) {
    if (event.button === 0) { 
        addRandomObject();
    }
}

window.addEventListener('mousedown', handleMouseDown);

