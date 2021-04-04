<%@ page language="java" import="java.sql.*, java.util.*, java.time.*, java.io.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationId = request.getParameter("applicationId");
    try{
        boolean flag = checkApproveStatus(applicationId, out);
        if(flag){
            out.println("1");
        } else {
            out.println("0");
        }
    } catch(Exception e){
        out.println(" Approved status exception: " +e);
    }
%>

<%!
    public static boolean checkApproveStatus(String applicationId, JspWriter out) throws Exception{
        boolean isApproved = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String selectQuery = "select approve_status from passenger_form where application_form_id = '"+applicationId+"'";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                isApproved = false;
            } else {
                int approveStatus = rs.getInt("approve_status");
                isApproved = (approveStatus == 1) ? true : false;
            }
        } catch(Exception e){
            out.println(" Check approve status exception: " +e);
        } finally {
            closeConnection();
        }
        return isApproved;
    }
%>