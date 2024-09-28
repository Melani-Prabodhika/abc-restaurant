<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="/WEB-INF/view/user/admin/layout/header.jsp" %>

<style>

    #stffTbl_wrapper {
        padding: 0px 20px;
    }

</style>

<div class="wraper-content">
    <div class="title-section">
        <h5>Staff List</h5>
        <hr>
    </div>
    <!-- DataTable -->
    <table id="stffTbl" class="display" style="width:100%">
        <thead>
        <tr>
            <th>#</th>
            <th>User Name</th>
            <th>Email</th>
            <th>Contact No</th>
            <th>User Type</th>
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
    const users = <%= new Gson().toJson(request.getAttribute("users")) %>;

    $(document).ready(function() {
        const tableBody = $('#stffTbl tbody');

        users.forEach((user, index) => {
            const userType = user.utId === 1 ? 'Admin' : user.utId === 2 ? 'Staff' : 'Other';
            const status = user.status === 'act' ? 'Active' : 'Inactive';

            const row = `
                <tr>
                    <td>${index + 1}</td>
                    <td>${user.userName}</td>
                    <td>${user.email}</td>
                    <td>${user.contactNo}</td>
                    <td>${userType}</td>
                    <td>${status}</td>
                    <td>
                        <button class="btn btn-xs btn-${status == 'Active' ? 'success' : 'warning'}"
                                title="${status} User" type="button" style="margin-right: 5px;">
                            ${status}
                        </button>
                        <button class="btn btn-xs btn-danger" type="button" title="Delete User">Delete</button>
                    </td>
                </tr>
            `;

            tableBody.append(row);
        });

        $('#stffTbl').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copyHtml5',
                'excelHtml5',
                'pdfHtml5'
            ]
        });
    });

</script>