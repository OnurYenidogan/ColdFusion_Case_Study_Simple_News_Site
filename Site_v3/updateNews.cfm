<!-- updateNews.cfm -->
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
    <div class="container">
        <cfif IsDefined("form.title")>
            <cfquery datasource="NewsSiteDS">
                UPDATE News
                SET title = <cfqueryparam value="#form.title#" cfsqltype="CF_SQL_VARCHAR">,
                    content = <cfqueryparam value="#form.content#" cfsqltype="CF_SQL_LONGVARCHAR">,
                    categoryID = <cfqueryparam value="#form.categoryID#" cfsqltype="CF_SQL_INTEGER">
                WHERE newsID = <cfqueryparam value="#form.newsID#" cfsqltype="CF_SQL_INTEGER">
            </cfquery>
            <cflocation url="detail.cfm?newsID=#form.newsID#" addtoken="no">
        </cfif>
        
        <cfquery name="getNewsDetail" datasource="NewsSiteDS">
            SELECT n.title, n.content, n.categoryID, c.categoryName
            FROM News n
            JOIN Categories c ON n.categoryID = c.categoryID
            WHERE n.newsID = <cfqueryparam value="#URL.newsID#" cfsqltype="CF_SQL_INTEGER">
        </cfquery>

        <cfquery name="getCategories" datasource="NewsSiteDS">
            SELECT categoryID, categoryName FROM Categories
        </cfquery>

        <cfoutput query="getNewsDetail">
            <form action="" method="post">
                <input type="hidden" name="newsID" value="#URL.newsID#">
                Başlık: <input type="text" name="title" value="#title#"><br>
                İçerik: <textarea name="content">#content#</textarea><br>
                Kategori: <select name="categoryID">
                    <option value="#categoryID#" selected>#categoryName#</option>
                    <cfloop query="getCategories">
                        <cfif categoryID neq getNewsDetail.categoryID>
                            <option value="#categoryID#">#categoryName#</option>
                        </cfif>
                    </cfloop>
                </select><br>
                <input type="submit" value="Güncelle">
            </form>
        </cfoutput>
    </div>
</body>
</html>
