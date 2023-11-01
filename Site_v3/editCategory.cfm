<!-- addCategory.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<cfinclude template="navigation.cfm">
<div class="container">
    <h2 style="text-align:center;">Kategori Ekle</h2>
    <cfif structKeyExists(form, "submitted")>
        <cfquery datasource="NewsSiteDS">
            INSERT INTO Categories (categoryName)
            VALUES (
                <cfqueryparam value="#form.categoryName#" cfsqltype="CF_SQL_VARCHAR">
            )
        </cfquery>
        <div class="success-message">Kategori eklendi!</div>
    </cfif>

    <form action="addCategory.cfm" method="post" class="news-form">
        <input type="hidden" name="submitted" value="true">
        <input type="text" name="categoryName" required class="input-field"><br>
        <input type="submit" value="Kategori Ekle" class="submit-btn">
    </form>
</div>

<hr style="width: 80%; margin: 20px 10%;">

<div class="container">
    <h2 style="text-align:center;">Kategori Sil</h2>
    <form action="deleteCategory.cfm" method="post" class="news-form">
        <select name="categoryID" required class="input-field">
            <cfquery name="getCategories" datasource="NewsSiteDS">
                SELECT categoryID, categoryName FROM Categories
            </cfquery>
            <cfoutput query="getCategories">
                <option value="#categoryID#">#categoryName#</option>
            </cfoutput>
        </select><br>
       <input type="submit" value="Kategori Sil" class="submit-btn" style="background-color:red;">
    </form>
</div>

<style>
    .success-message {
        color: green;
        font-weight: bold;
        margin-bottom: 10px;
        font-size: 30pt;
        text-align: center;
    }
    .input-field, .submit-btn {
        width: 80%;
        padding: 10px;
        font-size: 1.2em;
        margin-bottom: 10px;
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