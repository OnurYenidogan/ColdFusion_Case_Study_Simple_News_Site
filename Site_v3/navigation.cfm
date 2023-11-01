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