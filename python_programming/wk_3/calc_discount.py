# get the original price and discount percentage from the user
# and calculate the final price after applying the discount
original_price = float(input("Enter the original price of the item: "))
discount_input = float(input("Enter the discount percentage: "))

def calculate_discount(price, discount_percent): 
    """
    Calculate the final price after applying a discount.
<<<<<<< HEAD
    :param price: Original price of the item
    :param discount_percent: Discount percentage to apply
=======
    :param price: Original price of the item"
    "param discount_percent: Discount percentage to apply
>>>>>>> e45588157e799c6409eeee6fe7883c75ce492e7f
    :return: Final price after discount
    """
    if discount_percent >= 20:
        discount_amount = price * (discount_percent / 100)
        final_price = price - discount_amount
<<<<<<< HEAD
        print(f"Discount amount: {discount_amount:.2f}")
        print(f"Final price after discount: {final_price:.2f}")
    else:
        print("Discount percentage is less than 20%. No discount applied.")
        final_price = price
    return final_price

# Call the function and display the result
final_price = calculate_discount(original_price, discount_input)
print(f"The final price returned by the function is: {final_price:.2f}")
=======
        return final_price
    else:
        return price
>>>>>>> e45588157e799c6409eeee6fe7883c75ce492e7f
