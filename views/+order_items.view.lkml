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
   }
