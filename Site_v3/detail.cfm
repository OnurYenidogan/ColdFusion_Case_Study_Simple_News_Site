<!-- detail.cfm -->
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
            <button onclick="location.href='updateNews.cfm?newsID=#URL.newsID#'">Güncelle</button>
            <form action="" method="post" onsubmit="return confirm('Haberi silmek istediğinizden emin misiniz?');">
                <input type="hidden" name="newsID" value="#URL.newsID#">
                <input type="submit" name="delete" value="Sil">
            </form>
        </cfoutput>
    </div>
</body>
</html>
