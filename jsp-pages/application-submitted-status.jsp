<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="common-database.jsp" %>

<%
    try{
        String applicationId = request.getParameter("applicationId");
        con = fetchConnection();
        stmt = con.createStatement();
        String selectQuery = "select submit_status from passenger_form where application_form_id = '"+applicationId+"'";
        rs = stmt.executeQuery(selectQuery);
        if(!rs.next()){
            out.println("-1");  //It means record is not stored in the database.
        } else {
            out.println(rs.getInt("submit_status"));
        }
    } catch(Exception e){
        out.println(" Exception: " +e);
    } finally {
        closeConnection();
    }
%>