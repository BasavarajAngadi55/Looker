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

view: +order_items {
  measure: Cumulative_Total_Sales {
    description: "Cumulative total sales from items sold (also known as a running total)"
    type: running_total
    sql: ${order_items.total_sale_price} ;;
    value_format_name: usd_0
  }
}

view: +order_items {
measure: total_gross_revenue {
  description: "Total revenue from completed sales (cancelled and returned orders excluded)"
  type: sum
  sql:
    CASE
      WHEN ${TABLE}.order_status NOT IN ('cancelled', 'returned') THEN ${TABLE}.sale_price
      ELSE 0
    END ;;
  value_format_name: usd_0
}
}
