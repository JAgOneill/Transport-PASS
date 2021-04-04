<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationNo = request.getParameter("applicationNo");
    try {
        showApplicationStatusByNo(applicationNo, out);
    } catch(Exception e){
        out.println(" Exception: " +e);
    }
%>

<%!
    public static void showApplicationStatusByNo(String applicationNo, JspWriter out) throws Exception{
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String selectQuery = "select passenger_name,approve_status from passenger_form where application_form_id = '"+applicationNo+"'";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                out.println(" Records not found!");
            } else {
                //Here approveStatus means applicationStatus
                String approveStatus = rs.getInt("approve_status") == 1 ? "Approved" : "Pending";
				
				if(rs.getInt("approve_status") == 1)
					approveStatus="Approved";
				else if(rs.getInt("approve_status") == -1)
					approveStatus="Rejected";
				else
					approveStatus="Pending";
				
                String showTable = "<tr>"+
                                        "<td><b>Application No:</b></td>"+
                                        "<td>"+applicationNo+"</td>"+
                                   "</tr>"+
                                   "<tr>"+
                                        "<td><b>Name:</b></td>"+
                                        "<td>"+rs.getString("passenger_name")+"</td>"+
                                   "</tr>"+
                                   "<tr>"+
                                        "<td><b>Approve Status</b></td>"+
                                        "<td>"+approveStatus+"</td>"+
                                   "</tr>";
               out.println(showTable);
            }
        } catch(Exception e){
            out.println(" showApplicationStatusByNo: " +e);
        } finally {
            closeConnection();
        }
    }
%>