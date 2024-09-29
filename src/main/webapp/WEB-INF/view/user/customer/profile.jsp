<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="com.google.gson.JsonSerializer" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="/WEB-INF/view/layout/header.jsp" %>

<style>

  .profile-section {
    padding: 50px 0;
    background-color: #f8f9fa;
  }

  .profile-section h2 {
    text-align: center;
    color: #000000;
    margin-bottom: 30px;
    font-size: 36px;
    margin-top: 20px;
    font-weight: 700;
  }

  .profile-details {
    margin-bottom: 40px;
  }

  .profile-details h3 {
    color: #000000;
    font-weight: 600;
    font-size: 24px;
    margin-bottom: 20px;
  }

  .profile-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
  }

  .profile-table th, .profile-table td {
    padding: 12px 15px;
    text-align: left;
    border: 1px solid #ddd;
  }

  .profile-table th {
    background-color: #BD965A;
    color: #fff;
    font-weight: 600;
  }

  .profile-table td {
    background-color: #fff;
  }

  .profile-table tbody tr:nth-child(even) {
    background-color: #f2f2f2;
  }

  .profile-table tbody tr:hover {
    background-color: #f1f1f1;
  }

  #reservations-table, #orders-table {
    margin-top: 20px;
    margin-bottom: 40px;
  }

  .btn-xs {
    font-size: 0.85rem;
  }

  /* CSS for Modal */
  .modal-header {
    background-color: #DC3545;
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

<div class="profile-section" id="profile">
  <div class="container"><br><br><br>
    <h2>My Profile</h2>

    <div class="profile-details">
      <h3>My Reservations</h3>
      <table class="profile-table" id="reservations-table">
        <thead>
        <tr>
          <th>Reservation ID</th>
          <th>Date</th>
          <th>Time (24h)</th>
          <th>Branch</th>
          <th>Type</th>
          <th>Guests</th>
          <th>Special Note</th>
          <th>Status</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
    </div>

    <div class="profile-details">
      <h3>My Orders</h3>
      <table class="profile-table" id="orders-table">
        <thead>
        <tr>
          <th>Order ID</th>
          <th>Order Date</th>
          <th>Items</th>
          <th>Total (LKR)</th>
          <th>Status</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- Delete Modal HTML -->
<div class="modal fade" id="cancelReservationModal" tabindex="-1" role="dialog" aria-labelledby="cancelReservationLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="cancelReservationLabel">Cancel Reservation</h5>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to cancel this reservation?</p>
        <input type="hidden" id="reservationId" value=""/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary close" data-dismiss="modal">No</button>
        <button type="button" class="btn btn-danger" id="confirmCancelReservation">Yes, Cancel</button>
      </div>
    </div>
  </div>
</div>


<%@include file="/WEB-INF/view/layout/footer.jsp" %>

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
  const orders = <%= gson.toJson(request.getAttribute("orders")) %>;

  $(document).ready(function () {
    var tableBody = document.querySelector("#reservations-table tbody");

    reservations.forEach(function(reservation) {
      var row = document.createElement("tr");
      row.innerHTML = "<td>" + reservation.res_id + "</td>" +
              "<td>" + reservation.reservation_date + "</td>" +
              "<td>" + reservation.reservation_time + "</td>" +
              "<td>" + reservation.branchName + "</td>" +
              "<td>" + reservation.message + "</td>" +
              "<td>" + reservation.number_of_people + "</td>" +
              "<td>" + reservation.reservation_type + "</td>" +
              "<td>" + (reservation.status === "pending"
                      ? '<button class="btn btn-danger btn-xs" type="button" title="Cancel Reservation">Cancel</button>'
                      : (reservation.status || 'N/A')) + "</td>";
      tableBody.appendChild(row);
    });

    $('#reservations-table').on('click', '.btn-danger', function () {
      var reservationId = $(this).closest('tr').find('td:first').text();
      $('#reservationId').val(reservationId); // Store the reservation ID in hidden input field
      $('#cancelReservationModal').modal('show'); // Show the modal
    });

    $('#confirmCancelReservation').on('click', function () {
      var reservationId = $('#reservationId').val();
      console.log(reservationId);

      $.ajax({
        url: '/profile',
        type: 'POST',
        data: {
          reservationId: reservationId,
          status: 'canceled'
        },
        success: function (response) {
          if (response.success) {
            $('#reservations-table tbody tr').each(function () {
              if ($(this).find('td:first').text() === reservationId) {
                $(this).find('td:last').html('Canceled');
              }
            });
            $('#cancelReservationModal').modal('hide');
            toastr.success('Reservation canceled successfully.');
          } else {
            toastr.error('Failed to cancel the reservation. Please try again.');
          }
        },
        error: function () {
          toastr.error('Error occurred while canceling the reservation.');
        }
      });
    });

  });

  const ordersTableBody = document.querySelector("#orders-table tbody");

  ordersTableBody.innerHTML = "";

  orders.forEach((order) => {
    const row = document.createElement("tr");

    const orderIdCell = document.createElement("td");
    orderIdCell.textContent = order.id;

    const orderDateCell = document.createElement("td");
    orderDateCell.textContent = order.orderDate;

    const itemsCell = document.createElement("td");
    itemsCell.textContent = order.orderItems.map((item) => item.name).join(", ");

    const totalCell = document.createElement("td");
    totalCell.textContent = order.totalAmount.toFixed(2);

    const statusCell = document.createElement("td");
    statusCell.textContent = order.orderStatus.charAt(0).toUpperCase() + order.orderStatus.slice(1);

    row.appendChild(orderIdCell);
    row.appendChild(orderDateCell);
    row.appendChild(itemsCell);
    row.appendChild(totalCell);
    row.appendChild(statusCell);

    ordersTableBody.appendChild(row);
  });

</script>

</body>
</html>
