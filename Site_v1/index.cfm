<!-- index.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <cfquery name="getNews" datasource="NewsSiteDS">
            SELECT n.newsID, n.title, c.categoryName
            FROM News n
            JOIN Categories c ON n.categoryID = c.categoryID
            ORDER BY n.newsID DESC
        </cfquery>

        <cfoutput query="getNews">
            <div class="news-item">
                <div class="news-title">
                    <a href="detail.cfm?newsID=#newsID#">#title#</a>
                </div>
                <div class="news-category">
                    Category: #categoryName#
                </div>
            </div>
        </cfoutput>
    </div>
</body>
</html>
