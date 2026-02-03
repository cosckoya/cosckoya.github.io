---
name: color-theory
description: Expert guidance on color theory, color psychology, emotional associations, color schemes, harmonies, accessibility, and web design color best practices. Use when users ask about (1) color meanings, psychology, or emotions, (2) creating color schemes or palettes for websites/brands/designs, (3) color harmony types (monochromatic, analogous, complementary, triadic, etc.), (4) analyzing existing color palettes or site colors, (5) color accessibility and WCAG compliance, (6) industry-specific color strategies, (7) cultural color meanings, (8) improving color contrast or readability, (9) semantic colors for UI (success, error, warning), (10) color best practices for specific design contexts.
---

# Color Theory Expert

## Quick Start

For any color-related query, determine the type of assistance needed:

1. **Color analysis** → Use `scripts/color_analyzer.py` to analyze hex colors, generate schemes, check contrast
2. **Theory questions** → Reference `references/color-theory-fundamentals.md` for technical concepts
3. **Psychology/emotions** → Reference `references/color-psychology.md` for meanings and associations
4. **Scheme creation** → Reference `references/color-schemes.md` for harmony types and patterns
5. **Web/UI design** → Reference `references/web-design-best-practices.md` for practical application

## Core Capabilities

### 1. Color Scheme Generation

Generate harmonious color schemes using established color theory:

**Available harmony types**:
- **Monochromatic**: Single hue with varying lightness/saturation
- **Analogous**: 3-5 adjacent colors (30-60° apart)
- **Complementary**: Opposite colors (180° apart) for maximum contrast
- **Split-complementary**: Base + two colors adjacent to complement
- **Triadic**: Three evenly spaced colors (120° apart)
- **Tetradic**: Two complementary pairs (rectangle/square)
- **Accented neutral**: Neutral base with one vibrant accent

Use the Python script for algorithmic generation:
```bash
python scripts/color_analyzer.py
```

For manual creation, reference `references/color-schemes.md` for detailed formulas and examples.

### 2. Color Psychology Analysis

Provide emotional associations and psychological impact:

- Individual color meanings (red = urgency, blue = trust, etc.)
- Industry-specific color strategies (tech, healthcare, food, finance, etc.)
- Cultural considerations (Western vs. Eastern interpretations)
- Contextual meanings (time of day, seasons, gender associations)
- Emotional response patterns (calming, energetic, luxury, professional)

Reference `references/color-psychology.md` for comprehensive associations.

### 3. Color Accessibility & Compliance

Check and ensure WCAG compliance:

**Contrast requirements**:
- Normal text: 4.5:1 (AA), 7:1 (AAA)
- Large text: 3:1 (AA), 4.5:1 (AAA)
- UI components: 3:1 minimum

**Color blindness considerations**:
- Protanopia (red-blind), Deuteranopia (green-blind), Tritanopia (blue-blind)
- Never rely on color alone for information
- Use patterns, icons, labels alongside color
- Test with simulators (Color Oracle, Stark)

Use `scripts/color_analyzer.py` to calculate contrast ratios programmatically.

### 4. Site/Brand Color Analysis

Analyze existing color palettes:

1. **Extract colors** from CSS, screenshots, or hex codes
2. **Identify scheme type** (monochromatic, analogous, complementary, etc.)
3. **Assess psychology** (emotions conveyed, industry fit)
4. **Check accessibility** (contrast ratios, color blindness issues)
5. **Recommend improvements** (better contrast, more harmonious alternatives)

The Python script includes `extract_colors_from_css()` for automated extraction.

### 5. Web/UI Design Guidance

Apply color theory to practical web design:

- **UI elements**: Buttons, links, forms, navigation, alerts
- **Color hierarchy**: Primary/secondary/tertiary actions
- **60-30-10 rule**: Balanced color distribution
- **Semantic colors**: Success (green), error (red), warning (orange), info (blue)
- **Text colors**: Body text, headings, disabled states
- **Backgrounds**: Light/dark mode, tinted backgrounds
- **Responsive considerations**: Mobile vs. desktop

Reference `references/web-design-best-practices.md` for detailed UI patterns.

## Workflow for Color Scheme Requests

When user asks: *"Help me create a color scheme for my [type] website"*

**Step 1**: Understand context
- Industry/purpose (e-commerce, SaaS, blog, portfolio, etc.)
- Target emotion (professional, playful, calming, energetic, etc.)
- Target audience (children, professionals, luxury consumers, etc.)
- Existing brand colors (if any)

**Step 2**: Read relevant references
```bash
# Always read these for comprehensive understanding
view references/color-psychology.md
view references/color-schemes.md
view references/web-design-best-practices.md
```

**Step 3**: Recommend scheme type
- Match harmony type to goals (complementary for bold, analogous for calm, etc.)
- Consider industry norms (blue for tech/finance, green for health/eco, etc.)

**Step 4**: Generate specific palette
- Provide hex codes for primary, secondary, accent, neutrals
- Include shades/tints for each (light, medium, dark variants)
- Specify usage (60% backgrounds, 30% main content, 10% CTAs)

**Step 5**: Validate accessibility
- Use Python script to check contrast ratios
- Ensure WCAG AA compliance minimum
- Note any color blindness concerns

**Step 6**: Provide implementation guidance
- CSS variables/Tailwind config
- Usage examples (button colors, text colors, backgrounds)
- Hover/active/disabled states

## Best Practices

**Always provide**:
- Specific hex codes (not just color names)
- Multiple shades/variants (3-5 per color)
- Accessibility notes (contrast ratios)
- Psychological rationale (why these colors work)
- Practical usage guidance (what goes where)

**Consider context**:
- Industry conventions (don't fight established norms unnecessarily)
- Cultural audience (Western vs. Eastern interpretations vary)
- Use case (app vs. website vs. presentation vs. print)
- Accessibility requirements (medical/government sites need AAA)

**Avoid common mistakes**:
- Too many colors (limit to 3-5 main colors)
- Pure black on white (use #333 on #FFF instead)
- Low contrast (always check ratios)
- Relying on color alone (use icons/labels too)
- Inconsistent semantic colors (green should always mean success)

## Reference Documentation

**Technical foundations**: `references/color-theory-fundamentals.md`
- Color models (RGB, HSL, CMYK)
- Color wheel structure
- Properties (hue, saturation, lightness)
- Contrast types and accessibility standards

**Psychological impact**: `references/color-psychology.md`
- Individual color meanings and emotions
- Industry-specific strategies
- Cultural considerations
- Contextual interpretations

**Harmony types**: `references/color-schemes.md`
- All harmony types with formulas
- Modern patterns (duotone, gradients, Material Design)
- 60-30-10 rule application
- Selection guide by goal

**Web design**: `references/web-design-best-practices.md`
- UI element colors (buttons, forms, navigation)
- Text and background colors
- Semantic colors
- Responsive considerations

## Python Tools

**Color analyzer script**: `scripts/color_analyzer.py`

Capabilities:
- Analyze hex colors (RGB, HSL, properties, temperature)
- Generate all harmony types algorithmically
- Calculate WCAG contrast ratios
- Check accessibility compliance
- Extract colors from CSS text
- Convert between color formats

Usage examples:
```python
from scripts.color_analyzer import *

# Analyze a color
analysis = analyze_color("#2196F3")
print(analysis['color_name'])  # "blue"
print(analysis['temperature'])  # "cool"

# Generate schemes
complementary = generate_complementary("#2196F3")
triadic = generate_triadic("#2196F3")
monochromatic = generate_monochromatic("#2196F3", count=5)

# Check accessibility
contrast = check_wcag_compliance("#2196F3", "#FFFFFF")
print(f"Contrast ratio: {contrast['ratio']}:1")
print(f"AA compliant: {contrast['AA_normal']}")
```

## Common Query Patterns

**"What colors should I use for [industry]?"**
→ Read `color-psychology.md` industry section, provide 3-5 color palette with rationale

**"Generate a [harmony type] scheme"**
→ Use Python script or manual formula from `color-schemes.md`, provide hex codes and usage

**"Is this color combination accessible?"**
→ Use Python script to calculate contrast, check against WCAG standards

**"What does [color] mean/convey?"**
→ Reference `color-psychology.md` for psychological associations and cultural meanings

**"Improve the colors on my site"**
→ Analyze current palette, identify issues (contrast, harmony, psychology), recommend specific changes

**"Color scheme for [emotion/goal]"**
→ Match emotion to color psychology, select appropriate harmony type, generate specific palette
