<cfscript>
	request.dilbertObj = createobject('component','dilbert');
	request.dilbert = request.dilbertObj.getDilbert(pathToFiles="c:\");
</cfscript>

<cfdump var="#request.dilbert#">