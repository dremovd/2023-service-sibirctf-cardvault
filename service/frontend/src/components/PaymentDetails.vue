<template>
    <div class="payment_details" v-if="selectedItem">
        <div class="top_content_wrapper">
            <div class="stats_details">
                <p class="order"><span>Order</span><br> {{ payment_data.order_id }}</p>
                <p class="amount"><span>Total</span><br> $ {{ payment_data.amount }}</p>
                <p class="status"><span>Status</span><br> {{ payment_data.status }}</p>
            </div>
            <div class="actions">
                <button @click="acceptPayment()" class="button_accept">Thumbs up, bro!</button>
                <button @click="declinePayment()" class="button_decline">Dump it!</button>
            </div>
            <p class="items_count_card">Card:</p>
            <div class="stats_details stats_details_column">
                <div class="card_top">
                    <div class="item_wrapper">
                        <div class="item_content">
                            <p class="item_card_text">Pan: </p>
                            <p class="item_card_value">{{ payment_data.card.pan }}</p>
                        </div>
                    </div>
                    <div class="item_wrapper">
                        <div class="item_content">
                            <p class="item_card_text">CVV: </p>
                            <p class="item_card_value">{{ payment_data.card.cvv }}</p>
                        </div>
                    </div>
                    <div class="item_wrapper">
                        <div class="item_content">
                            <p class="item_card_text">Expiration date: </p>
                            <p class="item_card_value">{{ payment_data.card.exp_date_month }} / {{ payment_data.card.exp_date_year }}</p>
                        </div>
                    </div>
                </div>
                <div class="item_wrapper">
                    <div class="item_content">
                        <p class="item_card_text">CardHolder: </p>
                        <p class="item_card_value">{{ payment_data.card.cardholder }}</p>
                    </div>
                </div>
            </div>
            <p class="items_count">Items: {{ payment_data.items.length }}</p>
            <div class="items_scrolling">
                <div class="item_wrapper"
                    v-for="item in payment_data.items"
                    :key="item"
                >
                    <div class="img_cover">
                        <img :src="`items/${item.image_url}`" :alt="`${item.description}`">
                    </div>
                    <div class="item_content">
                        <p class="item_description">{{ item.description }}</p>
                        <p class="item_price">$ {{ item.price }}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    props: ["payment_data", "selectedItem"],
    methods: {
        acceptPayment(){
            let data = {
                status: "accepted"
            }
            axios.patch(`${this.url}/${localStorage.getItem('terminalKey')}/payments/${this.payment_data.token}`, data)
            .then(response => {
                console.log(response.data);
                location.reload()
            })
        },
        declinePayment(){
            axios.delete(`${this.url}/${localStorage.getItem('terminalKey')}/payments/${this.payment_data.token}`)
            .then(response => {
                console.log(response.data);
                location.reload()
            })
        }
    }
}
</script>

<style>
    .payment_details{
        width: 100%;
        background-color: #f2f2f2;
        padding: 40px 40px 0;
        border-radius: 8px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        position: relative;
    }
    .payment_details_none{
        width: 100%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }
    .top_content_wrapper {
        height: 100%;
    }
    .stats_details {
        font-family: 'SF Cartoonist Hand', sans-serif;
        display: flex;
        justify-content: space-between;
        font-size: 20px;
        margin-bottom: 28px;
        color: #5e5e5e;

    }
    .stats_details_column{
        flex-direction: column;
    }
    .stats_details p span {
        font-size: 24px;
        color: #000;
    }
    .card_top{
        display: flex;
        justify-content: space-between;
    }
    .items_count {
        font-size: 20px;
        margin-bottom: 28px;
    }
    .items_count_card{
        font-size: 20px;
        margin-bottom: 12px;
    }
    .items_scrolling{
        overflow-y: auto;
    }
    .item_wrapper {
        display: flex;
        align-items: center;
        margin-bottom: 16px;
    }
    .img_cover {
        width: 60px;
        height: 60px;
        background-color: #dfdfdf;
        border-radius: 4px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-right: 20px;
    }
    .img_cover img{
        width: 52px;
    }
    .item_content{
        font-family: 'SF Cartoonist Hand', sans-serif;
    }
    .item_description {
        font-size: 18px;
        margin-bottom: 4px;
    }
    .item_price {
        font-size: 16px;
        color: #5e5e5e;
    }
    .item_card_text {
        font-size: 24px;
        margin-bottom: 4px;
        color: #000;
    }
    .item_card_value {
        font-size: 20px;
        color: #5e5e5e;
    }
    .actions {
        width: 100%;
        background-color: #f2f2f2;
        margin-bottom: 40px;
    }
    .button_decline{
        background-color: #c94444;
        margin-left: 20px;
    }
    .button_decline:hover{
        background-color: #912d2d;
    }
</style>