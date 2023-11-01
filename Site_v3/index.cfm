<!-- index.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<cfinclude template="navigation.cfm">
    <div class="container">
        <cfquery name="getNews" datasource="NewsSiteDS">
            SELECT n.newsID, n.title, c.categoryName, n.createdDate, n.updatedDate
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
                    Kategori: #categoryName# 
                    <span style="float:right;">Olusturulma: #DateFormat(createdDate, "dd.mm.yyyy")# #TimeFormat(createdDate, "HH:mm:ss")# | 
                    Son Guncelleme: #DateFormat(updatedDate, "dd.mm.yyyy")# #TimeFormat(updatedDate, "HH:mm:ss")#</span>
                </div>
            </div>
        </cfoutput>
    </div>
</body>
</html>
