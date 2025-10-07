# PokeAPI App
## 👾 ¿Qué hace la App?
La app desarrollada en SwitfUI muestra información real de Pokémon obtenida desde una API pública (Poke API).
El usuario puede ver una lista de 10 pokémones aleatorios, consultar sus detalles, agregarlos a favoritos y organizarlos en equipos personalizados de hasta seis pokémones.

## 🚀 Funcionalidades principales
- 🔄 Lista aleatoria: muestra 10 Pokémon aleatorios de la PokéAPI.
- 🔍 Vista detallada: muestra el nombre, tipo, peso, altura y estadísticas del Pokémon (HP, Attack, Defense, Speed).
- ⭐ Favoritos: permite agregar o quitar Pokémon de la lista de favoritos
- 🧠 Equipos: el usuario puede crear equipos con nombre y color personalizados, y agregar Pokémon a ellos.
- 🎨 Diseño visual: interfaz limpia con gradientes de color según el tipo de Pokémon.
- ⚙️ Arquitectura MVVM: separación clara entre lógica de datos (ViewModel) y vistas (SwiftUI Views).
- ❌ Manejo robusto de errores: muestra mensajes amigables si ocurre un error de red o si no hay conexión.

## 🛜 API Utilizada
**PokéAPI** – API pública gratuita con información detallada de Pokémon.  
🔗 [https://pokeapi.co/api/v2/pokemon/](https://pokeapi.co/api/v2/pokemon/)

**Ejemplo de endpoint usado:**
https://pokeapi.co/api/v2/pokemon/{id}
> Donde `{id}` representa el número del Pokémon (por ejemplo, `1` para Bulbasaur).

---

## 🛠️ Tecnologías y librerías

- **SwiftUI**
- **Combine**
- **Async/Await (URLSession)**
- **Arquitectura MVVM**
- **Xcode 26.0.1+**
- **iOS 17 Target**

---

## 📱 Cómo ejecutar la app

### 🧩 Requisitos previos
- macOS Tahoe 26 o posterior  
- Xcode **26.0.1 o superior**  
- iOS **17.0 o superior** (simulador o dispositivo físico)

### ⚙️ Pasos para ejecutar

1. **Clona el repositorio**
   ```bash
   git clone https://github.com/tuusuario/PokedexApp.git
   ```
2. **Abre el proyecto en Xcode**
    ```bash
    cd PokedexApp
    open PokedexApp.xcodeproj
    ```
3. **Selecciona un simulador de iPhone (por ejemplo, iPhone 17)**
4. **Ejecuta la app presionando el botón de play o usando *Cmd + R***

## 📄 Créditos
API: [Poke API](https://pokeapi.co)
Aplicación desarrollada por: Sergio Rodríguez Pérez
