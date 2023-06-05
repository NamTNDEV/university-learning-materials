<%-- 
    Document   : upload
    Created on : Apr 18, 2023, 9:24:39 AM
    Author     : quocb
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <input type="file" name="material" id="material-input-file"/>
        <button type="button" id="btn-upload">Upload</button>

        <script>
            document.getElementById("btn-upload").addEventListener("click", onClickToUpload);

            async function onClickToUpload() {
                console.log('Start to upload');
                const inputNode = document.getElementById('material-input-file');
                const formData = new FormData();
                console.log('Append file to formData');
                formData.append('file', inputNode.files[0]);
                console.log({formData});
                fetch('${pageContext.request.servletContext.contextPath}/Test', {
                    method: 'POST',
                    body: formData
                });
            }
        </script>
    </body>
</html>
