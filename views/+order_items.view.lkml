include: "/views/order_items.view"

view: +order_items {
  measure: total_sale_price {
    type: sum
    sql: ${TABLE}.sales_price ;;
    value_format_name: usd_0
  }
}
