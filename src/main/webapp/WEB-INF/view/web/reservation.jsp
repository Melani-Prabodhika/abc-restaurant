<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="/WEB-INF/view/layout/header.jsp" %>

<style>

#offer {
    background: url(/assets/img/fish-near-parsley.jpg) center center;
    background-size: cover;
}

</style>

<div id="offer" class="offer-area">
    <div class="container"><br><br><br>
        <div class="offer-content d-flex justify-content-center">
            <div class="col-md-8 col-sm-12 col-xs-12">
                <div class="single-offer">
                    <div class="offer-content">
                        <h2 class="signup-form-title">Make Your Reservation</h2>
                        <form method="post" id="resForm">
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="name">Name</label></div>
                                <div class="col-lg-9"><input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required/></div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="phone">Contact No</label></div>
                                <div class="col-lg-9"><input type="text" class="form-control" id="phone" name="contactNumber" placeholder="Enter your contact number" required/></div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="email">Email</label></div>
                                <div class="col-lg-9"><input type="email" class="form-control" id="email" name="email" placeholder="Enter your email address" required/></div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="date">Date</label></div>
                                <div class="col-lg-9"><input type="date" class="form-control" id="date" name="reservationDate" placeholder="Select date" required/></div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="time">Time</label></div>
                                <div class="col-lg-9"><input type="time" class="form-control" id="time" name="reservationTime" placeholder="Select time" required/></div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="people">Number of People</label></div>
                                <div class="col-lg-9"><input type="number" class="form-control" id="people" name="numberOfPeople" placeholder="Enter number of people" required/></div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="type">Type</label></div>
                                <div class="col-lg-9">
                                    <select class="form-control" id="type" name="reservationType" required>
                                        <option value="">Select Type</option>
                                        <option value="Dine-in">Dine-in</option>
                                        <option value="Delivery">Delivery</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="branch">Branch</label></div>
                                <div class="col-lg-9">
                                    <select class="form-control" id="branch" name="branchId" required>
                                        <option value="" selected disabled hidden>Select Branch</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group2 d-flex justify-content-between">
                                <div class="col-lg-3"><label for="note">Message</label></div>
                                <div class="col-lg-9"><textarea class="form-control" id="note" name="message" placeholder="Enter message"></textarea></div>
                            </div>
                            <button type="submit" class="btn signup-form-signup-button">Save Reservation</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/view/layout/footer.jsp" %>

<script>

    const branches = <%= new Gson().toJson(request.getAttribute("branches")) %>;

    branches.forEach(branch => {
        const option = document.createElement("option");
        option.value = branch.branchId;
        option.text = branch.branchName;
        document.getElementById("branch").appendChild(option);

    })

    $(document).ready(function () {
        $('#resForm').on('submit', function (event) {
            event.preventDefault(); // Prevent the default form submission

            // Clear previous error messages
            $('.form-control').removeClass('is-invalid');
            toastr.clear();

            // Send AJAX request
            $.ajax({
                url: '/reservation',
                method: 'POST',
                data:{
                    name: $('#name').val(),
                    phone: $('#phone').val(),
                    email: $('#email').val(),
                    reservationDate: $('#date').val(),
                    reservationTime: $('#time').val(),
                    numberOfPeople: $('#people').val(),
                    reservationType: $('#type').val(),
                    branchId: $('#branch').val(),
                    message: $('#note').val()
                },
                success: function (response) {
                    if (response.success) {
                        toastr.success('Reservation submitted successfully!');
                        $('#resForm')[0].reset(); // Reset form on success
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

</body>
</html>