<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ABC Restaurant - Sign Up Form</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="css/style.css"/>

</head>

<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-6 signup-side d-flex flex-column justify-content-between">
            <div>
                <div class="signup-header">
                    <a href="index.html" class="btn btn-link"><i class="fa-solid fa-angle-left"></i> Back to Home</a>
                </div>
                <div class="signup-content">
                    <div class="logo"><!--<img src="img/sla.png" alt="">--><h2 class="res-title"><strong>ABC Restaurant</strong></h2></div>
                    <h2 class="signup-form-title">Sign Up Form</h2>
                    <h5 class="signup-form-heading">Create a new account</h5>
                    <form>
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
                <div class="signup-form-login-text">Already have an account? <a href="login.html">Sign in</a></div>
                <div class="signup-form-or-login-with">
                    <div class="signup-form-divider-line"></div>
                    <div class="signup-form-or-login-with-text">Or sign up with</div>
                    <div class="signup-form-divider-line"></div>
                </div>
                <div class="signup-form-social-logos">
                    <a href="#"><img src="img/Ellipse 31.png" alt="Google Logo" /></a>
                    <a href="#"><img src="img/Ellipse 30.png" alt="Facebook Logo" /></a>
                </div>
            </div>
            <div class="signup-footer">
                <div class="signup-footer-left"><a href="">Privacy Policy</a></div>
                <div class="signup-footer-right">Copyright © 2023</div>
            </div>
        </div>
        <div class="col-md-6 image-side"></div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

<script src="js/main.js"></script>

<script src="https://www.google.com/recaptcha/api.js" async defer></script>

</body>

</html>
