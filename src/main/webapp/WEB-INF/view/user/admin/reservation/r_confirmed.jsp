<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="com.google.gson.JsonSerializer" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="/WEB-INF/view/user/admin/layout/header.jsp" %>

<style>

    #confRes_wrapper {
        padding: 0px 20px;
    }

</style>

<div class="wraper-content">
    <div class="title-section">
        <h5>Confirmed Reservations</h5>
        <hr>
    </div>
    <!-- DataTable -->
    <table id="confRes" class="display" style="width:100%">
        <thead>
        <tr>
            <th>#</th>
            <th>Customer Details</th>
            <th>Reservation Details</th>
            <th>Type</th>
            <th>Message</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>

<%@include file="/WEB-INF/view/user/admin/layout/footer.jsp" %>

<script>

    <%
      // Create custom Gson instance with LocalDate and LocalTime adapters
      JsonSerializer<LocalDate> localDateSerializer = (src, typeOfSrc, context) ->
          src == null ? null : context.serialize(src.format(DateTimeFormatter.ISO_LOCAL_DATE));

      JsonSerializer<LocalTime> localTimeSerializer = (src, typeOfSrc, context) ->
          src == null ? null : context.serialize(src.format(DateTimeFormatter.ISO_LOCAL_TIME));

      Gson gson = new GsonBuilder()
          .registerTypeAdapter(LocalDate.class, localDateSerializer)
          .registerTypeAdapter(LocalTime.class, localTimeSerializer)
          .create();
  %>

$(document).ready(function () {
    const reservations = <%= gson.toJson(request.getAttribute("reservations")) %>;

    if (reservations && Array.isArray(reservations)) {
        $('#confRes').DataTable({
            data: reservations,
            columns: [
                { data: null, render: (data, type, row, meta) => meta.row + 1 },
                {
                    data: null,
                    render: (data) => `${data.user_name}<br>${data.phone}<br>${data.user_email}`
                },
                {
                    data: null,
                    render: (data) => `${data.reservation_date} ${data.reservation_time}<br>${data.number_of_people} person`
                },
                { data: 'reservation_type' },
                { data: 'message' }
            ],
            dom: 'Bfrtip',
            buttons: [
                'copyHtml5',
                'excelHtml5',
                'pdfHtml5'
            ],
            paging: true,
            searching: true,
            ordering: true,
            info: true
        });
    }
});

</script>

</body>
</html>
