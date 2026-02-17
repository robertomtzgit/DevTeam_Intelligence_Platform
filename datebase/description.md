# Estructura de Base de Datos - DevTeam Intelligence Platform (DTIP)

**Motor de Base de Datos:** MariaDB / MySQL  
**Herramienta de Gestión:** PHPMyAdmin  
**Versión del Script:** 1.0 (Simplificada para IA)

Este documento describe el esquema de base de datos relacional diseñado para soportar la plataforma de gestión de proyectos con Inteligencia Artificial. El diseño respeta la **3ra Forma Normal (3NF)** y está optimizado para consultas rápidas de los módulos de Machine Learning.

## Diagrama Entidad-Relación (Descripción)

El sistema consta de 6 tablas principales:
1.  **users**: Usuarios y roles (Admin, Dev, PM).
2.  **areas**: Catálogo simple de áreas (Backend, Frontend, etc.).
3.  **projects**: Información general de los proyectos.
4.  **tasks**: El núcleo del sistema. Contiene los datos para entrenar la IA (complejidad, prioridad).
5.  **task_history**: Auditoría de cambios para el Sistema Experto de riesgos.
6.  **comments**: Colaboración del equipo.

## Base de Datos vs. IA

Concepto de IA: Feature (Entrada)
Campo en tu BD (SQL): tasks.complexity_score
Uso: Define qué tan difícil es el problema.

Concepto de IA: Feature (Entrada)
Campo en tu BD (SQL): tasks.priority
Uso: Define la urgencia.

Concepto de IA: Feature (Entrada)
Campo en tu BD (SQL): users.area_id
Uso: Filtra candidatos (no asignar Backend a un Frontend).

Concepto de IA: Label (Salida/Predicción)
Campo en tu BD (SQL): tasks.assigned_to
Uso: Lo que el modelo intentará adivinar.

Concepto de IA: Métrica de Entrenamiento
Campo en tu BD (SQL): tasks.completed_at - tasks.created_at
Uso: Tiempo real que tomó la tarea (para enseñar a la IA).

Concepto de IA: Detector de Anomalías
Campo en tu BD (SQL): task_history.new_status
Uso: Detecta si una tarea regresa de "QA" a "DEV" muchas veces (retrabajo).
