include: "/views/order_items.view"
include: "/views/users.view"

view: +order_items{
  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
    value_format_name:usd_0
  }
  measure: average_sale_price {
    type: average
    sql: ${order_items.sale_price} ;;
    drill_fields: [inventory_items.product_brand, inventory_items.cost]
    description: "Calculates the average sale price of items."
  }
  measure: cumulative_total_sales {
    type: running_total
    sql: ${order_items.total_sale_price} ;;
    value_format_name: usd
    description: "Calculates the running total of sales revenue in USD."
  }
  measure: total_gross_revenue {
    type: sum
    sql: CASE WHEN ${order_items.status} NOT IN ('cancelled', 'returned') THEN ${order_items.sale_price} ELSE 0 END ;;
    value_format_name: usd_0
    drill_fields: [products.brand, products.category]
    description: "Calculates the total gross revenue by summing the sale prices of all items, excluding cancelled or returned items."
  }
  measure: total_cost {
    type: sum
    sql: ${inventory_items.cost} ;;
    description: "Calculates the total cost of inventory items."
  }
  measure: average_cost {
    type: average
    sql: ${inventory_items.cost} ;;
    description: "Calculates the average cost of inventory items."
  }
  measure: total_gross_margin_amount {
    type: number
    sql: ${order_items.total_gross_revenue} - ${order_items.total_cost} ;;
    value_format_name: usd
    drill_fields: [products.category,products.brand]
    description: "Calculates the total gross margin amount by subtracting the total cost from the total gross revenue."
  }

  measure: average_gross_margin {
    type: number
    sql: CASE WHEN ${order_items.total_gross_revenue} IS NOT NULL THEN
         (${order_items.total_gross_revenue} - ${order_items.total_cost}) / NULLIF(${order_items.total_gross_revenue}, 0)
       ELSE NULL END ;;
    value_format_name: usd
    description: "Calculates the average gross margin as a percentage of total gross revenue."
  }
  measure: gross_margin_percentage {
    type: number
    sql: ${order_items.total_gross_margin_amount} / NULLIF(${order_items.total_gross_revenue}, 0) ;;
    value_format_name: percent_2
    drill_fields: [products.category, products.product_id]
    description: "Calculates the gross margin percentage by dividing the total gross margin amount by the total gross revenue."
  }
  measure: number_of_items_returned {
    type: count_distinct
    sql: ${status}='returned' ;;
    drill_fields: [products.brand]
    description: "Counts the number of items that have been returned."
  }
  measure: num_items_sold {
    type: count_distinct
    sql: CASE WHEN ${order_items.id} IS NOT NULL THEN ${order_items.id} ELSE NULL END ;;
    description: "Counts the number of distinct items sold."
  }
  }
