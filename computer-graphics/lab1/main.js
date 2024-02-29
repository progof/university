import * as THREE from 'three';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

const geometry = new THREE.BoxGeometry(1, 1, 1);
const material = new THREE.MeshBasicMaterial({ color: 0x419BD6 });
const material2 = new THREE.MeshBasicMaterial({ color: 0xE94639 });

const cube = new THREE.Mesh(geometry, material);
const cube_second = new THREE.Mesh(geometry, material2);

const pyramidGeometry = new THREE.ConeGeometry(1, 2, 4);
const pyramidMaterial = new THREE.MeshBasicMaterial({ color: 0xffff00 });
const pyramidMesh = new THREE.Mesh(pyramidGeometry, pyramidMaterial);


const torusGeometry = new THREE.TorusGeometry(1, 0.4, 16, 100); 
const torusMaterial = new THREE.MeshBasicMaterial({ color: 0xDF33DA });
const torusMesh = new THREE.Mesh(torusGeometry, torusMaterial);


scene.add(cube);
scene.add(cube_second);
scene.add(pyramidMesh);
scene.add(torusMesh);


camera.position.z = 3;

cube.position.set(-3, 0, 0);      
pyramidMesh.position.set(-1, 0, 0); 
torusMesh.position.set(1, 0, 0);    
cube_second.position.set(3, 0, 0);   



function animate() {
    requestAnimationFrame(animate);

    cube.rotation.x += 0.02;
    cube.rotation.y += 0.02;

    cube_second.rotation.x += 0.02;
    cube_second.rotation.y += 0.02;

    pyramidMesh.rotation.x += 0.02;
    pyramidMesh.rotation.y += 0.02;

    torusMesh.rotation.x += 0.01;
    torusMesh.rotation.y += 0.01;


    renderer.render(scene, camera);
}

animate();
