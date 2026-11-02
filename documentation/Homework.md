# Homework — próxima sesión

## 📚 Mini log de proyectos/temas vistos

- **dropsim** (cliente API L2, Swift): funcional — 4/4 milestones. PR #4 mergeado a `release/v0.1` (2026-09-27), cumplido antes del deadline del 2026-09-28. PR #5 mergeado (2026-09-30): `LocalConstants.swift`/`utils.swift` + limpieza de código muerto.
- **dropsim — pendientes migrados a GitHub issues (2026-10-26):** plan de branches ([#7](https://github.com/ChristianSRgit/dropsim/issues/7)), refactor SRP de `main.swift` ([#6](https://github.com/ChristianSRgit/dropsim/issues/6)) e idea de cara visual para portfolio ([#8](https://github.com/ChristianSRgit/dropsim/issues/8)) viven ahora en el repo. Dropsim sale de Homework — queda como proyecto a retomar a futuro, prioridad baja (necesita bastante trabajo y su utilidad como producto es acotada frente a CirujeAR).
- **VM local (hackingtosh) operativa (validado 2026-10-24):** pipeline de build/run end-to-end por SSH (`/ios-code` + `/ios-build`) probado contra un proyecto real (`prueba`). Reemplaza la necesidad de un Mac en la nube — esa decisión queda cerrada, no se retoma salvo que la VM deje de ser viable.
- **Git:** branch alignment practicado (PR #3, fast-forward limpio), `CheatsheetGit.md` creado.
- **CRUD.swift** (gastos-consola): refactor analizado (notas ya no vigentes, eliminadas 2026-09-29).
- **Notion sync:** skill armada 2026-09-28 (Homework local como fuente de verdad → Notion, con bump de fecha en Inicio).
- **100 Days of Swift:** deprioritizado (2026-09-29) — el foco pasó a vistas (UIKit) y ahora a CirujeAR.
- **Limpieza de documentación (2026-09-29):** eliminado `refactor-notes-CRUD-2026-09-06.md` y un archivo basura `dropsim-plan.md:Zone.Identifier`. `CONTEXT.md` actualizado. Notas de teoría de videos van en `ApuntesTeoria.md`.
- **Placeholder de `chance` nulo (dropsim):** descartado (2026-09-29), no se implementa.
- **Convención de mensajes de commit:** no hace falta definirla. Nota informal: Juan suele hacer squash merge por PR — gusto personal suyo, práctica sugerida, no obligatoria.
- **Teoría — vistas UIKit (ciclo de vida y composición):** explicada 2026-09-29 — ver `ApuntesTeoria.md`.
- **Teoría de la sesión 2026-10-01:** value vs reference types, semver, resolución de conflictos de git — notas en `ApuntesTeoria.md`.
- **Fuente de videos UIKit:** playlist estructurada (ver "Videos — en curso" abajo), video actual (#19) es largo (~5hs), se digiere en varias sesiones.
- **Proyecto "ciruja" renombrado a CirujeAR (2026-10-26):** a diferencia de dropsim, pensado para usuarios reales con mira a lanzamiento en App Store a futuro. Suma referencias de diseño de **pasitoapp** (app validada en el mercado argentino, estilo minimalista) — Christian va a pasar link/capturas.
- **Notion sync (2026-10-26):** Homework.md local actualizado y propagado a la página Homework de Notion.
- **Sesión 2026-10-29 (CirujeAR):** quitado el Storyboard default de Xcode — `SceneDelegate` arma la ventana por código, `ViewController` es el punto de entrada real. Notas en `docs/app-lifecycle.md` del repo (no estaban commiteadas, se subieron recién hoy 2026-11-01 junto con el resto).
- **Sesión 2026-10-31 (CirujeAR):** primera pasada de la pantalla Dashboard — título, secciones "Cirujanos TOP"/"Podrían interesarte" (solo labels), `cardsStack` horizontal con 3 tarjetas placeholder sin scroll todavía. Vocabulario UIKit nuevo de esa sesión en `documentation/screens_cheatsheet.md`.
- **Sesión 2026-11-01 (CirujeAR):** `UIScrollView` aplicado al `cardsStack` de "Podrían interesarte" (ahora 8 tarjetas, scroll horizontal, indicador oculto) — teoría en `ApuntesTeoria.md` (sección nueva) y resumen de sesión en `screens_cheatsheet.md`. Dos bugs de runtime debugueados en vivo (no los agarra el compilador): vista colgada de un padre desconectado de la jerarquía, y crash de AutoLayout por falta de ancestro común — ver detalle en `ApuntesTeoria.md`. Christian aprendió el flujo de build manual desde Xcode GUI en la VM (elegir dispositivo + ▶️/`Cmd+R`) como plan B sin SSH. Decisión de scope: "Cirujanos TOP" lleva datos hardcodeados por ahora (`topCirujanos: [(name, points)]`, sin modelo real todavía — eso es Fase 2). Referencia de paleta de colores neo-brutalista guardada en `docs/public/paleta-neo-brutalismo.jpg` del repo CirujeAR (todavía no aplicada a las pantallas). Todo sincronizado VM → repo → push con `/ios-sync` al cierre de la sesión.
- **Sesión 2026-11-02 (CirujeAR) — grilling post-repaso con Juan:** repaso semanal de código con Juan (TableView/CollectionView vs ScrollView, delegate/dataSource, lazy init, main vs background thread) seguido de sesión de grilling con Claude para estructurar la semana. Decisiones cerradas:
  - **Rename de rol:** "Cirujano" → **Eco Ciruja** (grupo de Facebook [Eco Cirujas](https://www.facebook.com/groups/185025519282360/), +1.1M usuarios — también candidato a fuente de datos real a futuro). "Cirujanos TOP" → **"Eco Cirujas TOP"**. Actualizado en `FEATURES.md`.
  - **Modelo de datos del Dashboard cerrado** (structs `EcoCiruja`/`Objeto` completos desde ya, no versión mínima — ver `docs/FEATURES.md` del repo CirujeAR, sección "Fase 1 — Dashboard, modelo de datos").
  - **Arquitectura VIP adoptada para el Dashboard esta semana** (antes era "teoría en paralelo, no bloquea") — View/Presenter/Interactor/Worker completos + Router ya armado en el molde pero sin pantalla real todavía (sin Router no hay nada a lo que navegar). Detalle y motivo en [`docs/adr/0001-vip-architecture-dashboard.md`](https://github.com/ChristianSRgit/CirujeAR/blob/main/docs/adr/0001-vip-architecture-dashboard.md) del repo. Christian sigue tipeando el código; Claude da la estructura/snippets.
  - **TableView afuera, CollectionView solo en "Podrían interesarte"** (reemplaza el hack actual de `UIScrollView`+`UIStackView` manual); leaderboard sigue con stack simple de filas (lista corta, no justifica reciclado).
  - **Secciones del Dashboard esta semana:** Eco Cirujas TOP, Podrían interesarte, Mis recolecciones (estructura lista, datos de un JSON mock separado de 1-2 ítems simulando usuario logueado — login real queda muy a futuro), Desafíos (placeholder estático sin modelo). Mapa/Perfil quedan para después.
  - **Datos:** JSON local bundleado (no red) decodificado con `Decodable`, mismo patrón que `dropsim` pero leyendo de `Bundle.main` en vez de `URLSession` — el swap a Supabase después solo cambia el Worker.
  - **Vistas como closures** (`lazy var ... = { ... }()` en vez de armar en `viewDidLoad`/`init`) aplicado parejo en ViewController y en las celdas custom.
  - Candidata a próxima pantalla (semana siguiente, no esta): "Eco Cirujas TOP" como pantalla propia, primer destino real del Router.

## 🥇 Prioridad 1 — CirujeAR

Proyecto nuevo (distinto de dropsim) con foco explícito en que **Christian programe las pantallas él mismo** — IA al mínimo, Claude como PM para scope/metas, no como el que escribe el código. Objetivo inmediato: tener pantallas armadas para mostrarle a Juan.

Base técnica ya armada (2026-10-26): repo privado [`ChristianSRgit/CirujeAR`](https://github.com/ChristianSRgit/CirujeAR), proyecto Xcode creado y corriendo en el Simulator de la VM (UIKit por código, sin Storyboard).

Plan completo de pantallas y del sistema de puntaje "Eco Ciruja" (avistamientos, donaciones, confirmaciones, badges), relevado sobre referencias de **pasitoapp**: [`docs/FEATURES.md`](https://github.com/ChristianSRgit/CirujeAR/blob/main/docs/FEATURES.md) del repo. Dividido en:
- **Fase 1 (ahora):** las 9 pantallas con modelo simplificado (objeto posteado/levantado, sin distinción avistamiento/donación todavía) — esto es lo que se programa esta etapa.
- **Fase 2 (después, no bloquea Fase 1):** sistema de puntaje Eco Ciruja completo — dos tipos de posteo (avistamiento/donación) con puntaje distinto, confirmación entre usuarios, badges (Ojo Clínico + 3 propuestos). Queda documentado, no se implementa todavía.
- **VIP/VIPER y capa de persistencia** (manager/factory/delegate/protocol para cache/UserDefaults/API REST, candidata Supabase): **adoptada para el Dashboard a partir de la sesión 2026-11-02** (dejó de ser "teoría en paralelo") — ver mini-log de esa fecha y [`docs/adr/0001-vip-architecture-dashboard.md`](https://github.com/ChristianSRgit/CirujeAR/blob/main/docs/adr/0001-vip-architecture-dashboard.md).

Puntaje y badges ya cerrados (2026-10-26): avistamiento = 1 punto, donación = 2 puntos. Badges son progresión de avistamientos: Siempre Alerta (10), Sentido Arácnido (25), Ojo de Águila (50) — se descartó "Ojo Clínico".

**Próximo paso (arranca la próxima sesión, antes del repaso con Juan):** armar el molde VIP del Dashboard (View/Presenter/Interactor/Worker + Router vacío) y migrar las secciones a `UITableView`/`UICollectionView` con los structs `EcoCiruja`/`Objeto` cerrados el 2026-11-02 (detalle completo en el mini-log de esa fecha y en `docs/FEATURES.md` del repo).

## 🥈 Prioridad 2 — práctica UIKit en paralelo

- [ ] Avanzar el curso UIKit en las partes que seleccione Juan en la próxima sesión.
- [ ] Ejercicio de práctica "vistas con API": pantalla con `UIImage` cargada desde una URL, un label de descripción y un botón que trae un ítem random (puede ser un array de structs con datos ya armados, o un get/query real a una API).
- [ ] Curso complementario: [iOS 13 App Development Bootcamp (Udemy)](https://nisum.udemy.com/course/ios-13-app-development-bootcamp/) — AutoLayout/responsive, iOS design patterns.

Credenciales de la cuenta Nisum para loguear el curso — **no subir a ningún lado** (tampoco a Notion), borrarlas de aquí después de loguear el perfil de Chrome:
```
nisum.udemy.com
jramundo@nisum.com
UdemyNisum21!
```

## 🥉 Prioridad 3 — contenido de referencia (en curso)

Fuente actual: ["Curso UIKit en Swift para Principiantes"](https://www.youtube.com/watch?v=y1qkDJFxaLU&list=PLeTOFRUxkMcoVxB1Dkt1Nh_N83XQtqYXQ&index=19), video único de ~5.5hs con 20 capítulos internos. Transcript completo procesado 2026-10-01 y filtrado en `ApuntesUIKit-Curso.md` — resumen por bloque temático, checklist de repaso y studyflow sugerido. En curso, se sigue viendo de a poco.

## 💡 Ideas futuras — sin empezar

- **Juego de memoria (parejas) con skills de L2:** backend primero (para mostrar con Juan más adelante la parte visual). Una clase de L2 al inicio, expandible a elegir varias clases con sus skills. Nombres e imágenes desde la API si están disponibles, si no buscadas a mano. Mecánica: cartas boca arriba unos segundos → se dan vuelta → el usuario toca dos → si coinciden quedan reveladas/desaparecen, si no, se vuelven a tapar y continúa el loop. **Mecánica principal todavía no está del todo cerrada** (nota de Christian, 2026-10-01) — no arrancar implementación hasta definirla mejor. Prioridad baja frente a CirujeAR.
