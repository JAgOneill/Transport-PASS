<%@ page language="java" import="java.sql.*, java.text.*, java.util.*, java.time.*, java.io.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationId = request.getParameter("applicationId");
    try{
        float amount = getPaymentAmount(applicationId, out);
        out.println(amount);
    } catch(Exception e){
        out.println(" Payment exception: " +e);
    }
%>

<%!
    public static float getPaymentAmount(String applicationId, JspWriter out) throws Exception{
        float amount = 0.0f;
        try{
            String dob = getDOB(applicationId, out);
            LocalDate localDateDOB = LocalDate.parse(dob);
            LocalDate currentDate = LocalDate.now();
            Period difference = Period.between(localDateDOB, currentDate);
            int differenceYears = difference.getYears();
            if(differenceYears > 16 && differenceYears <= 25){
                amount = 750.0f;
            } else if(differenceYears >= 26 && differenceYears <= 60){
                amount = 1400.0f;
            } else if(differenceYears >= 61){
                amount = 900.0f;
            }
        } catch(Exception e){
            out.println(" Get payment amount exception: " +e);
        } finally {
            closeConnection();
        }
        return amount;
    }
%>

<%!
    public static String getDOB(String applicationId, JspWriter out) throws Exception{
        String dob = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String selectQuery = "select passenger_dob from passenger_form where application_form_id = '"+applicationId+"'";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                out.println(" Date of birth not provided");
            } else {
                dob = rs.getString("passenger_dob");
            }
        } catch(Exception e){
            out.println(" Get DOB Exception: " +e);
        } finally {
            closeConnection();
        }
        return dob;
    }
%>