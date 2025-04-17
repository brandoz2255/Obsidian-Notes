### CyberCandy Portfolio: Frontend Development Documentation (Part 2)

## 1. Detailed Component Implementation

### 1.1 Component Architecture Deep Dive

The portfolio follows a hierarchical component structure:


```bash
app/                  # Next.js App Router structure
├── layout.tsx        # Root layout with providers
├── page.tsx          # Homepage with section composition
├── projects/         # Projects section
│   ├── page.tsx      # Projects listing page
│   ├── [id]/         # Dynamic project routes
│   │   └── page.tsx  # Individual project page
│   └── edit/         # Project editor
│       └── page.tsx  # Editor interface
└── skills/           # Skills page
    └── page.tsx      # Detailed skills listing

components/           # Shared components
├── ui/               # Base UI components
├── section-components/ # Main content sections
│   ├── hero-section.tsx
│   ├── skills-section.tsx
│   ├── projects-section.tsx
│   ├── experience-section.tsx
│   ├── education-section.tsx
│   └── contact-section.tsx
├── layout-components/ # Structural components
│   ├── navbar.tsx
│   ├── footer.tsx
│   └── floating-nav.tsx
└── utility-components/ # Helper components
    ├── animated-background.tsx
    ├── theme-toggle.tsx
    └── scroll-progress.tsx
```

### 1.2 Server vs. Client Components

The application strategically uses both server and client components:

```tsx
// Server Component Example (no "use client" directive)
export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className={inter.className}>
        <ThemeProvider attribute="class" defaultTheme="dark" enableSystem>
          {children}
        </ThemeProvider>
      </body>
    </html>
  )
}

// Client Component Example
"use client"

import { useState } from "react"
import { motion } from "framer-motion"

export default function HeroSection() {
  const [isHovered, setIsHovered] = useState(false)
  
  return (
    <motion.div
      onHoverStart={() => setIsHovered(true)}
      onHoverEnd={() => setIsHovered(false)}
    >
      {/* Component content */}
    </motion.div>
  )
```

### 1.3 Dynamic Routing Implementation

Project detail pages use dynamic routing with data fetching:

```tsx
// app/projects/[id]/page.tsx
"use client"

import { useEffect, useState } from "react"
import { useParams, useRouter } from "next/navigation"
import { type Project, getProjectById } from "@/data/projects"

export default function ProjectPage() {
  const params = useParams()
  const router = useRouter()
  const [project, setProject] = useState<Project | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (params.id) {
      const projectData = getProjectById(params.id as string)
      if (projectData) {
        setProject(projectData)
      } else {
        router.push("/projects")
      }
    }
    setLoading(false)
  }, [params.id, router])

  // Render logic
```

### 1.4 Composition Pattern

The main page uses composition to assemble sections:

```tsx
// app/page.tsx
export default function Home() {
  return (
    <main className="min-h-screen bg-slate-950 text-slate-200 overflow-hidden">
      <div className="matrix-bg">
        <Navbar />

        <div className="container mx-auto px-4 py-8">
          <HeroSection />
          <SkillsSection />
          <ProjectsSection />
          <ExperienceSection />
          <EducationSection />
          <ContactSection />
          {/* Additional content */}
        </div>

        <Footer />
      </div>
    </main>
  )
}
```

## 2. Custom Hooks and Utilities

### 2.1 useMobile Hook

Created a custom hook for responsive design decisions:

```tsx
// hooks/use-mobile.tsx
"use client"

import { useState, useEffect } from "react"

export function useMobile() {
  const [isMobile, setIsMobile] = useState(false)

  useEffect(() => {
    // Function to check if the screen is mobile-sized
    const checkMobile = () => {
      setIsMobile(window.innerWidth < 768)
    }

    // Initial check
    checkMobile()

    // Add event listener for window resize
    window.addEventListener("resize", checkMobile)

    // Clean up
    return () => window.removeEventListener("resize", checkMobile)
  }, [])

  return isMobile
}
```

Usage example:

```tsx
function Component() {
  const isMobile = useMobile()
  
  return (
    <div className={isMobile ? "mobile-layout" : "desktop-layout"}>
      {/* Conditional rendering based on device */}
      {isMobile ? <MobileView /> : <DesktopView />}
    </div>
  )
}
```

### 2.2 Theme Management

Implemented theme switching with next-themes:

```tsx
// components/theme-toggle.tsx
"use client"

import { useTheme } from "next-themes"
import { useState, useEffect } from "react"
import { Sun, Moon, Monitor } from 'lucide-react'

export default function ThemeToggle() {
  const { theme, setTheme } = useTheme()
  const [mounted, setMounted] = useState(false)

  // Ensure component is mounted before accessing theme
  useEffect(() => {
    setMounted(true)
  }, [])

  if (!mounted) return null

  return (
    <div className="fixed bottom-6 left-6 z-50">
      <button
        onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
        className="flex items-center justify-center w-12 h-12 rounded-full bg-slate-800/80"
      >
        {theme === "dark" ? (
          <Moon className="h-5 w-5 text-blue-400" />
        ) : (
          <Sun className="h-5 w-5 text-yellow-400" />
        )}
      </button>
    </div>
  )
}
```

### 2.3 Utility Functions

Created utility functions for common operations:


```tsx
// lib/utils.ts
export function formatDate(date: string): string {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

export function cn(...classes: (string | undefined | null | false)[]): string {
  return classes.filter(Boolean).join(' ')
}

export function truncateText(text: string, maxLength: number): string {
  if (text.length <= maxLength) return text
  return text.slice(0, maxLength) + '...'
}
```


## 3. Animation Techniques

### 3.1 Framer Motion Integration

Implemented complex animations with Framer Motion:

```tsx
// components/hero-section.tsx
<motion.div
  initial={{ opacity: 0, x: -50 }}
  animate={{ opacity: 1, x: 0 }}
  transition={{ duration: 0.5 }}
  className="flex-1"
>
  <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold mb-4 text-blue-400 glow-text">
    DevSecOps Specialist
  </h1>
  
  {/* Additional content */}
</motion.div>
```

### 3.2 Scroll-Triggered Animations

Implemented animations that trigger on scroll:

```tsx
// components/skills-section.tsx
<motion.div
  initial={{ opacity: 0, y: 20 }}
  whileInView={{ opacity: 1, y: 0 }}
  transition={{ duration: 0.5 }}
  viewport={{ once: true }}
  className="text-center mb-16"
>
  <h2 className="text-3xl md:text-4xl font-bold mb-4 text-blue-400 glow-text">
    Technical Arsenal
  </h2>
  <p className="text-slate-400 max-w-2xl mx-auto">
    My specialized skill set focuses on securing and optimizing infrastructure.
  </p>
</motion.div>
```

### 3.3 Custom Typing Animation

Implemented a custom typing animation effect:

```tsx
// components/hero-section.tsx
useEffect(() => {
  if (hasTyped) return // Skip if already typed
  hasTyped = true // Mark as done

  const typeText = async () => {
    if (!typingRef.current) return

    // Clear any existing content first
    typingRef.current.textContent = ""

    // Text to type
    const text = "Securing the digital frontier, one line of code at a time."

    // Add each character with a delay
    for (let i = 0; i < text.length; i++) {
      if (!typingRef.current) break
      typingRef.current.textContent += text.charAt(i)
      await new Promise((resolve) => setTimeout(resolve, 50))
    }
  }

  // Small delay before starting the typing animation
  setTimeout(() => {
    typeText()
  }, 500)

  return () => {
    // Cleanup if component unmounts
    if (typingRef.current) {
      typingRef.current.textContent = ""
    }
  }
}, [])
```

### 3.4 Canvas-Based Matrix Animation

Implemented a custom canvas animation for the matrix background:

```tsx
// components/animated-background.tsx
useEffect(() => {
  const canvas = canvasRef.current
  if (!canvas) return

  const ctx = canvas.getContext("2d")
  if (!ctx) return

  // Set canvas dimensions
  canvas.width = window.innerWidth
  canvas.height = window.innerHeight

  // Matrix effect parameters
  const fontSize = isMobile ? 10 : 14
  const columns = Math.floor(canvas.width / fontSize)
  const drops: number[] = []

  // Initialize drops
  for (let i = 0; i < columns; i++) {
    drops[i] = Math.floor(Math.random() * -canvas.height)
  }

  // Characters to display
  const chars = "01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン"

  // Draw function
  const draw = () => {
    // Semi-transparent black background to create fade effect
    ctx.fillStyle = "rgba(2, 6, 23, 0.05)"
    ctx.fillRect(0, 0, canvas.width, canvas.height)

    // Set text color and font
    ctx.fillStyle = "#3b82f6" // Blue color
    ctx.font = `${fontSize}px monospace`

    // Draw characters
    for (let i = 0; i < drops.length; i++) {
      // Random character
      const text = chars[Math.floor(Math.random() * chars.length)]
      
      // Calculate positions
      const x = i * fontSize
      const y = drops[i] * fontSize

      // Draw the character
      if (y > 0) {
        const opacity = Math.random() * 0.5 + 0.3
        ctx.fillStyle = `rgba(59, 130, 246, ${opacity})`
        ctx.fillText(text, x, y)
      }

      // Move drops down
      drops[i]++

      // Reset drop when it reaches bottom or randomly
      if (drops[i] * fontSize > canvas.height && Math.random() > 0.975) {
        drops[i] = Math.floor(Math.random() * -20)
      }
    }
  }

  // Animation loop
  const interval = setInterval(draw, 50)

  return () => clearInterval(interval)
}, [isMobile, isDark])
```

## 4. State Management Patterns

### 4.1 Component State Management

Used React's useState for component-level state:

```tsx
// app/projects/edit/page.tsx
export default function EditProjectsPage() {
  const router = useRouter()
  const [projects, setProjects] = useState<Project[]>(initialProjects)
  const [activeTab, setActiveTab] = useState<string>("edit")

  const handleProjectChange = (index: number, field: keyof Project, value: any) => {
    const updatedProjects = [...projects]
    updatedProjects[index] = { ...updatedProjects[index], [field]: value }
    setProjects(updatedProjects)
  }

  // Additional handlers and render logic
}
```

### 4.2 Context-Based State Management

Used React Context for theme management:

```tsx
// components/theme-provider.tsx
"use client"

import { ThemeProvider as NextThemesProvider } from "next-themes"
import type { ThemeProviderProps } from "next-themes"

export function ThemeProvider({ children, ...props }: ThemeProviderProps) {
  return <NextThemesProvider {...props}>{children}</NextThemesProvider>
}

// Usage in layout.tsx
<ThemeProvider attribute="class" defaultTheme="dark" enableSystem>
  {children}
</ThemeProvider>
```

### 4.3 URL State Management

Used URL parameters for state persistence:

```tsx
// app/projects/[id]/page.tsx
export default function ProjectPage() {
  const params = useParams()
  const router = useRouter()
  
  useEffect(() => {
    if (params.id) {
      const projectData = getProjectById(params.id as string)
      if (projectData) {
        setProject(projectData)
      } else {
        router.push("/projects")
      }
    }
  }, [params.id, router])
  
  // Component logic
}
```

## 5. Advanced Styling Techniques

### 5.1 Tailwind CSS v4 Configuration

Configured Tailwind CSS v4 with custom variables:

```tsx
/* app/globals.css */
@import "tailwindcss";

:root {
  --background: 0 0% 100%;
  --foreground: 222 47% 11%;
  --card: 0 0% 100%;
  --card-foreground: 222 47% 11%;
  --primary: 217 91% 60%;
  --primary-foreground: 210 40% 98%;
  /* Additional variables */
}

.dark {
  --background: 222 47% 11%;
  --foreground: 210 40% 98%;
  --card: 222 47% 11%;
  --card-foreground: 210 40% 98%;
  /* Dark mode variables */
}
```

### 5.2 Custom Animation Keyframes

Defined custom CSS animations:

```tsx
/* app/globals.css */
@keyframes blink-caret {
  from, to {
    opacity: 0;
  }
  50% {
    opacity: 1;
  }
}

@keyframes pulse-glow {
  0%, 100% {
    box-shadow: 0 0 5px rgba(59, 130, 246, 0.5);
  }
  50% {
    box-shadow: 0 0 15px rgba(59, 130, 246, 0.8);
  }
}

.typing-cursor {
  display: inline-block;
  width: 2px;
  height: 1.2em;
  background-color: rgba(59, 130, 246, 0.75);
  margin-left: 2px;
  animation: blink-caret 0.75s step-end infinite;
}

.shadow-glow {
  animation: pulse-glow 2s infinite;
}
```

### 5.3 Responsive Design Patterns

Implemented responsive design with Tailwind:

```tsx
// components/hero-section.tsx
<div className={`flex flex-col ${isMobile ? "gap-8" : "md:flex-row items-center justify-between gap-12"}`}>
  {/* Content */}
  <motion.div className={`flex-shrink-0 ${isMobile ? "mx-auto mt-8" : ""}`}>
    {/* Profile image container */}
    <div className="relative cyber-border rounded-lg overflow-hidden bg-gradient-to-br from-blue-900/20 to-black">
      <div className={`${isMobile ? "w-64 h-80" : "w-72 h-96"}`}>
        <Image
          src="/placeholder.svg?height=600&width=450"
          alt="Profile Image"
          fill
          className="object-cover object-center"
        />
      </div>
    </div>
  </motion.div>
</div>
```

### 5.4 CSS Custom Properties for Theming

Used CSS custom properties for theme switching:

```css
/* app/globals.css */
:root {
  --background: 0 0% 100%;
  --foreground: 222 47% 11%;
  /* Light theme variables */
}

.dark {
  --background: 222 47% 11%;
  --foreground: 210 40% 98%;
  /* Dark theme variables */
}

body {
  background-color: hsl(var(--background));
  color: hsl(var(--foreground));
}
```


## 6. Performance Optimization Techniques

### 6.1 Image Optimization

Configured Next.js Image component for optimal loading:

```tsx
// next.config.mjs
const nextConfig = {
  images: {
    domains: ['placeholder.com'],
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**',
      },
    ],
  },
};

// Usage in components
<Image
  src={project.image || "/placeholder.svg?height=600&width=800"}
  alt={project.title}
  fill
  className="object-cover transition-transform duration-300 hover:scale-105"
/>
```


### 6.2 Component Lazy Loading

Implemented lazy loading for below-the-fold content:

```tsx
// app/page.tsx
import dynamic from 'next/dynamic'

// Lazy load components that are below the fold
const ProjectsSection = dynamic(() => import('@/components/projects-section'))
const ExperienceSection = dynamic(() => import('@/components/experience-section'))
const EducationSection = dynamic(() => import('@/components/education-section'))
const ContactSection = dynamic(() => import('@/components/contact-section'))

export default function Home() {
  return (
    <main>
      <HeroSection /> {/* Loaded immediately */}
      <SkillsSection /> {/* Loaded immediately */}
      <ProjectsSection /> {/* Lazy loaded */}
      <ExperienceSection /> {/* Lazy loaded */}
      <EducationSection /> {/* Lazy loaded */}
      <ContactSection /> {/* Lazy loaded */}
    </main>
  )
}
```


### 6.3 Package Optimization

Configured Next.js to optimize package imports:

```tsx
// next.config.mjs
const nextConfig = {
  // Other config
  experimental: {
    optimizePackageImports: ['lucide-react', 'framer-motion'],
  },
};
```


### 6.4 Conditional Rendering for Performance

Used conditional rendering to optimize performance:

```tsx
// components/animated-background.tsx
export default function AnimatedBackground() {
  const { theme } = useTheme()
  const isDark = theme === "dark"

  useEffect(() => {
    // Only run animation in dark mode
    if (!isDark) {
      ctx.clearRect(0, 0, canvas.width, canvas.height)
      return
    }
    
    // Animation logic
  }, [isDark])
  
  // Only render canvas when needed
  if (!isDark) return null
  
  return <canvas ref={canvasRef} className="fixed top-0 left-0 w-full h-full pointer-events-none z-0 opacity-30" />
}
```


## 7. Advanced Features Implementation

### 7.1 Floating Navigation

Implemented a floating navigation component for improved mobile UX:

```tsx
// components/floating-nav.tsx
export default function FloatingNav() {
  const [isOpen, setIsOpen] = useState(false)
  const isMobile = useMobile()

  // Only show on mobile or when scrolled down on desktop
  const [showButton, setShowButton] = useState(false)

  // Handle scroll to show/hide the button
  useEffect(() => {
    const handleScroll = () => {
      if (window.scrollY > 300) {
        setShowButton(true)
      } else {
        setShowButton(false)
      }
    }
    
    window.addEventListener("scroll", handleScroll)
    return () => window.removeEventListener("scroll", handleScroll)
  }, [])

  if (!showButton && !isMobile) return null

  return (
    <div className="fixed bottom-6 right-6 z-50">
      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: 20 }}
            className="mb-4 bg-slate-900/90 backdrop-blur-md border border-blue-900/30 rounded-lg shadow-lg overflow-hidden"
          >
            {/* Navigation items */}
          </motion.div>
        )}
      </AnimatePresence>

      <motion.button
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
        onClick={() => setIsOpen(!isOpen)}
        className="flex items-center justify-center w-12 h-12 rounded-full bg-blue-600 text-white shadow-lg"
      >
        {isOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
      </motion.button>
    </div>
  )
}
```


### 7.2 Scroll Progress Indicator

Implemented a scroll progress indicator:

```tsx
// components/scroll-progress.tsx
export default function ScrollProgress() {
  const { scrollYProgress } = useScroll()
  const [isVisible, setIsVisible] = useState(false)

  useEffect(() => {
    const handleScroll = () => {
      // Show the progress bar after scrolling down a bit
      if (window.scrollY > 100) {
        setIsVisible(true)
      } else {
        setIsVisible(false)
      }
    }

    window.addEventListener("scroll", handleScroll)
    return () => window.removeEventListener("scroll", handleScroll)
  }, [])

  if (!isVisible) return null

  return (
    <div className="fixed top-0 left-0 right-0 h-1 bg-slate-800/50 z-50">
      <motion.div
        className="h-full bg-gradient-to-r from-blue-600 via-blue-400 to-blue-600 origin-left"
        style={{ scaleX: scrollYProgress }}
      />
    </div>
  )
}
```


### 7.3 Theme Toggle with Animation

Implemented an animated theme toggle:

```tsx
// components/theme-toggle.tsx
export default function ThemeToggle() {
  const { theme, setTheme } = useTheme()
  const [mounted, setMounted] = useState(false)
  const [isOpen, setIsOpen] = useState(false)

  // Ensure component is mounted before accessing theme
  useEffect(() => {
    setMounted(true)
  }, [])

  if (!mounted) return null

  const toggleTheme = (newTheme: string) => {
    setTheme(newTheme)
    setIsOpen(false)
  }

  return (
    <div className="fixed bottom-6 left-6 z-50">
      <motion.button
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
        onClick={() => setIsOpen(!isOpen)}
        className="flex items-center justify-center w-12 h-12 rounded-full bg-slate-800/80 backdrop-blur-sm"
      >
        {theme === "dark" ? (
          <Moon className="h-5 w-5 text-blue-400" />
        ) : (
          <Sun className="h-5 w-5 text-yellow-400" />
        )}
      </motion.button>

      <motion.div
        initial={{ opacity: 0, scale: 0.8, y: 10 }}
        animate={isOpen ? { opacity: 1, scale: 1, y: 0 } : { opacity: 0, scale: 0.8, y: 10 }}
        transition={{ duration: 0.2 }}
        className={`absolute bottom-16 left-0 bg-slate-900/90 backdrop-blur-md ${isOpen ? "block" : "hidden"}`}
      >
        {/* Theme options */}
      </motion.div>
    </div>
  )
}
```


## 8. Debugging and Troubleshooting Techniques

### 8.1 Hydration Error Resolution

Resolved Next.js hydration errors:


```tsx
// app/layout.tsx
export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className={inter.className}>
        <ThemeProvider attribute="class" defaultTheme="dark" enableSystem>
          {children}
        </ThemeProvider>
      </body>
    </html>
  )
}

// components with client-side state
"use client"

export function ClientComponent() {
  const [mounted, setMounted] = useState(false)
  
  useEffect(() => {
    setMounted(true)
  }, [])
  
  if (!mounted) {
    return <div>Loading...</div> // Server-side placeholder
  }
  
  return <div>Client-side content</div>
}// app/layout.tsx
export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className={inter.className}>
        <ThemeProvider attribute="class" defaultTheme="dark" enableSystem>
          {children}
        </ThemeProvider>
      </body>
    </html>
  )
}

// components with client-side state
"use client"

export function ClientComponent() {
  const [mounted, setMounted] = useState(false)
  
  useEffect(() => {
    setMounted(true)
  }, [])
  
  if (!mounted) {
    return <div>Loading...</div> // Server-side placeholder
  }
  
  return <div>Client-side content</div>
}
```


### 8.2 Mobile Layout Debugging

Resolved mobile layout issues:

```tsx
// components/hero-section.tsx
export default function HeroSection() {
  const isMobile = useMobile()
  
  return (
    <section id="home" className="py-24 mb-12 relative overflow-hidden">
      <div className={`flex flex-col ${isMobile ? "gap-8" : "md:flex-row items-center justify-between gap-12"}`}>
        {/* Content structured differently for mobile vs desktop */}
        <motion.div className="flex-1">
          {/* Text content */}
        </motion.div>
        
        <motion.div className={`flex-shrink-0 ${isMobile ? "mx-auto mt-8" : ""}`}>
          {/* Image with different dimensions based on device */}
          <div className={`${isMobile ? "w-64 h-80" : "w-72 h-96"}`}>
            <Image
              src="/placeholder.svg?height=600&width=450"
              alt="Profile Image"
              fill
              className="object-cover object-center"
            />
          </div>
        </motion.div>
      </div>
    </section>
  )
}
```

### 8.3 Animation Debugging

Fixed animation timing issues:


```tsx
// components/hero-section.tsx
// Use a module-level variable to track if typing has occurred
let hasTyped = false

export default function HeroSection() {
  const typingRef = useRef<HTMLDivElement>(null)
  
  useEffect(() => {
    if (hasTyped) return // Skip if already typed
    hasTyped = true // Mark as done

    const typeText = async () => {
      if (!typingRef.current) return

      // Clear any existing content first
      typingRef.current.textContent = ""

      // Add each character with a delay
      for (let i = 0; i < text.length; i++) {
        if (!typingRef.current) break
        typingRef.current.textContent += text.charAt(i)
        await new Promise((resolve) => setTimeout(resolve, 50))
      }
    }

    // Small delay before starting
    setTimeout(() => {
      typeText()
    }, 500)

    return () => {
      // Cleanup if component unmounts
      if (typingRef.current) {
        typingRef.current.textContent = ""
      }
    }
  }, [])
  
  // Render logic
}
```

## 9. Code Organization and Best Practices

### 9.1 File Structure Organization

Organized files according to Next.js best practices:

```bash
app/                  # Next.js App Router structure
components/           # Shared components
hooks/                # Custom React hooks
lib/                  # Utility functions and shared logic
data/                 # Data files and models
public/               # Static assets
```

### 9.2 Component Naming Conventions

Followed consistent naming conventions:

- PascalCase for component files and function names
- kebab-case for file names
- Descriptive, purpose-based names (e.g., `HeroSection`, `FloatingNav`)
- Suffix patterns for related components (e.g., `-section` for main content sections)

### 9.3 TypeScript Type Definitions

Used TypeScript for type safety

```tsx
// data/projects.ts
export interface Project {
  id: string
  title: string
  description: string
  longDescription: string
  tags: string[]
  image: string
  github: string
  gitlab: string
  demo?: string | null
  features: string[]
  technologies: string[]
}

// Type-safe component props
interface SkillCardProps {
  name: string
  icon: React.ReactNode
  description: string
  level: number
  category: string
}

function SkillCard({ name, icon, description, level, category }: SkillCardProps) {
  // Component implementation
}
```

### 9.4 Code Comments and Documentation

Added meaningful comments for complex logic:

```tsx
// components/animated-background.tsx
useEffect(() => {
  // Only run in browser environment
  if (typeof window === 'undefined') return
  
  const canvas = canvasRef.current
  if (!canvas) return

  const ctx = canvas.getContext("2d")
  if (!ctx) return

  // Set canvas dimensions to match window
  const resizeCanvas = () => {
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
  }

  resizeCanvas()
  window.addEventListener("resize", resizeCanvas)

  // Matrix effect parameters
  const fontSize = isMobile ? 10 : 14
  const columns = Math.floor(canvas.width / fontSize)
  const drops: number[] = []

  // Initialize drops with random starting positions
  for (let i = 0; i < columns; i++) {
    drops[i] = Math.floor(Math.random() * -canvas.height)
  }

  // Characters to display - mix of numbers and Japanese characters
  const chars = "01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン"

  // Animation loop with cleanup
  const interval = setInterval(draw, 50)
  return () => {
    clearInterval(interval)
    window.removeEventListener("resize", resizeCanvas)
  }
}, [isMobile, isDark])
```


## 10. Deployment and Build Process

### 10.1 Next.js Configuration

Configured Next.js for optimal production builds:

```tsx
// next.config.mjs
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  images: {
    domains: ['placeholder.com'],
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**',
      },
    ],
  },
  experimental: {
    optimizePackageImports: ['lucide-react', 'framer-motion'],
  },
};

export default nextConfig;
```

### 10.2 Build Scripts

Set up npm scripts for development and production:

```tsx
// package.json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  }
}
```

### 10.3 Deployment Instructions

Created detailed deployment instructions:

```tsx
// components/setup-instructions.tsx
export default function SetupInstructions() {
  return (
    <div className="mt-8 p-6 bg-slate-950/50 rounded-lg border border-blue-900/30 text-left">
      <h3 className="text-xl font-bold text-blue-400 mb-4">Setup Instructions</h3>

      <div className="terminal-window mb-6">
        <div className="text-blue-500 font-bold mb-2"># Clone the repository</div>
        <div className="terminal-prompt">git clone https://github.com/yourusername/cyber-portfolio.git</div>

        <div className="text-blue-500 font-bold mt-4 mb-2"># Navigate to the project directory</div>
        <div className="terminal-prompt">cd cyber-portfolio</div>

        <div className="text-blue-500 font-bold mt-4 mb-2"># Install dependencies</div>
        <div className="terminal-prompt">npm install</div>

        <div className="text-blue-500 font-bold mt-4 mb-2"># Run the development server</div>
        <div className="terminal-prompt">npm run dev</div>

        <div className="terminal-output">Ready on http://localhost:3000</div>
      </div>

      <h4 className="text-lg font-semibold text-blue-300 mb-2">Deployment</h4>
      <div className="terminal-window">
        <div className="text-blue-500 font-bold mb-2"># Build for production</div>
        <div className="terminal-prompt">npm run build</div>

        <div className="text-blue-500 font-bold mt-4 mb-2"># Deploy to Vercel</div>
        <div className="terminal-prompt">vercel --prod</div>

        <div className="terminal-output">
          ✅ Deployment complete! Your site is live at: https://your-domain.vercel.app
        </div>
      </div>
    </div>
  )
}
```

