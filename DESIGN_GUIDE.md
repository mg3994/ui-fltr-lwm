# LinkWithMentor - Premium UI Design Guide

## 🎨 Design System Overview

This document outlines the premium design patterns and components used throughout the LinkWithMentor application.

---

## 📐 Layout Patterns

### **Screen Structure**
```
AppBar (with actions)
  ↓
Animated Header Card (gradient + stats)
  ↓
Section Title
  ↓
Animated List Items (staggered)
  ↓
FloatingActionButton (optional)
```

### **Card Hierarchy**
1. **Hero Card** - Top stats/progress card with gradient
2. **Content Cards** - Main list items with animations
3. **Detail Cards** - Nested information within content cards

---

## 🎭 Animation Recipes

### **1. Entry Animation (Fade + Slide)**
```dart
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0.0, end: 1.0),
  duration: Duration(milliseconds: 400 + (index * 100)),
  curve: Curves.easeOut,
  builder: (context, value, child) {
    return Opacity(
      opacity: value,
      child: Transform.translate(
        offset: Offset(0, 20 * (1 - value)),
        child: child,
      ),
    );
  },
  child: YourWidget(),
);
```

### **2. Scale Animation (Bounce)**
```dart
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0.0, end: 1.0),
  duration: const Duration(milliseconds: 800),
  curve: Curves.easeOutBack,
  builder: (context, value, child) {
    return Transform.scale(
      scale: 0.95 + (0.05 * value),
      child: Opacity(
        opacity: value,
        child: child,
      ),
    );
  },
  child: YourWidget(),
);
```

### **3. Progress Animation**
```dart
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0.0, end: targetProgress),
  duration: const Duration(milliseconds: 1200),
  curve: Curves.easeOut,
  builder: (context, value, _) {
    return LinearProgressIndicator(
      value: value,
      minHeight: 12,
      // ... styling
    );
  },
);
```

---

## 🎨 Color Patterns

### **Gradient Backgrounds**
```dart
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(24),
  gradient: LinearGradient(
    colors: [
      Theme.of(context).colorScheme.primaryContainer,
      Theme.of(context).colorScheme.secondaryContainer,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
),
```

### **Icon Backgrounds (Circular)**
```dart
Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: color.withValues(alpha: 0.15),
    shape: BoxShape.circle,
  ),
  child: Icon(icon, color: color, size: 28),
)
```

### **Glowing Effect (Unlocked Items)**
```dart
boxShadow: [
  BoxShadow(
    color: color.withValues(alpha: 0.3),
    blurRadius: 12,
    spreadRadius: 2,
  ),
]
```

---

## 📦 Component Patterns

### **Premium Card**
```dart
Card(
  elevation: 4,
  shadowColor: color.withValues(alpha: 0.3),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
    side: BorderSide(
      color: color.withValues(alpha: 0.3),
      width: 2,
    ),
  ),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      gradient: LinearGradient(...),
    ),
    padding: const EdgeInsets.all(24),
    child: // Content
  ),
)
```

### **Stat Column**
```dart
Column(
  children: [
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 28),
    ),
    const Gap(12),
    Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
    const Gap(4),
    Text(label, style: TextStyle(fontSize: 12, color: onSurfaceVariant)),
  ],
)
```

### **Progress Indicator (Rounded)**
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: LinearProgressIndicator(
    value: progress,
    minHeight: 8,
    backgroundColor: surfaceContainerHighest,
    valueColor: AlwaysStoppedAnimation<Color>(color),
  ),
)
```

### **Badge/Tag**
```dart
Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  decoration: BoxDecoration(
    color: color.withValues(alpha: 0.15),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: color.withValues(alpha: 0.3),
    ),
  ),
  child: Text(
    label,
    style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      color: color,
    ),
  ),
)
```

---

## 🎯 State Indicators

### **Unlocked State**
- ✅ Full color saturation
- ✅ Glowing box shadow
- ✅ Gradient background
- ✅ Colored border (2px)
- ✅ Check icon + date

### **Locked State**
- ⏳ Reduced opacity/grayscale
- ⏳ No shadow
- ⏳ No gradient
- ⏳ Gray border (1px)
- ⏳ Progress bar + percentage

---

## 📏 Spacing Scale

```
4px   - Tiny gaps (icon to text)
8px   - Small gaps (related elements)
12px  - Medium gaps (card sections)
16px  - Large gaps (major sections)
20px  - XL gaps (card padding)
24px  - XXL gaps (screen padding)
32px  - Section separators
```

---

## 🔤 Typography Scale

```
28px - Page headers (Bold)
20px - Section headers (Bold)
18px - Card titles (Bold)
16px - Subheadings (Bold/SemiBold)
14px - Body text (Regular)
13px - Secondary text (Regular)
12px - Captions (Medium)
11px - Labels/Tags (Bold)
```

---

## 🎨 Icon Sizes

```
16px - Small inline icons
20px - List item icons
24px - Standard icons
28px - Stat icons
32px - Large feature icons
40px - Hero icons
48px - Extra large icons
```

---

## 🌈 Color Usage

### **Primary Color**
- Main actions
- Progress indicators
- Active states
- Important icons

### **Secondary Color**
- Supporting actions
- Gradients
- Accents

### **Success (Green)**
- Unlocked items
- Completed states
- Positive metrics

### **Warning (Orange)**
- In-progress items
- Attention needed
- Medium priority

### **Error (Red)**
- Locked items
- Errors
- High priority

### **Info (Blue)**
- Informational
- Default states
- Neutral actions

---

## 🎭 Micro-interactions

### **Button Press**
- Scale down to 0.95
- Slight opacity change
- Haptic feedback (mobile)

### **Card Tap**
- Ripple effect
- Slight elevation change
- Smooth navigation

### **Toggle**
- Smooth slide animation
- Color transition
- Icon rotation/change

---

## 📱 Responsive Considerations

### **Padding Adjustments**
```dart
EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? 24 : 16)
```

### **Font Scaling**
```dart
fontSize: MediaQuery.of(context).size.width > 600 ? 20 : 18
```

### **Grid Columns**
```dart
crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2
```

---

## ✨ Premium Touches

1. **Smooth Animations** - Everything animates smoothly
2. **Consistent Timing** - 400-800ms for most animations
3. **Staggered Delays** - 100ms increments for lists
4. **Color Harmony** - Theme-based color system
5. **Visual Feedback** - Clear state changes
6. **Attention to Detail** - Rounded corners, shadows, gradients
7. **Performance** - Optimized animations and rebuilds

---

## 🚀 Implementation Checklist

When creating a new screen:

- [ ] Add animated header card with gradient
- [ ] Implement staggered list animations
- [ ] Use consistent card styling (rounded corners, elevation)
- [ ] Add progress indicators where applicable
- [ ] Include state-based visual changes
- [ ] Apply proper spacing (20-24px padding)
- [ ] Use theme colors consistently
- [ ] Add micro-animations for interactions
- [ ] Test in both light and dark modes
- [ ] Verify accessibility (contrast ratios)

---

**Remember**: Premium UI is about consistency, attention to detail, and smooth interactions. Every element should feel intentional and polished.
