<div class="header">
    <h1>Onur Yenido&#287;an Study Case</h1>

</div>

<div class="navigation">
    <div class="top-nav">
        <button onclick="location.href='addCategory.cfm'">Kategori Ekle</button>
        <button onclick="location.href='index.cfm'">Anasayfa</button>
        <button onclick="location.href='addNews.cfm'">Haber Ekle</button>
        <button onclick="location.href='jsonPosts.cfm'" style="background-color: black; color: white; font-family: 'Courier New', monospace;">JSON G&ouml;r&uuml;nt&uuml;le</button>
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
