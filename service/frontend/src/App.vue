<template>
  <div class="container">
    <div class="row">
      <div class="col12">
        <header>
          <RouterLink to="/">
            <div class="logo_wrapper">
              <img src="./assets/img/logo.png" alt="">
            </div>
          </RouterLink>
          <div class="howTO_wrapper" @click="openClosePopup()">
            <p class="howTo">How's this thing supposed to work, dude?!</p>
          </div>
        </header>
        <div class="onboarding_popup" v-if="showPopup">
          <div class="content_popup_wrapper">
            <div class="top_content">
              <div class="popup_title">How's this thing supposed to work, dude?!</div>
              <div class="close_link" @click="openClosePopup()">Shut it down!</div>
            </div>
              <div class="popup_description">
                1. Log in to your fraud-watch thingamajig.
              </div>
              <div class="popup_description">
                2. Scope out those sketchy alerts.
              </div>
              <div class="popup_description">
                3. Keep your peepers peeled for dodgy deals.
              </div>
              <div class="popup_description">
                4. Dig into the fishy stuff.
              </div>
              <div class="popup_description">
                5. Holler at customers when things look wonky.
              </div>
              <div class="popup_description">
                6. Throw a block or give the green light on transactions.
              </div>
              <div class="popup_description">
                7. Jot down your super-sleuth moves.
              </div>
              <div class="popup_description">
                8. Keep those filters sharp as a ninja star.
              </div>
              <div class="popup_description">
                9. School yourself on the scammer's playbook.
              </div>
              <div class="popup_description">
                10. Stick to the code, buddies.
              </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <RouterView />
</template>

<script>
import { RouterLink, RouterView } from 'vue-router'

export default {
    data(){
        return({
          showPopup: false,
        })
    },
    methods: {
      openClosePopup(){
        if(this.showPopup){
          this.showPopup = false
        } else {
          this.showPopup = true
        }
      },
    }
}
</script>

<style scoped>
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
</style>
