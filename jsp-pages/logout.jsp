<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationId = request.getParameter("applicationNo");
    if(applicationId == null){
        applicationId = request.getParameter("applicationId");
    }
    int loginStatus = 0;
    boolean isUpdated = updateLoginStatus(applicationId, loginStatus, out);
    if(isUpdated){
        String MESSAGE = "<center>"+
                            "<font size=5 color=green>"+
                                "Logout successfully!!!<br><br>"+
                                "<a href=\"../passenger-login-page.html\">Click here login again.!!!</a>"+
                            "</font>"+
                         "<center>";
        out.println(MESSAGE);
    }
%>

<%!
    public static boolean updateLoginStatus(String applicationId, int loginStatus, JspWriter out) throws Exception{
        boolean isUpdatedFlag = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String updateQuery = "update passenger_form set login_status = "+loginStatus+" where application_form_id = '"+applicationId+"'";
            stmt.executeUpdate(updateQuery);
            isUpdatedFlag = true;
        } catch(Exception e){
            out.println(" Update login status exception: " +e);
        } finally {
            closeConnection();
        }
        return isUpdatedFlag;
    }
%>