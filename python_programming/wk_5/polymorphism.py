"""
Vehicle Polymorphism Example
This module demonstrates polymorphism using different types of vehicles,
where each vehicle type implements the move() method differently.
"""

class Vehicle:
    """
    Base class for all vehicles.
    
    This class serves as the parent class for different types of vehicles,
    providing a common interface through the move() method.
    """

    def move(self) -> str:
        """Base movement method for vehicles."""
        return "Moving"


class Car(Vehicle):
    """
    A class representing a car.
    
    Inherits from Vehicle and overrides the move() method
    to provide car-specific movement.
    """

    def move(self) -> str:
        """Return car-specific movement description."""
        return "Driving 🚗"


class Plane(Vehicle):
    """
    A class representing a plane.
    
    Inherits from Vehicle and overrides the move() method
    to provide plane-specific movement.
    """

    def move(self) -> str:
        """Return plane-specific movement description."""
        return "Flying ✈️"


class Train(Vehicle):
    """
    A class representing a train.
    
    Inherits from Vehicle and overrides the move() method
    to provide train-specific movement.
    """

    def move(self) -> str:
        """Return train-specific movement description."""
        return "Chugging 🚂"


def main():
    """Demonstrate polymorphism with different vehicles."""
    # Create instances of different vehicles
    vehicles = [
        Car(),
        Plane(),
        Train()
    ]

    # Demonstrate polymorphic behavior
    print("\n=== Vehicle Movement Demonstration ===")
    for vehicle in vehicles:
        print(f"{vehicle.__class__.__name__}: {vehicle.move()}")


if __name__ == "__main__":
    main()