<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationId = request.getParameter("applicationId").split("=")[1];
    String reasonOfReject = request.getParameter("reasonOfReject");
    
    try{
        boolean flag = storeApplicationRejectionReason(applicationId, reasonOfReject, out);
        if(flag){
            makeApproveRejectEntryToForm(applicationId, -1, out);
            out.println("1");
        } else {
            out.println("0");
        }
    } catch(Exception e){
        out.println(" Submit reason exception: " +e);
    }
%>


<%!
    public static boolean storeApplicationRejectionReason(String applicationId, String reasonOfReject, JspWriter out) throws Exception{
        boolean flag = false;
        String newId = getNewRejectionTableId(out);
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String insertQuery = "insert into admin_rejection_list values('"+newId+"', '"+reasonOfReject+"', '"+applicationId+"')";
            stmt.executeUpdate(insertQuery);
            flag = true;
        } catch(Exception e){
            out.println(" Store reason exception: " +e);
        } finally {
            closeConnection();
        }
        return flag;
    }
%>

<%!
    public static String getNewRejectionTableId(JspWriter out) throws Exception{
        String newId = null;
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String selectQuery = "select * from admin_rejection_list";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                newId = "R1";
            } else {
                rs.last();
                int id = Integer.parseInt(rs.getString("rejection_id").split("R")[1]);
                id++;
                newId = "R"+id;
            }
        } catch(Exception e){
            out.println(" Exception: " +e);
        } finally {
            closeConnection();
        }
        return newId;
    }
%>

<%!
    public static void makeApproveRejectEntryToForm(String applicationId, int approveStatus, JspWriter out) throws Exception{
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String updateQuery = "update passenger_form set approve_status = "+approveStatus+" where application_form_id = '"+applicationId+"'";
            stmt.executeUpdate(updateQuery);
        } catch(Exception e){
            out.println(" Exception while approval entry: " +e);
        } finally {
            closeConnection();
        }
    }
%>