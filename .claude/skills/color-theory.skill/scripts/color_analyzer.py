#!/usr/bin/env python3
"""
Color analysis and scheme generation utilities.
Analyzes color palettes and generates harmonious color schemes.
"""

import colorsys
import re
from typing import List, Tuple, Dict


def hex_to_rgb(hex_color: str) -> Tuple[int, int, int]:
    """Convert hex color to RGB tuple."""
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))


def rgb_to_hex(rgb: Tuple[int, int, int]) -> str:
    """Convert RGB tuple to hex color."""
    return '#{:02x}{:02x}{:02x}'.format(*rgb)


def rgb_to_hsl(rgb: Tuple[int, int, int]) -> Tuple[float, float, float]:
    """Convert RGB to HSL."""
    r, g, b = [x / 255.0 for x in rgb]
    h, l, s = colorsys.rgb_to_hls(r, g, b)
    return (h * 360, s * 100, l * 100)


def hsl_to_rgb(hsl: Tuple[float, float, float]) -> Tuple[int, int, int]:
    """Convert HSL to RGB."""
    h, s, l = hsl[0] / 360, hsl[1] / 100, hsl[2] / 100
    r, g, b = colorsys.hls_to_rgb(h, l, s)
    return (int(r * 255), int(g * 255), int(b * 255))


def get_color_temperature(hue: float) -> str:
    """Determine if color is warm, cool, or neutral based on hue."""
    if 0 <= hue < 60 or 300 < hue <= 360:
        return "warm"
    elif 60 <= hue < 180:
        return "neutral-warm"
    elif 180 <= hue <= 300:
        return "cool"
    return "neutral"


def analyze_color(hex_color: str) -> Dict:
    """Analyze a single color and return its properties."""
    rgb = hex_to_rgb(hex_color)
    h, s, l = rgb_to_hsl(rgb)
    
    # Determine color characteristics
    saturation_level = "desaturated" if s < 30 else "moderate" if s < 70 else "vibrant"
    lightness_level = "dark" if l < 30 else "medium" if l < 70 else "light"
    temperature = get_color_temperature(h)
    
    # Color name approximation
    color_name = get_color_name(h, s, l)
    
    return {
        "hex": hex_color,
        "rgb": rgb,
        "hsl": (round(h), round(s), round(l)),
        "hue": round(h),
        "saturation": round(s),
        "lightness": round(l),
        "temperature": temperature,
        "saturation_level": saturation_level,
        "lightness_level": lightness_level,
        "color_name": color_name
    }


def get_color_name(h: float, s: float, l: float) -> str:
    """Approximate color name based on HSL values."""
    if s < 10:
        if l < 20:
            return "black"
        elif l < 40:
            return "dark gray"
        elif l < 60:
            return "gray"
        elif l < 80:
            return "light gray"
        else:
            return "white"
    
    # Hue-based names
    if 0 <= h < 15 or 345 <= h <= 360:
        base = "red"
    elif 15 <= h < 45:
        base = "orange"
    elif 45 <= h < 75:
        base = "yellow"
    elif 75 <= h < 165:
        base = "green"
    elif 165 <= h < 255:
        base = "blue"
    elif 255 <= h < 285:
        base = "purple"
    elif 285 <= h < 345:
        base = "pink" if l > 50 else "magenta"
    else:
        base = "unknown"
    
    # Add lightness modifier
    if l < 30:
        return f"dark {base}"
    elif l > 70:
        return f"light {base}"
    else:
        return base


def generate_complementary(hex_color: str) -> str:
    """Generate complementary color."""
    h, s, l = rgb_to_hsl(hex_to_rgb(hex_color))
    comp_hue = (h + 180) % 360
    return rgb_to_hex(hsl_to_rgb((comp_hue, s, l)))


def generate_analogous(hex_color: str, angle: int = 30) -> List[str]:
    """Generate analogous color scheme."""
    h, s, l = rgb_to_hsl(hex_to_rgb(hex_color))
    return [
        hex_color,
        rgb_to_hex(hsl_to_rgb(((h - angle) % 360, s, l))),
        rgb_to_hex(hsl_to_rgb(((h + angle) % 360, s, l)))
    ]


def generate_triadic(hex_color: str) -> List[str]:
    """Generate triadic color scheme."""
    h, s, l = rgb_to_hsl(hex_to_rgb(hex_color))
    return [
        hex_color,
        rgb_to_hex(hsl_to_rgb(((h + 120) % 360, s, l))),
        rgb_to_hex(hsl_to_rgb(((h + 240) % 360, s, l)))
    ]


def generate_split_complementary(hex_color: str) -> List[str]:
    """Generate split-complementary color scheme."""
    h, s, l = rgb_to_hsl(hex_to_rgb(hex_color))
    comp_hue = (h + 180) % 360
    return [
        hex_color,
        rgb_to_hex(hsl_to_rgb(((comp_hue - 30) % 360, s, l))),
        rgb_to_hex(hsl_to_rgb(((comp_hue + 30) % 360, s, l)))
    ]


def generate_tetradic(hex_color: str) -> List[str]:
    """Generate tetradic (rectangle) color scheme."""
    h, s, l = rgb_to_hsl(hex_to_rgb(hex_color))
    return [
        hex_color,
        rgb_to_hex(hsl_to_rgb(((h + 60) % 360, s, l))),
        rgb_to_hex(hsl_to_rgb(((h + 180) % 360, s, l))),
        rgb_to_hex(hsl_to_rgb(((h + 240) % 360, s, l)))
    ]


def generate_monochromatic(hex_color: str, count: int = 5) -> List[str]:
    """Generate monochromatic color scheme with varying lightness."""
    h, s, l = rgb_to_hsl(hex_to_rgb(hex_color))
    colors = []
    
    for i in range(count):
        # Distribute lightness from dark to light
        new_l = 20 + (i * (80 / (count - 1))) if count > 1 else l
        colors.append(rgb_to_hex(hsl_to_rgb((h, s, new_l))))
    
    return colors


def calculate_contrast_ratio(color1: str, color2: str) -> float:
    """Calculate WCAG contrast ratio between two colors."""
    def get_luminance(rgb):
        """Calculate relative luminance."""
        rgb_norm = [x / 255.0 for x in rgb]
        rgb_linear = [
            x / 12.92 if x <= 0.03928 else ((x + 0.055) / 1.055) ** 2.4
            for x in rgb_norm
        ]
        return 0.2126 * rgb_linear[0] + 0.7152 * rgb_linear[1] + 0.0722 * rgb_linear[2]
    
    l1 = get_luminance(hex_to_rgb(color1))
    l2 = get_luminance(hex_to_rgb(color2))
    
    lighter = max(l1, l2)
    darker = min(l1, l2)
    
    return (lighter + 0.05) / (darker + 0.05)


def check_wcag_compliance(foreground: str, background: str) -> Dict:
    """Check if color combination meets WCAG standards."""
    ratio = calculate_contrast_ratio(foreground, background)
    
    return {
        "ratio": round(ratio, 2),
        "AA_normal": ratio >= 4.5,
        "AA_large": ratio >= 3.0,
        "AAA_normal": ratio >= 7.0,
        "AAA_large": ratio >= 4.5
    }


def extract_colors_from_css(css_text: str) -> List[str]:
    """Extract hex colors from CSS text."""
    hex_pattern = r'#[0-9A-Fa-f]{6}|#[0-9A-Fa-f]{3}'
    colors = re.findall(hex_pattern, css_text)
    # Expand 3-digit hex to 6-digit
    expanded = []
    for color in colors:
        if len(color) == 4:  # #RGB
            expanded.append('#' + ''.join([c*2 for c in color[1:]]))
        else:
            expanded.append(color.upper())
    return list(set(expanded))  # Remove duplicates


if __name__ == "__main__":
    # Example usage
    test_color = "#2196F3"
    
    print(f"Analyzing color: {test_color}")
    analysis = analyze_color(test_color)
    print(f"Color name: {analysis['color_name']}")
    print(f"HSL: H={analysis['hue']}° S={analysis['saturation']}% L={analysis['lightness']}%")
    print(f"Temperature: {analysis['temperature']}")
    
    print(f"\nComplementary: {generate_complementary(test_color)}")
    print(f"Analogous: {generate_analogous(test_color)}")
    print(f"Triadic: {generate_triadic(test_color)}")
    
    # Test contrast
    contrast = check_wcag_compliance(test_color, "#FFFFFF")
    print(f"\nContrast with white: {contrast['ratio']}:1")
    print(f"AA compliant (normal text): {contrast['AA_normal']}")
