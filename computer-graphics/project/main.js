import * as THREE from 'three';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.5, 1000);
const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

camera.position.set(-12, 15, 30);
camera.lookAt(scene.position);

// Player creation - spaceship
const shipTexture = new THREE.TextureLoader().load('/images/whiteship.png');
const playerGeometry = new THREE.CylinderGeometry();
const playerMaterial = new THREE.MeshBasicMaterial({ map: shipTexture });
const playerShip = new THREE.Mesh(playerGeometry, playerMaterial);
playerShip.position.y = 1; 
playerShip.position.z = 10; 
scene.add(playerShip);

// An array for storing enemy ships
const enemies = [];
let killedEnemies = 0; // Counter of killed enemies
const maxEnemiesPerGroup = 5; // Maximum number of enemies in a group
const totalEnemyGroups = 500; // Total number of enemy groups
let currentEnemyGroup = 0; // Current enemy group
let enemyGroupInterval; // Interval for generating an enemy group
let enemySpeed = 0.1; // Initial enemy speed

// Function to generate an enemy group
function generateEnemyGroup() {
    for (let i = 0; i < maxEnemiesPerGroup; i++) {
        const enemyTexture = new THREE.TextureLoader().load('/images/backship.jpeg');
        const enemyGeometry = new THREE.TorusKnotGeometry();
        const enemyMaterial = new THREE.MeshBasicMaterial({ map: enemyTexture });
        const enemyShip = new THREE.Mesh(enemyGeometry, enemyMaterial);
        const randomX = getRandomNumber(-20, 20); // Random position on X axis
        const randomZ = getRandomNumber(-50, -20); // Random Z-axis position
        enemyShip.position.set(randomX, 1, randomZ); // Position of the enemy ship
        scene.add(enemyShip);
        enemies.push(enemyShip);
    }
}

function getRandomNumber(min, max) {
    return Math.random() * (max - min) + min;
}

function movePlayer(direction) {
    const speed = 1;
    switch (direction) {
        case 'left':
            playerShip.position.x -= speed;
            break;
        case 'right':
            playerShip.position.x += speed;
            break;
    }
}

function shoot() {
    const bulletGeometry = new THREE.SphereGeometry (0.2, 16, 8);
    const bulletMaterial = new THREE.MeshBasicMaterial({ color: 0xFF0000});
 
    const bullet = new THREE.Mesh(bulletGeometry, bulletMaterial);
    bullet.position.copy(playerShip.position);
    scene.add(bullet);
    // Bullet motion
    function moveBullet() {
        bullet.position.z -= 0.5;
        // Checking bullet collision with enemies
        enemies.forEach((enemy, index) => {
            if (bullet.position.distanceTo(enemy.position) < 2) {
                // Clashing with the enemy
                scene.remove(bullet);
                scene.remove(enemy);
                enemies.splice(index, 1);
                killedEnemies++; // Increase the counter of killed enemies
                updateKilledEnemiesCounter(); // Update the counter of killed enemies on the screen
                if (killedEnemies % 5 === 0) {
                    enemySpeed += 0.15; // Increase enemy speed after every 5 kills
                }
            }
        });
        if (bullet.position.z < -50) {
            // Removing the bullet if it is out of the scene
            scene.remove(bullet);
        } else {
            requestAnimationFrame(moveBullet);
        }
    }
    moveBullet();
}

// Function to check player collision
function checkPlayerCollision() {
    enemies.forEach((enemy) => {
        if (playerShip.position.distanceTo(enemy.position) < 2) {
            // Stop the game if there is a collision with the enemy
            stopGame();
        }
    });
}

// Function to stop the game
function stopGame() {
    // Stop the animation
    cancelAnimationFrame(animationId);

    // Create a container for the game over message
    const gameOverContainer = document.createElement('div');
    gameOverContainer.style.position = 'absolute';
    gameOverContainer.style.width = '300px';
    gameOverContainer.style.padding = '20px';
    gameOverContainer.style.background = 'rgba(255, 255, 255, 0.8)';
    gameOverContainer.style.borderRadius = '10px';
    gameOverContainer.style.boxShadow = '0 0 10px rgba(0, 0, 0, 0.5)';
    gameOverContainer.style.textAlign = 'center';
    gameOverContainer.style.top = '50%';
    gameOverContainer.style.left = '50%';
    gameOverContainer.style.transform = 'translate(-50%, -50%)';
    
    // Create a message about the end of the game
    const gameOverText = document.createElement('div');
    gameOverText.style.color = 'green';
    gameOverText.innerText = 'Game Over :(';
    gameOverText.style.marginBottom = '20px';
    gameOverContainer.appendChild(gameOverText);
    
    // Create a restart button
    const restartButton = document.createElement('button');
    restartButton.innerText = 'Restart';
    restartButton.style.padding = '10px 20px';
    restartButton.style.background = 'green';
    restartButton.style.color = 'white';
    restartButton.style.border = 'none';
    restartButton.style.borderRadius = '5px';
    restartButton.style.cursor = 'pointer';
    restartButton.addEventListener('click', () => {
        // Remove the game over container
        document.body.removeChild(gameOverContainer);
        restartGame();
    });
    gameOverContainer.appendChild(restartButton);

    // Add the game over container to the body
    document.body.appendChild(gameOverContainer);
}

// Function to restart the game
function restartGame() {
    // Remove all enemies from the scene
    enemies.forEach((enemy) => {
        scene.remove(enemy);
    });
    enemies.length = 0;
    // Remove all bullets from the scene
    killedEnemies = 0;
    enemySpeed = 0.1; // Reset enemy speed
    // Restart the generation of enemy groups
    updateKilledEnemiesCounter();
    // Restart the animation
    animate();
}

const backgroundLights = [];

// Function to create glowing spheres
function createBackgroundLights() {
    const lightCount = 200; 
    for (let i = 0; i < lightCount; i++) {
        const light = new THREE.PointLight(0xffffff, 1, 30); 
        const sphereGeometry = new THREE.SphereGeometry(0.2, 16, 8); 
        const sphereMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });
        const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
        
        const randomX = getRandomNumber(-60, 90); 
        const randomY = getRandomNumber(-40, 70); 
        const randomZ = getRandomNumber(-50, -10); 
        
        light.position.set(randomX, randomY, randomZ);
        sphere.position.copy(light.position);

        scene.add(light);
        scene.add(sphere);
        backgroundLights.push({ light, sphere, velocity: { 
            x: getRandomNumber(-0.01, 0.01), 
            y: getRandomNumber(-0.01, 0.01), 
            z: getRandomNumber(-0.01, 0.01) 
        } 
    });
    }
}

// Function to move glowing spheres
function moveBackgroundLights() {
    backgroundLights.forEach(({ light, sphere, velocity }) => {
        light.position.x += velocity.x;
        light.position.y += velocity.y;
        light.position.z += velocity.z;

        sphere.position.copy(light.position);

        if (light.position.x < -30 || light.position.x > 30) velocity.x = -velocity.x;
        if (light.position.y < 0 || light.position.y > 20) velocity.y = -velocity.y;
        if (light.position.z < -50 || light.position.z > -10) velocity.z = -velocity.z;
    });
}

function animate() {
    animationId = requestAnimationFrame(animate);

    // Move enemies
    enemies.forEach((enemy) => {
        enemy.position.z += enemySpeed; // Move the enemy ship along the Z axis based on the current speed
    });

    // Check if the enemy is out of the scene
    checkPlayerCollision();
    moveBackgroundLights(); // Move glowing spheres

    renderer.render(scene, camera);
}

// Add event listeners for player movement and shooting
document.addEventListener('keydown', (event) => {
    switch (event.key) {
        case 'ArrowLeft':
            movePlayer('left');
            break;
        case 'ArrowRight':
            movePlayer('right');
            break;
        case ' ':
            shoot();
            break;
    }
});

// Start the animation
let animationId;
animate();

// Function to start generating enemies
function startGeneratingEnemies() {
    // Set an interval for generating enemy groups
    enemyGroupInterval = setInterval(() => {
        // Generate a new enemy group
        if (currentEnemyGroup < totalEnemyGroups) {
            generateEnemyGroup();
            currentEnemyGroup++;
        } else {
            // Stop generating enemy groups after reaching the total number of groups
            clearInterval(enemyGroupInterval);
        }
    }, 5000); // Generate a new group every 5 seconds
}

// Call the function to start generating enemies
startGeneratingEnemies();

// Function to update the counter of killed enemies on the screen
function updateKilledEnemiesCounter() {
    const counterElement = document.getElementById('killedEnemiesCounter');
    if (counterElement) {
        counterElement.innerText = 'Enemies killed: ' + killedEnemies;
    } else {
        const counterContainer = document.createElement('div');
        counterContainer.id = 'killedEnemiesCounter';
        counterContainer.style.position = 'fixed';
        counterContainer.style.bottom = '20px'; 
        counterContainer.style.left = '20px';
        counterContainer.style.padding = '10px';
        counterContainer.style.background = 'rgba(255, 255, 255, 0.8)';
        counterContainer.style.borderRadius = '5px';
        counterContainer.style.boxShadow = '0 0 10px rgba(0, 0, 0, 0.5)';
        counterContainer.style.color = 'green';
        counterContainer.innerText = 'Enemies killed: ' + killedEnemies;
        document.body.appendChild(counterContainer);
    }
}

// Call the function to create glowing spheres
createBackgroundLights();
