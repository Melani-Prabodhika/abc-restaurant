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

    #penRes_wrapper {
        padding: 0px 20px;
    }

    /* CSS for Modal */
    .hd1{
        background-color: #DC3545;
        color: #fff;
    }

    .hd2{
        background-color: #198754;
        color: #fff;
    }

    .modal-title {
        font-weight: 600;
    }

    .modal-body p {
        font-size: 18px;
        margin: 0;
    }

    .modal-footer .btn {
        font-size: 16px;
    }


</style>

<div class="wraper-content">
    <div class="title-section">
        <h5>Confirmed Reservations</h5>
        <hr>
    </div>
    <table id="penRes" class="display" style="width:100%">

    </table>
</div>

<!-- Delete Modal HTML -->
<div class="modal fade" id="cancelReservationModal" tabindex="-1" role="dialog" aria-labelledby="cancelReservationLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header hd1">
                <h5 class="modal-title" id="cancelReservationLabel">Cancel Reservation</h5>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to cancel this reservation?</p>
                <input type="hidden" id="reservationId" value=""/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-danger" id="confirmCancelReservation">Reject</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Modal HTML -->
<div class="modal fade" id="confirmReservationModal" tabindex="-1" role="dialog" aria-labelledby="confirmReservationLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header hd2">
                <h5 class="modal-title" id="confirmReservationLabel">Confirm Reservation</h5>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to confirm this reservation?</p>
                <input type="hidden" id="reservationsId" value=""/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-success" id="confirmReservation">Confirm</button>
            </div>
        </div>
    </div>
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

    const reservations = <%= gson.toJson(request.getAttribute("reservations")) %>;

    $(document).ready(function() {
        $('#penRes').DataTable({
            data: reservations, // Pass JSON data as the data source
            columns: [
                { data: 'res_id', title: '#' },
                {
                    data: null,
                    title: 'Customer Details',
                    render: function(data, type, row) {
                        return `${data.user_name}<br>${data.phone}<br>${data.user_email}`;
                    }
                },
                {
                    data: null,
                    title: 'Reservation Details',
                    render: function(data, type, row) {
                        return `${data.reservation_date} ${data.reservation_time}<br>${data.number_of_people} person(s)`;
                    }
                },
                { data: 'reservation_type', title: 'Type' },
                { data: 'message', title: 'Message' },
                {
                    data: null,
                    title: 'Action',
                    render: function(data, type, row) {
                        return `
                            <button class="btn btn-xs btn-success" type="button" title="Confirm Reservation">Confirm</button>
                            <button class="btn btn-xs btn-danger" type="button" title="Reject Reservation">Reject</button>
                        `;
                    }
                }
            ],
            dom: 'Bfrtip',
            buttons: [
                'copyHtml5',
                'excelHtml5',
                'pdfHtml5'
            ]
        });

        $('#penRes').on('click', '.btn-danger', function () {
            var reservationId = $(this).closest('tr').find('td:first').text();
            $('#reservationId').val(reservationId);
            $('#cancelReservationModal').modal('show');
        });

        $('#confirmCancelReservation').on('click', function () {
            var reservationId = $('#reservationId').val();
            console.log(reservationId);

            $.ajax({
                url: '/profile',
                type: 'POST',
                data: {
                    reservationId: reservationId,
                    status: 'rejected'
                },
                success: function (response) {
                    if (response.success) {
                        $('#cancelReservationModal').modal('hide');
                        toastr.success('Reservation rejected successfully.');
                        window.location.reload();
                    } else {
                        toastr.error('Failed to reject the reservation. Please try again.');
                    }
                },
                error: function () {
                    toastr.error('Error occurred while rejecting the reservation.');
                }
            });
        });

        $('#penRes').on('click', '.btn-success', function () {
            var reservationsId = $(this).closest('tr').find('td:first').text();
            $('#reservationsId').val(reservationsId);
            $('#confirmReservationModal').modal('show');
        });

        $('#confirmReservation').on('click', function () {
            var reservationId = $('#reservationsId').val();
            console.log(reservationId);

            $.ajax({
                url: '/profile',
                type: 'POST',
                data: {
                    reservationId: reservationId,
                    status: 'confirmed'
                },
                success: function (response) {
                    if (response.success) {
                        $('#confirmReservationModal').modal('hide');
                        toastr.success('Reservation confirmed successfully.');
                        window.location.reload();
                    } else {
                        toastr.error('Failed to confirm the reservation. Please try again.');
                    }
                },
                error: function () {
                    toastr.error('Error occurred while confirming the reservation.');
                }
            });
        });


    });
</script>

</body>
</html>

