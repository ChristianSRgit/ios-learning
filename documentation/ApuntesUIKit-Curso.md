# UIKit — Curso completo (playlist, video #19)

Notas filtradas del video "Curso UIKit en Swift para Principiantes" (~5.5hs, 20 capítulos internos — NO son 20 videos separados, es un único video largo). Se excluye lo ya cubierto en sesiones previas: AutoLayout básico por código (anchors, `translatesAutoresizingMaskIntoConstraints`, `safeAreaLayoutGuide`), value vs reference types, ciclo de vida básico de `UIView` (ver `ApuntesTeoria.md`).

> Corrección a `Homework.md` (2026-09-30): se había asumido que el video de AutoLayout era el 3° de una serie de videos separados. Con el transcript completo confirmado: es un único video de 20 capítulos internos, y AutoLayout es el capítulo 2 de ese mismo video.

---

## A — Vistas básicas (Cap 3, 4, 5)

- `UIButton.Configuration` (iOS 15+) reemplaza la configuración manual: `.filled()`, `.plain()`, `.tinted()`. Propiedades: `.title`, `.subtitle`, `.image`, `.imagePadding`, `.imagePlacement`, `.buttonSize`, `.baseBackgroundColor`, `.baseForegroundColor`.
- Acción moderna sin selector: `UIButton(primaryAction: UIAction { _ in ... })` — si el closure usa `self`, la propiedad debe ser `lazy var` (si no, error "uso de self antes de inicializar").
- `UILabel.numberOfLines = 0` + constraints leading/trailing → multilínea real (si no, trunca con "...").
- `UILabel.attributedText` con `NSAttributedString(string:attributes:)` para texto enriquecido (subrayado, color, fondo, fuente combinados — no disponibles como propiedades sueltas).
- `UIImageView.contentMode = .scaleAspectFit` evita distorsión al forzar un tamaño distinto al nativo.
- `.tintColor` tiñe SF Symbols. Imagen circular con borde: `layer.cornerRadius` + `layer.borderWidth` + `layer.borderColor` (requiere `.cgColor`).

*Solo práctica (sin nota): arrastrar vistas, inspector de atributos, probar configs visualmente.*

## B — Listas y colecciones (Cap 6, 7, 8, 12)

- `UITableViewDataSource` obligatorios: `numberOfRowsInSection`, `cellForRowAt`. `UITableViewDelegate` opcional (`didSelectRowAt`, headers, tamaño).
- Hay que **registrar la celda** (`register(_:forCellReuseIdentifier:)`) antes de `dequeueReusableCell` — si no, crash.
- `dequeueReusableCell` reutiliza celdas fuera de pantalla → memoria eficiente con miles de elementos.
- Patrón recomendado: sacar datasource/delegate del ViewController a clases propias.
- `UIStackView`: apila subvistas sin crear constraints individuales. `axis`, `spacing`, `alignment`, `distribution`. Se agregan vía `arrangedSubviews`, no `addSubview`.
- `UICollectionView` requiere `UICollectionViewLayout` (típicamente `UICollectionViewFlowLayout`) al inicializar, si no crashea. `itemSize`, `scrollDirection`, `minimumLineSpacing`, `minimumInteritemSpacing`.
- Alternativa moderna: `UICollectionViewDiffableDataSource<SectionID, ItemID>` (tipos `Hashable`) + `UICollectionViewCompositionalLayout` + `NSDiffableDataSourceSnapshot` (`appendSections`/`appendItems` + `apply(snapshot, animatingDifferences: true)`) — evita `reloadData()` manual, anima solo.

*Solo práctica: crear proyecto, nombrar celdas custom, drag & drop.*

## C — Navegación (Cap 9, 10, 11)

- `present`/`dismiss` (modal) vs `UINavigationController.pushViewController`/`popViewController` (stack, back button gratis).
- `navigationItem.rightBarButtonItem` / `leftBarButtonItem` con `target`/`action`.
- Mantener pulsado el back button → salta a cualquier VC intermedio del stack.
- `UISheetPresentationController` (iOS 15+): `.detents = [.medium(), .large()]`, `.prefersGrabberVisible`, `.preferredCornerRadius` — bottom sheet nativo, se presenta con `present` normal.
- Push y modal son combinables entre sí.

*Solo práctica: crear VCs de ejemplo, nombrar proyectos.*

## D — Delegation Pattern y Retain Cycles (Cap 13) — PRIORIDAD

- Patrón agnóstico de framework: clase B (ej. `APIClient`) devuelve resultado a clase A (ej. `ViewController`) que la invocó, sin que B conozca el tipo concreto de A.
- Receta: 1) `protocol XDelegate: AnyObject` con el método callback, 2) `weak var delegate: XDelegate?` en la clase que hace el trabajo, 3) `client.delegate = self`, 4) quien conforma el protocolo lo hace vía `extension`.
- El protocolo debe heredar de `AnyObject` (class-only) — requisito para que `delegate` pueda ser `weak`.
- **Por qué `weak`:** si A → B fuerte y B → A fuerte (vía delegate), ninguna se libera nunca → retain cycle.
- Verificar liberación: `deinit { print(...) }` — si no se imprime al dismissear, hay ciclo. Debug real: Xcode → **Debug Memory Graph**.
- Mismo cuidado con closures que capturan `self` fuerte (ej. `primaryAction` de `UIButton`) → `[weak self]` + `self?.algo`.

## E — Interface Builder: Storyboard y Xib (Cap 1, 2, 14, 15)

- Separar la vista del VC: `UIView` custom con la construcción de subvistas/constraints, cargada en el VC sobreescribiendo `loadView()`.
- Un storyboard es XML bajo el capó (clic derecho → Open As → Source Code).
- Varios storyboards por app, enlazados con "Storyboard Reference".
- Navegación por código entre VCs de storyboard: `storyboard.instantiateViewController(withIdentifier:)` (requiere Storyboard ID seteado).
- `@IBOutlet` (referencia a vista) / `@IBAction` (método disparado por evento) — se crean arrastrando con Control.
- `@IBDesignable` + `prepareForInterfaceBuilder()` → preview en vivo en el storyboard. `@IBInspectable` → propiedad custom editable desde el Attributes Inspector.
- Xib (`.xib`) = una sola vista/VC (no varias pantallas como storyboard). Al compilar se vuelve "nib" (de ahí `loadNibNamed`, `nibName:bundle:`).
- Vista custom reutilizable en xib: File's Owner = la clase custom, e `init` que carga el nib con `Bundle(for:).loadNibNamed(...)` y la agrega como subview.

*Solo práctica: todo el manejo visual de Interface Builder (arrastrar, segues, Document Outline).*

## F — Ciclo de vida avanzado, animaciones, composición (Cap 16, 17, 19, 20)

- `viewDidLoad`: una sola vez. `viewWillAppear`/`viewDidAppear`: cada vez que la vista aparece (incluyendo volver de un push).
- `viewWillLayoutSubviews` / `viewDidLayoutSubviews`: antes/después de reposicionar subvistas (rotación, cambio de constraint en código).
- `UIView.animate(withDuration:animations:)` simple vs la versión con `usingSpringWithDamping:initialSpringVelocity:options:completion:` (damping cercano a 0 = más rebote).
- Animar una **constraint**: cambiar `.constant` dentro del bloque + llamar `view.layoutIfNeeded()` dentro del mismo bloque (si no, salta sin animar).
- App sin storyboard: borrar `Main.storyboard` + quitar `Storyboard Name` de `Info.plist` (Application Scene Manifest) + en `SceneDelegate` crear el VC inicial, asignarlo a `window.rootViewController`, `window.makeKeyAndVisible()`.
- **Child View Controllers**: componer un VC a partir de VCs completos reutilizables (ej. loading indicator, error genérico). Hereda tamaño del padre automáticamente.
  - Agregar: `addChild(childVC)` → `parentView.addSubview(childVC.view)` → `childVC.didMove(toParent: self)`.
  - Remover: `childVC.willMove(toParent: nil)` → `childVC.view.removeFromSuperview()` → `childVC.removeFromParent()`.

## G — Puente con SwiftUI (Cap 18)

- `UIHostingController(rootView:)`: envuelve una vista SwiftUI para usarla como `UIViewController` normal dentro de una app UIKit.
- `UIHostingConfiguration`: usa una vista SwiftUI directo como `contentConfiguration` de una celda de tabla/colección.
- Migración incremental: reemplazar una vista o celda a la vez, sin tocar el resto (data source, delegate, navegación siguen en UIKit).

---

## Checklist de repaso

- [ ] A — Vistas básicas: puedo armar una pantalla con Button/Label/ImageView configurados por código sin mirar el video
- [ ] B — Listas: puedo armar un UITableView funcional con datasource separado del VC, de memoria
- [ ] B — Puedo explicar por qué hace falta registrar la celda antes de dequeuear
- [ ] C — Navegación: sé cuándo usar modal vs push, y cómo volver atrás por código
- [ ] D — Delegation pattern: puedo armar el protocolo + weak delegate + extension de memoria, sin copiar del video
- [ ] D — Sé verificar con `deinit` si hay un retain cycle, y arreglarlo con `[weak self]`
- [ ] E — Sé crear un `@IBOutlet`/`@IBAction` y entiendo diferencia storyboard vs xib
- [ ] F — Entiendo la diferencia entre viewDidLoad (una vez) y viewWillAppear (cada vez)
- [ ] F — Puedo animar una constraint (constant + layoutIfNeeded)
- [ ] F — Entiendo para qué sirve un Child View Controller y el ciclo addChild/removeFromParent
- [ ] G — Entiendo qué hace UIHostingController (puente UIKit↔SwiftUI) — nivel conceptual, no urgente

## Studyflow propuesto

1. **Ya cubierto hoy, repaso rápido solamente**: Cap 1-2 (MVC, separar vista del VC con `loadView()`) — no requiere sesión dedicada.
2. **Práctica dirigida (1 sesión)**: Cap 3-5 (Button/Label/ImageView) — armar una pantalla simple en Xcode combinando los tres, sin copiar código del video.
3. **Sesión dedicada, prioridad alta**: Cap 13 (Delegation Pattern + Retain Cycles) — adelantarlo antes de seguir con listas, porque aparece transversalmente en casi todo lo demás (datasource/delegate de tablas y colecciones usan el mismo patrón). Hacer el ejercicio del API client con Pokémon de memoria.
4. **Práctica dirigida (1-2 sesiones)**: Cap 6-7-8 (TableView, StackView, CollectionView) — con el patrón de delegation ya entendido, van a tener más sentido los protocolos `UITableViewDataSource`/`Delegate`. Armar un listado propio (podría ser con datos de dropsim: monstruos o drops).
5. **Sesión corta**: Cap 9-10-11 (Navegación modal/push/sheet) — una vez hay más de una pantalla para navegar.
6. **Opcional, según preferencia por código vs Interface Builder**: Cap 14-15 (Storyboard/Xib en profundidad) — dado que tu estilo de trabajo en dropsim es "todo explícito, cero magia", podrías priorizar en cambio el Cap 19 (apps sin storyboard, 100% código) y tratar Storyboard/Xib como lectura de referencia, no como práctica obligatoria.
7. **Sesión corta**: Cap 16-17 (ciclo de vida avanzado + animaciones) y Cap 20 (Child View Controllers) — una vez el resto esté sólido.
8. **Último, sin apuro**: Cap 12 (DiffableDataSource) y Cap 18 (puente SwiftUI) — son mejoras sobre patrones que ya vas a dominar, no bloquean nada.
