<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="common-database.jsp" %>

<%
    String emailId = request.getParameter("email-id");
    String password = request.getParameter("password");
    
    try{
        con = fetchConnection();
        stmt = con.createStatement();
        String query = "select * from passenger_register where email_id = '"+emailId+"' and password = '"+password+"'";
        rs = stmt.executeQuery(query);
        if(!rs.next()){
            String ERROR_MSG = "<center>"+
                                    "<font size=5 color=red>"+
                                        "<br><br> Invalid Credentials! <br><br>"+
                                        "<a href=\"../passenger-login-page.html\"> Click here to go back... </a>"+
                                    "</font>"+
                               "</center>";
            out.println(ERROR_MSG);
        } else {
			String passengerId = getCurrentPassengerIdByEmailid(emailId, password, out);
			String applicationId = getApplicationIdByPassengerId(passengerId, out);
			int loginStatus = 1;
			boolean isUpdated = updateLoginStatus(applicationId, loginStatus, out);
            if(isUpdated){
                response.sendRedirect("../welcome-passenger-form.html?applicationId="+applicationId);
            } else {
                out.println(" Error occurred while updating! ");
            }
        }
    } catch(Exception e){
        out.println(" Login Validity Exception: " +e);
    } finally {
        closeConnection();
    }
%>

<!-- 
	This method returns the current logged in passenger id, because we have to maintain the state of 
	the current passenger.
-->
<%!
    public static String getCurrentPassengerIdByEmailid(String emailId, String password, JspWriter out) throws Exception{
        String currentPassengerId = "";
		try{
            con = fetchConnection();
			stmt = con.createStatement();
			String query = "select passenger_id from passenger_register where email_id = '"+emailId+"' and password = '"+password+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				return null;
			} else {
				currentPassengerId = rs.getString("passenger_id");
			}
        } catch(Exception e){
            out.println(" Is User Already Created Exception: " +e);
        } finally {
            closeConnection();
        }
		return currentPassengerId;
    }
%>

<!-- This method is used to return application id of the previously logged in user. -->
<%!
	public static String getApplicationIdByPassengerId(String passengerId, JspWriter out) throws Exception{
		String applicationId = "";
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select application_form_id from passenger_form where passenger_id = '"+passengerId+"'";
			rs = stmt.executeQuery(query);
			rs.next();
			applicationId = rs.getString("application_form_id");
		} catch(Exception e){
			out.println(" Get application id exception: " +e);
		} finally {
			closeConnection();
		}
		return applicationId;
	}
%>

<%!
	public static boolean updateLoginStatus(String applicationId, int loginStatus, JspWriter out) throws Exception {
		boolean updateFlag = false;
        try{
			out.println("update");
			con = fetchConnection();
			stmt = con.createStatement();
			String updateQuery = "update passenger_form set login_status = "+loginStatus+" where application_form_id = '"+applicationId+"'";
			stmt.executeUpdate(updateQuery);
            updateFlag = true;
		} catch(Exception e){
			out.println(" Update login status exception: " +e);
		} finally{
			closeConnection();
		}
        return updateFlag;
	}
%>

<!--
Ready try catch body
try{
	con = fetchConnection();
	stmt = con.createStatement();
	String query = "";
	stmt.executeQuery();
	stmt.executeUpdate();
} catch(Exception e){
	out.println(" Update login status exception: " +e);
} finally{
	closeConnection();
}
-->