<%@include file="/WEB-INF/view/user/admin/layout/header.jsp" %>

<div class="wraper-content">
    <div class="title-section">
        <h5>Pending Reservations</h5>
        <hr>
    </div>
    <!-- DataTable -->
    <table id="tbl" class="display" style="width:100%">
        <thead>
        <tr>
            <th>#</th>
            <th>Customer Details</th>
            <th>Reservation Details</th>
            <th>Type</th>
            <th>Message</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>1</td>
            <td>user<br>0772345677<br>test@gmail.com</td>
            <td>2023.02.12 03.00 pm<br>3 person</td>
            <td>Dine In</td>
            <td>test</td>
            <td><button class="btn btn-xs btn-success">Confirm</button><button class="btn btn-xs btn-danger">Reject</button></td>
        </tr>
        <tr>
            <td>2</td>
            <td>user<br>0772345677<br>test@gmail.com</td>
            <td>2023.02.12 03.00 pm<br>3 person</td>
            <td>Dine In</td>
            <td>test</td>
            <td><button class="btn btn-xs btn-success">Confirm</button><button class="btn btn-xs btn-danger">Reject</button></td>
        </tr>
        </tbody>
    </table>
</div>

<script>
    $(document).ready(function() {
        init_dataTable('#tbl');
    })
</script>

<%@include file="/WEB-INF/view/user/admin/layout/footer.jsp" %>
