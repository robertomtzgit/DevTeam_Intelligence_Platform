-- Creación de la Base de Datos (Opcional si ya estás dentro de una)
CREATE DATABASE IF NOT EXISTS dtip_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE dtip_db;

-- ==========================================
-- 1. TABLA DE ÁREAS
-- Catálogo simple para clasificar al personal
-- ==========================================
CREATE TABLE areas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
) ENGINE=InnoDB;

-- Insertar datos semilla (Seed data)
INSERT INTO areas (name, description) VALUES 
('Backend', 'Lógica de servidor y base de datos'),
('Frontend', 'Interfaz de usuario'),
('QA', 'Aseguramiento de calidad'),
('DevOps', 'Infraestructura y despliegue');

-- ==========================================
-- 2. GESTIÓN DE USUARIOS
-- ==========================================
CREATE TABLE users (
    id CHAR(36) NOT NULL DEFAULT (UUID()), -- Genera UUID automáticamente (MariaDB 10.2+)
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    
    area_id INT,
    
    -- Roles definidos como ENUM nativo
    role ENUM('ADMIN', 'DEV', 'PROJECT_MANAGER') NOT NULL DEFAULT 'DEV',
    
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    CONSTRAINT fk_users_area FOREIGN KEY (area_id) REFERENCES areas(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ==========================================
-- 3. GESTIÓN DE PROYECTOS
-- ==========================================
CREATE TABLE projects (
    id CHAR(36) NOT NULL DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    
    leader_id CHAR(36) NOT NULL,
    
    start_date DATE NOT NULL,
    end_date_estimated DATE,
    end_date_actual DATE,
    
    -- Estados del proyecto
    status ENUM('PLANNING', 'ACTIVE', 'PAUSED', 'COMPLETED', 'CANCELLED') DEFAULT 'PLANNING',
        
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    CONSTRAINT fk_projects_leader FOREIGN KEY (leader_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- ==========================================
-- 4. TAREAS (Núcleo para la IA)
-- Fusiona Actividades y Tickets
-- ==========================================
CREATE TABLE tasks (
    id CHAR(36) NOT NULL DEFAULT (UUID()),
    
    project_id CHAR(36) NOT NULL,
    assigned_to CHAR(36), -- Puede ser NULL (sin asignar)
    
    title VARCHAR(150) NOT NULL,
    description TEXT,
    
    -- Métricas para el Algoritmo de IA (1=Fácil, 10=Complejo)
    complexity_score TINYINT UNSIGNED CHECK (complexity_score BETWEEN 1 AND 10),
    
    priority ENUM('LOW', 'MEDIUM', 'HIGH', 'CRITICAL') DEFAULT 'MEDIUM',
    
    due_date DATE,
    completed_at DATETIME,
    
    -- Flujo de trabajo (Kanban)
    status ENUM('BACKLOG', 'TODO', 'IN_PROGRESS', 'REVIEW', 'DONE') DEFAULT 'BACKLOG',
        
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    CONSTRAINT fk_tasks_project FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
    CONSTRAINT fk_tasks_user FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ==========================================
-- 5. HISTORIAL DE TAREAS (Auditoría e IA)
-- Registra cada movimiento de tarjeta en el Kanban
-- ==========================================
CREATE TABLE task_history (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    task_id CHAR(36) NOT NULL,
    changed_by CHAR(36),
    
    previous_status VARCHAR(20),
    new_status VARCHAR(20),
    
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_history_task FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    CONSTRAINT fk_history_user FOREIGN KEY (changed_by) REFERENCES users(id)
) ENGINE=InnoDB;

-- ==========================================
-- 6. COMENTARIOS
-- ==========================================
CREATE TABLE comments (
    id CHAR(36) NOT NULL DEFAULT (UUID()),
    task_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    CONSTRAINT fk_comments_task FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    CONSTRAINT fk_comments_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;