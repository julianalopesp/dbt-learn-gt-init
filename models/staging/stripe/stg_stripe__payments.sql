select 
    id as payment_id,
    orderid as order_id,
    amount,
    paymentmethod as payment_method,
    status,
    created as created_at
from raw.stripe.payment