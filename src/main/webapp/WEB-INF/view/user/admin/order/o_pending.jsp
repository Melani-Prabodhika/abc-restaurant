<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="/WEB-INF/view/user/admin/layout/header.jsp" %>

<style>

    #penOrdrTbl_wrapper {
        padding: 0px 20px;
    }

</style>

<div class="wraper-content">
    <div class="title-section">
        <h5>Pending Order List</h5>
        <hr>
    </div>
    <!-- DataTable -->
    <table id="penOrdrTbl" class="display" style="width:100%">
        <thead>
        <tr>
            <th>#</th>
            <th>Order Date</th>
            <th>Customer Details</th>
            <th>Order Items</th>
            <th>Total (LKR)</th>
            <th>Delivery Method</th>
            <th>Payment Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
</div>

<%@include file="/WEB-INF/view/user/admin/layout/footer.jsp" %>

<script>
    const orders = <%= new Gson().toJson(request.getAttribute("orders")) %>;

    $(document).ready(function() {

        const tableBody = $('#penOrdrTbl tbody');
        let tableContent = '';

        orders.forEach((order, index) => {
            const orderDate = new Date(order.orderDate).toLocaleDateString('en-GB');

            const customerDetails = `${order.userName}<br>${order.customerContact}<br>${order.deliveryAddress}`;

            const orderItems = order.orderItems.map(item => `${item.name} (${item.quantity})`).join(', ');

            const actionButtons = `
            <button class="btn btn-xs btn-success" data-order-id="${order.id}" style="margin-right: 5px; margin-bottom: 5px;" type="button">Delivered</button>
            <button class="btn btn-xs btn-danger" data-order-id="${order.id}" type="button">Reject</button>
        `;

            tableContent += `
            <tr>
                <td>${index + 1}</td>
                <td>${orderDate}</td>
                <td>${customerDetails}</td>
                <td>${orderItems}</td>
                <td>${order.totalAmount.toFixed(2)}</td>
                <td>${order.deliveryMethod.charAt(0).toUpperCase() + order.deliveryMethod.slice(1)}</td>
                <td>${order.paymentStatus.charAt(0).toUpperCase() + order.paymentStatus.slice(1)}</td>
                <td>${actionButtons}</td>
            </tr>
        `;
        });

        tableBody.html(tableContent);

        $('#penOrdrTbl').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copyHtml5',
                'excelHtml5',
                'pdfHtml5'
            ]
        });
    });
</script>

</body>
</html>