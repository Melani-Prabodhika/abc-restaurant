<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="/WEB-INF/view/user/admin/layout/header.jsp" %>

<style>

    #otherOrdrTbl_wrapper {
        padding: 0px 20px;
    }

</style>

<div class="wraper-content">
    <div class="title-section">
        <h5>Order List</h5>
        <hr>
    </div>
    <!-- DataTable -->
    <table id="otherOrdrTbl" class="display" style="width:100%">
        <thead>
        <tr>
            <th>#</th>
            <th>Order Date</th>
            <th>Customer Details</th>
            <th>Order Items</th>
            <th>Total (LKR)</th>
            <th>Delivery Method</th>
            <th>Payment Status</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
</div>

<%@include file="/WEB-INF/view/user/admin/layout/footer.jsp" %>

<script>
    const orders = <%= new Gson().toJson(request.getAttribute("orders")) %>;
    console.log(orders);

    $(document).ready(function() {

        const tableBody = $('#otherOrdrTbl tbody');
        let tableContent = '';

        orders.forEach((order, index) => {
            const orderDate = new Date(order.orderDate).toLocaleDateString('en-GB');

            const customerDetails = `${order.userName}<br>${order.customerContact}<br>${order.deliveryAddress}`;

            const orderItems = order.orderItems.map(item => `${item.name} (${item.quantity})`).join(', ');

            tableContent += `
            <tr>
                <td>${index + 1}</td>
                <td>${orderDate}</td>
                <td>${customerDetails}</td>
                <td>${orderItems}</td>
                <td>${order.totalAmount.toFixed(2)}</td>
                <td>${order.deliveryMethod.charAt(0).toUpperCase() + order.deliveryMethod.slice(1)}</td>
                <td>${order.paymentStatus.charAt(0).toUpperCase() + order.paymentStatus.slice(1)}</td>
            </tr>
        `;
        });

        tableBody.html(tableContent);

        $('#otherOrdrTbl').DataTable({
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