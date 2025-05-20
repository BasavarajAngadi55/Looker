include: "/views/order_items.view"

view: +order_items {
  measure: total_sale_price {
    description: "Total sales from items sold"
    type: sum
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd_0
  }
}

view: +order_items {
  measure: Average_Sale_Price  {
    description: "Average sale price of items sold"
    type: average
    sql: ${TABLE}.sale_price ;;
    value_format_name: usd_0
  }
}
