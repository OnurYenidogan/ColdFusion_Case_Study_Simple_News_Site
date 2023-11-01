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
                    Category: #categoryName#
                </div>
                <div class="news-content">
                    #content#
                </div>
            </div>
            <button onclick="location.href='updateNews.cfm?newsID=#URL.newsID#'">Güncelle / Sil</button>
        </cfoutput>
    </div>
    <cfif IsDefined("form.delete")>
    <cfquery datasource="NewsSiteDS">
        DELETE FROM News
        WHERE newsID = <cfqueryparam value="#form.newsID#" cfsqltype="CF_SQL_INTEGER">
    </cfquery>
    <cflocation url="index.cfm" addtoken="no">
</cfif>

</body>
</html>
