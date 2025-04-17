## CSS Variables vs. Tailwind Utilities

**Previous Issue:**
We were trying to use Tailwind's utility classes with HSL color values:

```css
bg-primary text-primary-foreground
```

**Solution:**
We switched to direct CSS variables and explicit classes:

```css
.service-card {
  background-color: #000;
  border: 1px solid #0e2a38;
  /* other styles */
}

.service-card:hover {
  border-color: #be185d;
  box-shadow: 0 0 15px rgba(236,72,153,0.3);
  /* other hover styles */
}
```

**Why it works:**

- This approach doesn't rely on Tailwind's utility classes
- It uses standard CSS which works regardless of Tailwind's configuration
- It gives us more direct control over the styling