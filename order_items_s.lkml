include: "/views/order_items.view.lkml"
view: order_items_s {
measure: total_sale_price {
type : sum
sql: ${sales price};;
}
}
