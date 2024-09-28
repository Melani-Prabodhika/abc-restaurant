<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="/WEB-INF/view/layout/header.jsp" %>

<style>

    /*-- Menu-item --*/

    .main-menu {
        padding-top: 140px;
    }

    .main-menu .menu-column .inner-box {
        position: relative;
        margin-bottom: 30px;
        text-align: center;
        box-shadow: 1px 0px 5px 0px #292929a3;
        background-color: #f5f5f5;
    }

    .main-menu .menu-column .inner-box a{
        color: #4e4e4e;
        position: relative;
        font-weight: 400;
        font-size: 23px;
        text-decoration: none;
        text-align: center;
        padding-top: 0;
        margin: 0;
    }

    .main-menu .menu-column .inner-box .img-box {
        position: relative;
        text-align: center;
        width: 100%;
        margin: 0 auto;
        overflow: hidden;
    }

    .main-menu .menu-column .inner-box .img-box .text-box{
        padding: 15px;
    }

    .main-menu .menu-column .inner-box .img-box {
        transition: all 0.3s ease 0s;
    }

    .main-menu .menu-column  .inner-box .img-box .img img{
        height: 220px;
        border-radius: 3px;
        width: 100%;
        margin-bottom: 10px;
    }

    .main-menu  .menu-column .inner-box a {
        color: #fff;
        position: absolute;
        background-color: #00000055;
        padding: 10px;
        margin: 5px;
        width: 97.5%;
        border-radius: 0 0 3px 3px;
        left: 0;
        text-align: center;
        z-index: 20;
        -webkit-transform: translate(0%, -100%);
        -ms-transform: translate(0%, -100%);
        transform: translate(0%, -130%);
    }

    .main-menu  .menu-column .inner-box a:hover {
        color: #000;
        background-color: #e3e3e355;
    }

    .main-menu .menu-column .inner-box .img-box .add-btn {
        position: absolute;
        left: 50%;
        transform: translateX(-50%) translateY(-50%);
        bottom: 53px;
        z-index: 1;
    }

    .main-menu .menu-column .inner-box .img-box .add-btn button {
        font-size: 25px;
        font-weight: 600;
        background-color: #000000;
        padding: 3px 14px 2px 14px;
        border-radius: 50px;
        color: #fff;
        box-shadow: 0 2px 3px #ddd;
        border: unset;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .main-menu .menu-column .inner-box .img-box .add-btn button:hover {
        background-color: #bd965a;
        color: #ffffff;
    }

    button {
        cursor: pointer;
    }

    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.5);
    }

    .modal-content {
        background-color: #fff;
        margin: 10% auto;
        border: 1px solid #888;
        width: 500px;
        border-radius: 2px;
    }

    .modal-header {
        background: #efeff0;
        padding: 10px 15px 0px 15px !important;
    }

    .modal-header .modal-title {
        text-align: center;
    }

    .close {
        margin-bottom: 10px;
        color: #979595;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }

    h4 {
        font-weight: 600;
        font-size: 1.3rem;
    }

    .modal-body {
        padding: 15px 0px 0px 0px;
    }

    .item-info {
        padding: 3px 20px 0px 20px;
    }

    .add-note {
        padding-top: 10px;
        font-size: 15px;
        font-weight: 700;
        color: #717171;
        padding-right: 5px;
    }

    .added-section {
        margin: 15px 20px;
    }

    .para {
        font-size: 12px;
        font-style: italic;
        margin-top: 0;
        margin-bottom: 1rem;
    }

    .required-badge {
        background-color: #f0ad4e;
        color: white;
        padding: 3px 15px;
        font-size: 11px;
        border-radius: 3px;
    }

    .checkbox-section {
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: #0075ffcf;
    }

    .quantity-section {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin: 25px 20px 25px 20px;
    }

    .quantity-section button {
        font-size: 18px;
        border: none;
        background-color: #ddd;
        border-radius: 3px;
        width: 30px;
        height: 30px;
    }

    .quantity-section input {
        margin-left: 12px;
        width: 30px;
        text-align: center;
        font-size: 16px;
    }

    .subtotal-section {
        color: #6e6e6e;
        font-size: 15px;
        font-weight: 600;
        background: #efeff0;
        padding: 15px 20px 12px 20px
    }

    #addToCartBtn {
        background-color: black;
        color: white;
        padding: 10px;
        width: 100%;
        border: none;
        border-radius: 2px;
        font-size: 16px;
    }

</style>

<!-- Menu Items -->
<div class="main-menu">
    <div class="container"><br>
        <h1 class="text-center"><strong>MENU</strong></h1><br>
        <div class="row" id="menu-items-container">

        </div>
    </div>
</div><br>
<!-- End Menu Items -->

<!-- Modal -->
<div id="addmodal" class="modal">
    <div class="modal-content">
        <div class="modal-header d-flex justify-content-between">
            <div class="modal-title"><h4></h4></div>
            <div><span class="close">&times;</span></div>
        </div>
        <div class="modal-body">
            <div class="item-info d-flex justify-content-between">
                <div class="item-name">Item price</div>
                <div class="item-price"></div>
            </div>
            <hr>
            <div class="added-section">
                <span class="add-note">Added</span><span class="required-badge">Required</span>
                <div class="para">You can select up to <b>1 item</b> from below</div>
                <div class="checkbox-section">
                    <div>
                        <input type="text" id="menu_item_id" name="menu_item_id" hidden >
                        <input type="checkbox" id="packagingCost" name="packagingCost" checked disabled>
                        <label for="packagingCost">Packaging Cost</label>
                    </div>
                    <div><span>LKR 30.00</span></div>
                </div>
            </div>
            <div class="quantity-section">
                <div><label for="itemQuantity">Item Quantity</label></div>
                <div>
                    <button id="decreaseQty">-</button>
                    <input type="number" id="itemQuantity" value="1" min="1">
                    <button id="increaseQty">+</button>
                </div>
            </div>
            <div class="subtotal-section d-flex justify-content-between">
                <div>Sub Total</div>
                <div><span id="subTotal"></span></div>
            </div>
        </div>
        <button id="addToCartBtn">ADD TO CART</button>
    </div>
</div>
<!-- End Modal -->

<%@include file="/WEB-INF/view/layout/footer.jsp" %>

<script>

    $(document).ready(function () {

        const menuItems = <%= new Gson().toJson(request.getAttribute("menuItems")) %>;

        const menuContainer = document.getElementById('menu-items-container');

        menuItems.forEach(item => {
            const menuColumn = document.createElement('div');
            menuColumn.className = 'menu-column col-lg-3 col-md-6 col-sm-12 col-xs-12 mb-4';

            const innerBox = `
            <article class="inner-box">
                <div class="img-box">
                    <div class="img">
                        <!-- Use a placeholder or a dynamic image path if available -->
                        <img src="/assets/document/menu_item/${item.id}.jpg" alt="${item.item_name}" class="img-fluid">
                    </div>
                    <div class="add-btn">
                        <button class="btn btn-add" type="button">+</button>
                    </div>
                    <div class="text-box">
                        <div class="menu-item"><strong>${item.item_name}</strong></div>
                        <div style="display: none;" class="menu_id"><strong>${item.id}</strong></div>
                        <div class="item-price">LKR ${item.item_price.toFixed(2)}</div>
                    </div>
                </div>
            </article>
        `;

            menuColumn.innerHTML = innerBox;

            menuContainer.appendChild(menuColumn);
        });


        $('.btn-add').on('click', function() {
            // Find the closest parent containing the menu item details
            var itemContainer = $(this).closest('.img-box');

            // Get the itemName and itemPrice from the clicked item's container
            var itemName = itemContainer.find('.menu-item').text();
            var itemId = itemContainer.find('.menu_id').text();
            var itemPrice = parseFloat(itemContainer.find('.item-price').text().replace('LKR', '').trim());

            // Set the modal title and price
            $('#addmodal').show();
            $('.modal-title h4').text(itemName);
            $('#menu_item_id').val(itemId);
            $('.item-price').text('LKR ' + itemPrice.toFixed(2));

            // Set the initial quantity
            $('#itemQuantity').val(1);

            // Update subtotal based on the selected quantity and item price
            updateSubTotal(itemPrice);
        });

        // Close modal
        $('.close').on('click', function() {
            $('#addmodal').hide();
        });

        // Close modal if user clicks outside of it
        $(window).on('click', function(event) {
            if ($(event.target).is('#addmodal')) {
                $('#addmodal').hide();
            }
        });

        // Update subtotal
        function updateSubTotal(itemPrice) {
            var quantity = parseInt($('#itemQuantity').val());
            var packagingCost = 30; // Packaging cost as a constant
            var total = (itemPrice + packagingCost) * quantity;

            // Set the subtotal in the modal
            $('#subTotal').text('LKR ' + total.toFixed(2));
        }

        $('#increaseQty').on('click', function() {
            var quantity = parseInt($('#itemQuantity').val()) + 1;
            $('#itemQuantity').val(quantity);
            var itemPrice = parseFloat($('.item-price').text().replace('LKR', '').trim());
            updateSubTotal(itemPrice);
        });

        $('#decreaseQty').on('click', function() {
            var quantity = Math.max(1, parseInt($('#itemQuantity').val()) - 1); // Ensure minimum quantity is 1
            $('#itemQuantity').val(quantity);
            var itemPrice = parseFloat($('.item-price').text().replace('LKR', '').trim());
            updateSubTotal(itemPrice);
        });

        $('#itemQuantity').on('change', function() {
            var quantity = parseInt($('#itemQuantity').val());
            var itemPrice = parseFloat($('.item-price').text().replace('LKR', '').trim());
            updateSubTotal(itemPrice);
        });

    });

</script>

</body>
</html>