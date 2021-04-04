<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="common-database.jsp" %>

<%
	String applicationId = request.getParameter("applicationNo").split("=")[1];
	try{
		List<String> applicationData = getApplicationById(applicationId, out);
		if(applicationData == null){
			out.println(" Records not found!");
		} else {
			String paymentStatus = applicationData.get(8).equals("1") ? "Yes" : "No";
			
			String data = ""+
					"<tr>"+
						"<th><b>Application Id:</b></th>"+
						"<th>"+applicationData.get(0)+"</th>"+
					"</tr>"+
					"<tr>"+
						"<th><b>Applicant's Name:<b></th>"+
						"<th>"+applicationData.get(1)+"</th>"+
					"</tr>"+
					"<tr>"+
						"<th><b>Payment Status:<b></th>"+
						"<th>"+paymentStatus+"</th>"+
					"</tr>";
			out.println(data);
		}
	} catch(Exception e){
		out.println(" Exception: " +e);
	}
%>

<%!
	public static List<String> getApplicationById(String applicationId, JspWriter out) throws Exception{
		List<String> applicationData = null;
		try{
			con = fetchConnection();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            String query = "select * from passenger_form where application_form_id = '"+applicationId+"'";
            rs = stmt.executeQuery(query);
			if(!rs.next()){
				return applicationData;
			} else {
				//Each time only one record is found thats why we dont iterate it using loop.
				if(rs.getString("passenger_name") == null){
					return applicationData;
				} else {
					applicationData = new ArrayList<String>();
					applicationData.add(rs.getString("application_form_id"));  //0
					applicationData.add(rs.getString("passenger_name"));       //1
																			   
					applicationData.add(rs.getString("full_address"));         //2
					applicationData.add(rs.getString("passenger_dob"));        //3
																			   
					applicationData.add(rs.getString("bus_route_from"));       //4
					applicationData.add(rs.getString("bus_route_to"));         //5
																			   
					applicationData.add(rs.getString("register_date"));        //6
					applicationData.add(rs.getInt("submit_status")+"");        //7
					
					applicationData.add(rs.getInt("payment_status")+"");       //8
					applicationData.add(rs.getString("photo"));                //9
																			   
					applicationData.add(rs.getString("aadhar_card"));          //10
					applicationData.add(rs.getInt("login_status")+"");         //11
					applicationData.add(rs.getString("passenger_id"));         //12
				}
			}
		} catch(Exception e){
			out.println(" Get application data exception: " +e);
		} finally{
			closeConnection();
		}
		return applicationData;
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