<!-- jsonPosts.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        .filter-section, .sort-section {
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
            background-color: #28a745;  /* Yeşil arka plan rengi */
            color: #ffffff;  /* Beyaz yazı rengi */
            padding: 10px 20px;  /* Daha büyük padding */
            font-size: 16px;  /* Daha büyük font boyutu */
            border: none;  /* Kenarlık kaldırıldı */
            cursor: pointer;  /* İmleç, düğme üzerine gelindiğinde el simgesi olur */
            border-radius: 5px;  /* Köşeleri yuvarlak yapar */
        }
        .sort-section select {
            font-size: 16px; /* veya istediğiniz başka bir değer */
        }


    </style>
</head>
<body>
<cfinclude template="navigation.cfm">
    <div class="container">
        <cfset fileContent = FileRead(expandPath("./posts.json"))>
        <cfset posts = DeserializeJSON(fileContent)>

        <!--- Unique tags structure --->
        <cfset uniqueTags = {}>
        <cfloop array="#posts.posts#" index="post">
            <cfloop array="#post.tags#" index="tag">
                <cfif NOT structKeyExists(uniqueTags, tag)>
                    <cfset uniqueTags[tag] = true>
                </cfif>
            </cfloop>
        </cfloop>

        <!--- Filtering form --->
        <div class="filter-section">
            <form action="jsonPosts.cfm" method="post">
                <div class="filter-tags">
                    <cfoutput>
                    <label for="sortField">Etiketler:</label>
                        <cfloop collection="#uniqueTags#" item="tag">
                            <cfset isChecked = StructKeyExists(FORM, "tags") AND ArrayFind(ListToArray(FORM.tags), tag)>
                            <label><input type="checkbox" name="tags" value="#tag#" <cfif isChecked>checked</cfif>> #tag#</label>
                        </cfloop>
                    </cfoutput>
                </div>
                <div class="sort-section">
                    <label for="sortField">S&inodot;rala:</label>
                    <select name="sortField" id="sortField">
                        <option value="id">Post ID</option>
                        <option value="userId">User ID</option>
                    </select>
                    <select name="sortOrder" id="sortOrder">
                        <option value="asc">Artan</option>
                        <option value="desc">Azalan</option>
                    </select>
                </div>
                <input type="submit" value="Filtrele / Sırala" class="filter-button">
            </form>
        </div>

        <!--- If form submitted, get tags array --->
        <cfif structKeyExists(FORM, "tags")>
            <cfset selectedTags = ListToArray(FORM.tags)>
        </cfif>
        <cfif structKeyExists(FORM, "sortField") AND structKeyExists(FORM, "sortOrder")>
            <cfset sortField = FORM.sortField>
            <cfset sortOrder = FORM.sortOrder>
            <cfset arraySort(posts.posts, function(a, b) {
                if (sortOrder == "asc") {
                    return val(a[sortField]) - val(b[sortField]);
                } else {
                    return val(b[sortField]) - val(a[sortField]);
                }
            })>
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
                            <ul style="display: inline;">
                                <p>Tags: 
                                    <cfloop array="#post.tags#" index="tag">
                                        #tag#<cfif tag NEQ post.tags[arrayLen(post.tags)]>,</cfif>
                                    </cfloop>
                                </p>
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
