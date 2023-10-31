<cfparam name="URL.newsID" default="0">
<cfquery name="getNewsDetail" datasource="NewsSiteDS">
    SELECT * FROM News
    JOIN Categories ON News.categoryID = Categories.categoryID
    WHERE newsID = <cfqueryparam value="#URL.newsID#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfif getNewsDetail.recordCount eq 0>
    Haber bulunamadı.
<cfelse>
    <cfset ARGUMENTS.Template = "newsDetailContent.cfm">
    <cfinclude template="layout.cfm">
</cfif>
