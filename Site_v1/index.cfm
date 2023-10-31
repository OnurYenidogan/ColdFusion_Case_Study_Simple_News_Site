<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Ana Sayfa</title>
</head>
<body>

<cfquery name="getNews" datasource="NewsSiteDS">
    SELECT * FROM Haberler
</cfquery>

<cfoutput query="getNews">
    <div>
        <h2><a href="detail.cfm?newsID=#newsID#">#baslik#</a></h2>
        <p>#icerik#</p>
    </div>
</cfoutput>

</body>
</html>
