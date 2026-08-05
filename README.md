# Escena de Museo con Reloj

Una aplicación de Flutter animada que muestra una galería de museo virtual en 2.5D. La aplicación presenta un suave zoom de cámara cinematográfico que viaja por la habitación y se detiene elegantemente en un reloj de pared.

## Características

- **Movimiento de Cámara Cinematográfico:** Utiliza un `Transform` preciso y un `AnimationController` para hacer un zoom suave directamente hacia un punto focal designado.
- **Entorno 2.5D Rico:** Hermosos elementos de diseño plano meticulosamente superpuestos utilizando un `Stack`, incorporando pinturas, esculturas y una perspectiva de piso simulada.
- **Reloj Pintado Personalizado:** Cuenta con un reloj analógico animado, muy detallado y pintado a medida, con manecillas independientes en movimiento.
- **Interactivo:** Toca la pantalla o presiona el botón de acción flotante para invertir o repetir el movimiento de la cámara.

## Instrucciones de Configuración y Ejecución

Este es un proyecto estándar de Flutter.

1. Asegúrate de tener Flutter instalado y configurado.
2. Clona o descarga este repositorio.
3. Obtén las dependencias:
   ```bash
   flutter pub get
   ```
4. Ejecuta la aplicación en tu plataforma preferida (Web, iOS, Android, macOS, Windows, Linux):
   ```bash
   flutter run
   ```

## Tecnología

- **Framework:** Flutter
- **Lenguaje:** Dart
- **Diseño y Renderizado:** `Stack`, `AnimatedBuilder`, `Transform`, `CustomPaint`, `LinearGradient`

---

## Acerca de CouldAI

Esta aplicación fue generada con [CouldAI](https://could.ai), un creador de aplicaciones de IA para aplicaciones multiplataforma que convierte indicaciones en verdaderas aplicaciones nativas para iOS, Android, Web y Escritorio. Con agentes de IA autónomos que diseñan, construyen, prueban, implementan e iteran, CouldAI crea aplicaciones listas para producción sin problemas.