<%@ page language="java" import="java.sql.*, java.util.*, java.time.*, java.io.*"%>
<%@include file="common-database.jsp" %>

<%
    try{
        showRejectApplications(out);
    } catch(Exception e){
        out.println(" Rejection exception: " +e);
    }
%>

<%!
    public static void showRejectApplications(JspWriter out) throws Exception{
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String selectQuery = "select * from admin_rejection_list where application_form_id in (select application_form_id from passenger_form where approve_status = -1)";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                out.println(" <tr> <td> </td> <td> Record not found! </td> <td> </td> </tr>");
            } else {
                rs.previous();
                int index = 1;
                String data = "";
                while(rs.next()){
                    String applicationId = rs.getString("application_form_id");
                    String reason = rs.getString("description_of_rejection");
                
                    data += "<tr>"+
                                "<td class=\"align-middle\" scope=\"row\">"+(index++)+"</td>"+
                                "<td class=\"align-middle\">"+applicationId+"</td>"+
                                "<td class=\"align-middle\">"+reason+"</td>"+
                            "</tr>";
                }
                out.println(data);
            }
        } catch(Exception e){
            out.println(" Show rejection application list exception: " +e);
        } finally {
            closeConnection();
        }
    }
%>