<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="/WEB-INF/view/user/admin/layout/header.jsp" %>

<style>

    #menuTbl_wrapper {
        padding: 0px 20px;
    }

</style>


<div class="wraper-content">
    <div class="title-section">
        <h5>Menu Item List</h5>
        <hr>
    </div>
    <!-- DataTable -->
    <table id="menuTbl" class="display" style="width:100%">
        <thead>
        <tr>
            <th>#</th>
            <th>Image</th>
            <th>Name</th>
            <th>Price(LKR)</th>
            <th>Category</th>
            <th>Description</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
</div>

<%@include file="/WEB-INF/view/user/admin/layout/footer.jsp" %>

<script>

    const menu = <%= new Gson().toJson(request.getAttribute("menuItems")) %>;

    $(document).ready(function() {
        const tableBody = $('#menuTbl tbody');

        menu.forEach((item, index) => {
            const row = `
                <tr>
                    <td>${index + 1}</td>
                    <td><img src="placeholder.jpg" alt="${item.item_name}" style="width:50px; height:50px;" /></td>
                    <td>${item.item_name}</td>
                    <td>${item.item_price.toFixed(2)}</td>
                    <td>${item.item_type}</td>
                    <td>${item.item_description || 'No description available'}</td>
                    <td>
                        <button class="btn btn-xs btn-success" type="button" title="Activate Menu Item">Activate</button>
                        <button class="btn btn-xs btn-danger" type="button" title="Delete Menu Item">Delete</button>
                    </td>
                </tr>
            `;

            tableBody.append(row);
        });

        $('#menuTbl').DataTable({
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