<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>

<div id="nav-bar">
    <div id="top-nav">
        <a href="kategoriDuzenle.cfm">Kategori Düzenle</a>
        <a href="index.cfm">Anasayfa</a>
        <a href="haberEkle.cfm">Haber Ekle</a>
    </div>
    <div id="bottom-nav">
        <!-- Kategori listesi -->
        <cfquery name="getCategories" datasource="NewsSiteDS">
            SELECT * FROM Categories
        </cfquery>
        <cfloop query="getCategories">
            <a href="index.cfm?categoryID=#categoryID#">#categoryName#</a>
        </cfloop>
    </div>
</div>

<div id="content">
    <!-- Sayfa içeriği -->
    <cfinclude template="#ARGUMENTS.Template#">
</div>

</body>
</html>
