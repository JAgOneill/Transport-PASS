<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationId = request.getParameter("applicationId");
    try{
        int isApproved = updateApproveStatus(applicationId, 1, out);
        if(isApproved == 1){
            out.println(" Approved status updated.");
        } else {
            out.println(" Approved status not updated.");
        }
    } catch(Exception e){
        out.println(" Approve exception: " +e);
    }
%>

<%!
    public static int updateApproveStatus(String applicationId, int approve_status, JspWriter out) throws Exception{
        int isApprove = -1;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String updateQuery = "update passenger_form set approve_status = "+approve_status+" where application_form_id = '"+applicationId+"'";
            stmt.executeUpdate(updateQuery);
            isApprove = 1;
        } catch(Exception e){
            out.println(" Update approve status exception: " +e);
        } finally {
            closeConnection();
        }
        return isApprove;
    }
%>