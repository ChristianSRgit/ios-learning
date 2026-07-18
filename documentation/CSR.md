# CSR - Perfil de Conocimiento: Christian Ramundo
> Actualizado progresivamente por Claude a medida que avanzan las sesiones de estudio.

---

## Identidad

- **Nombre:** Christian Ramundo
- **GitHub:** ChristianSRgit (id 105684594)
- **Rol:** Founder / solo-developer — combina negocio gastronómico, desarrollo web y bug bounty
- **Objetivo concreto:** Estar empleable como desarrollador iOS a finales de diciembre 2026 (~6 meses), con el apoyo y mentoria de su hermano menor (alto seniority en iOS/Swift)

---

## Stack Tecnico Real

- **Frontend:** React 19, Next.js 15/16, Vite, Radix UI, Tailwind CSS 4
- **Backend / integraciones:** Node.js, Google Apps Script, Telegraf (bots de Telegram)
- **Deploy:** Vercel, Netlify
- **Lenguaje principal:** JavaScript / TypeScript end-to-end
- **Herramientas IA:** Gemini CLI (principal hasta hoy), Claude Code (migracion iniciada 2026-07-04)
- **MCP activos:** Google Drive MCP

## Proyectos Activos

- **SMASH** — dark kitchen de hamburguesas smash. Stack: Next.js, React 19, Radix UI, Tailwind 4, bots Telegram, Google Apps Script como DB provisional
- **Bhunting** — practica de bug bounty / pentesting autorizado: subfinder, httpx, Burp Suite, scripts propios en Python (XSS, fuzzing, brute force)
- **AWI** — framework creado por su hermano Guido, Christian lo usa ocasionalmente como usuario

---

## Experiencia en Programacion

- **Años programando:** ~3 años (desde 2023)
- **Lenguaje principal:** JavaScript / TypeScript
- **Lenguajes con exposicion:** C++, C#, Python, Visual Basic
- **Paradigma dominante:** Funcional / OOP en JS; sistemas agénticos

---

## Fundamentos de Programacion

| Concepto | Nivel | Notas |
|---|---|---|
| Variables y constantes | Solido | Entiende la diferencia let/var en Swift correctamente |
| Tipos de dato primitivos | Solido | Int, String, Bool, Float/Double — bien diferenciados |
| Arrays | Solido | Manejo fluido en JS, aplicacion correcta en Swift |
| Clases e instancias (OOP) | Solido | Entiende clase como blueprint, objeto como instancia |
| Funciones | Sin evaluar | - |
| Condicionales / control de flujo | Sin evaluar | - |

---

## Swift — Estado Actual

**Curso:** 100 Days of Swift
**Dia actual:** Dia 3 (Arrays, Dictionaries, Sets, Enums)

| Tema Swift | Estado | Nivel evaluado |
|---|---|---|
| Variables (`var`) y constantes (`let`) | Visto y comprendido | Correcto |
| Strings e interpolacion | Visto | Sin evaluar en profundidad |
| Booleans | Visto | Sin evaluar |
| Arrays | Visto | Comprension intuitiva correcta |
| Dictionaries | Visto | Sin evaluar |
| Sets | Visto | Sin evaluar |
| Enums — basico | Comprendido | Entiende enum como conjunto fijo de opciones validas, contraste correcto con arrays |
| Enums — associated values | Revision necesaria | Concepto nuevo, visto en sesion pero no evaluado aun |
| Enums — switch | Comprendido | Entiende la relacion entre switch y enums, y exhaustividad de casos |
| Structs vs Classes | Comprendido | Entiende value type vs reference type y cuando aplicar cada uno |
| mutating en Structs | Pendiente | No conocia que las funciones que modifican propiedades requieren `mutating` |
| let en instancias de Struct | Comprendido | Entiende correctamente que `let` congela todas las propiedades |
| init | Comprendido | Entiende init como constructor, analogia correcta con C++/Java |
| Enum dentro de Struct | Comprendido | Comprende la combinacion de ambos en un mismo modelo de datos |
| Closures — sintaxis basica | Comprendido | Entiende closure como bloque asignable, sintaxis correcta con `in` y return |
| Closures — captura de variables | Revision necesaria | Tenia el concepto invertido: el closure captura variables externas, no las confina |
| Closures — shorthand ($0) | Pendiente | No conocia la sintaxis de shorthand arguments |
| map / filter | Comprendido | Distingue correctamente transformacion vs filtrado |
| reduce | Pendiente | No visto aun |
| Extensions | Pendiente | - |
| Try/Catch y manejo de errores | Pendiente | - |
| Typecasting / guard let | Pendiente | - |
| Force Unwrap vs Optional | Pendiente | - |

---

## Observaciones de Claude

- Tiene buena base conceptual de OOP desde JS — la transicion a structs/clases en Swift deberia ser fluida.
- La exposicion previa a C# y C++ le da intuicion sobre tipado fuerte, lo que ayuda en Swift.
- Estilo de aprendizaje: responde bien a preguntas directas y analogias concretas. Prefiere profundidad real sobre cobertura superficial.
- Razona bien sobre diseño de tipos: identifica correctamente cuando usar enum vs struct sin necesidad de pistas.
- Perfil practico: combina producto, negocio y seguridad ofensiva — el aprendizaje de Swift/iOS tiene contexto real (apps propias para SMASH).

---

## Historial de Evaluaciones

### Sesion — 2026-07-04
- Evaluacion inicial de nivel general completada.
- Temas evaluados: tipos de dato, OOP basico, let/var, arrays, intro a enums.
- Resultado: base solida para continuar con Dia 3-4 del curso.
