<%@ page language="java" import="java.sql.*, java.util.*, java.time.*, java.io.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationId = request.getParameter("applicationId");
    try{
        boolean flag = checkPaymentStatusOfRenewPass(applicationId, out);
        if(flag){
            out.println("1");
        } else {
            out.println("0");
        }
    } catch(Exception e){
        out.println(" Check renew payment status exception: " +e);
    }
%>

<%!
    public static boolean checkPaymentStatusOfRenewPass(String applicationId, JspWriter out) throws Exception{
        boolean flag = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select * from renew_pass where payment_status = 1 and application_form_id = '"+applicationId+"'";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                flag = false;
            } else {
                flag = true;
            }
        } catch(Exception e){
            out.println(" Check payment status exception: " +e);
        } finally {
            closeConnection();
        }
        return flag;
    }
%>