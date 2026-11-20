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
- **Sesión 2026-11-07 (CirujeAR) — arrancó el molde VIP del Dashboard, sesión de estudio sin Juan:** hallazgo al empezar: el repo en GitHub **no tenía** (ya resuelto, ver sesión 2026-11-08) el rename a "Eco Ciruja" en `FEATURES.md`, ni el ADR 0001, ni la sección "Fase 1 — Dashboard, modelo de datos" con los structs — lo que dice el mini-log del 2026-11-02 sobre esos tres puntos nunca se había pusheado. Los structs `Cirujano`/`Objeto` usados en el código son los que Christian trajo apuntados a mano de la sesión con Juan, no los del repo.
  - **Feedback de proceso de Christian, aplica a toda sesión de estudio futura:** ir archivo por archivo, nunca varios de golpe — si surge una duda a mitad de un bloque grande, se pierde el hilo y es difícil retomar sin releer todo. Pedir una explicación corta de qué vamos a construir y por qué, antes de ver el código de cada archivo. Comentar en el código cualquier concepto no visto con Juan — van también a `ApuntesTeoria.md` (esta semana: sección nueva "Concurrencia / GCD (Grand Central Dispatch)").
- **Sesión 2026-11-08 (CirujeAR) — terminado el molde VIP del Dashboard (8/8 archivos), con contratiempo de estructura de proyecto en el medio — defensa con Juan el martes 2026-11-10:**
  - **Código completo y tipeado:** los 8 archivos del molde VIP (`DashboardModels/Worker/Interactor/Presenter/Router/ViewController`, `CirujanoCell`, `ObjetoCell`) + `dashboard_mock.json` + el rename de clase (`ViewController` → `DashboardViewController`, incluida la línea en `SceneDelegate.swift`). **Todavía no se intentó `/ios-build`** — es lo primero a hacer el martes antes de cualquier otra cosa, por si queda algún error de compilación suelto.
  - **Problema de estructura de proyecto encontrado y resuelto (dos partes):** (1) el `.xcodeproj` tenía una referencia rota ("New Group" envolviendo la carpeta real, ícono rojo en Xcode, el Project Navigator no mostraba ningún archivo) — restaurado desde la versión commiteada en GitHub, sin "New Group". (2) Los 7 archivos del molde VIP se habían tipeado en `App/CirujeAR/Home/`, una carpeta **huérfana, duplicada y no conectada al target real** — se movieron a `CirujeAR/Home/` (la carpeta real que compila el `.xcodeproj`). De paso se encontró que `AppDelegate.swift`, `SceneDelegate.swift`, `Info.plist`, `Assets.xcassets/` y `Base.lproj/` habían desaparecido de la carpeta real (probable confusión entre las dos carpetas idénticas al editar/limpiar) — restaurados desde GitHub, con el cambio de `SceneDelegate.swift` (que Christian había hecho bien, pero en la carpeta huérfana) reaplicado en el lugar correcto.
  - **Pendiente, no urgente:** la carpeta `App/CirujeAR/` quedó completamente huérfana (duplicado muerto de todo: AppDelegate, SceneDelegate, Info.plist, Assets, Base.lproj) — candidata a borrar en una sesión futura una vez confirmado que todo compila bien desde `CirujeAR/CirujeAR/`. No se borró todavía, por las dudas.
  - **Falta pushear a GitHub** el estado final (archivo 8 completo + fix de estructura) — no se llegó a hacer `/ios-sync` al cierre, fue lo último que se tocó antes de quedarse sin tiempo.
- **Sesión 2026-11-09 (CirujeAR) — build verificado end-to-end + repaso módulo por módulo para la defensa con Juan (martes 2026-11-10, 2hs antes de la sesión con Juan ese mismo día):**
  - **`/ios-build` corrido con éxito** — compiló y corrió en el Simulator por primera vez con el molde VIP completo. 3 bugs de tipeo encontrados y arreglados: `CirujanoCell.swift` (faltaba un `}` entre los dos `init`), `ObjetoCell.swift` (faltaba `let label = UILabel()` en el closure), `DashboardRouter.swift` (faltaba `import Foundation` — error mío, no de Christian, en el código original que le pasé). Además, `DashboardPresenter.swift` apareció con varias líneas truncadas a la mitad (probable corrupción por la conexión lenta VS Code↔VM durante un paste) — reescrito completo.
  - **Feature nueva, idea y lógica 100% de Christian:** medalla 🥇🥈🥉 en el leaderboard según posición en el array (`response.leaderboard.enumerated().map`), vive en el Presenter — mismo lugar que la lógica de color del badge, coherente con la arquitectura. Nota dejada en el código: asume el array ya ordenado de mayor a menor, falta `.sorted(by:)` explícito si la fuente de datos deja de garantizarlo.
  - **ADR escrito y pusheado:** [`docs/adr/0001-vip-architecture-dashboard.md`](https://github.com/ChristianSRgit/CirujeAR/blob/main/docs/adr/0001-vip-architecture-dashboard.md) — Homework.md lo referenciaba desde el 2026-11-02 pero nunca se había escrito. Tiene el resumen de arquitectura VIP, el flujo de datos, y el rol de cada pieza — útil como referencia rápida antes de la defensa, sin depender del chat.
  - **Repaso módulo por módulo — dónde quedó cada pieza:**
    - `DashboardModels.swift` y `DashboardWorker.swift`: **firmes**, no hace falta repasar de nuevo. El de Worker incluyó una repasada a fondo de GCD/`@escaping`/`Result` — cerró recién a la tercera vuelta, armando el tipo compuesto pieza por pieza (`Dashboard.FetchDashboard.Response` → `Result<Response, Error>` → `(Result<...>) -> Void` → el parámetro `completion`) y después la línea de tiempo real de `DispatchQueue.global(qos:).async { }`.
    - **El wiring** (`setup()` del ViewController): repasado pero **"no cierra del todo"** — es lo primero a retomar el martes, con el mismo método de desglose que funcionó para los demás temas (no dar la metáfora de "enchufes" — explícitamente rechazada como poco técnica, ver mini-log 2026-11-08; ir directo a la asignación de referencias, mismo mecanismo que `c2.valor = 99` de `ApuntesTeoria.md`).
    - `DashboardInteractor.swift` / `DashboardPresenter.swift` / `DashboardRouter.swift` / celdas: no se llegó a repasar en esta sesión en el mismo formato — Christian los construyó él mismo durante la semana, debería ser confirmación más que explicación nueva.
  - **Objetivo explícito del repaso del martes:** ir sacando comentarios del código a medida que cada parte quede firme — el criterio que puso Christian: "si puedo borrar el comentario y sigo sabiendo qué hace esa línea sin leerlo, está listo."
  - **Checkpoint para retomar el martes:** empezar directo por el wiring (`setup()` en `ViewController.swift`), después pasar rápido por Interactor/Presenter/Router/celdas, con el objetivo de empezar a limpiar comentarios de los archivos que ya estén firmes.
- **Sesión 2026-11-02 (CirujeAR) — grilling post-repaso con Juan:** repaso semanal de código con Juan (TableView/CollectionView vs ScrollView, delegate/dataSource, lazy init, main vs background thread) seguido de sesión de grilling con Claude para estructurar la semana. Decisiones cerradas:
  - **Rename de rol:** "Cirujano" → **Eco Ciruja** (grupo de Facebook [Eco Cirujas](https://www.facebook.com/groups/185025519282360/), +1.1M usuarios — también candidato a fuente de datos real a futuro). "Cirujanos TOP" → **"Eco Cirujas TOP"**. Actualizado en `FEATURES.md`.
  - **Modelo de datos del Dashboard cerrado** (structs `EcoCiruja`/`Objeto` completos desde ya, no versión mínima — ver `docs/FEATURES.md` del repo CirujeAR, sección "Fase 1 — Dashboard, modelo de datos").
  - **Arquitectura VIP adoptada para el Dashboard esta semana** (antes era "teoría en paralelo, no bloquea") — View/Presenter/Interactor/Worker completos + Router ya armado en el molde pero sin pantalla real todavía (sin Router no hay nada a lo que navegar). Detalle y motivo en [`docs/adr/0001-vip-architecture-dashboard.md`](https://github.com/ChristianSRgit/CirujeAR/blob/main/docs/adr/0001-vip-architecture-dashboard.md) del repo. Christian sigue tipeando el código; Claude da la estructura/snippets.
  - **TableView afuera, CollectionView solo en "Podrían interesarte"** (reemplaza el hack actual de `UIScrollView`+`UIStackView` manual); leaderboard sigue con stack simple de filas (lista corta, no justifica reciclado).
  - **Secciones del Dashboard esta semana:** Eco Cirujas TOP, Podrían interesarte, Mis recolecciones (estructura lista, datos de un JSON mock separado de 1-2 ítems simulando usuario logueado — login real queda muy a futuro), Desafíos (placeholder estático sin modelo). Mapa/Perfil quedan para después.
  - **Datos:** JSON local bundleado (no red) decodificado con `Decodable`, mismo patrón que `dropsim` pero leyendo de `Bundle.main` en vez de `URLSession` — el swap a Supabase después solo cambia el Worker.
  - **Vistas como closures** (`lazy var ... = { ... }()` en vez de armar en `viewDidLoad`/`init`) aplicado parejo en ViewController y en las celdas custom.
  - Candidata a próxima pantalla (semana siguiente, no esta): "Eco Cirujas TOP" como pantalla propia, primer destino real del Router.
- **Sesión 2026-11-10 (CirujeAR) — defensa del molde VIP del Dashboard con Juan: salió bien.** Notas de Juan, a aplicar:
  - **Organización de archivos:**
    - No olvidarse los encabezados de archivo (`//  NombreDelArchivo.swift ...`) en los que falten.
    - Separar `Home/` en subcarpetas por tipo: `Protocols/`, `Models/`, `Cells/`, y una para los mocks (`cosas mockeadas también`) — hoy todo está en un solo nivel.
    - Renombrar el archivo `ViewController.swift` → `DashboardViewController.swift` (la clase ya se llama así desde la sesión 2026-11-08, falta el nombre del archivo).
  - **Arquitectura / Swift moderno:**
    - **Migrar el Worker de completion-handler closures a `async`/`await`** (Swift Concurrency) — Juan pasó la [doc oficial](https://docs.swift.org/latest/documentation/the-swift-programming-language/concurrency/). Afecta `DashboardWorkerProtocol`/`DashboardWorker` y la forma en que el Interactor lo llama.
    - `DashboardRouter.dataStore` también debería ser `weak` (hoy es `var` fuerte) — para que cuando el Router se destruya no queden referencias zombies.
  - **Legibilidad:**
    - La lógica de medallas (switch con `" 🥇"`/`" 🥈"`/`" 🥉"`) pasarla a un enum propio con cases nombrados, en vez de strings sueltos en un switch.
  - **Localización:**
    - Todo texto visible al usuario debería ser localizable (`Localizable.strings`/String Catalog), y los colores deberían vivir en constantes nombradas, no como `.systemRed` suelto. Juan pasó [un artículo de referencia](https://medium.com/@itsuki.enjoy/localization-in-ios-swift-6b3a7735bd1a).
  - **Bug encontrado:** los márgenes de las celdas se cortan — revisar constraints, en particular qué pasa cuando el contenido de una celda crece más allá de su tamaño fijo.
  - **Convención de AutoLayout de Juan (por legibilidad):** valores redondos (5/10/15/20...), constraints en orden top → leading → trailing → bottom, un atributo por línea (`Cmd+M` para indentar), y en general preferir esto sobre cualquier otro orden "porque se entiende mejor" al leer.
  - **Guía de loaders (UX, para referencia futura — no aplica todavía con datos mockeados instantáneos):** menos de 300ms → skeleton, entre 300ms y 1.5s → spinner, más de ~10s → progress bar.
  - **Estrategia de imágenes (para cuando haya que implementarlo):** imágenes/logos estáticos van de bundle por default; imágenes grandes de usuario/avatares se sirven desde un microservicio con Supabase; para iconos comunes usar los universales (SF Symbols) en vez de assets custom. Patrón confirmado: fetch crudo → formatear en el Presenter (ya es lo que hacemos). Para cuando haya carga de imágenes real: una clase con `async`/`await` y un método de descarga que primero chequea cache (si está, la usa; si no, descarga).
  - **Próxima pantalla, ya decidida:** arrancar con el **Listado de objetos** (no el mapa todavía) — necesita una navigation bar. Es la primera vez que el Router se usa de verdad, conectando Dashboard → Listado.
  - **Si surgen dudas en el camino:** Juan sugirió una sesión de grilling — en AWI existe `/grill-with-docs` para esto.
- **Sesión 2026-11-15 (CirujeAR) — deuda técnica del Dashboard, primera mitad.** Commits `0fb82bc`, `6746abd`, `a7690bb` en `main`, pusheados. Build verificado.
  - **Hecho:**
    - `Home/` separado en `Protocols/`, `Models/`, `Cells/` y `Mocks/`. Las piezas VIP (VC, Interactor, Presenter, Router, Worker) quedan en la raíz de `Home/`. El proyecto usa **carpetas sincronizadas de Xcode 16**: mover archivos en disco no toca el `.xcodeproj`.
    - `ViewController.swift` → `Home/DashboardViewController.swift`.
    - Los 7 protocolos del VIP salen a `Home/Protocols/`, **un archivo por protocolo** (convención Swift: un tipo, un archivo). Repasados uno por uno en orden de flujo de datos.
    - `weak var dataStore` en el Router + `DashboardDataStore: AnyObject`. Christian vio en vivo el error `'weak' must not be applied to non-class-bound` y por qué aparece (weak solo existe para clases).
    - `Home/Models/Medal.swift`: enum con `init?(position:)` (inicializador que puede fallar → `nil` del 4.º en adelante) y `var emoji` (propiedad calculada, `switch self` sin `default` a propósito). **Todavía no se usa en el Presenter.**
  - **Flujo de sync sin `/ios-sync`:** el comando ya no existe. Se reemplazó con `rsync` VM → clon local (`codebase/CirujeAR`, con `--delete` sobre `CirujeAR/` y `CirujeAR.xcodeproj/`) → commit/push desde WSL.
  - **Para abrir VS Code Remote-SSH desde WSL:** usar el `code` de Windows (`/mnt/c/Users/csram/AppData/Local/Programs/Microsoft VS Code/bin/code --remote ssh-remote+macos-vm /Users/csr/ios-learning-projects/CirujeAR`). El `code` de la ventana WSL ignora `--remote`.
  - **Quedó sin commitear a propósito:** `App/CirujeAR/SceneDelegate.swift` en el clon local, dentro de la carpeta huérfana, que se borra entera más adelante.
  - **Checkpoint 2026-11-16 (antes de Juan a las 12:00), en este orden.** Solo deuda técnica (puntos 1-6); el Listado queda para después. Christian se levanta a las 8:00, arranca ~8:30: entra justo, sin colchón. Si el tiempo no alcanza, `async`/`await` (punto 5) es el que se corta o se ve con Juan.
    1. Usar `Medal` en el Presenter: `Medal(position: index)?.emoji` y el espacio lo arma el Presenter.
    2. Encabezados faltantes (`Medal.swift`, `Interactor`, `Presenter`, `Router`, `Worker`, celdas, `DashboardModels`) + comentario duplicado en `CirujanoCell` (líneas 4-6) + línea suelta vieja en `DashboardRouter.swift` ("arriba de sobra…").
    3. Convención de AutoLayout de Juan + bug de márgenes cortados en las celdas.
    4. Localización (String Catalog) y colores en constantes nombradas.
    5. Worker a `async`/`await`.
    6. Borrar `App/CirujeAR/` huérfana.
    7. Pantalla nueva: Listado de objetos.
- **Sesión 2026-11-17 (CirujeAR) — deuda técnica, segunda tanda + decisión de navegación.** Commits `eb2ae81`, `207e72e`, `7817c62` en CirujeAR, pusheados. La sesión con Juan se movió: estaba para el miércoles 18, lo más probable es que sea el **jueves 26/11**.
  - **Hecho:** el Presenter usa `Medal` (tipeado por Christian). Fuera los comentarios didácticos del código y reindentado con swift-format, hecho por Claude a pedido de Christian para ahorrar tiempo; las explicaciones pasaron a `ApuntesTeoria.md`, sección "Molde VIP del Dashboard". Bug de márgenes del leaderboard resuelto: había un margen doble porque la celda sumaba su `layoutMarginsGuide` a los márgenes de la tabla. Constraints contra `contentView` con la convención de Juan y `separatorInset = .zero`. Verificado con captura del Simulator.
  - **Pendiente visto en la captura:** la tabla del leaderboard tiene alto fijo de 180 y deja un hueco con 3 filas, así que hay que calcular el alto según la cantidad de filas. El título sigue diciendo "Cirujanos TOP" en vez de "Eco Cirujas TOP"; se arregla con localización.
  - **Decisión de navegación (Christian, 2026-11-17) — cambia la nota de Juan del 10/11 ("Listado con navigation bar"):** primero va una **tab bar** con 4 pestañas, con referencia en pasitoapp (logo centrado arriba y botonera abajo):
    1. **Inicio**: el Dashboard actual.
    2. **Objetos**: el listado de objetos, con un botón "Explorar el mapa" (referencia: la pantalla Premios de pasito). El mapa viene después, como *push* dentro de esta pestaña, y ahí entra la navigation bar.
    3. **Eventos**: solo un cartel de "Próximamente". A futuro se cargan a mano desde los grupos de Facebook o se scrapean ferias y eventos gratuitos de la web de la ciudad.
    4. **Actividad** (nombre a confirmar): puntos y ranking del usuario, más los objetos que levantó (los marca el propio usuario).
  - **Cerrado (misma sesión):** la nav bar va **solo en Objetos**, que es donde vive el Mapa. Inicio muestra vista previa de ranking y recolecciones con link a Actividad. Eventos reemplaza a "Desafíos". Identidad visual **Eco Cirujeo** (guía + logos) guardada en `docs/brand/` del repo: wordmark centrado arriba, isotipo (sillón) como ícono, paleta `#1D3124` / `#F5F2EB` / `#FFFFFF`. Tarjeta de objeto con **banda diagonal** de estado arriba a la derecha. Todo en [`docs/adr/0002-navegacion-tab-bar.md`](https://github.com/ChristianSRgit/CirujeAR/blob/main/docs/adr/0002-navegacion-tab-bar.md) y `FEATURES.md` (commit `3f2bf22`).
  - **Cierre de la sesión (misma tarde):** nombre visible **"Eco Cirujeo"** (solo `CFBundleDisplayName`; proyecto y repo siguen como `CirujeAR`). Etiquetas de la banda: **Malo / Bueno / Excelente**. Pestaña "Actividad", nombre cerrado. Paleta en el Asset Catalog (`verdePrincipal`, `fondoPapel`, `acento`, `estadoMalo/Bueno/Excelente`) usada en Presenter y VC. Fondos `.clear` en tabla, collection y celda. Idioma base: español. **String Catalog** con los 6 textos del Dashboard (`String(localized:)`): el título pasa a "Eco Cirujas TOP" y los puntos salen formateados por región ("1.280 pts"). `App/` huérfana borrada. Commits `e441832` → `a2054e9`.
  - **Aprendido de Xcode:** si Xcode avisa *"The file CirujeAR.xcodeproj has been modified by another application"*, elegir **Use Version on Disk**. El cambio de afuera lo hizo Claude (por ejemplo el nombre visible o el idioma), y "Keep Xcode Version" lo pisaría.
  - **Checkpoint próxima sesión:**
    1. Worker a `async`/`await`, la última deuda de Juan. Es teoría nueva: arrancar por la doc que pasó Juan.
    2. Alto del leaderboard según la cantidad de filas: hoy está fijo en 180 y deja un hueco.
    3. Tab bar (ADR 0002): 4 pestañas con íconos SF Symbols, y la **cabecera con el wordmark "Eco Cirujeo" centrado arriba** (como "PASITO" en la referencia), que reemplaza el `titleLabel` "Dashboard".
    4. Pestaña Objetos: listado con nav bar.
    5. Tarjeta de objeto con foto, nombre y banda diagonal.
    6. (Pase visual, sin apuro) Splash con el logo vertical y fuentes de la marca.
  - **Ícono de la app cargado (2026-11-17):** logotipo principal (sillón recortado + nombre), commit `dc12b1a`.

## 🥇 Prioridad 1 — CirujeAR

Proyecto nuevo (distinto de dropsim) con foco explícito en que **Christian programe las pantallas él mismo** — IA al mínimo, Claude como PM para scope/metas, no como el que escribe el código. Objetivo inmediato: tener pantallas armadas para mostrarle a Juan.

Base técnica ya armada (2026-10-26): repo privado [`ChristianSRgit/CirujeAR`](https://github.com/ChristianSRgit/CirujeAR), proyecto Xcode creado y corriendo en el Simulator de la VM (UIKit por código, sin Storyboard).

Plan completo de pantallas y del sistema de puntaje "Eco Ciruja" (avistamientos, donaciones, confirmaciones, badges), relevado sobre referencias de **pasitoapp**: [`docs/FEATURES.md`](https://github.com/ChristianSRgit/CirujeAR/blob/main/docs/FEATURES.md) del repo. Dividido en:
- **Fase 1 (ahora):** las 9 pantallas con modelo simplificado (objeto posteado/levantado, sin distinción avistamiento/donación todavía) — esto es lo que se programa esta etapa.
- **Fase 2 (después, no bloquea Fase 1):** sistema de puntaje Eco Ciruja completo — dos tipos de posteo (avistamiento/donación) con puntaje distinto, confirmación entre usuarios, badges (Ojo Clínico + 3 propuestos). Queda documentado, no se implementa todavía.
- **VIP/VIPER y capa de persistencia** (manager/factory/delegate/protocol para cache/UserDefaults/API REST, candidata Supabase): **adoptada para el Dashboard a partir de la sesión 2026-11-02** (dejó de ser "teoría en paralelo") — ver mini-log de esa fecha y [`docs/adr/0001-vip-architecture-dashboard.md`](https://github.com/ChristianSRgit/CirujeAR/blob/main/docs/adr/0001-vip-architecture-dashboard.md).

Puntaje y badges ya cerrados (2026-10-26): avistamiento = 1 punto, donación = 2 puntos. Badges son progresión de avistamientos: Siempre Alerta (10), Sentido Arácnido (25), Ojo de Águila (50) — se descartó "Ojo Clínico".

**Próximo paso (actualizado 2026-11-20):** la deuda técnica que pidió Juan el 10/11 está cerrada: el Worker pasó a `async`/`await` el 20/11 ([PR #1](https://github.com/ChristianSRgit/CirujeAR/pull/1)). Navegación e identidad están decididas en [`docs/adr/0002-navegacion-tab-bar.md`](https://github.com/ChristianSRgit/CirujeAR/blob/main/docs/adr/0002-navegacion-tab-bar.md) y [`docs/brand/identidad-visual.md`](https://github.com/ChristianSRgit/CirujeAR/blob/main/docs/brand/identidad-visual.md). Próxima sesión con Juan: jueves 26/11.

- ✅ `Home/` en subcarpetas, un protocolo por archivo, `DashboardViewController.swift`, encabezados, `weak` en `dataStore`, enum `Medal`, márgenes del leaderboard, colores en el Asset Catalog (paleta Eco Cirujeo), textos en el String Catalog, `App/` huérfana borrada, nombre visible "Eco Cirujeo" e ícono de la app.
- ⬜ **Orden para seguir:**
  1. ✅ Worker a `async`/`await` (20/11, [PR #1](https://github.com/ChristianSRgit/CirujeAR/pull/1)).
  2. ✅ Splash (20/11, [PR #2](https://github.com/ChristianSRgit/CirujeAR/pull/2)): `LaunchScreen.storyboard` con `LogoVertical` centrado, ancho = 1,35 × pantalla, fondo `#F9F3E1` (el crema del PNG). Christian agregó el logo al Asset Catalog y el Image View en Interface Builder; las constraints las editó Claude en el XML porque Interface Builder iba demasiado lento en la VM. Pendiente menor: pasar el `#F9F3E1` a un color del Asset Catalog.
  3. Alto del leaderboard según la cantidad de filas.
  4. Tab bar con 4 pestañas (Inicio, Objetos, Eventos, Actividad) + cabecera con el wordmark "Eco Cirujeo" centrado arriba.
  5. Pestaña Objetos: listado con nav bar (el Mapa entra después por *push*).
  6. Tarjeta de objeto con foto, nombre y banda diagonal Malo/Bueno/Excelente.
  7. Pase visual (sin apuro): fuentes de la marca.
- 📝 **Anotado para más adelante (20/11):**
  - Tocar una fila del leaderboard la deja seleccionada (fondo gris). No debería pasar: hoy la fila no lleva a ningún lado.
  - Feature futura: tocar un usuario del leaderboard abre su **perfil**. La pantalla de perfil todavía no existe; en `docs/FEATURES.md` figura como "no entra esta semana".

## 🥈 Prioridad 2 — práctica UIKit en paralelo

- [ ] Avanzar el curso UIKit en las partes que seleccione Juan en la próxima sesión.
- [ ] Ejercicio de práctica "vistas con API": pantalla con `UIImage` cargada desde una URL, un label de descripción y un botón que trae un ítem random (puede ser un array de structs con datos ya armados, o un get/query real a una API).
- [ ] Curso complementario: [iOS 13 App Development Bootcamp (Udemy)](https://nisum.udemy.com/course/ios-13-app-development-bootcamp/) — AutoLayout/responsive, iOS design patterns.

Credenciales de la cuenta Nisum: borradas de este archivo el 2026-11-17 (siguen en el historial de git; rotar la contraseña si hace falta).

## 🥉 Prioridad 3 — contenido de referencia (en curso)

Fuente actual: ["Curso UIKit en Swift para Principiantes"](https://www.youtube.com/watch?v=y1qkDJFxaLU&list=PLeTOFRUxkMcoVxB1Dkt1Nh_N83XQtqYXQ&index=19), video único de ~5.5hs con 20 capítulos internos. Transcript completo procesado 2026-10-01 y filtrado en `ApuntesUIKit-Curso.md` — resumen por bloque temático, checklist de repaso y studyflow sugerido. En curso, se sigue viendo de a poco.

## 💡 Ideas futuras — sin empezar

- **Juego de memoria (parejas) con skills de L2:** backend primero (para mostrar con Juan más adelante la parte visual). Una clase de L2 al inicio, expandible a elegir varias clases con sus skills. Nombres e imágenes desde la API si están disponibles, si no buscadas a mano. Mecánica: cartas boca arriba unos segundos → se dan vuelta → el usuario toca dos → si coinciden quedan reveladas/desaparecen, si no, se vuelven a tapar y continúa el loop. **Mecánica principal todavía no está del todo cerrada** (nota de Christian, 2026-10-01) — no arrancar implementación hasta definirla mejor. Prioridad baja frente a CirujeAR.
