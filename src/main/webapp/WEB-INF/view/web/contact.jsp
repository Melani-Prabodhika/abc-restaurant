<%@include file="/WEB-INF/view/layout/header.jsp" %>

<div id="offer" class="offer-area">
    <div class="container"><br><br><br>
        <div class="offer-content d-flex justify-content-center">
            <div class="col-md-8 col-sm-12 col-xs-12">
                <div class="single-offer">
                    <div class="offer-content">
                        <h2 class="signup-form-title">Send Message</h2>
                        <form id="conForm" method="post">
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="name">Name</label></div>
                                <div class="col-lg-9"><input type="text" class="form-control" id="name" placeholder="Enter your name"/></div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="phone">Contact No</label></div>
                                <div class="col-lg-9"><input type="text" class="form-control" id="phone" placeholder="Enter your contact number"/></div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="whatsapp">Whatsapp No</label></div>
                                <div class="col-lg-9"><input type="text" class="form-control" id="whatsapp" placeholder="Enter your whatsapp number"/></div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="email">Email</label></div>
                                <div class="col-lg-9"><input type="email" class="form-control" id="email" placeholder="Enter your email address"/></div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="subject">Subject</label></div>
                                <div class="col-lg-9"><input type="text" class="form-control" id="subject" placeholder="Enter subject"/></div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="message">Message</label></div>
                                <div class="col-lg-9"><textarea typeof="text" class="form-control" id="message" placeholder="Enter message"></textarea></div>
                            </div>
                            <button type="submit" class="btn signup-form-signup-button">Send Message</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#conForm').on('submit', function (event) {
            event.preventDefault(); // Prevent the default form submission

            // Clear previous error messages
            $('.form-control').removeClass('is-invalid');
            toastr.clear();

            // Send AJAX request
            $.ajax({
                url: '/contact',
                method: 'POST',
                data: {
                    name: $('#name').val(),
                    phone: $('#phone').val(),
                    whatsapp: $('#whatsapp').val(),
                    email: $('#email').val(),
                    subject: $('#subject').val(),
                    message: $('#message').val()
                },
                success: function (response) {
                    if (response.success) {
                        toastr.success('Your message was sent successfully! You will get a reply within 36 hours.');
                        $('#conForm')[0].reset(); // Reset form on success
                    } else {
                        toastr.error(response.message);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    toastr.error('An unexpected error occurred.');
                }
            });
        });
    });

</script>

<%@include file="/WEB-INF/view/layout/footer.jsp" %>

