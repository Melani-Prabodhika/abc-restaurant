<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="/WEB-INF/view/user/admin/layout/header.jsp" %>

<style>

    #cusTbl_wrapper {
        padding: 0px 20px;
    }

</style>

<div class="wraper-content">
    <div class="title-section">
        <h5>Customer List</h5>
        <hr>
    </div>
    <!-- DataTable -->
    <table id="cusTbl" class="display" style="width:100%">
        <thead>
        <tr>
            <th>#</th>
            <th>Customer Name</th>
            <th>Email</th>
            <th>Contact No</th>
            <th>Address</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
</div>

<%@include file="/WEB-INF/view/user/admin/layout/footer.jsp" %>

<script>
    const customers = <%= new Gson().toJson(request.getAttribute("customers")) %>;
    console.log(customers);

    $(document).ready(function() {
        // Reference to the table body
        const tableBody = $('#cusTbl tbody');

        // Iterate over each customer and construct table rows
        customers.forEach((customer, index) => {
            // Construct a table row with the customer data
            const row = `
                <tr>
                    <td>${index + 1}</td>
                    <td>${customer.userName}</td>
                    <td>${customer.email}</td>
                    <td>${customer.contactNo}</td>
                    <td>${customer.address}</td>
                    <td>${customer.status === 'act' ? 'Active' : 'Inactive'}</td>
                    <td>
                        <button class="btn btn-xs btn-${customer.status === 'act' ? 'success' : 'warning'}"
                                title="${customer.status === 'act' ? 'Active Customer' : 'Inactive Customer'}" type="button">
                            ${customer.status === 'act' ? 'Active' : 'Inactive'}
                        </button>
                        <button class="btn btn-xs btn-danger" type="button" title="Delete Customer">Delete</button>
                    </td>
                </tr>
            `;

            // Append the row to the table body
            tableBody.append(row);
        });

        // Initialize DataTables with export buttons
        $('#cusTbl').DataTable({
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