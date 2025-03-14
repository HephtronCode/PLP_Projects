firstNumber = int(input("Enter your first number: "))
secondNumber = int(input("Enter your second number: "))
operator = input("Enter your operator: ")

if operator == "+":
    print(firstNumber + secondNumber)
elif operator == "-":
    print(firstNumber - secondNumber)
elif operator == "*":
    print(firstNumber * secondNumber)
elif operator == "/":
    print(firstNumber / secondNumber)
else:
    print("Invalid operator")