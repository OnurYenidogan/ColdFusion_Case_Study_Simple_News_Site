<!-- jsonPosts.cfm -->
<html>
<head>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<cfinclude template="navigation.cfm">
    <div class="container">
        <cfhttp url="https://dummyjson.com/posts" method="get" result="response"></cfhttp>
        <cfset posts = DeserializeJSON(response.FileContent)>
        
        <cfoutput>
            <cfloop array="#posts.posts#" index="post">
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
            </cfloop>
        </cfoutput>
    </div>
</body>
</html>
