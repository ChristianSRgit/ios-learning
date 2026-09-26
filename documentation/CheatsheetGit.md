# Cheatsheet: Git 🌿

Comandos que fui usando de verdad en las sesiones de `dropsim`, no la lista completa de man git. Se va a ir llenando a medida que aparezcan casos nuevos.

---

## 📌 0. Filosofía — por qué existen las branches

Una branch es un puntero movible a un commit. `main` y `release/v0.1` no son "carpetas distintas" — son dos punteros sobre el mismo historial de commits. Cuando parecen "divergir", en realidad uno de los dos puntero se quedó atrás o tomó un camino que el otro no tiene.

**Flujo que uso en `dropsim`** (ver homework 2026-09-24): cada tarea nueva = una branch con nombre descriptivo → PR contra `release/v0.1` (no contra `main`) → mergear → borrar la branch. `main` solo se actualiza por promoción desde `release/v0.1` cuando está estable. Ver [[feedback_git_branch_workflow]].

---

## 🔍 1. Inspeccionar antes de tocar nada

Regla de oro: **nunca arrancar a trabajar sin saber en qué branch estás parado.**

```bash
git status --short --branch     # branch actual + si estás ahead/behind del remoto
git branch -v                   # todas las branches locales, con su último commit
git branch -a                   # incluye las branches remotas (origin/...)
```

| Comando | Para qué |
| :--- | :--- |
| `git log --oneline -10` | últimos 10 commits, una línea cada uno |
| `git log --oneline --graph --all` | como el anterior pero dibuja las branches — clave para entender divergencias |
| `git diff branchA branchB --stat` | qué archivos difieren entre dos branches (sin mergear nada, solo mirar) |
| `git merge-base --is-ancestor A B` | ¿es A un ancestro directo de B? Si dice que sí, un merge de A en B va a ser fast-forward (sin conflicto posible) |

**Caso real (2026-09-26):** usé `git merge-base --is-ancestor origin/release/v0.1 origin/main` para confirmar que un merge iba a resolver limpio *antes* de crear el PR — evita sorpresas.

---

## 🌱 2. Crear y moverse entre branches

```bash
git switch -c chore/align-release-v0.1 main   # crea la branch NUEVA a partir de main, y te para ahí
git switch release/v0.1                        # cambia a una branch que ya existe
```

`git switch -c` es el reemplazo moderno de `git checkout -b` — hacen lo mismo, `switch` es más explícito (checkout históricamente hacía demasiadas cosas distintas).

Convención de nombres que vengo usando: `feature/<algo>` para código nuevo, `chore/<algo>` para bookkeeping (como alinear branches), `fix/<algo>` para arreglar algo roto.

---

## 🚀 3. Subir la branch y abrir un PR

```bash
git push -u origin chore/align-release-v0.1
# -u = "upstream": la próxima vez alcanza con `git push` a secas, ya sabe a dónde

gh pr create --base release/v0.1 --head chore/align-release-v0.1 \
  --title "chore: alinear release/v0.1 con main" \
  --body "Descripción de por qué"
```

`--base` = a qué branch querés que entren tus cambios. **Default siempre `release/v0.1` en este repo, nunca `main`** (ver sección 0).

```bash
gh pr view --web       # abre el PR en el navegador para revisarlo
gh pr merge --merge     # mergea el PR actual (o pasale el número: gh pr merge 3 --merge)
```

---

## 🔄 4. Después de mergear: sincronizar y limpiar

```bash
git switch release/v0.1
git pull origin release/v0.1          # traer el merge que acabás de hacer en GitHub

git branch -d chore/align-release-v0.1              # borrar la branch local (ya cumplió su función)
git push origin --delete chore/align-release-v0.1   # borrarla del remoto (si GitHub no lo hizo solo al mergear)
```

`-d` (minúscula) se niega a borrar si la branch tiene commits que no llegaron a ningún lado (red de seguridad). `-D` mayúscula fuerza el borrado igual — usar con cuidado, es la versión "sin red".

---

## ⚔️ 5. Conflictos — pendiente de practicar

Todavía no me tocó resolver un conflicto real (el align de 2026-09-26 resultó ser un merge limpio, sin fricción — verificado de antemano con `merge-base --is-ancestor`). Sigue en la lista de homework con Juan. Cuando lo practique, esta sección se llena con el flujo real: qué pinta tienen los marcadores `<<<<<<<` / `=======` / `>>>>>>>`, cómo elegir qué lado ganar, y `git merge --abort` como vía de escape si algo sale mal.

---

## 🩹 6. Deshacer cosas (para cuando meta la pata)

| Quiero... | Comando |
| :--- | :--- |
| Descartar cambios sin commitear en un archivo | `git restore <archivo>` |
| Sacar un archivo del staging (sin perder el cambio) | `git restore --staged <archivo>` |
| Deshacer el último commit pero mantener los cambios | `git reset --soft HEAD~1` |
| Cancelar un merge que se puso feo | `git merge --abort` |

**Ojo:** ninguno de estos se usa "por las dudas" — cada uno resuelve un problema puntual. Si no sabés cuál corresponde, mejor preguntar antes de tirar el comando.
