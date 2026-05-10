with order_payments as (
    select
        order_id,
        sum(amount) as total_amount
    from {{ ref('stg_stripe__payments') }}
        where status = 'success'
    group by order_id
),

orders as (
    select
        order_id,
        customer_id,
        order_date
    from {{ ref('stg_jaffle_shop__orders') }}
),

final as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce(order_payments.total_amount, 0) as amount
    from orders
    left join order_payments
        on orders.order_id = order_payments.order_id
)

select * from final