﻿<div class="header">
    <h1>Onur Yenidoğan ColdFusion Study Case</h1>
</div>

<div class="navigation">
    <div class="top-nav">
    <button onclick="location.href='index.cfm'" style="background-color: green; font-size: 1.2em; order: -1;">Anasayfa</button>
    <button onclick="location.href='editCategory.cfm'">Kategori Ekle / Sil</button>
    <button onclick="location.href='addNews.cfm'">Haber Ekle</button>
    <button onclick="location.href='jsonPosts.cfm'" style="background-color: black; color: white; font-family: 'Courier New', monospace;">JSON Görüntüle</button>
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
