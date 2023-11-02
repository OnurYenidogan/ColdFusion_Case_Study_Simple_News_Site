<!-- index.cfm -->
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
    </style>
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
