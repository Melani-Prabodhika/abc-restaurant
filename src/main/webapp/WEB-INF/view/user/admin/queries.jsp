<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="/WEB-INF/view/user/admin/layout/header.jsp" %>

<style>

    #queTbl_wrapper {
        padding: 0px 20px;
    }

</style>

<div class="wraper-content">
    <div class="title-section">
        <h5>Query List</h5>
        <hr>
    </div>
    <!-- DataTable -->
    <table id="queTbl" class="display" style="width:100%">
        <thead>
        <tr>
            <th>#</th>
            <th>Customer Name</th>
            <th>Contact Details</th>
            <th>Whatsapp No</th>
            <th>Message</th>
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
    const queries = <%= new Gson().toJson(request.getAttribute("queries")) %>;

    $(document).ready(function() {
        const table = $('#queTbl').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copyHtml5',
                'excelHtml5',
                'pdfHtml5'
            ],
            data: queries.map((query, index) => [
                index + 1,
                query.cus_name,
                `${query.cus_contact}<br>${query.email}`,
                query.cus_whatsapp,
                `${query.subject}<br>${query.message}`,
                "Active",
                '<button class="btn btn-xs btn-info" type="button">Replied</button>'
            ])
        });
    });
</script>

</body>
</html>