<%@ page language="java" import="java.sql.*, java.text.*, java.util.*, java.time.*, java.io.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationId = request.getParameter("applicationId");
    float amount = Float.parseFloat(request.getParameter("amount"));
    try{
        boolean flag = storePaymentDetails(applicationId, amount, out);
        if(flag){
            updatePaymentStatus(applicationId, 1, out);
            out.println("1");
        } else {
            out.println("0");
        }
    } catch(Exception e){
        out.println(" Store payment exception: " +e);
    }
%>

<%!
    public static boolean storePaymentDetails(String applicationId, float amount, JspWriter out) throws Exception {
        boolean isStoredFlag = false;
        try{
            String newPaymentId = getNewPaymentId(out);
            con = fetchConnection();
            stmt = con.createStatement();
            String insertQuery = "insert into payment_details values('"+newPaymentId+"', '"+amount+"', '"+applicationId+"')";
            stmt.executeUpdate(insertQuery);
            isStoredFlag = true;
        } catch(Exception e){
            out.println("Store payment details exception: " +e);
        } finally {
            closeConnection();
        }
        return isStoredFlag;
    }
%>

<%!
    public static String getNewPaymentId(JspWriter out) throws Exception {
        String paymentId = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String selectQuery = "select payment_id from payment_details";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                paymentId = "P1";
            } else {
                rs.last();
                int oldId = Integer.parseInt(rs.getString("payment_id").split("P")[1]);
                oldId++;
                paymentId = "P"+oldId;
            }
        } catch(Exception e){
            out.println(" New payment id exception: " +e);
        } finally{
            closeConnection();
        }
        return paymentId;
    }
%>

<%!
    public static void updatePaymentStatus(String applicationId, int paymentStatus, JspWriter out) throws Exception {
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String updateQuery = "update renew_pass set payment_status = "+paymentStatus+" where application_form_id = '"+applicationId+"'";
            stmt.executeUpdate(updateQuery);
        } catch(Exception e){
            out.println(" Update renew payment status exception: " +e);
        } finally {
            closeConnection();
        }
    }
%>