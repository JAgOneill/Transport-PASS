<%@ page language="java" import="java.sql.*, java.util.*, java.time.*, java.io.*, com.itextpdf.text.*, java.io.*, com.itextpdf.text.pdf.*, com.itextpdf.text.html.simpleparser.*, com.itextpdf.text.Font.*"%>
<%@include file="common-database.jsp" %>

<%
    String applicationId = request.getParameter("applicationId");
    try{
        boolean flag = checkApproveStatus(applicationId, out);
        if(flag){
            java.util.List<String> applicationDetails = getApplicationDetails(applicationId, out);
            if(applicationDetails != null){
                printPass(applicationDetails, out);
            }
        } else {
            out.println("0");
        }
    } catch(Exception e){
        out.println(" Approved status exception: " +e);
    }
%>

<%!
    public static boolean checkApproveStatus(String applicationId, JspWriter out) throws Exception{
        boolean isApproved = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String selectQuery = "select approve_status,submit_status,payment_status from passenger_form where application_form_id = '"+applicationId+"'";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                isApproved = false;
            } else {
                int approveStatus = rs.getInt("approve_status");
                int submitStatus = rs.getInt("submit_status");
                int paymentStatus = rs.getInt("payment_status");
                isApproved = (approveStatus == 1 && submitStatus == 1 && paymentStatus == 1) ? true : false;
                //Meaning of above line is form is approved & submitted but not payment is not made.
            }
        } catch(Exception e){
            out.println(" Check approve & submit status exception: " +e);
        } finally {
            closeConnection();
        }
        return isApproved;
    }
%>

<%!
    public static java.util.List<String> getApplicationDetails(String applicationId, JspWriter out) throws Exception{
        java.util.List<String> applicationDetails = new ArrayList<String>();
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String selectQuery = "select * from passenger_form,passenger_register where passenger_form.application_form_id = '"+applicationId+"' and passenger_form.passenger_id = passenger_register.passenger_id";
            rs = stmt.executeQuery(selectQuery);
            if(!rs.next()){
                applicationDetails = null;
            } else {
                applicationDetails.add(rs.getString("application_form_id"));  //0
                applicationDetails.add(rs.getString("passenger_name"));       //1
                applicationDetails.add(rs.getString("full_address"));         //2
                applicationDetails.add(rs.getString("bus_route_from"));       //3
                applicationDetails.add(rs.getString("bus_route_to"));         //4
                applicationDetails.add(rs.getString("register_date"));        //5
                applicationDetails.add(rs.getString("city"));                 //6
                applicationDetails.add(rs.getString("gender"));               //7
                applicationDetails.add(rs.getString("photo"));                //8
                applicationDetails.add(rs.getString("aadhar_card"));          //9
                applicationDetails.add(rs.getString("phone_no"));             //10
                applicationDetails.add(rs.getString("email_id"));             //11
                applicationDetails.add(rs.getString("passenger_dob"));        //12
            }
        } catch(Exception e){
            out.println(" Get application details exception: " +e);
        } finally{
            closeConnection();
        }
        return applicationDetails;
    }
%>

<%!
    public static void printPass(java.util.List<String> applicationDetails, JspWriter out) throws Exception{
        try{
            String photo = applicationDetails.get(8);
            String userHome = System.getProperty("user.home");
            String downloadFolderPath = userHome + File.separator + "Downloads";
            String downloadFileName = applicationDetails.get(0)+"-"+applicationDetails.get(1)+".pdf";
            String fileAbsolutePath = downloadFolderPath + File.separator + downloadFileName;
            
            
            String userDirectory = System.getProperty("user.dir");
            String logoPath = userDirectory + File.separator +".."+File.separator+ "webapps" + File.separator + "pmt-pass" + File.separator + "images" + File.separator + "logo.gif";

            LocalDate passengerDOB= LocalDate.parse(applicationDetails.get(12));
            LocalDate currentDate  = LocalDate.now();
            Period difference = Period.between(passengerDOB, currentDate);
            int age = difference.getYears();
            
            LocalDate fromDate = LocalDate.parse(applicationDetails.get(5)).plusDays(3);
            LocalDate toDate = fromDate.plusMonths(1);
            toDate = toDate.minusDays(1);

            Document document = new Document(PageSize.LETTER);
			PdfWriter.getInstance(document, new FileOutputStream(fileAbsolutePath));
			document.open();
			document.addCreationDate();
			document.addTitle("PMT - PASS");

			HTMLWorker htmlWorker = new HTMLWorker(document);
			
			int height = 100;
			int width = 90;
			
			String data = ""
					+ "<html>"
						+ "<body>"
							+ "<center>"
								+ "<table>"
									+ "<thead>"
										+ "<tr>"
											+ "<td><img src="+photo+" height="+height+" width="+width+"></img></td>"
											+ "<td colspan=2 align=center> <h3><b> Pune Mahanagar Parivahan Mahamandal Ltd. <br> Passenger's Monthly PMT Pass </b></h3></td> </td>"
											+ "<td><img align=right src="+logoPath+" height="+height+" width="+width+"></img></td>"
										+ "</tr>"
									+ "</thead>"
								+ "</table>"
								+ "<table border=1>"
									+ "<thead>"
										+ "<b> <tr align=center>"
											+ "<td valign=\"top\">Application Id:</td>"
											+ "<td valign=\"top\">"+applicationDetails.get(0)+"</td>"
											+ "<td valign=\"top\">Name:</td>"
											+ "<td valign=\"top\">"+applicationDetails.get(1)+"</td>"
										+ "</tr>"

										+ "<tr align=center>"
											+ "<td valign=\"top\">Address:</td>"
											+ "<td valign=\"top\">"+applicationDetails.get(2)+"</td>"
											+ "<td valign=\"top\">Age:</td>"
											+ "<td valign=\"top\">"+age+"</td>"
										+ "</tr>"

										+ "<tr align=center>"
											+ "<td valign=\"top\">From Date:</td>"
											+ "<td valign=\"top\">"+fromDate+"</td>"
											+ "<td valign=\"top\">To Date:</td>"
											+ "<td valign=\"top\">"+toDate+"</td>"
										+ "</tr>"
									+ "</thead>"
									+ "</b>"
								+ "</table>"
							+ "<center>"
						+ "</body>"
					+ "</html>";
			htmlWorker.parse(new StringReader(data));
			document.close();
			out.println("Pass generated successfully! Please check downloads folder.");
        }catch(Exception e){
            out.println(" Print pass exception: " +e);
        }
    }
%>
