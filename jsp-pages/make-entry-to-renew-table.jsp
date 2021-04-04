<%@ page language="java" import="java.sql.*, java.util.*, java.time.*, java.io.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationId = request.getParameter("applicationId");
    String fromDate = request.getParameter("fromDate");
    
    try{
        boolean flag = makeNewEntryToRenewPassTable(applicationId, fromDate, 0, out);
        if(flag){
            out.println("1");
        } else {
            out.println("0");
        }
    } catch(Exception e){
        out.println(" Make entry renew exception: " +e);
    }
%>

<%!
    public static boolean makeNewEntryToRenewPassTable(String applicationId, String fromDate, int paymentStatus, JspWriter out) throws Exception{
        boolean flag = false;
        try{
            String newId = getNewRenewId(out);
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "insert into renew_pass values('"+newId+"', '"+fromDate+"', "+paymentStatus+", '"+applicationId+"')";
            stmt.executeUpdate(query);
            flag = true;
        } catch(Exception e){
            out.println(" Make new entry exception: " +e);
        } finally {
            closeConnection();
        }
        return flag;
    }
%>

<%!
    public static String getNewRenewId(JspWriter out) throws Exception{
        String newId = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select renew_id from renew_pass";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                newId = "R1";
            } else {
                rs.last();
                int intId = Integer.parseInt(rs.getString("renew_id").split("R")[1]);
                intId++;
                newId = "R"+intId;
            }
        } catch(Exception e){
            out.println(" Make new entry exception: " +e);
        } finally {
            closeConnection();
        }
        return newId;
    }
%>