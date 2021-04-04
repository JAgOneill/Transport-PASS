<%@ page language="java" import="java.sql.*, java.text.*, java.util.*, java.time.*, java.io.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationId = request.getParameter("applicationId");
    try{
        String rejectReason = isApplicationRejected(applicationId, out);
        if(rejectReason == null){
            out.println("0");
        } else {
            out.println(rejectReason);
        }
    } catch(Exception e){
        out.println(" Is rejected exception: " +e);
    }
%>

<%!
    public static String isApplicationRejected(String applicationId, JspWriter out) throws Exception {
        String rejectReason = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String selectQuery = "select description_of_rejection from admin_rejection_list, passenger_form where passenger_form.application_form_id = '"+applicationId+"' and passenger_form.approve_status = -1";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                return null;
            } else {
                rejectReason = rs.getString("description_of_rejection");
            }
        } catch(Exception e){
            out.println(" Application rejected exception: " +e);
        } finally {
            closeConnection();
        }
        return rejectReason;
    }
%>