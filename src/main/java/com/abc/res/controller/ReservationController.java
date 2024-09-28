package com.abc.res.controller;

import com.abc.res.model.BranchModel;
import com.abc.res.model.CommonMsgModel;
import com.abc.res.model.ReservationModel;
import com.abc.res.service.ReservationService;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import static com.abc.res.service.HomeService.getHomeService;
import static com.abc.res.service.ReservationService.getReservationService;

@WebServlet("/reservation")
public class ReservationController extends HttpServlet {

    private ReservationService reservationService;

    @Override
    public void init() throws ServletException {
        super.init();
        reservationService = getReservationService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        List<BranchModel> branches = reservationService.getAllBranches();
        req.setAttribute("branches", branches);
        req.getRequestDispatcher("/WEB-INF/view/web/reservation.jsp").forward(req, res);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        CommonMsgModel message;
        res.setContentType("application/json");
        PrintWriter out = res.getWriter();

        try {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String date = req.getParameter("reservationDate");
            String time = req.getParameter("reservationTime");
            int numberOfPeople = Integer.parseInt(req.getParameter("numberOfPeople"));
            String specialMsg = req.getParameter("message");
            String type = req.getParameter("reservationType");
            String branch = req.getParameter("branchId");

            // Parse date and time
            LocalDate reservationDate = LocalDate.parse(date);
            LocalTime reservationTime = LocalTime.parse(time);

            // Create ReservationModel
            ReservationModel reservationModel = new ReservationModel();
            reservationModel.setName(name);
            reservationModel.setEmail(email);
            reservationModel.setContactNumber(phone);
            reservationModel.setReservationDate(reservationDate);
            reservationModel.setReservationTime(reservationTime);
            reservationModel.setNumberOfPeople(numberOfPeople);
            reservationModel.setMessage(specialMsg);
            reservationModel.setReservationType(type);
            reservationModel.setBranchId(Integer.parseInt(branch));

            message = getReservationService().addReservation(reservationModel, req);

            out.println(new Gson().toJson(message));
            out.flush();

        } catch (Exception e) {
            message = new CommonMsgModel("Something went wrong.", false, null);
            out.print(new Gson().toJson(message.toJsonObject()));
            out.flush();
            e.printStackTrace();
        }
    }

}


