<!-- addNews.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <cfinclude template="navigation.cfm">
    <div class="container">
        <cfif structKeyExists(form, "submitted")>
    <cfquery datasource="NewsSiteDS">
        INSERT INTO News (title, content, categoryID, createdDate, updatedDate)
        VALUES (
            <cfqueryparam value="#form.title#" cfsqltype="CF_SQL_VARCHAR">,
            <cfqueryparam value="#form.content#" cfsqltype="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#form.categoryID#" cfsqltype="CF_SQL_INTEGER">,
            <cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP">,
            <cfqueryparam value="#Now()#" cfsqltype="CF_SQL_TIMESTAMP">
        )
    </cfquery>
        </cfif>

        <cfquery name="getCategories" datasource="NewsSiteDS">
            SELECT categoryID, categoryName FROM Categories
        </cfquery>

        <form action="addNews.cfm" method="post" class="news-form">
            <input type="hidden" name="submitted" value="true">
            <div class="form-label">Başlık</div> <input type="text" name="title" required class="input-field"><br>
            <div class="form-label">İçerik</div> <textarea name="content" required class="textarea-field"></textarea><br>
            <div class="form-label">Kategori</div> <select name="categoryID" required class="input-field">
                <cfoutput query="getCategories">
                    <option value="#categoryID#">#categoryName#</option>
                </cfoutput>
            </select><br>
            <input type="submit" value="Haber Ekle" class="submit-btn">
        </form>
        <cfif structKeyExists(form, "submitted")>
            <div class="success-message">Haber eklendi!</div>
        </cfif>
    </div>

    <style>
        .success-message {
        color: green;
        font-weight: bold;
        margin-bottom: 10px;
        font-size: 30pt;
        text-align: center;
    }
        .input-field, .textarea-field, .submit-btn {
            width: 80%;
            padding: 10px;
            font-size: 1.2em;
            margin-bottom: 10px;
        }
        .textarea-field {
            height: 150px;
        }
        .news-form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .form-label {
        font-size: 1.5em;
        font-weight: bold;
        margin-bottom: 5px;
    }
        .submit-btn {
        padding: 10px;
        font-size: 1.2em;
        margin-bottom: 10px;
        width: auto;
        background-color: #008CBA;
        color: white;
    }
    </style>
</body>
</html>