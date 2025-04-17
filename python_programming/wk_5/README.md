# Python OOP Examples

This repository contains two Python files demonstrating Object-Oriented Programming (OOP) concepts through practical examples.

## 🚗 Vehicle Polymorphism (`polymorphism.py`)

This file demonstrates the concept of polymorphism using different types of vehicles. Each vehicle type implements the `move()` method differently while maintaining a common interface.

### Features:
- Base `Vehicle` class with a common `move()` method
- Three derived classes: `Car`, `Plane`, and `Train`
- Each vehicle type has its own unique movement description
- Demonstrates runtime polymorphism through method overriding

### Example Output:
```
=== Vehicle Movement Demonstration ===
Car: Driving 🚗
Plane: Flying ✈️
Train: Chugging 🚂
```

## 🦸‍♂️ Superhero Implementation (`superhero.py`)

This file showcases various OOP concepts using a superhero-themed example, including inheritance, polymorphism, and encapsulation.

### Features:
- Base `Superhero` class with public and private attributes
- `MarvelSuperhero` subclass demonstrating inheritance
- Encapsulation through private attributes (using `_` prefix)
- Method overriding and super() usage
- Type hints for better code documentation

### Example Output:
```
=== DC Superhero ===
Superhero Details:
Name: Wonder Woman
Power: Superhuman Strength
Secret Identity: Diana Prince

=== Marvel Superhero ===
Superhero Details:
Name: Iron Man
Power: Genius Billionaire
Marvel Power: Repulsor
Secret Identity: Tony Stark
```

## 🚀 Getting Started

1. Clone this repository
2. Run either file using Python 3.x:
   ```bash
   python polymorphism.py
   # or
   python superhero.py
   ```

## 📚 Learning Points

These examples demonstrate several key OOP concepts:
- Inheritance
- Polymorphism
- Encapsulation
- Method Overriding
- Type Hints
- Private Attributes
- Super() Method Usage

## 🛠️ Requirements

- Python 3.x
- No external dependencies required
