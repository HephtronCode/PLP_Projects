"""
Superhero Class Implementation
This module demonstrates object-oriented programming concepts including:
- Inheritance
- Polymorphism
- Encapsulation
"""

class Superhero:
    """
    A base class representing a superhero with basic attributes and methods.
    
    Attributes:
        name (str): The superhero's public name
        power (str): The superhero's primary power
        _secret_identity (str): The superhero's secret identity (private)
    """
    def __init__(self, name: str, power: str, secret_identity: str):
        """
        Initialize a new Superhero instance.
        
        Args:
            name (str): The superhero's public name
            power (str): The superhero's primary power
            secret_identity (str): The superhero's secret identity
        """
        self.name = name
        self.power = power
        self._secret_identity = secret_identity  # Private attribute

    def display_details(self) -> None:
        """Display the superhero's public information."""
        print(f"\nSuperhero Details:")
        print(f"Name: {self.name}")
        print(f"Power: {self.power}")

    def display_secret(self) -> None:
        """Display the superhero's secret identity."""
        print(f"Secret Identity: {self._secret_identity}")


class MarvelSuperhero(Superhero):
    """
    A subclass of Superhero representing Marvel universe characters.
    
    Attributes:
        marvel_power (str): A unique power specific to Marvel superheroes
    """
    def __init__(self, name: str, power: str, secret_identity: str, marvel_power: str):
        """
        Initialize a new MarvelSuperhero instance.
        
        Args:
            name (str): The superhero's public name
            power (str): The superhero's primary power
            secret_identity (str): The superhero's secret identity
            marvel_power (str): A unique power specific to Marvel superheroes
        """
        super().__init__(name, power, secret_identity)
        self.marvel_power = marvel_power

    def display_details(self) -> None:
        """Override the display_details method to include Marvel-specific power."""
        super().display_details()
        print(f"Marvel Power: {self.marvel_power}")


def main():
    """Main function to demonstrate the superhero classes."""
    # Create and display DC superhero
    print("\n=== DC Superhero ===")
    wonder_woman = Superhero("Wonder Woman", "Superhuman Strength", "Diana Prince")
    wonder_woman.display_details()
    wonder_woman.display_secret()

    # Create and display Marvel superhero
    print("\n=== Marvel Superhero ===")
    iron_man = MarvelSuperhero("Iron Man", "Genius Billionaire", "Tony Stark", "Repulsor")
    iron_man.display_details()
    iron_man.display_secret()


if __name__ == "__main__":
    main()