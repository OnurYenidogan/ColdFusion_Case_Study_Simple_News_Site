<!-- detail.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="navigation">
        <!-- Navigation -->
        <div class="top-nav">
            <button>Kategori Ekle</button>
            <button><a href="index.cfm">Anasayfa</a></button>
            <button>Haber Ekle</button>
        </div>
        <div class="bottom-nav">
            <!-- Kategorileri dinamik olarak burada listele -->
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
        </cfoutput>
    </div>
</body>
</html>
