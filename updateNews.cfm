<!-- updateNews.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <cfinclude template="navigation.cfm">
    <div class="container">
        <cfif IsDefined("form.title")>
            <cfquery datasource="NewsSiteDS">
                UPDATE News
                SET title = <cfqueryparam value="#form.title#" cfsqltype="CF_SQL_VARCHAR">,
                    content = <cfqueryparam value="#form.content#" cfsqltype="CF_SQL_LONGVARCHAR">,
                    categoryID = <cfqueryparam value="#form.categoryID#" cfsqltype="CF_SQL_INTEGER">,
                    updatedDate = <cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP">
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
            <form action="" method="post" class="news-form">
                <input type="hidden" name="newsID" value="#URL.newsID#">
                <div class="form-label">Başlık</div> 
                <input type="text" name="title" value="#title#" required class="input-field"><br>
                <div class="form-label">İçerik</div> 
                <textarea name="content" required class="textarea-field">#content#</textarea><br>
                <div class="form-label">Kategori</div> 
                <select name="categoryID" required class="input-field">
                    <cfloop query="getCategories">
                        <option value="#categoryID#" <cfif categoryID EQ getNewsDetail.categoryID>selected</cfif>>#categoryName#</option>
                    </cfloop>
                </select><br>

                <div>
                    <input type="submit" value="Güncelle" class="update-btn">
                    <button type="button" onclick="location.href='deleteNews.cfm?newsID=#URL.newsID#'" class="delete-btn">Sil</button>
                </div>
            </form>
            <cfif IsDefined("form.title")>
                <div class="success-message">
                    Haber başarıyla güncellendi!
                </div>
            </cfif>
        </cfoutput>
    </div>
    <style>
        .success-message {
            font-size: 2em; /* Font boyutunu büyüt */
            color: green;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .input-field, .textarea-field, .update-btn, .delete-btn {
            width: 80%;  /* Adjust as needed */
            padding: 10px;
            font-size: 1.2em; /* Adjust as needed */
            margin-bottom: 10px;
        }
        .textarea-field {
            height: 150px;  /* Adjust as needed */
        }
        .news-form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .form-label {
            font-size: 1.5em;  /* Adjust as needed */
            font-weight: bold;
            margin-bottom: 5px;
        }
        .delete-btn {
            background-color: red;
            color: white;
            padding: 10px 20px;
            font-size: 1.2em;
            border: none;
            cursor: pointer;
        }
        .update-btn {
            background-color: #007bff; /* Mavi renk */
            color: white;
            padding: 10px 20px;
            font-size: 1.2em;
            border: none;
            cursor: pointer;
            margin-right: 10px; /* Sil butonundan sağa doğru boşluk bırakır */
        }
    </style>
</body>
</html>
