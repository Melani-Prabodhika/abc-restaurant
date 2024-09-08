<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Account</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTable CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
    <!-- DataTable Buttons CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.3/css/buttons.dataTables.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/assets/css/custom.css">
    <link rel="stylesheet" type="text/css" href="/assets/fonts/font-awesome/css/font-awesome.css">
</head>
<body>
<div class="wrapper">
    <!-- Side Navigation -->
    <nav class="side-nav">
        <div class="user-info">
            <div class="logo"><img src="/assets/img/logo.png" alt="" width="150"></div>
            <h6>User Name</h6>
            <p>User Role</p>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a href="#" class="nav-link">Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="collapse" href="#menu2" role="button" aria-expanded="false" aria-controls="menu2">
                    Reservations
                </a>
                <div class="collapse" id="menu2">
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="#">Pending List</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Confirmed List</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Rejected List</a></li>
                    </ul>
                </div>
            </li>
            <li class="nav-item"></li>
            <a class="nav-link" data-bs-toggle="collapse" href="#menu4" role="button" aria-expanded="false" aria-controls="menu4">
                Orders
            </a>
            <div class="collapse" id="menu4">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="#">Pending Orders</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Confirmed Orders</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Rejected Orders</a></li>
                </ul>
            </div>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">Customers</a>
            </li>
            <li class="nav-item"></li>
            <a class="nav-link" data-bs-toggle="collapse" href="#menu1" role="button" aria-expanded="false" aria-controls="menu1">
                Menu Items
            </a>
            <div class="collapse" id="menu1">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="#">Add Menu Item</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Menu Item List</a></li>
                </ul>
            </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="collapse" href="#menu3" role="button" aria-expanded="false" aria-controls="menu3">
                    Staff
                </a>
                <div class="collapse" id="menu3">
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="#">Add Staff</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Staff List</a></li>
                    </ul>
                </div>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link">Queries</a>
            </li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="content">
        <div class="top-header">
            <div class="top-section">
                <input type="text" class="form-control search-input" placeholder="Search...">
                <button class="btn btn-primary"><i class="fa fa-sign-out" aria-hidden="true"></i>&nbsp;Logout</button>
            </div>
        </div>