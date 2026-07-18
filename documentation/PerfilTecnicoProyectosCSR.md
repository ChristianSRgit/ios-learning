AWI — Hoja de Estudio y Perfil Técnico
Generado a partir de la revisión completa de awi-core, mi-awi-core (Windows) y my-awi-instance (WSL). Fecha de revisión: 2026-07-04

1. Qué es AWI (Agentic Workflow Integrator)
AWI es un framework open-source (GuidoAmici/awi, MIT) — un "vault" tipo Obsidian versionado en git, operado por un asistente de IA (Claude Code, Codex o Gemini CLI) que actúa como jefe de gabinete / chief of staff personal.

Filosofía central: "git es la base de datos". Cada acción (Write/Edit) se auto-commitea vía hook con prefijo cos:, sin storage separado. No hay memoria del agente fuera del vault — está explícitamente prohibida; todo vive en archivos versionados.

Cumple dos roles:

Personal OS — agenda, planificación diaria/semanal/trimestral/anual.
Workspace factory — /awi-org <name> o /initialize <name> crea un repo independiente (submódulo git) por empresa/cliente, con estructura idéntica: agenda/ + documentation/ + codebase/.
Tus tres instancias (mismo framework, distinto estado evolutivo)
Instancia	Ubicación	Estado
awi-core	Windows Documents/awi-core	Clon base del template original de GuidoAmici, sin modificar — referencia/upstream
mi-awi-core	Windows Documents/mi-awi-core	Tu fork personal más antiguo (_clients/), con Bhunting como único cliente cargado
my-awi-instance	WSL /home/csr1/my-awi-instance	Tu instancia activa y más evolucionada — nomenclatura final _data/organizations/, multi-usuario, toggles de organización, sync con GitHub Issues, submódulo agency-agents
⚠️ Nota de estado: my-awi-instance tiene un rebase interactivo detenido en curso (REBASE_HEAD presente, conflicto sin resolver en GEMINI.md). No se tocó — conviene resolverlo o abortarlo antes de seguir trabajando ahí.

2. Componentes del sistema
_system/_agentic-workflow-integrator/ — el núcleo:
INSTRUCTIONS.md — fuente única de verdad
definitions.md — taxonomía: Entity → Product → App → Project → Module → Feature → Task
confidence-scoring.md — umbrales 0.9 / 0.7 / 0.5 para actuar sin preguntar
navigation-patterns.md — patrón "OpenViking" L0/L1: .abstract.md (1 frase) / .overview.md (1-2 párrafos), evita cargar contexto completo de golpe
routing-rules.md — dónde va cada tipo de memoria (perfil de usuario vs. observaciones de sesión)
chief-of-staff/ — referencias operativas: formatos YAML, comandos de auditoría git
getting-things-done/task-selection.md — adaptación GTD: prioriza por Contexto → Tiempo disponible → Energía → Prioridad (no solo prioridad), con tags energy: high|medium|low
agency-agents/ — submódulo externo (msitarzewski/agency-agents, no propio) con cientos de sub-agentes especializados por rol instalables en ~/.claude/agents/
docs/agents/ — integración con skills tipo Matt Pocock (to-issues, to-prd, triage, tdd, diagnose), mapeo a GitHub Issues multi-repo
3. Catálogo de Skills — capa "Chief of Staff" (.claude/skills)
Skill	Qué hace
awi-introduction	Onboarding inicial: vincula GitHub, setea preferencias, aterriza en /today
awi-initialize	Bootstrap del repo AWI, inicializa submódulos de orgs activas
awi-user / awi-user-create / awi-user-login	Gestión de usuario (submódulo _data/users/<github-id>/)
awi-org / awi-client / new-client	Alta de organización/cliente — scaffolding + registro como submódulo
awi-org-toggle	Activa/desactiva un submódulo de org (active-orgs.json)
awi-sync	Sincroniza todos los submódulos (commit, pull, push)
awi-core-sync-status	Compara vault privado vs. awi-core público (drift check)
awi-layer-index / reindex / check-index	Audita/repara .abstract.md / .overview.md (L0/L1)
new	Captura rápida en lenguaje natural → clasifica y archiva (task/project/person/idea)
today / today-start / today-end	Hub diario: check-in matutino, plan del día, cierre
week / week-review	Plan semanal y ritual de re-priorización de viernes
quarter / year	Planificación trimestral y anual
delegate	Delega tarea a agente en background, notifica al completar
history	Actividad git reciente legible
break	Registra pausas para cálculo de tiempo real trabajado
wrap-session	Cierre de sesión: guarda observaciones sobre el usuario
4. Catálogo de Skills de desarrollo (.agents/skills)
Skill	Qué hace
setup-matt-pocock-skills	Configura issue tracker/labels/domain docs
triage	Máquina de estados para triage de issues
to-prd	Sintetiza el contexto de la conversación en un PRD
to-issues	Descompone un plan en issues independientes (vertical slices)
tdd	Red-green-refactor disciplinado
diagnose	Loop de diagnóstico para bugs difíciles/regresiones de performance
improve-codebase-architecture	Detecta oportunidades de refactor guiado por CONTEXT.md/ADRs
prototype	Prototipo descartable para validar diseño antes de comprometerse
grill-me / grill-with-docs	Interrogatorio exhaustivo de un plan (la segunda actualiza CONTEXT/ADRs)
zoom-out	Pide contexto de más alto nivel de código desconocido
write-a-skill	Crea nuevas skills con progressive disclosure
caveman (familia)	Modos ultra-comprimidos (-75% tokens): commit, review, compress, help
5. Organizaciones / clientes gestionados
Activas para tu usuario (github ChristianSRgit, id 105684594): bhunting, rabbitek, smash-workspace.

rabbitek está registrada pero vacía. newhaze/afin pertenecen al fork upstream de GuidoAmici — no son tuyas.

SMASH (smash-workspace)
Tu negocio real: dark kitchen de hamburguesas smash, en sociedad con Lucas y Milagros. Rol: founder/solo-developer — estrategia + producto digital + desarrollo.

smashWeb — Next.js 15/16 + React 19 + Radix UI + Tailwind 4 (sitio con e-commerce/leads)
MentalModelsApp — Vite + React 19 + TS, herramienta interna de toma de decisiones (usa deepl-node)
ComprasBotApp — bot de Telegram (Telegraf, Node.js), tracking de compras por proveedor/categoría, sincronizado con Google Apps Script como DB
BajoneandoCalc — calculadora de caja/ventas, vanilla JS + Google Apps Script
Deploy: Vercel / Netlify. DB actual: Google Sheets (sin auth real, solo password en .env — punto de seguridad a mejorar)
Prioridades del trimestre: automatizar carga de ventas multi-canal (PedidosYa, Rappi, MercadoPago, WhatsApp), tienda virtual como POS adicional
Bhunting
Tu práctica personal de bug bounty / pentesting: subfinder, assetfinder, httpx, gau, waybackurls, kxss, gobuster, kiterunner (vía go install), Burp Suite, Hydra, Wireshark, scripts propios en Python (nmapScan.py, bruteforce.py, fuzzer.py), payloads de XSS, plantillas de reporte de vulnerabilidades.

6. Perfil Técnico
Campo	Detalle
Nombre	Christian Ramundo
GitHub	ChristianSRgit (id 105684594)
Email	christian.s.ramundo@gmail.com
Rol	Founder / solo-developer — combina estrategia de negocio gastronómico con desarrollo full-stack y seguridad ofensiva
Stack técnico
Frontend: React 19, Next.js 15/16, Vite, Radix UI, Tailwind CSS 4
Backend / integraciones: Node.js, Google Apps Script (backend ligero/DB provisional), Telegraf (bots de Telegram)
Deploy: Vercel, Netlify
Lenguaje principal: JavaScript/TypeScript end-to-end
Herramientas de IA / desarrollo
Claude Code (principal — hooks de auto-commit, sonidos de notificación)
Gemini CLI, Codex CLI, Cursor
Arquitectura basada en submódulos git
MCP: Docker MCP Gateway, Meta Ads MCP, Google Drive MCP
Seguridad ofensiva
Practica activamente bug bounty hunting: reconocimiento de subdominios, fuzzing, brute force, XSS — investigación de seguridad autorizada.

Nivel de sofisticación
Alto en ingeniería de sistemas agénticos: diseñó/adoptó un framework propio de gestión de conocimiento con auto-commit, taxonomía formal, scoring de confianza, convención de contexto por capas (L0/L1) y delegación de tareas a agentes en background. Aplica metodologías serias de ingeniería (TDD, ADRs, triage de issues, PRDs) sobre sus propios repos.

Preferencias de flujo de trabajo registradas
Merge sin rebase (no-rebase) para integrar con upstream, para preservar cronología del historial local.
7. MCP e integraciones (.mcp.json)
Servidor	Propósito
MCP_DOCKER	Docker MCP Gateway — expone herramientas containerizadas
meta-ads	Gestión de campañas de Meta Ads — coherente con marketing digital de SMASH
gdrive	Google Drive con credenciales OAuth propias
8. Próximos pasos sugeridos
[ ] Resolver o abortar el rebase pendiente en my-awi-instance/.git (conflicto en GEMINI.md)
[ ] Revisar seguridad de smash-workspace (Google Sheets como DB sin auth real, password solo en .env)
[ ] Decidir si rabbitek se activa con contenido real o se da de baja
[ ] Evaluar consolidar awi-core / mi-awi-core (Windows) vs. my-awi-instance (WSL) para evitar drift entre instancias