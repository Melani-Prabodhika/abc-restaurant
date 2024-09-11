<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>ABC Restaurant - Sign In Form</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="/assets/css/styles.css"/>

</head>

<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6 image-side"></div>
        <div class="col-md-6 login-side d-flex flex-column justify-content-between">
            <div>
                <div class="login-header">
                    <a href="/" class="btn btn-link"><i class="fa-solid fa-angle-left"></i> Back to Home</a>
                </div>
                <div class="login-content">
                    <div class="logo d-flex justify-content-center"><img src="/assets/img/logo.png" alt="" width="200" height="50"></div>
                    <h2 class="login-form-title">Login</h2>
                    <h5 class="login-form-heading">We're glad to have you back!</h5>
                    <p class="text-center mt-2" id="loginMsg"></p>
                    <form id="loginForm" method="post" onsubmit="showLoader();">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="text" class="form-control"  id="email" placeholder="Enter your email address"/>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" placeholder="Enter your password"/>
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fa-solid fa-eye" id="eye"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group login-form-forgot-password">
                            <a href="#">Forgot password?</a>
                        </div>
                        <div class="form-group form-check login-form-remember-me">
                            <input type="checkbox" class="form-check-input" id="rememberMe"/>
                            <label class="form-check-label" for="rememberMe">Remember me</label>
                        </div>
                        <button type="submit" class="btn login-form-login-button">Log In</button>
                    </form>
                    <div class="login-form-or-login-with">
                        <div class="login-form-divider-line"></div>
                        <div class="login-form-or-login-with-text">Or login with</div>
                        <div class="login-form-divider-line"></div>
                    </div>
                    <div class="login-form-social-logos">
                        <a href="#"><img src="/assets/img/Ellipse 31.png" alt="Google Logo" /></a>
                        <a href="#"><img src="/assets/img/Ellipse 30.png" alt="Facebook Logo" /></a>
                    </div>
                    <div class="login-form-signup-text">Don't have an account? <a href="/auth?action=signup">Sign up</a></div>
                </div>
            </div>
            <div class="login-footer">
                <div class="login-footer-left"><a href="">Privacy Policy</a></div>
                <div class="login-footer-right">ABC Restaurant &copy; 2024 All Rights Reserved</div>
            </div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

<script src="/assets/js/main.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>

    function showLoader() {
        Swal.fire({
            title: 'Loading...',
            allowOutsideClick: false,
            showConfirmButton: false,
            didOpen: () => {
                Swal.showLoading()
            }
        })

        setTimeout(() => {
            Swal.close();
        }, 10000);
    }

    $(document).ready(function() {
        $('#loginForm').on('submit', function(e) {
            e.preventDefault();

            const email = $('#email').val();
            const password = $('#password').val();

            console.log(email, password);

            $.ajax({
                type: 'POST',
                url: '<%= request.getContextPath() %>/auth?action=login',
                data: {
                    email: email,
                    password: password
                },
                dataType: 'json',
                success: function(response) {
                    console.log(response);
                    if(response.success === false) {
                        loginMsg.style.color = '#e83200'
                        loginMsg.innerHTML = response.message
                    }
                    if(response.success === true) {
                        loginMsg.style.color = '#00b300'
                        loginMsg.innerHTML = response.message
                        setTimeout(() => {
                            window.location = response.returnUrl
                        }, 2000);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    // console.error("AJAX error:", textStatus, errorThrown);
                    console.log(jqXHR, textStatus, errorThrown)
                    loginMsg.style.color = '#e83200'
                    loginMsg.innerHTML = 'An error occurred while processing your request. Please try again!'
                    //showDialogBox('Error', "An error occurred while processing your request. Please try again.", 'error');
                }
            });
        });
    });

</script>

</body>

</html>