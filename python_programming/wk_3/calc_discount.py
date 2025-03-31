# get the original price and discount percentage from the user
# and calculate the final price after applying the discount
original_price = float(input("Enter the original price of the item: "))
discount_input = float(input("Enter the discount percentage: "))

def calculate_discount(price, discount_percent): 
    """
    Calculate the final price after applying a discount.
    :param price: Original price of the item"
    "param discount_percent: Discount percentage to apply
    :return: Final price after discount
    """
    if discount_percent >= 20:
        discount_amount = price * (discount_percent / 100)
        final_price = price - discount_amount
        return final_price
    else:
        return price