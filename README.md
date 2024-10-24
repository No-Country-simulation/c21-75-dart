# 📱 Gestión de Cursos y Evaluaciones - Flutter y Firebase

Este proyecto es una **aplicación móvil** desarrollada en **Flutter** que permite gestionar cursos educativos, sus contenidos y las evaluaciones realizadas por los estudiantes. La base de datos utiliza **Firebase Firestore**, permitiendo un manejo eficiente y en tiempo real de la información.

## 🚀 Funcionalidades Principales

- **Explorar Cursos**: Visualiza una lista de cursos disponibles con detalles como título, descripción y material de estudio.  
- **Gestión de Inscripciones**: Permite a los estudiantes inscribirse y gestionar su participación en los cursos.  
- **Evaluaciones**: Los estudiantes pueden dejar evaluaciones con una calificación y un comentario.  
- **Sincronización en Tiempo Real**: Almacenamiento y actualización automática de datos con Firebase.

## 🛠 Tecnologías Utilizadas

- **Flutter**: Framework para el desarrollo de interfaces móviles.  
- **Firebase Firestore**: Almacenamiento de los datos de cursos y evaluaciones.  
- **Dart**: Lenguaje utilizado en la aplicación.

## 📂 Estructura del Proyecto

- **models/**: Define las clases `Course` y `Evaluation`, que representan los datos almacenados en Firestore.  
- **firebase_config.dart**: Archivo de configuración para la integración con Firebase.  
- **ui/**: Contiene las pantallas y widgets de la interfaz de usuario.  
- **services/**: Lógica para interactuar con Firebase Firestore.

## ⚙️ Configuración Inicial

### Clonar el repositorio:
```bash
git clone https://github.com/No-Country-simulation/c21-75-dart.git
cd c21-75-dart
```
## ⚙️ Configuración Inicial

### Clonar el repositorio:
```bash  
git clone https://github.com/No-Country-simulation/c21-75-dart.git  
cd c21-75-dart  
```

### Instalar las dependencias:
```bash
flutter pub get  
```

### Configurar Firebase:
1. Crea un proyecto en [Firebase](https://firebase.google.com/).  
2. Añade la configuración para Android en `firebase_config.dart`.

### Ejecutar la aplicación en tu dispositivo:
```bash  
flutter run  
```
