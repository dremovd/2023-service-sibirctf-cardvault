<template>
    <div class="container">
        <div class="starting_popup" v-if="!hideStartingPopup">
          <div class="content_popup_wrapper_small">
            <div class="top_content">
              <div class="popup_title">Set Terminal Key Bro</div>
            </div>
            <form @submit.prevent="saveTerminalkey" class="bottom_content">
              <input v-model="terminalKey" class="input_text" type="text" name="" id="" placeholder="Put the key here" required>
              <button type="submit" class="button_accept">Thumbs up, bro!</button>
            </form>
          </div>
        </div>
        <div class="loading" v-if="isLoading">
            <img src="../assets/img/loading.png" alt="">
        </div>
        <div class="row">
            <div class="col12">
                <div class="title">
                    <h1>Fraud Squad for Online Dough!</h1>
                    <div class="terminal_key" @click="openClosePopupSmall()">{{ this.terminalKey }}</div>
                    <div class="choose_link" @click="openClosePopupSmall()" v-if="!this.terminalKey">Terminal Key Bro</div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col6">
                <div class="payments_list">
                    <PaymentItem
                        v-for="item in payment_items"
                        :key="item"
                        :payment_data="item"
                        @openDetails="takePaymentID"
                        :clickOnPayment="activeSelected"
                    />
                </div>
                <div class="payments_list_none" v-if="payment_items.length < 1">
                    <div class="empty_wrapper">
                        <p class="empty_title">{{ emptyList.title }}</p>
                        <img class="empty_img" src="../assets/img/empty.png" alt="">
                        <button class="refresh_button" @click="getPayments()">Refresh the list, dude!</button>
                    </div>
                </div>
            </div>
            <div class="col6">
                <PaymentDetails
                    :payment_data="this.payment_data"
                    :selectedItem="this.selectedItem"
                />
                <div class="payment_details_none" v-if="!selectedItem && payment_items.length > 0">
                    <p class="empty_title">{{ emptyPayment.title }}</p>
                    <img class="empty_img" src="../assets/img/empty.png" alt="">
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios'

import PaymentItem from '../components/PaymentItem.vue'
import PaymentDetails from '../components/PaymentDetails.vue'

export default {
    data(){
        return({
            payments: '',
            paymentID: '',
            payment_data: {},
            selectedItem: false,
            emptyPayment: {
                title: " <- List of sketchy shenanigans, dude!"
            },
            emptyList: {
                title: "Where's the list?!"
            },
            payment_items: [],
            isLoading: false,
            url: this.url,
            terminalKey: localStorage.getItem('terminalKey'),
            hideStartingPopup: localStorage.getItem('hideStartingPopup')
        })
    },
    components: {
        PaymentItem,
        PaymentDetails
    },
    methods: {
        takePaymentID(data){
            this.paymentID = data
            this.getPaymentDetails()
        },
        activeSelected(){
            this.selectedItem = true
        },
        getPaymentDetails(){
            this.isLoading = true
            axios.get(`${this.url}/${localStorage.getItem('terminalKey')}/payments/${this.paymentID}`)
            .then(response => {
                this.payment_data = response.data,
                this.isLoading = false
            })
            .catch(error => {
                setTimeout(() => {
                    this.isLoading = false
                }, 5000);
            })
        },
        getPayments(){
            if(localStorage.getItem('terminalKey')){
                    this.isLoading = true
                axios.get(`${this.url}/${localStorage.getItem('terminalKey')}/payments`)
                .then(response => (
                    this.payment_items = response.data,
                    this.isLoading = false
                ))
                .catch(error => {
                    setTimeout(() => {
                        this.isLoading = false
                    }, 5000);
                })
            }

        },
        checkTerminalKey(){
        if(localStorage.getItem('hideStartingPopup') && localStorage.getItem('terminalKey')){
          this.hideStartingPopup === localStorage.getItem('hideStartingPopup')
          this.terminalKey === localStorage.getItem('terminalKey')
        } else {
          this.hideStartingPopup === true
        }
      },
      saveTerminalkey(){
        localStorage.setItem('terminalKey', this.terminalKey)
        localStorage.setItem('hideStartingPopup', true)
        this.hideStartingPopup = localStorage.getItem('hideStartingPopup')
        this.getPayments()
      },
      openClosePopup(){
        if(this.showPopup){
          this.showPopup = false
        } else {
          this.showPopup = true
        }
      },
      openClosePopupSmall(){
        if(this.hideStartingPopup){
          this.hideStartingPopup = false
        } else {
          this.hideStartingPopup = true
        }
      }
    },
    mounted(){
        this.getPayments()
    }
}
</script>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

    .title{
        margin-top: 32px;
        margin-bottom: 20px;
        display: flex;align-items: center;
    }
    .title h1{
        margin-right: 24px;
    }
    .terminal_key, .choose_link {
        text-decoration: underline;
        color: #3e47c0;
        cursor: pointer;
    }
    .terminal_key:hover, .choose_link:hover {
        color: #1c2174;
    }
    .payments_list{
        width: 100%;
    }
    .empty_img{
        width: 400px;
        opacity: 90%;
        margin-top: 32px;
    }
    .empty_title{
        color: #5e5e5e;
        font-size: 20px;
    }
    .payments_list_none{
        width: 100%;
        height: 30vh;
    }
    .empty_wrapper{
        margin-top: 80px;
        margin-left: 40px;
        display: flex;
        flex-direction: column;
    }
    .loading {
        display: flex;
        justify-content: center;
        align-items: center;
        position: absolute;
        z-index: 9998;
        top: 0;
        left: 0;
        width: 100%;
        height: calc(100vh - 160px);
        background-color: rgba(252, 255, 255, .7);
    }
    .loading img{
        animation: rotate 2s linear infinite;
        width: 120px;
    }
    .fixed{
        overflow: none;
    }
    @keyframes rotate {
        100% {
            transform: rotate(360deg);
        }
    }
    header{
    margin: 16px 0;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .logo_wrapper{
    display: flex;
    align-items: center;
  }
  .logo_wrapper img{
    margin-right: 20px;
  }
  .howTO_wrapper{
    padding: 16px 12px;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #ffead7;
    border-radius: 4px;
  }
  .howTO_wrapper:hover {
    cursor: pointer;
    background-color: #f0d8bc;
  }
  .howTo{
    font-size: 20px;
  }
  .onboarding_popup{
    background-color: rgba(0, 0, 0, .7);
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    z-index: 9999;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .starting_popup {
    background-color: rgba(0, 0, 0, .7);
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    z-index: 9999;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .content_popup_wrapper{
    background-color: #fff;
    max-width: 800px;
    height: 600px;
    padding: 40px;
  }
  .content_popup_wrapper_small {
    background-color: #fff;
    max-width: 800px;
    min-height: 200px;
    padding: 40px;
  }
  .top_content{
    display: flex;
    justify-content: space-between;
  }
  .bottom_content{
    display: flex;
    flex-direction: column;
  }
  .input_text {
    padding: 12px;
    margin-bottom: 20px;
  }
  .popup_title{
    font-size: 28px;
    margin-bottom: 20px;
  }
  .popup_description{
    font-family: 'SF Cartoonist Hand', sans-serif;
    font-size: 20px;
    line-height: 24px;
    margin-bottom: 12px;
  }
  .close_link{
    color: #c94444;
    min-width: 120px;
  }
  .close_link:hover{
    cursor: pointer;
    color: #912d2d;
  }
  .refresh_button{
    margin-top: 20px;
  }
</style>