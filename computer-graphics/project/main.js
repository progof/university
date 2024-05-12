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
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.5, 1000);
const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

// Tworzymy gracza - statek kosmiczny
const playerGeometry = new THREE.BoxGeometry();
const playerMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });
const playerShip = new THREE.Mesh(playerGeometry, playerMaterial);
// Przesuwamy statek gracza niżej na osi Y
playerShip.position.y = -10; // Przykładowa nowa pozycja statku gracza
scene.add(playerShip);

// Ustawiamy pozycję kamery nad statkiem gracza i patrzącą na niego
camera.position.set(0, 10, 0);
camera.rotation.set(-Math.PI / 2, 0, 0); // Obracamy kamerę o 90 stopni w lewo
camera.lookAt(playerShip.position);

// Tablica przechowująca wrogie statki
const enemies = [];
let killedEnemies = 0; // Licznik zabitych wrogów

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
        enemyShip.position.set(randomX, -10, randomZ); // Przesuwamy wrogie statki na ten sam poziom Y co statek gracza
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
    const bulletGeometry = new THREE.ShapeGeometry();
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
                killedEnemies++; // Zwiększ licznik zabitych wrogów
                updateKilledEnemiesCounter(); // Aktualizuj licznik zabitych wrogów na ekranie
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

    // Tworzymy kontener dla komunikatu o przegranej grze
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
    
    // Dodajemy tekst komunikatu o przegranej grze
    const gameOverText = document.createElement('div');
    gameOverText.style.color = 'green';
    gameOverText.innerText = 'Przegrałeś!';
    gameOverText.style.marginBottom = '20px';
    gameOverContainer.appendChild(gameOverText);
    
    // Tworzymy przycisk do restartu gry
    const restartButton = document.createElement('button');
    restartButton.innerText = 'Restart';
    restartButton.style.padding = '10px 20px';
    restartButton.style.background = 'green';
    restartButton.style.color = 'white';
    restartButton.style.border = 'none';
    restartButton.style.borderRadius = '5px';
    restartButton.style.cursor = 'pointer';
    restartButton.addEventListener('click', () => {
        // Usuwamy komunikat o przegranej grze i restartujemy grę
        document.body.removeChild(gameOverContainer);
        restartGame();
    });
    gameOverContainer.appendChild(restartButton);

    // Dodajemy kontener do body dokumentu
    document.body.appendChild(gameOverContainer);
}

// Funkcja do restartowania gry
function restartGame() {
    // Usuwamy wszystkich wrogów
    enemies.forEach((enemy) => {
        scene.remove(enemy);
    });
    enemies.length = 0;
    // Zerujemy licznik zabitych wrogów
    killedEnemies = 0;
    // Aktualizujemy licznik zabitych wrogów na ekranie
    updateKilledEnemiesCounter();
    // Restartujemy animację
    animate();
    startGeneratingEnemies();
}

// Funkcja do animacji obiektów
function animate() {
    animationId = requestAnimationFrame(animate);

    // Ruch wrogich statków kosmicznych
    enemies.forEach((enemy) => {
        enemy.position.z += 0.1; // Dodajemy ruch wrogich statków
    });

    // Sprawdzamy kolizję z graczem
    checkPlayerCollision();

    renderer.render(scene, camera);
}

// Funkcja do obsługi klawiatury
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

// Funkcja startująca generowanie wrogów
function startGeneratingEnemies() {
    setInterval(() => {
        generateEnemy();
    }, 1000); // Wywołuj co sekundę, dostosuj czas według potrzeb
}

// Rozpocznij generowanie wrogów
startGeneratingEnemies();

// Funkcja aktualizująca licznik zabitych wrogów na ekranie
function updateKilledEnemiesCounter() {
    const counterElement = document.getElementById('killedEnemiesCounter');
    if (counterElement) {
        counterElement.innerText = 'Zabitych wrogów: ' + killedEnemies;
    } else {
        const counterContainer = document.createElement('div');
        counterContainer.id = 'killedEnemiesCounter';
        counterContainer.style.position = 'fixed';
        counterContainer.style.bottom = '20px'; // Ustawiamy na dolny margines
        counterContainer.style.left = '20px'; // Ustawiamy na lewy margines
        counterContainer.style.padding = '10px';
        counterContainer.style.background = 'rgba(255, 255, 255, 0.8)';
        counterContainer.style.borderRadius = '5px';
        counterContainer.style.boxShadow = '0 0 10px rgba(0, 0, 0, 0.5)';
        counterContainer.style.color = 'green';
        counterContainer.innerText = 'Zabitych wrogów: ' + killedEnemies;
        document.body.appendChild(counterContainer);
    }
}

