<!-- categoryNews.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<div class="navigation">
        <div class="top-nav">
            <button onclick="location.href='addCategory.cfm'">Kategori Ekle</button>
            <button onclick="location.href='index.cfm'">Anasayfa</button>
            <button onclick="location.href='addNews.cfm'">Haber Ekle</button>
        </div>
        <div class="bottom-nav">
            <cfquery name="getCategories" datasource="NewsSiteDS">
                SELECT categoryName FROM Categories
            </cfquery>
            <cfoutput query="getCategories">
                <button onclick="location.href='categoryNews.cfm?category=#categoryName#'">#categoryName#</button>
            </cfoutput>
        </div>
    </div>

    <div class="container">
        <cfquery name="getNewsInCategory" datasource="NewsSiteDS">
            SELECT n.newsID, n.title
            FROM News n
            JOIN Categories c ON n.categoryID = c.categoryID
            WHERE c.categoryName = <cfqueryparam value="#URL.category#" cfsqltype="CF_SQL_VARCHAR">
            ORDER BY n.newsID DESC
        </cfquery>

        <cfoutput query="getNewsInCategory">
            <div class="news-item">
                <div class="news-title">
                    <a href="detail.cfm?newsID=#newsID#">#title#</a>
                </div>
                <div class="news-category">
                    Category: #URL.category#
                </div>
            </div>
        </cfoutput>
    </div>
</body>
</html>
