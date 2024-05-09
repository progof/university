// // Импортируем необходимые модули Three.js
// import * as THREE from 'three';

// // Создаем сцену, камеру и рендерер
// const scene = new THREE.Scene();
// const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
// const renderer = new THREE.WebGLRenderer();
// renderer.setSize(window.innerWidth, window.innerHeight);
// document.body.appendChild(renderer.domElement);

// // Создаем куб
// const geometry = new THREE.BoxGeometry();
// const material = new THREE.MeshBasicMaterial({ color: 0x00ff00 });
// const cube = new THREE.Mesh(geometry, material);
// scene.add(cube);

// // Позиционируем камеру
// camera.position.z = 5;

// // Устанавливаем скорость перемещения куба
// const moveSpeed = 0.5;

// // Создаем функцию для обновления кадров
// function animate() {
//     requestAnimationFrame(animate);

//     // Поворачиваем куб
//     cube.rotation.x += 0.01;
//     cube.rotation.y += 0.01;

//     renderer.render(scene, camera);
// }

// // Вызываем функцию animate для начала анимации
// animate();

// // Обрабатываем нажатия клавиш
// document.addEventListener('keydown', (event) => {
//     switch (event.key) {
//         case 'ArrowLeft':
//             cube.position.x -= moveSpeed; // Перемещаем куб влево с учетом скорости
//             break;
//         case 'ArrowRight':
//             cube.position.x += moveSpeed; // Перемещаем куб вправо с учетом скорости
//             break;
//     }
// });


// Importujemy niezbędne moduły z Three.js
import * as THREE from 'three';

// Tworzymy scenę, kamerę i renderer
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

// Tworzymy gracza - statek kosmiczny
const playerGeometry = new THREE.BoxGeometry();
const playerMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });
const playerShip = new THREE.Mesh(playerGeometry, playerMaterial);
// Перемещаем корабль игрока ниже по оси Y
playerShip.position.y = -5; // Примерное новое положение корабля игрока

scene.add(playerShip);

// Ustawiamy pozycję kamery nad statkiem gracza i patrzącą na niego
// camera.position.set(0, 0, 10);
// camera.rotateZ(45);
// Устанавливаем позицию камеры над кораблем игрока и направляем ее вниз, чтобы видеть врагов сверху
camera.position.set(0, 10, 0);
camera.rotation.set(-Math.PI / 2, 0, 0); // Поворачиваем камеру на 90 градусов влево

camera.lookAt(playerShip.position);

// Tablica do przechowywania wrogich statków
const enemies = [];

// Limit generowanych wrogich statków
const maxEnemies = 5;

// Funkcja do generowania wrogich statków
function generateEnemy() {
    if (enemies.length < maxEnemies) {
        const enemyGeometry = new THREE.BoxGeometry();
        const enemyMaterial = new THREE.MeshBasicMaterial({ color: 0xff0000 });
        const enemyShip = new THREE.Mesh(enemyGeometry, enemyMaterial);
        const randomX = getRandomNumber(-10, 10); // Losowa pozycja w osi X
        const randomZ = getRandomNumber(-50, -20); // Losowa pozycja w osi Z (statki będą pojawiały się przed graczem)
        enemyShip.position.set(randomX, 0, randomZ);
        scene.add(enemyShip);
        enemies.push(enemyShip);
    }
}

// Funkcja do generowania losowych liczb z zakresu
function getRandomNumber(min, max) {
    return Math.random() * (max - min) + min;
}

// Funkcja do ruchu gracza
function movePlayer(direction) {
    const speed = 0.5;
    switch (direction) {
        case 'left':
            playerShip.position.x -= speed;
            break;
        case 'right':
            playerShip.position.x += speed;
            break;
    }
}

// Funkcja do strzelania
function shoot() {
    const bulletGeometry = new THREE.BoxGeometry();
    const bulletMaterial = new THREE.MeshBasicMaterial({ color: 0x00ff00 });
    const bullet = new THREE.Mesh(bulletGeometry, bulletMaterial);
    bullet.position.copy(playerShip.position);
    scene.add(bullet);
    // Ruch strzału
    function moveBullet() {
        bullet.position.z -= 0.5;
        // Sprawdzanie kolizji strzału z wrogami
        enemies.forEach((enemy, index) => {
            if (bullet.position.distanceTo(enemy.position) < 1) {
                // Kolizja z wrogiem
                scene.remove(bullet);
                scene.remove(enemy);
                enemies.splice(index, 1);
            }
        });
        if (bullet.position.z < -50) {
            // Usuwanie strzału, jeśli przekroczy granice widzenia
            scene.remove(bullet);
        } else {
            requestAnimationFrame(moveBullet);
        }
    }
    moveBullet();
}

// Funkcja do sprawdzania kolizji z graczem
function checkPlayerCollision() {
    enemies.forEach((enemy) => {
        if (playerShip.position.distanceTo(enemy.position) < 1) {
            // Kolizja z graczem
            stopGame();
        }
    });
}

// Funkcja do zatrzymywania gry i wyświetlania komunikatu o przegranej
function stopGame() {
    // Zatrzymujemy animację
    cancelAnimationFrame(animationId);
    // Wyświetlamy komunikat o przegranej grze
    const gameOverText = document.createElement('div');
    gameOverText.style.position = 'absolute';
    gameOverText.style.width = '100%';
    gameOverText.style.textAlign = 'center';
    gameOverText.style.color = 'green';
    gameOverText.style.top = '50%';
    gameOverText.innerText = 'Przegrałeś! Naciśnij przycisk, aby zacząć grę ponownie.';
    document.body.appendChild(gameOverText);
    // Tworzymy przycisk do restartu gry
    const restartButton = document.createElement('button');
    restartButton.innerText = 'Restart';
    restartButton.style.position = 'absolute';
    restartButton.style.top = '60%';
    restartButton.style.left = '50%';
    restartButton.style.transform = 'translate(-50%, -50%)';
    restartButton.addEventListener('click', () => {
        // Usuwamy komunikat o przegranej grze i restartujemy grę
        document.body.removeChild(gameOverText);
        document.body.removeChild(restartButton);
        restartGame();
    });
    document.body.appendChild(restartButton);
}

// Funkcja do restartowania gry
function restartGame() {
    // Usuwamy wszystkich wrogów
    enemies.forEach((enemy) => {
        scene.remove(enemy);
    });
    enemies.length = 0;
    // Restartujemy animację
    animate();
}

// Funkcja do animacji obiektów
function animate() {
    animationId = requestAnimationFrame(animate);

    // Ruch wrogich statków kosmicznych
    enemies.forEach((enemy) => {
        enemy.position.z += 0.1; // Dodajemy ruch wrogich statków
    });

    // Generowanie wrogich statków
    generateEnemy();

    // Sprawdzamy kolizję z graczem
    checkPlayerCollision();

    renderer.render(scene, camera);
}

// Obsługa klawiatury
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

// Rozpoczęcie animacji
let animationId;
animate();


