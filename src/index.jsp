<%@ page import="ProjektMPK.WorkerDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    WorkerDAO worker = null;
    String idStr = "";
    ServletContext c = session.getServletContext();
    if (c.getAttribute("firstRun") == null) {
        worker = new WorkerDAO();
        idStr = String.valueOf(worker.id);
        c.setAttribute("firstRun", 0);
        c.setAttribute("worker", worker);
    } else {
        worker = (WorkerDAO)c.getAttribute("worker");
        idStr = String.valueOf(worker.id);
    }
%>
<HTML>
    <HEAD>
        <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <TITLE>MSSQLServerWebApp</TITLE>
        <SCRIPT type="text/javascript">
            nameOnInput = function() {
		document.getElementsByName("delete")[0].disabled = true;
		document.getElementsByName("delete")[0].style.backgroundColor = "gray";
            };
	
            surnameOnInput = function() {
		document.getElementsByName("delete")[0].disabled = true;
		document.getElementsByName("delete")[0].style.backgroundColor = "gray";
            };
	
            addressOnInput = function() {
		document.getElementsByName("delete")[0].disabled = true;
		document.getElementsByName("delete")[0].style.backgroundColor = "gray";
            };
	
            cityOnInput = function() {
		document.getElementsByName("delete")[0].disabled = true;
		document.getElementsByName("delete")[0].style.backgroundColor = "gray";
            };
	
            postalCodeOnInput = function() {
		document.getElementsByName("delete")[0].disabled = true;
		document.getElementsByName("delete")[0].style.backgroundColor = "gray";
            };
	
            phoneOnInput = function() {
		document.getElementsByName("delete")[0].disabled = true;
		document.getElementsByName("delete")[0].style.backgroundColor = "gray";
            };
	
            mailOnInput = function() {
		document.getElementsByName("delete")[0].disabled = true;
		document.getElementsByName("delete")[0].style.backgroundColor = "gray";
            };

            createOnClick = function() {
                document.getElementsByName("action")[0].value = "create";
                document.getElementsByName("idValue")[0].value = document.getElementsByName("id")[0].value;
            };
	
            updateOnClick = function() {
                document.getElementsByName("action")[0].value = "update";
                document.getElementsByName("idValue")[0].value = document.getElementsByName("id")[0].value;
            };

            deleteOnClick = function() {
                document.getElementsByName("action")[0].value = "delete";
                document.getElementsByName("idValue")[0].value = document.getElementsByName("id")[0].value;
            };

            previousOnClick = function() {
                document.getElementsByName("action")[0].value = "previous";
                document.getElementsByName("idValue")[0].value = document.getElementsByName("id")[0].value;
            };
	
            nextOnClick = function() {
                document.getElementsByName("action")[0].value = "next";
                document.getElementsByName("idValue")[0].value = document.getElementsByName("id")[0].value;
            };
        </SCRIPT>
    </HEAD>
    <BODY background="images\texture.jpg">
        <DIV style="width: 312px; height: 328px; background-color: rgb(255,255,255); position: absolute; left: 0; top: 0; right: 0; bottom: 0; margin: auto;">
            <FORM method="post" action="Process">
                <INPUT name="action" type="hidden">
                <INPUT name="idValue" type="hidden">
                <DIV style="width: 296px; height: 256px; border-style: solid; border-width: 1px; border-color: rgb(0,0,0); position: absolute; left: 8px; top: 8px;">
                    <DIV style="width: 64px; height: 20px; position: absolute; left: 8px; top: 8px; text-align: left;">
                        <FONT style="font-family: sans-serif; font-size: 8pt">Id:</FONT>
                    </DIV>
                    <INPUT
                        name="id"
                        type="text"
                        style="box-sizing: border-box; width: 72px; height: 20px; position: absolute; left: 80px; top: 8px; font-family: sans-serif; font-size: 8pt;"
                        value="<%= idStr %>"
                        disabled
                    >

                    <DIV style="width: 64px; height: 20px; position: absolute; left: 8px; top: 32px; text-align: left;">
                        <FONT style="font-family: sans-serif; font-size: 8pt">Name:</FONT>
                    </DIV>
                    <INPUT
                        name="name"
                        type="text"
                        style="box-sizing: border-box; width: 208px; height: 20px; position: absolute; left: 80px; top: 32px; font-family: sans-serif; font-size: 8pt;"
                        value="<%= worker.name %>"
                        oninput="nameOnInput()"
                    >

                    <DIV style="width: 64px; height: 20px; position: absolute; left: 8px; top: 56px; text-align: left;">
                        <FONT style="font-family: sans-serif; font-size: 8pt">Surname:</FONT>
                    </DIV>
                    <INPUT
                        name="surname"
                        type="text"
                        style="box-sizing: border-box; width: 208px; height: 20px; position: absolute; left: 80px; top: 56px; font-family: sans-serif; font-size: 8pt;"
                        value="<%= worker.surname %>"
                        oninput="surnameOnInput()"
                    >

                    <DIV style="width: 64px; height: 20px; position: absolute; left: 8px; top: 80px; text-align: left;">
                        <FONT style="font-family: sans-serif; font-size: 8pt">Address:</FONT>
                    </DIV>
                    <INPUT
                        name="address"
                        type="text"
                        style="box-sizing: border-box; width: 208px; height: 20px; position: absolute; left: 80px; top: 80px; font-family: sans-serif; font-size: 8pt;"
                        value="<%= worker.address %>"
                        oninput="addressOnInput()"
                    >

                    <DIV style="width: 64px; height: 20px; position: absolute; left: 8px; top: 104px; text-align: left;">
                        <FONT style="font-family: sans-serif; font-size: 8pt">City:</FONT>
                    </DIV>
                    <INPUT
                        name="city"
                        type="text"
                        style="box-sizing: border-box; width: 208px; height: 20px; position: absolute; left: 80px; top: 104px; font-family: sans-serif; font-size: 8pt;"
                        value="<%= worker.city %>"
                        oninput="cityOnInput()"
                    >

                    <DIV style="width: 64px; height: 20px; position: absolute; left: 8px; top: 128px; text-align: left;">
                        <FONT style="font-family: sans-serif; font-size: 8pt">Postal code:</FONT>
                    </DIV>
                    <INPUT
                        name="postalCode"
                        type="text"
                        style="box-sizing: border-box; width: 208px; height: 20px; position: absolute; left: 80px; top: 128px; font-family: sans-serif; font-size: 8pt;"
                        value="<%= worker.postalCode %>"
                        oninput="postalCodeOnInput()"
                    >

                    <DIV style="width: 64px; height: 20px; position: absolute; left: 8px; top: 152px; text-align: left;">
                        <FONT style="font-family: sans-serif; font-size: 8pt">Phone:</FONT>
                    </DIV>
                    <INPUT
                        name="phone"
                        type="text"
                        style="box-sizing: border-box; width: 104px; height: 20px; position: absolute; left: 80px; top: 152px; font-family: sans-serif; font-size: 8pt;"
                        value="<%= worker.phone %>"
                        oninput="phoneOnInput()"
                    >

                    <DIV style="width: 64px; height: 20px; position: absolute; left: 8px; top: 176px; text-align: left;">
                        <FONT style="font-family: sans-serif; font-size: 8pt">Mail:</FONT>
                    </DIV>
                    <INPUT
                        name="mail"
                        type="text"
                        style="box-sizing: border-box; width: 208px; height: 20px; position: absolute; left: 80px; top: 176px; font-family: sans-serif; font-size: 8pt;"
                        value="<%= worker.mail %>"
                        oninput="mailOnInput()"
                    >

                    <INPUT
                        name="create"
                        type="submit"
                        value="Create"
                        style="width: 72px; height: 24px; position: absolute; left: 8px; top: 224px; background-color: green; color: white; font-family: sans-serif; font-size: 8pt;"
                        onclick="createOnClick()"
                    >
                    <INPUT
                        name="update"
                        type="submit"
                        value="Update"
                        style="width: 72px; height: 24px; position: absolute; left: 112px; top: 224px; background-color: green; color: white; font-family: sans-serif; font-size: 8pt;"
                        onclick="updateOnClick()"
                    >
                    <INPUT
                        name="delete"
                        type="submit"
                        value="Delete"
                        style="width: 72px; height: 24px; position: absolute; left: 216px; top: 224px; background-color: green; color: white; font-family: sans-serif; font-size: 8pt;"
                        onclick="deleteOnClick()"
                    >
                </DIV>
                <INPUT
                    name="previous"
                    type="submit"
                    value="◄"
                    style="width: 72px; height: 24px; position: absolute; left: 8px; top: 296px; background-color: green; color: white; font-family: sans-serif; font-size: 8pt;"
                    onclick="previousOnClick()"
                >
                <INPUT
                    name="next"
                    type="submit"
                    value="►"
                    style="width: 72px; height: 24px; position: absolute; left: 232px; top: 296px; background-color: green; color: white; font-family: sans-serif; font-size: 8pt;"
                    onclick="nextOnClick()"
                >
            </FORM>
        </DIV>
    </BODY>
</HTML>
