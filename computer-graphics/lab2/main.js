import * as THREE from 'three';

const scene = new THREE.Scene();

const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
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

// Floor
const floorGeometry = new THREE.PlaneGeometry(15, 15, 55, 50);
const floorMaterial = new THREE.MeshLambertMaterial({ color: 0x9B979B, side: THREE.DoubleSide });  //  wireframe: true 
const floorMesh = new THREE.Mesh(floorGeometry, floorMaterial);
floorMesh.rotation.x = -Math.PI / 2;
floorMesh.position.y = -1.5; 
floorMesh.receiveShadow = true; 
scene.add(floorMesh);




const geometry = new THREE.BoxGeometry(0.5, 0.5, 0.5);
const material = new THREE.MeshLambertMaterial({ color: 0x419BD6 });
const material2 = new THREE.MeshLambertMaterial({ color: 0xE94639 });

const cube = new THREE.Mesh(geometry, material);
cube.castShadow = true; 
const cube_second = new THREE.Mesh(geometry, material2);
cube_second.castShadow = true;

const pyramidGeometry = new THREE.ConeGeometry(0.5, 1, 4);
const pyramidMaterial = new THREE.MeshLambertMaterial({ color: 0xffff00 });
const pyramidMesh = new THREE.Mesh(pyramidGeometry, pyramidMaterial);
pyramidMesh.castShadow = true; 

const torusGeometry = new THREE.TorusGeometry(0.5, 0.2, 16, 100);
const torusMaterial = new THREE.MeshLambertMaterial({ color: 0xDF33DA });
const torusMesh = new THREE.Mesh(torusGeometry, torusMaterial);
torusMesh.castShadow = true; 

scene.add(cube);
scene.add(cube_second);
scene.add(pyramidMesh);
scene.add(torusMesh);

camera.position.z = 3;

cube.position.set(-3, 0, 0);
pyramidMesh.position.set(-1, 0, 0);
torusMesh.position.set(1, 0, 0);
cube_second.position.set(3, 0, 0);

renderer.shadowMap.enabled = true;

function animate() {
    requestAnimationFrame(animate);

    cube.rotation.x += 0.02;
    cube.rotation.y += 0.02;

    cube_second.rotation.x += 0.03;
    cube_second.rotation.y += 0.03;

    pyramidMesh.rotation.x += 0.03;
    pyramidMesh.rotation.y += 0.03;

    torusMesh.rotation.x += 0.03;
    torusMesh.rotation.y += 0.03;

    renderer.render(scene, camera);
}

animate();


