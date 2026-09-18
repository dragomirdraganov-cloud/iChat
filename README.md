# iChat

iChat es una aplicación de mensajería para iPhone y iPad en desarrollo, creada con SwiftUI y SwiftData.

## Estado actual

- Lista de chats guardados localmente.
- Navegación desde la lista al detalle de cada chat.
- Visualización de mensajes ordenados por fecha y diferenciados según el remitente.
- Interfaz para redactar mensajes. El envío todavía no está implementado.

El proyecto incluye datos de ejemplo para desarrollo en `iChat/App/DummyData.swift`, pero su carga automática está desactivada actualmente. Si la base de datos está vacía, la lista de chats aparecerá vacía.

## Tecnologías

- SwiftUI para la interfaz y la navegación.
- SwiftData para los modelos y la persistencia local.
- Observation para el estado compartido de la aplicación.

## Cómo ejecutarlo

1. Abre `iChat.xcodeproj` en Xcode.
2. Selecciona el esquema `iChat` y un simulador o dispositivo con iOS 26.5 o posterior.
3. Ejecuta la aplicación con **Run** (`⌘R`).

## Licencia

Este proyecto se distribuye bajo la [licencia Apache 2.0](LICENSE).
