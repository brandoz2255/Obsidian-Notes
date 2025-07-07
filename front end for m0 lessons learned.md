# 📘 Lessons Learned: Monaco Editor Integration in Next.js

## ✅ Goal

To integrate the **Monaco Editor** into a Next.js project with:

- A **custom dark theme** styled like Tailwind CSS
- Full **syntax highlighting** for `tsx`, `ts`, `js`, and `jsx`
- SSR safety (no `window` errors)
- Reliable rendering with no white flash


## 🔍 What Didn't Work (and Why)

### 1. ❌ Using `"tsx"` as the `language` prop

- Monaco **does not support `"tsx"`** as a language ID
- Monaco uses a single language ID: `"typescript"` for both `.ts` and `.tsx`, and configures JSX via **compiler options**, not the language name.

> **Fix:** Use `language="typescript"` and enable JSX with `compilerOptions`.

---

### 2. ❌ Async `beforeMount` function with `await import(...)`

- Monaco **does not wait for promises** returned by `beforeMount`.
- That caused a white editor flash and delayed theme registration.

> **Fix:** Use **static imports** at the top of the file and keep `beforeMount` synchronous.


### 3. ❌ Only importing `monaco.contribution`

- `monaco-editor/esm/vs/language/typescript/monaco.contribution` only registers the compiler (intellisense, error checking).
- It **does not register syntax highlighters / tokenizers**.

> **Fix:** Also import `monaco-editor/esm/vs/basic-languages/typescript/typescript.contribution` to enable proper coloring.


## ✅ What Worked (Final Solution)

### ✅ Static Imports for Language Support

```ts
import "monaco-editor/esm/vs/language/typescript/monaco.contribution"
import "monaco-editor/esm/vs/basic-languages/typescript/typescript.contribution"
```

Function that worked 

```ts
const handleBeforeMount = (monaco) => {
  monaco.editor.defineTheme("custom-dark", {
    base: "vs-dark",
    inherit: true,
    rules: [
      { token: "comment", foreground: "64748b", fontStyle: "italic" },
      { token: "keyword", foreground: "7dd3fc", fontStyle: "bold" },
      { token: "identifier", foreground: "f472b6" },
      { token: "string", foreground: "4ade80" },
      { token: "number", foreground: "facc15" },
      { token: "type.identifier", foreground: "818cf8" },
      { token: "function", foreground: "38bdf8" },
    ],
    colors: {
      "editor.background": "#0f172a",
      "editor.foreground": "#cbd5e1",
      "editorLineNumber.foreground": "#475569",
      "editorCursor.foreground": "#f472b6",
      "editor.lineHighlightBackground": "#1e293b",
    },
  })

  monaco.languages.typescript.typescriptDefaults.setCompilerOptions({
    target: monaco.languages.typescript.ScriptTarget.ESNext,
    allowNonTsExtensions: true,
    jsx: monaco.languages.typescript.JsxEmit.React,
  })
}
```

### ✅ Correct Language Prop

In the TSX:

```ts
<MonacoEditor
  language="typescript" // ✅ instead of "tsx"
  beforeMount={handleBeforeMount}
  theme="custom-dark"
  ...
/>
```

## ✅ End Result

|Feature|Status|
|---|---|
|Tailwind-style dark theme|✅|
|Full syntax highlighting|✅|
|TSX/JSX support|✅|
|SSR safe (Next.js 14)|✅|
|No white flash|✅|
|Fully dynamic + stylable|✅|


