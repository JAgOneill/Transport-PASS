<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationNo = request.getParameter("applicationId");
    try{
        String status = isApplicationCreated(applicationNo, out);
        out.println(status);
    } catch(Exception e){
        out.println(" Exception: " +e);
    }
%>

<%!
    public static String isApplicationCreated(String applicationId, JspWriter out) throws Exception{
        String status = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String selectQuery = "select * from passenger_form where application_form_id = '"+applicationId+"'";
            rs = stmt.executeQuery(selectQuery);
            rs.next();
            if(rs.getString("passenger_name").equals("") || rs.getString("passenger_name") == null){
                status = "0";
            } else {
                status = "1";
            }
        } catch(Exception e){
            out.println(" isApplicationCreated exception: " +e);
        } finally {
            closeConnection();
        }
        return status;
    }
%>