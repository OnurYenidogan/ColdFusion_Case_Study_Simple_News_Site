<!-- categoryNews.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .news-item {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        .news-title {
            font-size: 1.5em;
        }
            .news-category {
            color: #555;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
        }
        .category-title {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<cfinclude template="navigation.cfm">

    <div class="container">
        <div class="category-title">
            <cfquery name="getCategoryName" datasource="NewsSiteDS">
            SELECT categoryName
            FROM Categories
            WHERE categoryName = <cfqueryparam value="#URL.category#" cfsqltype="CF_SQL_VARCHAR">
            </cfquery>
            <cfoutput query="getCategoryName">
                <h1>#getCategoryName.categoryName# Kategorisindeki Haberler</h1>
            </cfoutput>
        </div>
        <cfquery name="getNewsInCategory" datasource="NewsSiteDS">
            SELECT n.newsID, n.title, n.createdDate, n.updatedDate
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
    Kategori: #URL.category#
    <div style="display: flex; flex-wrap: wrap; justify-content: flex-end;">
        <div>Oluşturulma: #DateFormat(createdDate, "dd.mm.yyyy")# |</div>
        <div>Son Güncelleme: #DateFormat(updatedDate, "dd.mm.yyyy")#</div>
    </div>
</div>
            </div>
        </cfoutput>
    </div>
</body>
</html>
