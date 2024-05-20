// Импорт необходимых модулей из Three.js
import * as THREE from 'three';

// Создание сцены, камеры и рендерера
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.5, 1000);
const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

// Установка позиции и поворота камеры
camera.position.set(-12, 15, 30);
camera.lookAt(scene.position);

// Создание игрока - космического корабля
const shipTexture = new THREE.TextureLoader().load('ship.jpeg');
const playerGeometry = new THREE.CylinderGeometry();
// const playerMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });
const playerMaterial = new THREE.MeshBasicMaterial({ map: shipTexture });
const playerShip = new THREE.Mesh(playerGeometry, playerMaterial);
// Продвигаем корабль игрока вниз по оси Y и чуть вперед по оси Z
playerShip.position.y = 1; 
playerShip.position.z = 10; 
scene.add(playerShip);

// Массив для хранения вражеских кораблей
const enemies = [];
let killedEnemies = 0; // Счетчик убитых врагов
const maxEnemiesPerGroup = 5; // Максимальное количество врагов в группе
const totalEnemyGroups = 500; // Общее количество групп врагов
let currentEnemyGroup = 0; // Текущая группа врагов
let enemyGroupInterval; // Интервал для генерации группы врагов

// Функция для генерации вражеской группы
function generateEnemyGroup() {
    for (let i = 0; i < maxEnemiesPerGroup; i++) {
        const enemyTexture = new THREE.TextureLoader().load('backship.jpeg');
        const enemyGeometry = new THREE.TorusKnotGeometry();
        // const enemyMaterial = new THREE.MeshBasicMaterial({ color: 0xff0000 });
        const enemyMaterial = new THREE.MeshBasicMaterial({ map: enemyTexture });
        const enemyShip = new THREE.Mesh(enemyGeometry, enemyMaterial);
        const randomX = getRandomNumber(-20, 20); // Случайная позиция по оси X
        const randomZ = getRandomNumber(-50, -20); // Случайная позиция по оси Z
        enemyShip.position.set(randomX, 1, randomZ); // Позиция вражеского корабля
        scene.add(enemyShip);
        enemies.push(enemyShip);
    }
}

// Функция для генерации случайного числа в заданном диапазоне
function getRandomNumber(min, max) {
    return Math.random() * (max - min) + min;
}

// Функция для движения игрока
function movePlayer(direction) {
    const speed = 0.9;
    switch (direction) {
        case 'left':
            playerShip.position.x -= speed;
            break;
        case 'right':
            playerShip.position.x += speed;
            break;
    }
}

// Функция для стрельбы
function shoot() {
    const bulletGeometry = new THREE.SphereGeometry (0.2, 16, 8);
    const bulletMaterial = new THREE.MeshBasicMaterial({ color: 0xFF0000});
 
    const bullet = new THREE.Mesh(bulletGeometry, bulletMaterial);
    bullet.position.copy(playerShip.position);
    scene.add(bullet);
    // Движение пули
    function moveBullet() {
        bullet.position.z -= 0.5;
        // Проверка столкновения пули с врагами
        enemies.forEach((enemy, index) => {
            if (bullet.position.distanceTo(enemy.position) < 1) {
                // Столкновение с врагом
                scene.remove(bullet);
                scene.remove(enemy);
                enemies.splice(index, 1);
                killedEnemies++; // Увеличиваем счетчик убитых врагов
                updateKilledEnemiesCounter(); // Обновляем счетчик убитых врагов на экране
            }
        });
        if (bullet.position.z < -50) {
            // Удаление пули, если она выходит за пределы обзора
            scene.remove(bullet);
        } else {
            requestAnimationFrame(moveBullet);
        }
    }
    moveBullet();
}

// Функция для проверки столкновений с игроком
function checkPlayerCollision() {
    enemies.forEach((enemy) => {
        if (playerShip.position.distanceTo(enemy.position) < 1) {
            // Столкновение с игроком
            stopGame();
        }
    });
}

// Функция для завершения игры при столкновении с врагом
function stopGame() {
    // Остановка анимации
    cancelAnimationFrame(animationId);

    // Создание контейнера для сообщения о проигрыше
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
    
    // Добавление текста сообщения о проигрыше
    const gameOverText = document.createElement('div');
    gameOverText.style.color = 'green';
    gameOverText.innerText = 'Проиграли!';
    gameOverText.style.marginBottom = '20px';
    gameOverContainer.appendChild(gameOverText);
    
    // Создание кнопки для перезапуска игры
    const restartButton = document.createElement('button');
    restartButton.innerText = 'Перезапустить';
    restartButton.style.padding = '10px 20px';
    restartButton.style.background = 'green';
    restartButton.style.color = 'white';
    restartButton.style.border = 'none';
    restartButton.style.borderRadius = '5px';
    restartButton.style.cursor = 'pointer';
    restartButton.addEventListener('click', () => {
        // Удаление сообщения о проигрыше и перезапуск игры
        document.body.removeChild(gameOverContainer);
        restartGame();
    });
    gameOverContainer.appendChild(restartButton);

    // Добавление контейнера в тело документа
    document.body.appendChild(gameOverContainer);
}

// Функция для перезапуска игры
function restartGame() {
    // Удаление всех врагов
    enemies.forEach((enemy) => {
        scene.remove(enemy);
    });
    enemies.length = 0;
    // Сброс счетчика убитых врагов
    killedEnemies = 0;
    // Обновление счетчика убитых врагов на экране
    updateKilledEnemiesCounter();
    // Перезапуск анимации
    animate();
}



const backgroundLights = [];

// Функция для генерации светящихся сфер на заднем плане
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
        backgroundLights.push({ light, sphere, velocity: { x: getRandomNumber(-0.01, 0.01), y: getRandomNumber(-0.01, 0.01), z: getRandomNumber(-0.01, 0.01) } });
    }
}

// Функция для движения светящихся сфер
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


// Функция для анимации объектов
function animate() {
    animationId = requestAnimationFrame(animate);

    // Движение вражеских кораблей
    enemies.forEach((enemy) => {
        enemy.position.z += 0.1; // Движение вперед
    });

    // Проверка столкновения с игроком
    checkPlayerCollision();
    moveBackgroundLights(); // Добавляем движение для светящихся сфер

    renderer.render(scene, camera);
}

// Обработчик клавиатуры
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

// Начало анимации
let animationId;
animate();

// Функция для запуска генерации врагов
function startGeneratingEnemies() {
    // Устанавливаем интервал для генерации группы врагов
    enemyGroupInterval = setInterval(() => {
        // Генерируем новую группу врагов, если еще не все группы созданы
        if (currentEnemyGroup < totalEnemyGroups) {
            generateEnemyGroup();
            currentEnemyGroup++;
        } else {
            // Останавливаем интервал, если все группы созданы
            clearInterval(enemyGroupInterval);
        }
    }, 5000); // Интервал в 5 секунд (можно изменить по необходимости)
}

// Начать генерацию врагов
startGeneratingEnemies();

// Функция для обновления счетчика убитых врагов на экране
function updateKilledEnemiesCounter() {
    const counterElement = document.getElementById('killedEnemiesCounter');
    if (counterElement) {
        counterElement.innerText = 'Убито врагов: ' + killedEnemies;
    } else {
        const counterContainer = document.createElement('div');
        counterContainer.id = 'killedEnemiesCounter';
        counterContainer.style.position = 'fixed';
        counterContainer.style.bottom = '20px'; // Устанавливаем внизу
        counterContainer.style.left = '20px'; // Устанавливаем слева
        counterContainer.style.padding = '10px';
        counterContainer.style.background = 'rgba(255, 255, 255, 0.8)';
        counterContainer.style.borderRadius = '5px';
        counterContainer.style.boxShadow = '0 0 10px rgba(0, 0, 0, 0.5)';
        counterContainer.style.color = 'green';
        counterContainer.innerText = 'Убито врагов: ' + killedEnemies;
        document.body.appendChild(counterContainer);
    }
}





// Вызов функции для создания светящихся сфер
createBackgroundLights();

