module ApplicationHelper
    def display_price_indian(amount)
        number_to_currency(amount, 
            unit: raw("&#x20b9;"),
            separator: ".", 
            delimiter: "", 
            format: "%u %n")
    end
end
