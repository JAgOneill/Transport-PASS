<%@ page language="java" import="java.sql.*, java.io.*, java.util.*, java.time.*, com.oreilly.servlet.MultipartRequest"%>
<%@include file="common-database.jsp" %>

<%
    String applicationNo = request.getParameter("applicationNo");
    String fileName = request.getParameter("fileName");
    try{
        String path = System.getProperty("user.dir");
        String uploadFolderPath = path + File.separator +".."+ File.separator+ "webapps" + File.separator + "pmt-pass" + File.separator + "uploaded-docs" + File.separator;
        boolean isExists = isDirectoryExists(fileName, path, applicationNo, out);
        if(!isExists){
            createDirectory(uploadFolderPath, applicationNo, out);
        }
        MultipartRequest m = new MultipartRequest(request, uploadFolderPath + applicationNo);
        changeFileName(fileName,  uploadFolderPath, applicationNo, out);
        out.print("Aadhar card uploaded successfully.");
    } catch(Exception e){
        out.println(" Exception: " +e);
    }
%>

<%!
    public static boolean isDirectoryExists(String fileName, String path, String applicationNo, JspWriter out) throws Exception{
        boolean flag = false;
        try{
            File file = new File(path + applicationNo);
            if(file.exists()){
                flag = true;
            }
        } catch(Exception e){
            out.println(" isDirectoryExists: " +e);
        }
        return flag;
    }
%>

<%!
    public static void changeFileName(String fileName, String path, String applicationNo, JspWriter out) throws Exception{
        try{
            StringTokenizer splitString = new StringTokenizer(fileName, ".");
            splitString.nextToken(); // Its filename not an extension thats why we traverse it.
            String extension = splitString.nextToken();
            String newFileName = applicationNo + "-AADHAR-CARD." + extension;
            File originalFile = new File(path + applicationNo + File.separator + fileName);
            File renameFile = new File(path + applicationNo + File.separator + newFileName);
            originalFile.renameTo(renameFile);
        } catch(Exception e){
            out.println(" isDirectoryExists: " +e);
        }
    }
%>

<%!
    public static void createDirectory(String path, String applicationNo, JspWriter out) throws Exception {
        try{
            new File(path + applicationNo).mkdir();
        } catch(Exception e){
            out.println(" createDirectory: " +e);
        }
    }
%>
