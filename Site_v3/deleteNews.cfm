<!-- deleteNews.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script type="text/javascript">
        var timeleft = 3;
        var downloadTimer = setInterval(function(){
          if(timeleft <= 0){
            clearInterval(downloadTimer);
          }
          document.getElementById("countdown").innerHTML = timeleft + " saniye sonra anasayfaya y&ouml;nlendiriliyorsunuz";
          timeleft -= 1;
        }, 1000);
    </script>
</head>
<body>
<cfinclude template="navigation.cfm">
    <div class="container">
        <cfquery datasource="NewsSiteDS">
            DELETE FROM News WHERE newsID = <cfqueryparam value="#URL.newsID#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>
        <div class="message">
            Haber Silindi
        </div>
        <div id="countdown"></div>
    </div>
    <style>
        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .message {
            font-size: 3em;
            margin-bottom: 20px;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            width: 80%;
        }
        .delete-btn {
            background-color: red;
        }
        .success-message {
            font-size: 2em;
            margin-top: 10px;
        }
    </style>
    <meta http-equiv="refresh" content="5;url=index.cfm" />
</body>
</html>
