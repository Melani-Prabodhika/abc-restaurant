<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ABC Restaurant</title>

    <!-- Fonts -->
    <link rel="stylesheet" type="text/css" href="/assets/fonts/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/Simple-Line-Icons-Webfont/simple-line-icons.css" media="screen" />
    <link rel="stylesheet" href="/assets/css/et-line-font/et-line-font.css">

    <!-- FONT AWESOME -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">

    <!-- Style CSS -->
    <link rel="stylesheet" href="/assets/css/styles.css">

    <!-- Responsive -->
    <link rel="stylesheet" type="text/css"  href="/assets/css/responsive.css">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Toastr CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

    <!-- Toastr JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>


</head>

<body>

<!-- Nav Bar -->
<header>

    <div class="header">
        <div class="header-top-area" id="header-top">
            <div class="header-top">

                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <ul>
                                <% if (session.getAttribute("user_id") == null) { %>
                                <li><a href="/auth?action=signup">Sign Up</a></li>
                                <li><a href="/auth?action=login">Sign In</a></li>
                                <% } else { %>
                                <li><a href="/auth?action=logout"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp;Logout</a></li>
                                <% } %>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="nav-bar">
                    <div class="container">
                        <div class="row">

                            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                                <div class="logo-area"> <a href="#"><img class="img-responsive" src="/assets/img/logo.png" alt="logo"></a></div>
                            </div>

                            <div class="col-lg-7 col-md-7 col-sm-9 col-xs-12">
                                <div class="main-menu">
                                    <nav>
                                        <ul>
                                            <li><a href="/">Home</a></li>
                                            </li>
                                            <li><a href="/about">About</a></li>
                                            <% if(session.getAttribute("user_id") == null) { %>
                                            <li><a href="/menu1">Menu</a></li>
                                            <li><a href="/gallery">Gallery</a></li>
                                            <li><a href="#offer">Offers</a></li>
                                            <% } %>
                                            <% if (session.getAttribute("user_id") != null) { %>
                                            <li><a href="/menu2">Menu</a></li>
                                            <li><a href="">Cart</a> </li>
                                            <li><a href="/reservation">Reservation</a></li>
                                            <li><a href="/profile">Profile</a></li>
                                            <% } %>
                                            <li><a href="/contact">Contact</a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>

                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12">
                                <div class="header-top-right">
                                    <ul>
                                        <li>
                                            <div class="header-top-search search-box">
                                                <form>
                                                    <a href="#"><i class="fa fa-search" style="width:10px; height:16px;">
                                                        <input class="search-text" type="text" placeholder="Search"></i> </a>
                                                </form>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- Mobile-menu Start -->
        <div class="mobile-menu-area">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="mobile-menu">
                            <nav id="dropdown">
                                <ul>
                                    <li class="active"><a href="/">Home</a></li>
                                    </li>
                                    <li><a href="/about">About</a></li>
                                    <% if(session.getAttribute("user_id") == null) { %>
                                    <li><a href="/menu1">Menu</a></li>
                                    <li><a href="/gallery">Gallery</a></li>
                                    <li><a href="#offer">Offers</a></li>
                                    <% } %>
                                    <% if (session.getAttribute("user_id") != null) { %>
                                    <li><a href="/menu2">Menu</a></li>
                                    <li><a href="">Cart</a> </li>
                                    <li><a href="/reservation">Reservation</a></li>
                                    <li><a href="/profile">Profile</a></li>
                                    <% } %>
                                    <li><a href="/contact">Contact</a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Mobile-menu -->
    </div>

</header>
<!-- End Nav Bar -->