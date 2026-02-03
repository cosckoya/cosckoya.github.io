# Web Design Color Best Practices

## UI/UX Color Principles

### Color Hierarchy

**Primary Actions**:
- Use most saturated, contrasting color
- Reserve for critical CTAs (signup, buy, submit)
- Should stand out immediately
- Limit to 1-2 per screen

**Secondary Actions**:
- Less saturated than primary
- Often outlined or ghost buttons
- Support primary actions
- More common, less critical

**Tertiary/Text Links**:
- Subtle, understated
- Often just underlined text
- Minimal visual weight

### The 3-Second Test

Users should understand:
1. What the site is about
2. What action to take
3. Where to focus attention

**Color helps by**:
- Drawing eye to important elements
- Creating visual hierarchy
- Establishing brand identity

## Color in Common UI Elements

### Buttons

**Primary Button**:
```
Background: Brand color (saturated)
Text: White or high-contrast
Hover: 10-15% darker
Active: 20% darker
Disabled: Low saturation, low contrast
```

**Secondary Button**:
```
Background: Transparent or light gray
Border: Brand color
Text: Brand color
Hover: Light background (brand color at 10% opacity)
```

**Danger/Destructive Button**:
```
Background: Red (#DC3545, #F44336)
Text: White
Use: Delete, remove, cancel subscriptions
```

### Links

**Default Link**:
- Blue (#0066CC, #2196F3) - universal convention
- Underlined for accessibility
- Darker on hover

**Visited Link**:
- Purple (#551A8B) - convention
- Lower saturation/brightness

**Active Link**:
- Even darker or different shade

### Forms

**Input Fields**:
```
Border: Light gray (#CCCCCC)
Focus: Brand color border
Error: Red border (#DC3545)
Success: Green border (#28A745)
Disabled: Light gray background
```

**Labels**:
- Dark gray (#333333, #424242)
- Not pure black (too harsh)

**Placeholder Text**:
- Medium gray (#999999, #9E9E9E)
- 40-50% opacity of regular text

**Validation Messages**:
```
Error: Red text, red icon (#DC3545)
Warning: Orange/amber (#FF9800)
Success: Green (#4CAF50)
Info: Blue (#2196F3)
```

### Navigation

**Active/Current Page**:
- Bold, saturated brand color
- Background highlight
- Underline or indicator

**Inactive Links**:
- Lower saturation
- Medium gray or desaturated brand color

**Hover State**:
- Slight color change
- Background highlight
- Underline appears

### Alerts & Notifications

```
Success: Green background (#D4EDDA), dark green text (#155724)
Info: Blue background (#D1ECF1), dark blue text (#0C5460)
Warning: Yellow/amber background (#FFF3CD), dark yellow text (#856404)
Error: Red background (#F8D7DA), dark red text (#721C24)
```

**Best Practices**:
- Use icons alongside color
- Don't rely on color alone (accessibility)
- Consistent across entire site

## Background Colors

### Light Backgrounds
```
Pure white: #FFFFFF (can be harsh)
Off-white: #F8F9FA, #FAFAFA (easier on eyes)
Light gray: #F5F5F5, #EEEEEE (subtle depth)
```

**When to use**:
- Most websites (default)
- Maximum readability
- Professional, clean look

### Dark Backgrounds
```
Near-black: #121212, #1E1E1E (better than pure black)
Dark gray: #212121, #2C2C2C
Dark blue: #1A1A2E, #0F1419
```

**When to use**:
- Modern, sophisticated feel
- Reduce eye strain (dark mode)
- Make colors pop
- Photo/portfolio sites

**Dark Mode Best Practices**:
- Use near-black, not pure black (#000000)
- Reduce white to off-white (#E0E0E0)
- Desaturate colors slightly
- Ensure 15.8:1 contrast minimum for pure white text

### Tinted Backgrounds

**Subtle Brand Integration**:
```
Light blue tint: #F0F8FF
Light green tint: #F1F8F4
Light purple tint: #F8F5FA
```

**Use**: Sections, cards, alternating backgrounds

## Text Colors

### Body Text
```
Dark on light: #333333, #424242 (not pure black)
Light on dark: #E0E0E0, #FAFAFA (not pure white)
```

**Why not pure black/white?**
- Pure black (#000000) is too harsh on white
- Pure white (#FFFFFF) on dark causes eye strain
- 85-90% is more comfortable

### Headings
```
Darker than body: #1A1A1A, #212121
Or: Brand color if appropriate
```

### Secondary Text
```
Labels, captions, metadata:
Light mode: #666666, #757575 (60% opacity)
Dark mode: #AAAAAA, #B0B0B0 (60% opacity)
```

### Disabled Text
- 38% opacity of regular text
- Light gray: #9E9E9E
- Should be obviously not clickable

## Semantic Colors

### Standard Convention
```
Success: Green (#4CAF50, #28A745)
Warning: Orange/Amber (#FF9800, #FFC107)
Error/Danger: Red (#F44336, #DC3545)
Info: Blue (#2196F3, #17A2B8)
```

**Maintain consistency**:
- Use same colors across entire application
- Don't use red for positive actions
- Don't use green for errors

### Color Blindness Considerations

**Red-Green Issues**:
- Never use only red/green to convey info
- Add icons, patterns, or labels
- Use different saturation/lightness

**Alternatives**:
```
Error: Use red + icon + "Error:" label
Success: Use green + checkmark + "Success:" label
```

**Better Color Pairings**:
- Blue/Orange (most color-blind friendly)
- Purple/Yellow
- Avoid: Red/Green, Blue/Purple

## Color in Data Visualization

### Sequential (One Variable)
```
Light to dark of single hue:
#E3F2FD → #90CAF9 → #42A5F5 → #1E88E5 → #1565C0

Use: Temperature, population density, rankings
```

### Diverging (Two Extremes)
```
Cool → Neutral → Warm:
Blue #2196F3 → Gray #9E9E9E → Red #F44336

Use: Above/below average, positive/negative sentiment
```

### Categorical (Distinct Items)
```
Use distinct hues:
#2196F3 (Blue)
#FF9800 (Orange)
#4CAF50 (Green)
#9C27B0 (Purple)
#F44336 (Red)

Use: Categories, different products, user groups
```

**Best Practices**:
- Limit to 7-10 colors max
- Use colorblind-friendly palette
- Ensure sufficient contrast between adjacent colors
- Provide legend/labels

## Gradients in Web Design

### Linear Gradients
```css
/* Subtle depth */
background: linear-gradient(180deg, #FFFFFF 0%, #F5F5F5 100%);

/* Bold statement */
background: linear-gradient(135deg, #667EEA 0%, #764BA2 100%);

/* Analogous colors */
background: linear-gradient(90deg, #2196F3 0%, #00BCD4 100%);
```

### Radial Gradients
```css
/* Spotlight effect */
background: radial-gradient(circle at center, #667EEA 0%, #764BA2 100%);
```

**Best Practices**:
- Keep text readable (ensure contrast)
- Use analogous colors for smooth gradients
- Limit to 2-3 colors
- Test on different screen sizes

### Text on Gradients

**Options**:
1. Use dark overlay: rgba(0,0,0,0.4)
2. Use text shadow: text-shadow: 0 2px 4px rgba(0,0,0,0.5)
3. Ensure lightest part has sufficient contrast
4. Use white text on dark gradients

## Brand Color Application

### Primary Brand Color

**Where to use (60-30-10 rule)**:
```
60% - Not the brand color (usually neutral)
     - Backgrounds, most of the space
     
30% - Brand color (primary)
     - Headers, major sections, important elements
     
10% - Accent color (complementary or analogous)
     - CTAs, highlights, interactive elements
```

**Primary color uses**:
- Logo
- Primary navigation
- CTAs
- Links
- Major headings
- Brand elements

**Don't overuse**:
- Not on every element
- Not as entire background
- Reserve for important elements

### Color Consistency Checklist

**Maintain across**:
- All pages/sections
- Light and dark modes
- Mobile and desktop
- Interactive states (hover, active, focus)
- Error/success states
- Disabled states

## Color Accessibility (WCAG)

### Minimum Requirements

**Text Contrast**:
```
Normal text (< 18pt):
- AA: 4.5:1 minimum
- AAA: 7:1 minimum

Large text (≥ 18pt or 14pt bold):
- AA: 3:1 minimum
- AAA: 4.5:1 minimum

UI Components & Graphics:
- AA: 3:1 minimum
```

### Tools
- WebAIM Contrast Checker
- Stark (Figma plugin)
- Chrome DevTools Accessibility Panel
- Colour Contrast Analyser

### Color Blindness Testing
- Color Oracle (free desktop app)
- Coblis (online simulator)
- Stark plugin (Figma/Sketch)
- Chrome DevTools emulation

## Common Mistakes

**1. Too Many Colors**:
- Limit to 3-5 main colors
- Use shades/tints for variety

**2. Low Contrast**:
- Always test contrast ratios
- Don't use light gray text on white

**3. Pure Black/White**:
- Use #333333 instead of #000000
- Use #FAFAFA instead of #FFFFFF

**4. Inconsistent Semantic Colors**:
- Red should always mean error/danger
- Green should always mean success
- Don't swap meanings

**5. Relying Only on Color**:
- Add icons, labels, patterns
- Critical for accessibility

**6. Wrong Saturation**:
- High saturation = eye strain
- Use desaturated versions for large areas

**7. Fighting Brand Colors**:
- If brand is red, don't use green CTAs
- Work with the brand palette

**8. No Color Hierarchy**:
- Most important = most contrast
- Secondary = less contrast
- Tertiary = subtle

## Responsive Considerations

**Mobile**:
- Higher contrast (bright sunlight)
- Larger touch targets (bigger colored areas)
- Simplify color usage

**Desktop**:
- Can be more subtle
- More colors in data viz
- Hover states matter more

**Print**:
- Convert to CMYK
- Test in grayscale
- Higher contrast needed
