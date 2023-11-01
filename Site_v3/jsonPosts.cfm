<!-- jsonPosts.cfm -->
<html>
<head>
        <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        .filter-section {
            background-color: #f9f9f9;
            padding: 10px;
            margin-bottom: 10px;
        }
        .filter-tags {
            display: flex;
            flex-wrap: wrap;
        }
        .filter-tags label {
            margin-right: 10px;
        }
        .filter-button {
            display: block;
            margin: 10px auto 0 auto;
        }
    </style>
</head>
<body>
<cfinclude template="navigation.cfm">
    <div class="container">
        <cfset fileContent = FileRead(expandPath("./posts.json"))>
        <cfset posts = DeserializeJSON(fileContent)>
        <!--- İnternetten JSON verisini çekek için
        <cfhttp url="https://dummyjson.com/posts" method="get" result="response"></cfhttp>
        <cfset posts = DeserializeJSON(response.FileContent)>
        --->

        <!--- Benzersiz tag'leri saklamak için bir yapı oluşturun --->
        <cfset uniqueTags = {}>
        <!--- Tüm post'ları döngüye alın ve her bir tag'i kontrol edin --->
        <cfloop array="#posts.posts#" index="post">
            <cfloop array="#post.tags#" index="tag">
                <!--- Eğer tag daha önce görülmemişse, yapıya ekleyin --->
                <cfif NOT structKeyExists(uniqueTags, tag)>
                    <cfset uniqueTags[tag] = true>
                </cfif>
            </cfloop>
        </cfloop>

        <!--- Filtreleme formunu oluşturun --->
        <div class="filter-section">
            <form action="jsonPosts.cfm" method="post">
                <div class="filter-tags">
                    <cfoutput>
                        <cfloop collection="#uniqueTags#" item="tag">
                            <cfset isChecked = StructKeyExists(FORM, "tags") AND ArrayFind(ListToArray(FORM.tags), tag)>
                            <label><input type="checkbox" name="tags" value="#tag#" <cfif isChecked>checked</cfif>> #tag#</label>
                        </cfloop>
                    </cfoutput>
                </div>
                <input type="submit" value="Filtrele" class="filter-button">
            </form>
        </div>

        <!--- Form gönderildiyse, tags dizisini elde edin --->
        <cfif structKeyExists(FORM, "tags")>
            <cfset selectedTags = ListToArray(FORM.tags)>
        </cfif>

        <cfoutput>
            <cfloop array="#posts.posts#" index="post">
                <cfif NOT structKeyExists(FORM, "tags") OR ArraySome(selectedTags, function(tag){ return ArrayFind(post.tags, tag); })>
                    <div class="news-item">
                        <div class="news-title">
                            <h2>#post.title#</h2>
                        </div>
                        <div class="news-content">
                            <p>#post.body#</p>
                            <ul>
                                <cfloop array="#post.tags#" index="tag">
                                    <li>#tag#</li>
                                </cfloop>
                            </ul>
                            <p>Reactions: #post.reactions#</p>
                            <p>User ID: #post.userId#</p>
                            <p>Post ID: #post.id#</p>
                        </div>
                    </div>
                </cfif>
            </cfloop>
        </cfoutput>
    </div>
</body>
</html>
