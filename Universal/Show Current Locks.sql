<?xml version="1.0" encoding="utf-8" ?>
<CodeSnippets  xmlns="http://schemas.microsoft.com/VisualStudio/2005/CodeSnippet">
<_locDefinition xmlns="urn:locstudio">
    <_locDefault _loc="locNone" />
    <_locTag _loc="locData">Title</_locTag>
    <_locTag _loc="locData">Description</_locTag>
    <_locTag _loc="locData">Author</_locTag>
    <_locTag _loc="locData">ToolTip</_locTag>
</_locDefinition>
	<CodeSnippet Format="1.0.0">
		<Header>
			<Title>Show Current Locks</Title>
                        <Shortcut></Shortcut>
			<Description>Shows current locked objects in the system.</Description>
			<Author>Matan yungman</Author>
			<SnippetTypes>
				<SnippetType>Expansion</SnippetType>
			</SnippetTypes>
		</Header>
		<Snippet>
			
			<Code Language="SQL">
		<![CDATA[
if object_id('tempdb..#locks') is not null
	drop table #locks
go
create table #locks(spid int,dbid int,objid int,indid int,type varchar(100),resource varchar(100),mode varchar(100),status varchar(100),objectName varchar(512))
go

insert #locks (spid,dbid,objid,indid,type,resource,mode,status) exec sp_lock 
exec sp_msforeachdb 'update l
					 set objectName = o.name
					 from #locks l inner join ?.sys.objects o with (nolock)
					 on l.objid = o.object_id and l.dbid = db_id(''?'')					 '

select spid,db_name(dbid) as DBName,objid,objectName,indid,type,resource,mode,status from #locks
]]>
			</Code>
		</Snippet>
	</CodeSnippet>
</CodeSnippets>