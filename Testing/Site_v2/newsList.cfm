<cfquery name="getNews" datasource="NewsSiteDS">
    SELECT * FROM News
    JOIN Categories ON News.categoryID = Categories.categoryID
</cfquery>

<cfif getNews.recordCount eq 0>
    Veritabanı boş.
<cfelse>
    <cfloop query="getNews">
        <div class="news-item">
            <h2><a href="detail.cfm?newsID=#newsID#">#title#</a></h2>
            <p>#left(content, 200)#...</p>
        </div>
    </cfloop>
</cfif>
