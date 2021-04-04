<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="common-database.jsp" %>

<%
    String passengerName = request.getParameter("passengerName");
    String emailId = request.getParameter("passengerEmailId");
    String phoneNumber = request.getParameter("passengerContactNo");
    String password = request.getParameter("passengerPassword");
    
    try{
		String passengerId = getNewPassengerId(out);
        boolean flag = storePassengerRegisterDetails(passengerId, passengerName, emailId, phoneNumber, password, out);
        if(flag){
			String applicationId = generateNewApplicationId();
			makeNewEntryToPassengerApplicationForm(applicationId, 0, 0, 0, passengerId, out);
            response.sendRedirect("../passenger-login-page.html");
        } else {
            String ERROR_MSG = "<center>"+
                                    "<font size=5 color=red>"+
                                        "<br><br><b>ERROR 404</b> <br><br> There is error occurred! <br><br>"+
                                        "<a href=\"../passenger-login-page.html\"> Click here to go back... </a>"+
                                    "</font>"+
                               "</center>";
            out.println(ERROR_MSG);
        }
    } catch(Exception e){
        out.println(" Exception: " +e);
    }
%>

<%!
    public static boolean storePassengerRegisterDetails(String passengerId, String passengerName, String emailId, String phoneNumber, String password, JspWriter out) throws Exception{
        boolean flag = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String insertQuery = "insert into passenger_register values('"+passengerId+"', '"+passengerName+"', '"+emailId+"', '"+phoneNumber+"', '"+password+"')";
            stmt.executeUpdate(insertQuery);
            flag = true;
        } catch(Exception e){
            out.println(" Passenger Registration Store Exception: " +e);
        } finally{
            closeConnection();
        }
        return flag;
    }
%>

<%!
    public static String getNewPassengerId(JspWriter out) throws Exception{
        String passengerId = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select passenger_id from passenger_register";
            rs = stmt.executeQuery(query);
            int pid = 0;
            if(!rs.next()){
                pid = 1;
                passengerId = "P"+pid;
            } else {
                rs.last();
                pid = Integer.parseInt(rs.getString("passenger_id").split("P")[1]);
                ++pid;
                passengerId = "P"+pid;
            }
        } catch(Exception e){
            out.println(" Get new passenger id exception: " +e);
        } finally {
            closeConnection();
        }
        return passengerId;
    }
%>

<%!
	public static String generateNewApplicationId(){
		LocalDate currentDate = LocalDate.now();
		LocalTime currentTime = LocalTime.now();
		
		return "APP" + currentDate.getYear() + "" + currentDate.getMonthValue() + "" + currentDate.getDayOfMonth() + "" +
							currentTime.getHour() + "" + currentTime.getMinute() + "" + currentTime.getSecond();
	}
%>

<!-- This method is used to maintain current user record of the application with initial values of status. -->
<%!
	public static void makeNewEntryToPassengerApplicationForm(String applicationId, int submitStatus, int paymentStatus, int loginStatus, String passengerId, JspWriter out) throws Exception{
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String insertQuery = "insert into passenger_form(application_form_id, submit_status, payment_status, login_status, passenger_id) values ('"+applicationId+"', '"+submitStatus+"', '"+paymentStatus+"', '"+loginStatus+"', '"+passengerId+"')";			
			stmt.executeUpdate(insertQuery);
		} catch(Exception e){
			out.println(" New application id exception: " +e);
		} finally {
			closeConnection();
		}
	}
%>