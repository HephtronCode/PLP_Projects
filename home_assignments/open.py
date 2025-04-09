#  Challenge: Create a program that reads a text file, processes its content, and writes the results to a new file.

# 📌 Task Requirements:
# Create a file called input.txt and write at least five lines of text into it.
# Write a Python script to:
# Read the contents of input.txt.
# Count the number of words in the file.
# Convert all text to uppercase.
# Write the processed text and the word count to a new file called output.txt.
# Print a success message once the new file is created.

# Read the contents of input.txt
try:
    with open("home_assignments/input.txt", 'r') as file:
        content = file.readlines()
        print("File read successfully.")

    # Count the number of words in the file
    word_count = sum(len(content.split()) for content in content)
    print(f"Word count: {word_count}")

    # Convert all text to uppercase
    content_upper = [content.upper() for content in content]
    print("Text converted to uppercase.")

    # Write the processed text and the word count to a new file called output.txt
    with open("home_assignments/output.txt", 'w') as output_file:
        output_file.write(f"Word Count: {word_count}\n")
        output_file.write("Processed Text:\n")
        output_file.writelines(content_upper)
    print("Processed text and word count written to output.txt.")
# Print a success message once the new file is created
    print("Success: output.txt created.")

except FileNotFoundError:
    print("Error: input.txt file not found.")