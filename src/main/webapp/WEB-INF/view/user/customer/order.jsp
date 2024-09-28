<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="/WEB-INF/view/layout/header.jsp" %>

<style>

  .order-modal {
    width: 700px;
    background-color: #ffffff;
    color: #000000;
    padding: 15px;
    margin: 15px auto;
    border-radius: 10px;
    height: 630px !important;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
  }

  .omodal-header {
    text-align: center;
    font-size: 24px;
    margin-bottom: 15px;
  }

  .omodal-content {
    display: flex;
    justify-content: space-between;
  }

  .delivery-info, .order-summary {
    padding: 20px;
    border-radius: 3px;
    width: 47%;
  }

  .delivery-info h3, .order-summary h3 {
    margin-top: 0;
    border-bottom: 1px solid #000000;
    padding-bottom: 10px;
    font-size: 20px;
  }

  form label, form select, form textarea, form input {
    display: block;
    margin-bottom: 5px;
    width: 100%;
    color: #000000;
  }

  .ordr {
    background-color: #000000;
    color: #ffffff !important;
    border: none;
    border-radius: 5px;
    padding: 10px;
  }

  textarea {
    resize: none;
  }

  .order-summary ul {
    list-style: none;
    padding: 0;
  }

  .order-summary ul li {
    display: flex;
    justify-content: space-between;
    padding: 5px 0;
    color: #000000;
  }

  .order-summary ul li span {
    color: #000000;
  }

  .total {
    margin-top: 20px;
    display: flex;
    justify-content: space-between;
    font-size: 18px;
    border-top: 1px solid #000000;
    padding-top: 10px;
  }

  .proceed-btn {
    width: 100%;
    padding: 15px;
    margin-top: 20px;
    background-color: #101010;
    border: none;
    color: #FFFFFF;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    text-align: center;
  }

  .proceed-btn:hover {
    background-color: #000000;
  }

  .close-btn2 {
    width: 100%;
    padding: 15px;
    margin-top: 20px;
    background-color: #FFFFFF;
    border: none;
    color: #000000;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    text-align: center;
    border: 2px solid #000000
  }

  .close-btn2:hover {
    background-color: #000000;
    color: #ffffff;
  }

</style>

<div class="order">
  <div class="container"><br><br><br><br><br>
    <div class="order-modal" id="order-modal">
      <h2 class="omodal-header">Confirm Your Order</h2>
      <div class="omodal-content">
        <div class="delivery-info">
          <h3>Delivery Information</h3>
          <form>
            <label for="delivery-method">Delivery Method</label>
            <select id="delivery-method" class="ordr">
              <option value="delivery">Delivery</option>
              <option value="pickup">Pickup</option>
            </select>

            <label for="branch">Branch</label>
            <select id="branch" class="ordr">
              <option value="1">Colombo</option>
              <option value="2">Kandy</option>
              <option value="3">Galle</option>
            </select>

            <label for="address">Delivery Address</label>
            <textarea id="address" rows="3" class="ordr" placeholder="Enter address"></textarea>

            <label for="contact-number">Contact Number</label>
            <input type="text" id="contact-number" class="ordr" placeholder="Enter Contact No">
          </form>
        </div>

        <div class="order-summary">
          <h3>Order Items</h3>
          <ul>
<%--            Item will show here--%>
          </ul>
          <div class="total">
            <strong>Total: </strong><span></span>
          </div>
        </div>
      </div>
      <button class="proceed-btn">Proceed to Payment</button>
    </div>
  </div><br>
</div>

<%@include file="/WEB-INF/view/layout/footer.jsp" %>

<script>
  $(document).ready(function() {
    // Retrieve cart items from local storage
    var cartItemsJson = localStorage.getItem('cartItems');

    if (cartItemsJson) {
      // Parse JSON string to object
      var cartItems = JSON.parse(cartItemsJson);

      var $orderList = $('.order-summary ul');
      var total = 0;

      // Iterate through cart items
      $.each(cartItems, function(index, item) {
        // Create list item for each product
        var $li = $('<li>');
        $li.html(item.name + ' - LKR' + item.price + ' x ' + item.quantity +
                ' (Packaging: LKR' + item.packagingCost + ')');
        $orderList.append($li);

        // Calculate total
        total += (item.price + item.packagingCost) * item.quantity;
      });

      // Update total in the DOM
      $('.order-summary .total span').text('LKR' + total.toFixed(2));
    } else {
      $('.order-summary ul').html('<li>No items in cart</li>');
      $('.order-summary .total span').text('LKR 0.00');
    }
  });
</script>



</body>
</html>
