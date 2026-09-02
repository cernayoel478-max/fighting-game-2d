# Fighting Game 2D - Godot

Un juego de peleas en 2D tipo **Brawlhalla** con mecánicas inspiradas en **Mortal Kombat**.

## Características Planeadas

- ✅ Sistema de combate básico
- ✅ Múltiples personajes
- ✅ Sistema de combos
- ✅ Ataques especiales
- ✅ Fatalities inspiradas en Mortal Kombat
- ✅ Modos de juego (1v1, Arcade, Versus)
- ✅ Sistema de progresión

## Estructura del Proyecto

```
fighting-game-2d/
├── scenes/              # Escenas del juego
│   ├── main_menu.tscn
│   ├── battle_arena.tscn
│   └── characters/
├── scripts/             # Scripts GDScript
│   ├── character.gd     # Script base del personaje
│   ├── main_menu.gd
│   └── battle_arena.gd
├── assets/              # Sprites, sonidos, fuentes
│   ├── sprites/
│   ├── sounds/
│   └── music/
└── project.godot        # Configuración del proyecto
```

## Requisitos

- Godot Engine 4.2+

## Cómo Ejecutar

1. Abre el proyecto en Godot Engine
2. Presiona `F5` o Click en "Play" para ejecutar
3. La escena principal es `main_menu.tscn`

## Controles

| Acción | Tecla |
|--------|-------|
| Mover Izquierda | A / Flecha Izquierda |
| Mover Derecha | D / Flecha Derecha |
| Saltar | W / Espacio |
| Atacar | Q / Botón 1 del Ratón |
| Ataque Especial | E / Botón 2 del Ratón |

## Próximos Pasos

- [ ] Crear spritesheet de personajes
- [ ] Implementar animaciones
- [ ] Agregar efectos de sonido
- [ ] Sistema completo de combos
- [ ] Fatalities
- [ ] IA para modo single player

## Contribuidores

- cernayoel478-max

## Licencia

MIT
