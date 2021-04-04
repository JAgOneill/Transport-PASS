<%@ page language="java" import="java.sql.*, java.util.*, java.time.*, java.io.*"%>
<%@include file="common-database.jsp" %>

<%
    String url = request.getParameter("applicationNo");
    StringTokenizer token = new StringTokenizer(url, "=");
    token.nextToken();
    String applicationId = token.nextToken();
    
    try{
        showDetails(applicationId, out);
    } catch(Exception e){
        out.println(" Edit exception: " +e);
    }
%>

<%!
    public static void showDetails(String applicationId, JspWriter out) throws Exception {
        String data = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String selectQuery = "select * from passenger_form where application_form_id = '"+applicationId+"'";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                data = "DATA-NOT-AVAILABLE";
            } else {
                String passengerName = rs.getString("passenger_name");
                String address = rs.getString("full_address");
                String passengerDOB = rs.getString("passenger_dob");
                String busRouteFrom = rs.getString("bus_route_from");
                String busRouteTo = rs.getString("bus_route_to");
                String registerDate = rs.getString("register_date");
                String city = rs.getString("city");
                String gender = rs.getString("gender");
                String submitStatus = rs.getString("submit_status");
                String approveStatus = rs.getString("approve_status");
                String passengerId = rs.getString("passenger_id");
                String photo = rs.getString("photo");
                String aadharCard = rs.getString("aadhar_card");
                deletePhotoAndAadharCard(applicationId, photo, aadharCard, out);
                deleteRejectionApplicationEntry(applicationId, out);
                data = passengerName + "$"+address+"$"+passengerDOB+"$"+busRouteFrom+"$"+busRouteTo+"$"+registerDate+"$"+city+"$"+gender+"$"+submitStatus+"$"+approveStatus+"$"+passengerId;
            }
            out.println(data);  //Here print statement must be required.
        } catch(Exception e){
            out.println(" Show details exception: " +e);
        } finally {
            closeConnection();
        }
    }
%>

<%!
    public static void deletePhotoAndAadharCard(String applicationId, String photo, String aadharCard, JspWriter out) throws Exception{
        try{
            File file = new File(photo);
            file.delete();
            file = new File(aadharCard);
            file.delete();
            String directoryName = photo.split(applicationId+"-")[0];
            file = new File(directoryName);
            file.delete();
            
            con = fetchConnection();
            stmt = con.createStatement();
            String emptyString = "";
            String updateQuery = "update passenger_form set photo = '"+emptyString+"', aadhar_card = '"+emptyString+"' where application_form_id = '"+applicationId+"'";
            stmt.executeUpdate(updateQuery);
        } catch(Exception e){
            out.println(" Delete photo and aadhar card exception: " +e);
        } finally{
            closeConnection();
        }
    }
%>

<%!
    public static void deleteRejectionApplicationEntry(String applicationId, JspWriter out) throws Exception{
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String deleteQuery = "delete from admin_rejection_list where application_form_id = '"+applicationId+"'";
            stmt.executeUpdate(deleteQuery);
        } catch(Exception e){
            out.println(" Delete rejection application entry exception: " +e);
        } finally{
            closeConnection();
        }
    }
%>