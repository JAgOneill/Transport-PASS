<%@ page language="java" import="java.sql.*, java.util.*, java.time.*, java.io.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationId = request.getParameter("applicationId").split("=")[1];
    try{
        showApplicationOnVertificationPage(applicationId, out);
    } catch(Exception e){
        out.println(" Exception: " +e);
    }
%>

<%!
    public static void showApplicationOnVertificationPage(String applicationId, JspWriter out) throws Exception{
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String selectQuery = "select * from passenger_form where application_form_id = '"+applicationId+"'";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                out.println(" No Record Found");
            } else {
                String passengerName = rs.getString("passenger_name");
                String address = rs.getString("full_address");      
                String passengerDOB = rs.getString("passenger_dob");
                
                String gender = rs.getString("gender");
                String busRouteFrom = rs.getString("bus_route_from");
                String busRouteTo = rs.getString("bus_route_to");
                
                String registerDate = rs.getString("register_date");
                String submitStatus = (rs.getInt("submit_status") == 1) ? "YES" : "NO";

                String paymentStatus = (rs.getInt("payment_status") == 1) ? "YES" : "NO";
                String photo = rs.getString("photo");

                String aadharCard = rs.getString("aadhar_card");
                //String rs.getString("passenger_id");
                
                String data = "<tr>"+
                                "<th><b>Application Id:</b></th>"+
                                "<th>"+applicationId+"</th>"+
                              "</tr>"+
                              
                              "<tr>"+
                                "<th><b>Applicant's Name:<b></th>"+
                                "<th>"+passengerName+"</th>"+
                              "</tr>"+
                              
                              "<tr>"+
                                "<th><b>Payment Status:<b></th>"+
                                "<th>"+paymentStatus+"</th>"+
                              "</tr>"+
                              
                              "<tr>"+
                                "<th><b>Gender:<b></th>"+
                                "<th>"+gender+"</th>"+
                              "</tr>"+
                              
                              "<tr>"+
                                "<th><b>Route From:<b></th>"+
                                "<th>"+busRouteFrom+"</th>"+
                              "</tr>"+
                              
                              "<tr>"+
                                "<th><b>Route To:<b></th>"+
                                "<th>"+busRouteTo+"</th>"+
                              "</tr>"+
                              
                              "<tr>"+
                                "<th><b>Address:<b></th>"+
                                "<th>"+address+"</th>"+
                              "</tr>";
                out.println(data +"$"+ photo + "$" +aadharCard + "$" + applicationId);
            }
        } catch(Exception e){
            out.println(" Verification exception: " +e);
        } finally {
            
        }
    }
%>