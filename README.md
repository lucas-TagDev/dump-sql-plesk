<h1>DUMP ALL DATABASES SQL PLESK WINDOWS</h1>

<p>This script allows you to dump all databases managed by your Plesk on Windows.</p>

<p>The script consists of two commands, the first being:</p>

<pre>
<strong>Command:</strong> plesk db "SELECT name FROM data_bases;"
</pre>

<p>This command will allow you to list all databases created in your Plesk.<br> 
Command output:</p>

<pre>
+--------------+
| name         |
+--------------+
| database_01  |  
| database_02  |  
+--------------+
</pre>

<p>Save the output in a <code>.txt</code> file (e.g., <code>list.txt</code>) and remove any special characters, including whitespaces, using a text editor. Remove the characters <code>+</code>, <code>-</code>, <code>|</code> as well.</p>

<p>Once done, save the file, leaving only the database names.</p>

<p>The second command performs the Plesk dump using <code>mysqldump</code>, which comes pre-installed with Plesk. You will need the MySQL or MariaDB admin password for your Plesk.</p>

<pre>
<strong>Command:</strong> C:> "%plesk_dir%"MySQL\bin\mysqldump -uadmin -p -P3306 client_base > client_base.sql
</pre>

<p><strong>Note:</strong> The MySQL or MariaDB admin password will be requested during the command's execution. If the password is unknown, it can be safely changed in <strong>Tools &amp; Settings &gt; Database Servers &gt; localhost</strong> (default for MySQL or MariaDB) on port 3306.</p>

<p>After running this command, the desired database will be dumped.</p>

<p>With this in mind, if you have many databases, the script in this repository will do all the hard work for you. 😉</p>

<pre>
Edit script .ps1 to your information:

# Configurações
$BackupDir = "C:\backup_bancos"
$MySQLUser = "admin"
$MySQLPassword = "<YOUR-PASSWORD-SQL-PLESK>"
$MySQLPort = 3306
$MySQLPath = "C:\Program Files (x86)\Plesk\MySQL\bin"
$FilePath = "lista.txt"
$WaitSeconds = 10
</pre>

