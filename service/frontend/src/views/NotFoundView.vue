<template>
    <div class="container">
        <div class="row">
            <div class="col12">
                <div class="page_wrapper">
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data(){
        return({
            error:{
                code: "404",
                subscription: "\"Screw you guys, I'm going home!\""
            }
        })
    }
}
</script>

<style>
    .page_wrapper {
        width: 100%;
        height: calc(100vh - 156px);
        display: flex;
        justify-content: right;
        align-items: center;
        position: relative;
        background: center / contain no-repeat url(../assets/img/404.png);
    
    }
    .title_wrapper{
        color: #fff;
    }
    .error_code{
        font-size: 40px;
        margin-bottom: 20px;
    }
    .subscription{
        font-size: 48px;
        max-width: 400px;
    }
</style>