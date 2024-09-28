<!-- Cart -->
<div id="cart" class="cart">
    <div class="cart-header">
        <h2 id="cart-title">Cart</h2>
        <button id="close-cart" class="close-btn">Close</button>
        <button id="clear-cart" class="clear-btn">Clear All</button>
    </div>
    <div class="cart-items"></div>
    <div class="cart-total">
        <p>Total: Rs. 0.00</p>
    </div>
    <div class="cart-actions">
        <button type="button" class="checkout-btn" id="openOrderModal" onclick="window.location.href='/order/confirm';">PROCEED TO CHECKOUT</button>
        <button type="button" class="shopping-btn" onclick="window.location.href='/menu2';">CONTINUE SHOPPING</button>
    </div>
</div>
<!-- End Cart -->

<!-- Footer Start  -->
<div class="footer-section-area padding-top-bottom">
    <div class="container">
        <div class="row">

            <div class="col-lg-3 col-md-6 col-sm-12 col-xs-12">
                <div class="title">
                    <h3>About</h3>
                </div>
                <div class="service">
                    <ul>
                        <li><a href="#">About Restaurant and Branches</a></li>
                        <li><a href="/gallery">Gallery</a></li>
                        <li><a href="#">Terms & Conditions</a></li>
                        <li><a href="#">Privacy Statements</a></li>
                    </ul>
                </div>
            </div>

            <div class="col-lg-3 col-md-6 col-sm-12 col-xs-12">
                <div class="title">
                    <h3>Quick Links</h3>
                </div>
                <div class="contact">
                    <ul>
                        <li><a href="/about">About</a></li>
                        <li><a href="/menu">Menu</a></li>
                        <li><a href="#">Reservation</a></li>
                        <li><a href="/contact">Contact Us</a></li>
                    </ul>
                </div>
            </div>

            <div class="col-lg-3 col-md-6 col-sm-12 col-xs-12">
                <div class="title">
                    <h3>Opening Hours</h3>
                </div>
                <div class="section">
                    <ul>
                        <li class="white-menu">MONDAY-THURSDAY</li>
                        <li class="white-menu">10.30 AM - 10.00 PM</li>
                        <li class="white-menu">FRIDAY - SUNDAY</li>
                        <li class="white-menu">10.00 AM - 11.00 PM</li>
                    </ul>
                </div>
            </div>

            <div class="col-lg-3 col-md-6 col-sm-12 col-xs-12">
                <div class="title">
                    <h3>Follow us</h3>
                </div>
                <div class="social-media">
                    <ul>
                        <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                        <li><a href="#"><i class="fa fa-youtube-play" aria-hidden="true"></i></a></li>
                    </ul>
                </div>
                <div class="white">ABC Restaurant provide an exceptional experience that combines great food with warm hospitality.</div><br>
                <div class="col-lg-8">
                    <div class="title">
                        <h4>Subscribe now</h4>
                    </div>
                    <div class="mt-4 mt-lg-0">
                        <form class="subscribe-form" action="#">
                            <div class="input-group">
                                <input type="email" class="form-control" id="subscribe" placeholder="Enter your email">
                                <button class="fa fa-arrow-right" type="button" id="subscribebtn"></button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- End Footer -->

<!-- Copyright Start  -->
<div class="copy-right-area">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
                <div class="copy-right">
                    <p>ABC Restaurant &copy; 2024 All Rights Reserved</p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Copyright -->

<script>
    $(document).ready(function () {
        var cartItems = [];
        var packagingCost = 30;

        loadCartFromLocalStorage();

        // Function to update cart display
        function updateCart() {
            var cartHtml = '';
            var total = 0;

            cartItems.forEach(function(item, index) {
                var itemTotal = (item.price + item.packagingCost) * item.quantity;
                total += itemTotal;

                cartHtml += `
                    <div class="cart-item">
                        <h3>${item.name}</h3>
                        <p>Added - Packaging Cost</p>
                        <div class="item-details">
                            <div><span class="item-price">Rs. ${itemTotal.toFixed(2)}</span></div>
                            <div class="d-flex justify-content-between">
                              <div class="item-quantity">
                                <button class="quantity-btn" onclick="updateItemQuantity(${index}, -1)"><i class="fa fa-minus" aria-hidden="true"></i></button>
                                <input type="text" value="${item.quantity}" disabled class="qty-input">
                                <input type="text" value="${item.id}" disabled class="id-input" hidden>
                                <button class="quantity-btn" onclick="updateItemQuantity(${index}, 1)"><i class="fa fa-plus" aria-hidden="true"></i></button>
                              </div>
                              <div>
                                <button class="remove-item-btn" onclick="removeCartItem(${index})"><i class="fa fa-trash" aria-hidden="true"></i></button></div>
                            </div>
                        </div>
                    </div>
                `;
            });

            $('.cart-items').html(cartHtml);
            $('.cart-total p').text('Total: Rs. ' + total.toFixed(2));

            saveCartToLocalStorage();
        }

        // Add item to cart
        function addItemToCart(id, name, price, quantity) {
            cartItems.push({
                id: id,
                name: name,
                price: price,
                packagingCost: packagingCost,
                quantity: quantity
            });
            updateCart();
            $('#addmodal').hide();
        }

        // Remove item from cart
        $(document).on('click', '.remove-item-btn', function() {
            var item_id = $(this).attr('cart_item_id'); // Correctly fetch the custom attribute
            console.log('Removing item: ', item_id);
            cartItems.splice(item_id, 1);  // Remove the item from the cart array
            updateCart();  // Update the cart display
        });

        // Update item quantity in cart
        window.updateItemQuantity = function(index, change) {
            var item = cartItems[index];
            item.quantity += change;

            if (item.quantity <= 0) {
                removeCartItem(index);
            } else {
                updateCart();
            }
        }

        $('#close-cart').click(function() {
            $('#cart').css('right', '-400px'); // Slide out the cart
        });

        // Toggle cart visibility
        $('.cart-link').on('click', function() {
            var cart = $('#cart');
            if (cart.css('right') === '0px') {
                cart.css('right', '-400px');
            } else {
                cart.css('right', '0');
            }
        });

        // Add to cart from modal
        $('#addToCartBtn').on('click', function() {
            var itemName = $('#addmodal .modal-title h4').text();
            var itemPrice = parseFloat($('#addmodal .item-price').text().replace('LKR ', ''));
            var itemQuantity = parseInt($('#itemQuantity').val());
            var itemId = parseInt($('#menu_item_id').val());
            console.log(itemId);

            addItemToCart(itemId, itemName, itemPrice, itemQuantity);
        });

        // Clear cart
        $('#clear-cart').on('click', function() {
            cartItems = [];
            updateCart();
        });

        function saveCartToLocalStorage() {
            localStorage.setItem('cartItems', JSON.stringify(cartItems));
        }

        // Retrieve cart items from local storage
        function loadCartFromLocalStorage() {
            const storedCart = localStorage.getItem('cartItems');
            if (storedCart) {
                cartItems = JSON.parse(storedCart);
                updateCart();  // Update cart display after loading
            }
        }

    })

    // $('#openOrderModal').on('click', function() {
    //     $('#cart').css('right', '-400px');
    //     $('#order-modal').modal('show');
    //     populateOrderModal();
    // });
    //
    // $('#closeOrderModal').on('click', function() {
    //     $('#order-modal').remove();
    //     $('body').removeClass('modal-open');
    //     $('.modal-backdrop').remove();
    // });

</script>

<!-- Bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- main js -->
<script src="/assets/js/main.js"></script>
