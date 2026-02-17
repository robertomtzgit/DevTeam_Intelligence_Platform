# DevTeam Intelligence Platform (DTIP) 

![Status](https://img.shields.io/badge/Status-In%20Development-yellow)
![Backend](https://img.shields.io/badge/Backend-Java-red)
![Database](https://img.shields.io/badge/Database-MariaDB-blue)
![AI](https://img.shields.io/badge/AI-Microservice-green)

**DevTeam Intelligence Platform** es una solución de gestión de proyectos de software diseñada para superar las limitaciones de las herramientas tradicionales. A diferencia de los tableros Kanban convencionales, DTIP utiliza una **arquitectura distribuida** y un **módulo de Inteligencia Artificial** para asistir en la toma de decisiones, optimizando la asignación de recursos y detectando riesgos de retraso en tiempo real.

## Características Principales

### Inteligencia Artificial Integrada
- **Asignación Inteligente de Tareas:** Algoritmo de clasificación supervisada que sugiere al desarrollador ideal basándose en la complejidad de la tarea (1-10), el área (Backend/Frontend) y el historial de desempeño.
- **Sistema Experto de Riesgos:** Análisis predictivo que alerta sobre posibles retrasos comparando la velocidad real del equipo vs. las fechas estimadas.

### Gestión de Proyectos Moderna
- **Tablero Kanban Interactivo:** Flujo de trabajo visual (Backlog, Todo, In Progress, Review, Done).
- **Métricas en Tiempo Real:** Visualización del ciclo de vida de las tareas.
- **Colaboración:** Sistema de comentarios y actualizaciones en tiempo real.

### Arquitectura Técnica
El sistema sigue un patrón de **microservicios desacoplados**:

1.  **Core Backend (Java):** API RESTful que maneja la lógica de negocio, autenticación y orquestación.
2.  **Base de Datos (MariaDB):** Modelo relacional normalizado (3NF) optimizado para integridad y consultas analíticas.
3.  **Módulo IA:** Servicio independiente que consume datos históricos para reentrenar modelos de predicción.
4.  **Frontend:** Interfaz web reactiva.

## Tecnologías Utilizadas

* **Lenguaje Principal:** Java (Backend)
* **Base de Datos:** MariaDB / MySQL
* **Gestión de BD:** PHPMyAdmin
* **Inteligencia Artificial:** Python (Scikit-Learn/TensorFlow) *[Integración vía API]*
* **Control de Versiones:** Git & GitHub

## Estructura del Proyecto

```text
devteam-intelligence-platform/
├── docs/                  # Documentación técnica y diagramas UML/ERD
├── database/              # Scripts SQL de creación (Schema & Seeds)
├── backend/               # Código fuente del servidor Java
│   ├── src/
│   └── pom.xml (o build.gradle)
├── ai-module/             # Scripts de entrenamiento y API de predicción
└── README.md              # Este archivo
