﻿<!-- jsonPosts.cfm -->
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
            background-color: #28a745;
            color: #ffffff;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .sort-section select {
            font-size: 16px;
        }


    </style>
</head>
<body>
<cfinclude template="navigation.cfm">
    <div class="container">
    
            <!--- İnternetten JSON verisini çekmek için--->
        <cfhttp url="https://dummyjson.com/posts" method="get" result="response"></cfhttp>
        <cfset posts = DeserializeJSON(response.FileContent)>

        <!--- Yerel JSON verisini çekmek için
        <cfset fileContent = FileRead(expandPath("./posts.json"))>
        <cfset posts = DeserializeJSON(fileContent)>
        --->

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
                    <label>Sırala:</label>
                    <input type="radio" name="sortField" value="id" <cfif NOT structKeyExists(FORM, "sortField") OR FORM.sortField eq "id">checked</cfif>> Post ID
                    <input type="radio" name="sortField" value="userId" <cfif structKeyExists(FORM, "sortField") AND FORM.sortField eq "userId">checked</cfif>> User ID
                    <input type="radio" name="sortField" value="reactions" <cfif structKeyExists(FORM, "sortField") AND FORM.sortField eq "reactions">checked</cfif>> Reactions
                    <select name="sortOrder" id="sortOrder">
                        <option value="asc" <cfif NOT structKeyExists(FORM, "sortOrder") OR FORM.sortOrder eq "asc">selected</cfif>>Artan Sıra</option>
                        <option value="desc" <cfif structKeyExists(FORM, "sortOrder") AND FORM.sortOrder eq "desc">selected</cfif>>Azalan Sıra</option>
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
