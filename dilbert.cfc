<cfcomponent output="false">

	<cffunction name="getDilbert" access="public" returntype="string" output="true" hint="gets todays dilbert cartoon">
		<cfargument name="pathToFiles" type="string" required="true" hint="file path to save the images in - c:\...">
		<cfset var dilbertUrl = "http://dilbert.com">
		<cfset var response = "">
		<cfset var strUserAgent = ("Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070309 Firefox/2.0.0.3")>
		<cfset var dateStr = lsdateformat(now())>

		<cftry>

			<!--- Initial hhtp call gets the whole page --->
			<cfhttp method="get" url="#dilbertUrl#" useragent="#strUserAgent#" charset="utf-8" throwonerror="yes">
				<cfhttpparam type="header" name="Accept-Encoding" value="*" />
				<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			</cfhttp>

			<cfscript>
				// lloking for (example) /dyn/str_strip/000000000/00000000/0000000/100000/10000/1000/000/111067/111067.strip.sunday.gif
				// find and strip out the image url
				startPos	= findNoCase('/dyn/str_strip/', cfhttp.Filecontent, 1);
				endPos		= findNoCase('.gif', cfhttp.Filecontent, startPos);
				diff		= endPos-startPos;
				imgStr		= mid(cfhttp.Filecontent, startPos, diff);
				imgStr		= dilbertUrl & imgStr & '.gif';
			</cfscript>

			<!--- second http call, get the image and save it --->
			<cfhttp method="get" url="#imgStr#" useragent="#strUserAgent#" throwonerror="yes" path="#arguments.pathToFiles#" file="#dateStr#-dilbert.gif">
				<cfhttpparam type="header" name="Accept-Encoding" value="*" />
				<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			</cfhttp>

			<cfset response = "#dateStr#-dilbert.gif">

		<cfcatch>
			<cfset response = cfcatch.message>
		</cfcatch>
		</cftry>

		<cfreturn response>
	</cffunction>

</cfcomponent>
