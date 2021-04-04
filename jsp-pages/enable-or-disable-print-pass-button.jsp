<%@ page language="java" import="java.sql.*, java.util.*, java.time.*, java.io.*"%>
<%@include file="common-database.jsp" %>
<%
    String applicationId = request.getParameter("applicationId");
    try{
        boolean flag = checkPaymentStatus(applicationId, out);
        if(flag){
            out.println("1");
        } else {
            out.println("0");
        }
    } catch(Exception e){
        out.println(" Payment status exception: " +e);
    }
%>

<%!
    public static boolean checkPaymentStatus(String applicationId, JspWriter out) throws Exception{
        boolean isApproved = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String selectQuery = "select approve_status,submit_status,payment_status from passenger_form where application_form_id = '"+applicationId+"'";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                isApproved = false;
            } else {
                int approveStatus = rs.getInt("approve_status");
                int submitStatus = rs.getInt("submit_status");
                int paymentStatus = rs.getInt("payment_status");
                isApproved = (approveStatus == 1 && submitStatus == 1 && paymentStatus == 1) ? true : false;
                //Meaning of above line is form is approved & submitted but not payment is not made.
            }
        } catch(Exception e){
            out.println(" Check payment status exception: " +e);
        } finally {
            closeConnection();
        }
        return isApproved;
    }
%>