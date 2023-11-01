<!-- detail.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
     <cfinclude template="navigation.cfm">
    <div class="container">
        <cfquery name="getNewsDetail" datasource="NewsSiteDS">
            SELECT n.title, n.content, c.categoryName
            FROM News n
            JOIN Categories c ON n.categoryID = c.categoryID
            WHERE n.newsID = <cfqueryparam value="#URL.newsID#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>

        <cfoutput query="getNewsDetail">
            <div class="news-detail">
                <div class="news-title">
                    #title#
                </div>
                <div class="news-category">
                    Kategori: #categoryName#
                </div>
                <div class="news-content">
                    <div class="news-content">
                        #Replace(content, chr(10), "<br>", "all")#
                    </div>
                </div>
            </div>
            <button onclick="location.href='updateNews.cfm?newsID=#URL.newsID#'">G&uuml;ncelle / Sil</button>
        </cfoutput>
    </div>
    <cfif IsDefined("form.delete")>
    <cfquery datasource="NewsSiteDS">
        DELETE FROM News
        WHERE newsID = <cfqueryparam value="#form.newsID#" cfsqltype="CF_SQL_INTEGER">
    </cfquery>
    <cflocation url="index.cfm" addtoken="no">
</cfif>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        color: #333;
    }
    .container {
        background-color: #fff;
        margin: auto;
        padding: 20px;
        width: 80%;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .news-detail {
        margin-bottom: 20px;
    }
    .news-title {
        font-size: 24px;
        margin-bottom: 10px;
    }
    .news-category {
        font-size: 18px;
        margin-bottom: 20px;
        color: #777;
    }
    .news-content {
        font-size: 16px;
        line-height: 1.6;
    }
    button {
        background-color: #008CBA;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
</style>

</body>
</html>
