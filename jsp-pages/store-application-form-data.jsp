<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*, com.oreilly.servlet.MultipartRequest"%>
<%@include file="common-database.jsp" %>

<%
    String applicationNo = request.getParameter("applicationNo");
    String passengerName = request.getParameter("passengerName");
    String passengerDOB = request.getParameter("passengerDOB");
    String busRouteFrom = request.getParameter("busRouteFrom");
    String busRouteTo = request.getParameter("busRouteTo");
    String city = request.getParameter("city");
    String gender = request.getParameter("gender").equals("male") ? "Male" : "Female";
    String address = request.getParameter("address");
    int paymentStatus = 0;
    int submitStatus = 1;
    int approveStatus = 0;
    
    String path = System.getProperty("user.dir");
    String uploadFolderPath = path + File.separator + ".." + File.separator + "webapps" + File.separator + "pmt-pass" + File.separator + "uploaded-docs";
    String actualFilePath = uploadFolderPath + File.separator + applicationNo;

    File photoAbsolutePath = new File(actualFilePath);
    String files[] = photoAbsolutePath.list();
    String photoFilePath = "";
    String aadharCardFilePath = "";
    for(String fileName : files){
        if(fileName.split("-")[1].equals("AADHAR")){
            aadharCardFilePath = actualFilePath + File.separator + fileName;
        } else {
            photoFilePath = actualFilePath + File.separator + fileName;
        }
    }
    
    try{
        LocalDate date = LocalDate.now();
        String registerDate = date.toString();
        con = fetchConnection();
        stmt = con.createStatement();
        String insertQuery = "update passenger_form set passenger_name = '"+passengerName+"', full_address = '"+address+"', passenger_dob = '"+passengerDOB+"', bus_route_from = '"+busRouteFrom+"', bus_route_to = '"+busRouteTo+"', register_date = '"+registerDate+"', city = '"+city+"', gender = '"+gender+"', submit_status = "+submitStatus+", payment_status = "+paymentStatus+", approve_status = '"+approveStatus+"', photo = '"+photoFilePath+"', aadhar_card = '"+aadharCardFilePath+"' where application_form_id = '"+applicationNo+"'";
        stmt.executeUpdate(insertQuery);
        
        String dashboard = "../dashboard.html?applicationNo="+applicationNo;
        String successMessage = "<center>"+
                                    "<font size=5 color=green>"+
                                        "<br> <b> Data successfully stored. </b>"+
                                        "<br> <a href="+dashboard+">Click here to go Dashboard</a>"+
                                    "</font>"+
                                "</center>";
        out.println(successMessage);
    } catch(Exception e){
        out.println(" Store bus pass form data exception: " +e);
    } finally {
        closeConnection();
    }
%>
