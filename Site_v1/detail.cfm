<!-- detail.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <cfquery name="getNewsDetail" datasource="NewsSiteDS">
            SELECT n.title, n.content, c.categoryName
            FROM News n
            JOIN Categories c ON n.categoryID = c.categoryID
            WHERE n.newsID = <cfqueryparam value="#URL.newsID#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>

        <cfoutput query="getNewsDetail">
            <div class="news-title">
                #title#
            </div>
            <div class="news-category">
                Category: #categoryName#
            </div>
            <div class="news-content">
                #content#
            </div>
            <a href="update.cfm?newsID=#URL.newsID#">Güncelle</a>
        </cfoutput>
    </div>
</body>
</html>
