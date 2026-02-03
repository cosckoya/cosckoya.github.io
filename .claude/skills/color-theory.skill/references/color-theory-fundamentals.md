# Color Theory Fundamentals

## Color Models

### RGB (Additive)
- **Red, Green, Blue** - Light-based (screens)
- Values: 0-255 per channel
- Hex: #RRGGBB (e.g., #FF5733)
- Use: Digital displays, web, apps

### HSL (Hue, Saturation, Lightness)
- **Hue**: 0-360° (color wheel position)
- **Saturation**: 0-100% (color intensity)
- **Lightness**: 0-100% (light/dark)
- Use: Easier color manipulation, creating schemes

### HSV/HSB (Hue, Saturation, Value/Brightness)
- Similar to HSL but Value ≠ Lightness
- Value: brightness of pure color
- Use: Design tools (Photoshop, Sketch)

### CMYK (Subtractive)
- **Cyan, Magenta, Yellow, Black** - Ink-based
- Values: 0-100% per channel
- Use: Print materials only

### LAB Color Space
- **L**: Lightness (0-100)
- **a**: Green to Red (-128 to +127)
- **b**: Blue to Yellow (-128 to +127)
- Use: Perceptually uniform, accurate color matching

## Color Wheel

### Primary Colors
- **RGB**: Red, Green, Blue (light)
- **RYB**: Red, Yellow, Blue (traditional/pigment)
- Cannot be created by mixing other colors

### Secondary Colors
- Created by mixing two primaries
- **RGB**: Cyan (G+B), Magenta (R+B), Yellow (R+G)
- **RYB**: Orange (R+Y), Green (Y+B), Purple (R+B)

### Tertiary Colors
- Primary + Adjacent Secondary
- Examples: Red-Orange, Yellow-Green, Blue-Violet

## Color Properties

### Hue
- The pure color (position on color wheel)
- What we name: "red," "blue," "yellow"

### Saturation (Chroma/Intensity)
- Purity of color
- High saturation = vivid, pure
- Low saturation = muted, grayed
- 0% = grayscale

### Lightness/Value/Brightness
- Amount of light in color
- Light = tints (+ white)
- Dark = shades (+ black)
- Muted = tones (+ gray)

### Temperature
- **Warm colors**: Red, Orange, Yellow (energetic, advancing)
- **Cool colors**: Blue, Green, Purple (calming, receding)
- **Neutral**: Black, White, Gray, Beige

## Color Contrast

### Types of Contrast

**1. Hue Contrast**
- Different hues (red vs. blue)
- Strongest with complementary colors

**2. Saturation Contrast**
- Vivid vs. muted colors
- Creates depth and focus

**3. Lightness/Value Contrast**
- Light vs. dark
- Most important for readability
- WCAG requires minimum 4.5:1 for text

**4. Temperature Contrast**
- Warm vs. cool
- Creates visual interest

**5. Complementary Contrast**
- Opposite colors on wheel
- Maximum visual vibration

### Accessibility (WCAG Standards)

**Contrast Ratios:**
- **Normal text**: 4.5:1 minimum (AA), 7:1 (AAA)
- **Large text** (18pt+): 3:1 minimum (AA), 4.5:1 (AAA)
- **UI components**: 3:1 minimum

**Color Blindness Types:**
- **Protanopia**: Red-blind (~1% males)
- **Deuteranopia**: Green-blind (~1% males)
- **Tritanopia**: Blue-blind (rare)
- **Achromatopsia**: Total color blindness (very rare)

**Accessibility Best Practices:**
- Don't rely on color alone for information
- Use patterns, icons, labels alongside color
- Test with color blindness simulators
- Ensure sufficient contrast
- Avoid red/green as only differentiators
