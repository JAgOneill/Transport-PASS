<%@ page language="java" import="java.sql.*, java.util.*, java.time.*, java.io.*"%>
<%@include file="common-database.jsp" %>

<%
    try{
        boolean isFound = showRecordOfPendingRequests(out);
        if(!isFound){
            out.println(" <tr> <td> Records not found! </td> </tr>");
        }
    } catch(Exception e){
        out.println(" Exception: " +e);
    }
%>

<%!
    public static boolean showRecordOfPendingRequests(JspWriter out) throws Exception{
        boolean isFoundFlag = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String selectQuery = "select * from passenger_form where submit_status = 1 and approve_status = 0";
            rs = stmt.executeQuery(selectQuery);
            
            if(!rs.next()){
                isFoundFlag = false;
            } else {
                rs.previous();
                int index = 1;
                String data = "";
                while(rs.next()){
                    String applicationId = rs.getString("application_form_id");
                    String passengerName = rs.getString("passenger_name");
                    int intSubmitStatus = rs.getInt("submit_status");
                    String submitStatus = (intSubmitStatus == 1) ? "YES" : "NO";
                    String url = "pending-approvals-verification-page.html?applicationId="+applicationId;
                    
                    data += "<tr>"+
                                "<td class=\"align-middle\" scope=\"row\">"+(index++)+"</td>"+
                                "<td class=\"align-middle\">"+applicationId+"</td>"+
                                "<td class=\"align-middle\">"+passengerName+"</td>"+
                                "<td class=\"align-middle\">"+submitStatus+"</td>"+
                                "<td> <a type=\"button\" class=\"btn btn-primary btn-sm\" href="+url+">Approve/Reject</a> </td>"+
                            "</tr>";
                }
                out.println(data);
                isFoundFlag = true;
            }
        } catch(Exception e){
            out.println(" Pending request exception: " +e);
        } finally {
            closeConnection();
        }
        return isFoundFlag;
    }
%>