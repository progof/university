import * as THREE from 'three';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

const floorTexture = generateFloorTexture();
const floorMaterial = new THREE.MeshBasicMaterial({ map: floorTexture });
const floorGeometry = new THREE.PlaneGeometry(8, 8);
const floor = new THREE.Mesh(floorGeometry, floorMaterial);
floor.rotation.x = -Math.PI / 2.0;
scene.add(floor);

const cubeTexture = generateCubeTexture();
const cubeMaterials = cubeTexture.map(tex => new THREE.MeshBasicMaterial({ map: tex }));
const cubeGeometry = new THREE.BoxGeometry(1, 1, 1);
const cube = new THREE.Mesh(cubeGeometry, cubeMaterials);
scene.add(cube);

camera.position.z = 5;

function animate() {
    requestAnimationFrame(animate);

    cube.rotation.x += 0.01;
    cube.rotation.y += 0.01;

    renderer.render(scene, camera);
}


animate();

function generateFloorTexture() {
    const canvas = document.createElement('canvas');
    canvas.width = 128;
    canvas.height = 128;
    const context = canvas.getContext('2d');

    context.fillStyle = '#808080';
    context.fillRect(0, 0, canvas.width, canvas.height);

    const texture = new THREE.CanvasTexture(canvas);
    texture.wrapS = THREE.RepeatWrapping;
    texture.wrapT = THREE.RepeatWrapping;
    texture.repeat.set(8, 8);

    return texture;
}

function generateCubeTexture() {
    const canvasArray = [];

    for (let i = 1; i <= 6; i++) {
        const canvas = document.createElement('canvas');
        canvas.width = 128;
        canvas.height = 128;
        const context = canvas.getContext('2d');

        context.fillStyle = '#ffffff';
        context.fillRect(0, 0, canvas.width, canvas.height);

        const numDots = i;
        context.fillStyle = '#000000';

        if (numDots === 1) {
            context.fillRect(47, 47, 10, 10);
            context.closePath();
        }
        else if (numDots === 2) {
            context.fillRect(17, 77, 10, 10);
            context.closePath();
            context.fillRect(77, 17, 10, 10);
            context.closePath();
        }
        else if (numDots === 3) {
            context.fillRect(47, 47, 10, 10);
            context.closePath();
            context.fillRect(17, 77, 10, 10);
            context.closePath();
            context.fillRect(77, 17, 10, 10);
            context.closePath();
        }
        else if (numDots === 4) {
            context.fillRect(17, 17, 10, 10);
            context.closePath();
            context.fillRect(77, 77, 10, 10);
            context.closePath();
            context.fillRect(17, 77, 10, 10);
            context.closePath();
            context.fillRect(77, 17, 10, 10);
            context.closePath();
        }
        else if (numDots === 5) {
            context.fillRect(47, 47, 10, 10);
            context.closePath();
            context.fillRect(17, 17, 10, 10);
            context.closePath();
            context.fillRect(77, 77, 10, 10);
            context.closePath();
            context.fillRect(17, 77, 10, 10);
            context.closePath();
            context.fillRect(77, 17, 10, 10);
            context.closePath();
        }
        else if (numDots === 6) {
            context.fillRect(17, 17, 10, 10);
            context.closePath();
            context.fillRect(77, 17, 10, 10);
            context.closePath();
            context.fillRect(47, 17, 10, 10);
            context.closePath();
            context.fillRect(17, 77, 10, 10);
            context.closePath();
            context.fillRect(77, 77, 10, 10);
            context.closePath();
            context.fillRect(47, 77, 10, 10);
            context.closePath();
        }

        const texture = new THREE.CanvasTexture(canvas);
        canvasArray.push(texture);
    }

    return canvasArray;
}













