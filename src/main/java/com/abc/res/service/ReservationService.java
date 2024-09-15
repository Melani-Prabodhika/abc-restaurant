package com.abc.res.service;

import com.abc.res.dao.BranchDao;
import com.abc.res.dao.ReservationDao;
import com.abc.res.dao.ReservationDaoImpl;
import com.abc.res.model.BranchModel;
import com.abc.res.model.CommonMsgModel;
import com.abc.res.model.ReservationModel;
import com.abc.res.utils.mail.EmailSender;

import javax.servlet.http.HttpServletRequest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.regex.Pattern;

public class ReservationService {

    private static ReservationService reservationService;
    private BranchDao branchDao;

    private ReservationService() {
        branchDao = new BranchDao();
    }

    private ReservationDao getReservationDao() {
        return new ReservationDaoImpl();
    }

    public static synchronized ReservationService getReservationService() {
        if (reservationService == null) {
            reservationService = new ReservationService();
        }
        return reservationService;
    }

    public List<BranchModel> getAllBranches() {
        return branchDao.getAllBranches();
    }

    private static EmailSender getEmailSender() {
        return EmailSender.getEmailSender();
    }

    private boolean isValidReservationDateTime(LocalDate date, LocalTime time) {
        LocalDate today = LocalDate.now();
        LocalTime currentTime = LocalTime.now();

        // Check if the reservation date is in the past
        if (date.isBefore(today)) {
            return false;
        }

        // Check if the reservation is for today and the time is valid
        if (date.isEqual(today)) {
            // Time must be between 10 AM and 10 PM
            if (time.isBefore(LocalTime.of(10, 0)) || time.isAfter(LocalTime.of(22, 0))) {
                return false;
            }
            // Check if the current time is past 10 PM
            if (currentTime.isAfter(LocalTime.of(22, 0))) {
                return false;
            }
        } else {
            // Check if the time is valid for future reservations
            if (time.isBefore(LocalTime.of(10, 0)) || time.isAfter(LocalTime.of(22, 0))) {
                return false;
            }
        }
        return true;
    }

    public CommonMsgModel addReservation(ReservationModel reservationModel, HttpServletRequest req) throws SQLException, NoSuchAlgorithmException, ClassNotFoundException {
        // Patterns for validation
        Pattern emailPattern = Pattern.compile("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$");
        Pattern phonePattern = Pattern.compile("[^\\d+]");

        // Validate reservation fields
        if (reservationModel.getName().length() > 100 || reservationModel.getName().isEmpty()) {
            return new CommonMsgModel("Invalid Customer Name!", false, null);
        } else if (!emailPattern.matcher(reservationModel.getEmail()).matches()) {
            return new CommonMsgModel("Invalid E-mail!", false, null);
        } else if (reservationModel.getContactNumber().length() > 15 || reservationModel.getContactNumber().length() < 6 || phonePattern.matcher(reservationModel.getContactNumber()).find()) {
            return new CommonMsgModel("Invalid Phone Number!", false, null);
        } else if (reservationModel.getNumberOfPeople() <= 0) {
            return new CommonMsgModel("Number of people must be greater than 0!", false, null);
        } else if (!isValidReservationDateTime(reservationModel.getReservationDate(), reservationModel.getReservationTime())) {
            return new CommonMsgModel("Invalid Reservation Date/Time!", false, null);
        } else if(reservationModel.getMessage().length() > 500) {
            return new CommonMsgModel("Invalid Message!", false, null);
        }else if(reservationModel.getReservationType().isEmpty()) {
            return new CommonMsgModel("Please Select a Reservation Type!", false, null);
        }else if(reservationModel.getBranchId() <= 0) {
            return new CommonMsgModel("Please Select a Branch!", false, null);
        }else {
            boolean isSuccess = getReservationDao().addReservation(reservationModel, req);
            if (isSuccess) {
                getEmailSender().sendMail(reservationModel.getEmail(), "Reservation Received Successfully - Confirmation Pending", "Hey,\n" +
                        "\n" +
                        "Thank you for choosing ABC Restaurants!"  +
                        "\n" +
                        "We are excited to inform you that your reservation request has been successfully placed. Our team is currently reviewing the details, and we will send you a confirmation email shortly after verifying the availability of your requested time and date." +
                        "\n" +
                        "If you have any questions or need to make changes to your reservation, please feel free to contact us." +
                        "\n" +
                        "We look forward to welcoming you soon at ABC Restaurants.\n" +
                        "\n" +
                        "Best regards,\n" +
                        "ABC Restaurants Team");
                return new CommonMsgModel("Reservation successfully added. You will get a confirmation email within 24 hours.", true, null);
            } else {
                return new CommonMsgModel("Failed to add reservation.", false, null);
            }
        }
    }
}

