<div style="margin-left:180px;margin-right:180px;">
<h1>Tiki installer v{$tiki_version} <a title='help' href='http://tikiwiki.org/InstallTiki' target="help"><img
border='0' src='img/icons/help.gif' alt='help' /></a></h1>
<a href="tiki-install.php?restart=1" class="link">reload</a><br/><br/>
	{if $dbcon eq 'n' or $resetdb eq 'y'}
	  <b>Tiki cannot find a database connection</b><br/>
	  Please enter your database connection info<br/><br/>
	  <form action="tiki-install.php" method="post">
	  <table class="normal">
	  	<tr>
	  		<td class="formcolor">Database type:</td>
	  		<td class="formcolor">
	  			<table><tr><td>
			    <select name="db">
			    {section name=dbnames loop=$dbservers}
			    <option value="{$dbservers[dbnames]}">{$dbservers[dbnames]}</option>
			    {/section}
			    </select>
	  			</td><td>
	  			<small>The type of database you intend to use</small>
	  			</td></tr></table>
	  		
	  		</td>
	  	</tr>
	  	<tr>
	  		<td class="formcolor">Host:</td>
	  		<td class="formcolor">
	  			<table><tr><td>
	  			<input type="text" name="host" value="localhost" />
	  			</td><td>
	  			<small>Hostname or IP for your MySQL database, example:
	  			localhost if running in the same machine as tiki<br />
				If you use Oracle, insert your TNS Name here<br />
				If you use SQLite, insert the path and filename to your database file</small>
	  			</td></tr></table>
	  		
	  		</td>
	  	</tr>
	  	<tr>
	  		<td class="formcolor">User:</td>
	  		<td class="formcolor">
		  	  <table><tr><td>
	  		  <input type="text" name="user" />
	  		  </td><td>
	  		  <small>Database user</small>
	  		  </td></tr></table>
	  		</td>
	  	</tr>
	  	<tr>
	  		<td class="formcolor">Password:</td>
	  		<td class="formcolor">
		  	  <table><tr><td>
	  		  <input type="password" name="pass" />
	  		  </td><td>
	  		  <small>Database password</small>
	  		  </td></tr></table>
	  		</td>
	  	</tr>
	  	<tr>
	  		<td class="formcolor">Database name:</td>
	  		<td class="formcolor">
	  		<table><tr><td>
	  		<input type="text" name="name" />
	  		</td><td>
	  		<small>
	  		The name of the database where tiki will create tables. You can
	  		create the database using mysqladmin, or PHPMyAdmin or ask your
	  		hosting service to create a MySQL database.
	  		Normally Tiki tables won't conflict with other product names. 
	  		</small>
	  		</td></tr></table>
	  		</td>
	  	</tr>
	  	<tr>
	  		<td class="formcolor">&nbsp;</td>
	  		<td class="formcolor"><input type="hidden" name="resetdb" value="{$resetdb}">
	  		<input type="submit" name="dbinfo" /></td>
	  	</tr>
	  	
	  </table>
	  </form>
	{else}
	  {* we do have a database connection *}
	  {if $dbdone eq 'n'}
		  {if $logged eq 'y'}
		    {* we are logged if no admin account is found or if he user logged in*}
		    <b>Welcome to the installation script!</b><br/>
		    You can now create a new database or update your current database<br/><br/>
		    <form method="post" action="tiki-install.php">
		    <table>
		    <tr><td>
			Create database with profile:
			</td><td>
			<select name="profile">
			{section name=ix loop=$profiles}
			<option value="{$profiles[ix].name|escape}">{$profiles[ix].desc}</option>
			{/section}
			</select>
			<input type="submit" name="scratch" value="create" />	    
		    </td></tr>
		    <tr><td>
			</td><td>
			<a href="http://tikiwiki.org/tiki-index.php?page=TikiProfiles" class="link">Descriptions of the available profiles</a>
			<p>
		    </td></tr>
		    <tr><td>
			Update database using script: 
			</td><td>
			<select name="file">
			{section name=ix loop=$files}
			<option value="{$files[ix]|escape}">{$files[ix]}</option>
			{/section}
			</select>
			<input type="submit" name="update" value="update" />
		    </td></tr>
		    </table>
		    </form><br/>
			<a href="tiki-index.php" class="link">Do nothing and enter Tiki</a><br />
			<a href="tiki-install.php?reset=yes" class="link">Reset database connection settings</a>
		  {else}
			{* we are not logged then no admin account found and user not logged*}
			<b>This site has an admin account configured</b><br/>
		    Please enter your admin password to continue<br/><br/>

     <form name="loginbox" action="tiki-install.php" method="post"> 
          <table>
          <tr><td class="module">{tr}user{/tr}:</td></tr>
          <tr><td>admin</td></tr>
          <tr><td class="module">{tr}pass{/tr}:</td></tr>
          <tr><td><input type="password" name="pass" size="20" /></td></tr>
          <tr><td><input type="submit" name="login" value="{tr}login{/tr}" /></td></tr>
          </table>
      </form>

{*
		  	<form action="tiki-install.php" method="post">
		  	<table class="normal">
		  		<tr>
		  			<td class="formcolor">Admin password</td>
		  			<td class="formcolor"><input type="password" name="pass" /></td>
		  		</tr>
		  		<tr>
		  			<td class="formcolor">&nbsp;</td>
		  			<td class="formcolor"><input type="submit" name="login" value="login" /></td>
		  		</tr>
		    </table>
		    </form>
*}
		  {/if}
    	{else}
    		<b>Print operations executed successfully</b><br/>
    		<textarea rows="15" cols="80">
    		{section loop=$succcommands name=ix}
    		{$succcommands[ix]}
    		{/section}
    		</textarea><br/><br/>
    		<b>Print operations failed</b><br/>
    		<textarea rows="15" cols="80">
    		{section loop=$failedcommands name=ix}
    		{$failedcommands[ix]}
    		{/section}
    		</textarea><br/><br/>
    		Your database has been configured and Tiki is ready to run, if
    		this is your first install your admin password is 'admin'. You can
    		now log in into Tiki as 'admin' - 'admin' and start configuring
    		the application.<br/>
    		Note: This install script may be potentially harmful so we strongly
    		recommend you to remove the script and then proceed into Tiki. If
    		you decide to remove the script it will be renamed to tiki-install.done<br/><br/>
    		<a href="tiki-install.php?kill=1" class="link">Click here to remove the install script and proceed into tiki</a><br/>
    		<a href="tiki-index.php" class="link">Click here to proceed into tiki without removing the script</a><br />
    		<a href="tiki-install.php?reset=yes" class="link">Reset database connection settings</a>
    	{/if}
	{/if}

</div>
