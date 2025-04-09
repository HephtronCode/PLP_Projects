# Ask user to enter file Name
# Read a file

# Modify its contents (maybe uppercase it, add line numbers, etc.)

# Write it into a new file

user_input = input('Enter a file name: ')

try:
    # Open the file for reading
    with open(user_input, 'r') as file:
        lines = file.readlines()
        print('File read successfully')

    # Modify the file contents to uppercase with line numbers
    with open(user_input, 'w') as file:
        for i, line in enumerate(lines, 1):
            file.write(f'{i}: {line.upper()}')
        print('File modified successfully')

    # Write the modified contents into a new output file
    with open('output.txt', 'w') as file:
        for i, line in enumerate(lines, 1):
            file.write(f'{i}: {line.upper()}')
        print('File written into output.txt successfully')

except FileNotFoundError:
    print('File not found')

except Exception as e:
    print(f'An error occurred: {e}')