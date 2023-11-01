<!-- addNews.cfm -->
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
        <cfif structKeyExists(form, "submitted")>
            <cfquery datasource="NewsSiteDS">
                INSERT INTO News (title, content, categoryID)
                VALUES (
                    <cfqueryparam value="#form.title#" cfsqltype="CF_SQL_VARCHAR">,
                    <cfqueryparam value="#form.content#" cfsqltype="CF_SQL_LONGVARCHAR">,
                    <cfqueryparam value="#form.categoryID#" cfsqltype="CF_SQL_INTEGER">
                )
            </cfquery>
            <div class="success-message">Haber eklendi!</div>
        </cfif>

        <cfquery name="getCategories" datasource="NewsSiteDS">
            SELECT categoryID, categoryName FROM Categories
        </cfquery>

        <form action="addNews.cfm" method="post" class="news-form">
            <input type="hidden" name="submitted" value="true">
            <div class="form-label">Başlık:</div> <input type="text" name="title" required class="input-field"><br>
            <div class="form-label">İçerik:</div> <textarea name="content" required class="textarea-field"></textarea><br>
            <div class="form-label">Kategori:</div> <select name="categoryID" required class="input-field">
                <cfoutput query="getCategories">
                    <option value="#categoryID#">#categoryName#</option>
                </cfoutput>
            </select><br>
            <input type="submit" value="Haber Ekle" class="submit-btn">
        </form>
    </div>

    <style>
        .success-message {
            color: green;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .input-field, .textarea-field, .submit-btn {
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
    </style>
</body>
</html>