<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ABC Restaurant - Sign Up Form</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="/assets/css/styles.css"/>

</head>

<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6 signup-side d-flex flex-column justify-content-between">
            <div>
                <div class="signup-header">
                    <a href="/" class="btn btn-link"><i class="fa-solid fa-angle-left"></i> Back to Home</a>
                </div>
                <div class="signup-content">
                    <div class="logo d-flex justify-content-center"><img src="/assets/img/logo.png" alt="" width="200" height="50"></div>
                    <h2 class="signup-form-title">Sign Up Form</h2>
                    <h5 class="signup-form-heading">Create a new account</h5>
                    <form id="signupForm" method="post">
                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" class="form-control" id="name" placeholder="Enter your full name" required/>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="text" class="form-control" id="phone" placeholder="Enter your phone number" required/>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" placeholder="Enter your email address" required/>
                        </div>
                        <div class="form-group">
                            <label for="address">Address</label>
                            <textarea type="text" class="form-control" id="address" placeholder="Enter your address" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" placeholder="Enter your password" required/>
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fa-solid fa-eye" id="eye"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password">Confirm Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="cpassword" placeholder="Enter your password" required/>
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fa-solid fa-eye" id="ceye"></i></span>
                                </div>
                            </div>
                        </div>
                        <!-- <div class="g-recaptcha" data-sitekey="6LfeGRcmAAAAAABKrUT8_uwiJwGKK-tMP6DxcwE8"></div> -->
                        <button type="submit" class="btn signup-form-signup-button">Sign Up</button>
                    </form>
                </div>
                <div class="signup-form-login-text">Already have an account? <a href="/auth?action=login">Sign in</a></div>
                <div class="signup-form-or-login-with">
                    <div class="signup-form-divider-line"></div>
                    <div class="signup-form-or-login-with-text">Or sign up with</div>
                    <div class="signup-form-divider-line"></div>
                </div>
                <div class="signup-form-social-logos">
                    <a href="#"><img src="/assets/img/Ellipse 31.png" alt="Google Logo" /></a>
                    <a href="#"><img src="/assets/img/Ellipse 30.png" alt="Facebook Logo" /></a>
                </div>
            </div>
            <div class="signup-footer">
                <div class="signup-footer-left"><a href="">Privacy Policy</a></div>
                <div class="signup-footer-right">ABC Restaurant &copy; 2024 All Rights Reserved</div>
            </div>
        </div>
        <div class="col-md-6 image-side2"></div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

<script src="/assets/js/main.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%--<script src="https://www.google.com/recaptcha/api.js" async defer></script>--%>

<script>
    $(document).ready(function() {
        $('#signupForm').submit(function(e) {
            e.preventDefault();

            // Basic form validation
            var name = $('#name').val().trim();
            var phone = $('#phone').val().trim();
            var email = $('#email').val().trim();
            var address = $('#address').val().trim();
            var password = $('#password').val();
            var cpassword = $('#cpassword').val();

            if (name === '' || phone === '' || email === '' || address === '' || password === '' || cpassword === '') {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: 'Please fill in all fields!'
                });
                return;
            }

            if (password !== cpassword) {
                Swal.fire({
                    icon: 'error',
                    title: 'Password Mismatch',
                    text: 'The passwords you entered do not match!'
                });
                return;
            }

            // Email validation
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Email',
                    text: 'Please enter a valid email address!'
                });
                return;
            }


            // If validation passes, make AJAX request
            $.ajax({
                url: '/auth?action=register',
                method: 'POST',
                data: {
                    name: $('#name').val(),
                    phone: $('#phone').val(),
                    email: $('#email').val(),
                    address: $('#address').val(),
                    password: $('#password').val()
                },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: response.message
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.href = response.returnUrl;
                            }
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Registration Failed',
                            text: response.message
                        });
                    }
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Registration Failed',
                        text: 'An error occurred while creating your account. Please try again later.'
                    });
                }
            });
        });
    });
</script>

</body>

</html>
