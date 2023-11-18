<template>
    <div class="payment_item"
        @click.prevent="sendID(payment_data.token), clickOnPayment()"
    >
        <p class="order">Order: {{ payment_data.order_id }}</p>
        <p class="amount">$ {{ payment_data.amount }}</p>
        <p class="items">Items: {{ payment_data.items.length }}</p>
        <p class="status"> {{ payment_data.status }}</p>
        <p>{{ payment_data.created_at }}</p>
    </div>
</template>

<script>
export default {
    props:["payment_data", "clickOnPayment"],
    methods: {
        sendID(data){
            this.$emit('openDetails', data)
        },
    }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

.payment_item{
    font-family: 'SF Cartoonist Hand', sans-serif;
    width: 100%;
    background-color: #fff;
    padding: 16px;
    border-radius: 8px;
    display: flex;
    gap: 1rem;
    justify-content: space-between;
    border: 3px solid #dbdbdb;
    margin-bottom: 16px;
}
.payment_item p{
    width: 100%;
}
.payment_item:hover {
    border: 3px solid #ff8b8b;
    cursor: pointer;
}
</style>