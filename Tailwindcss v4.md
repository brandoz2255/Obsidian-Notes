When working with `tailwindCSSv4` we need to take the new stuff into consideration

- [[what we did that worked]]
- [[What we did that worked continued Tailwindconfig.js]]
- [[Key Take aways]]: Always check this first before starting a nextjs project

- One it does not need a tailwind  config however when using `Shadcn/UI` since it hasn't been updated  fully we still needs to make one just for its components or so i believe 

```css
@import "tailwindcss";

```

- This is all that would need to be imported which is the basic tailwind library then all the custom colors are inside the CSS file
- When using the old `shadcn/ui` framework we use the `border-border`,`bg-background`, or `text-foreground` 
- using these var names are outdated and must be placed manually 

```css

* {
  border-color: var(--border);
}

body {
  background-color: var(--background);
  color: var(--foreground);
}
```


