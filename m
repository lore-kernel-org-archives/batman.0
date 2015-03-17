Return-Path: <anatoliy.lapitskiy@gmail.com>
Message-ID: <5507B4A5.5050905@gmail.com>
Date: Tue, 17 Mar 2015 06:59:17 +0200
From: Anatoliy <anatoliy.lapitskiy@gmail.com>
MIME-Version: 1.0
References: <1426419015-31756-1-git-send-email-anatoliy.lapitskiy@gmail.com>
 <2573454.vIxcRXbgX8@sven-edge>
In-Reply-To: <2573454.vIxcRXbgX8@sven-edge>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] alfred: Add "--update-command"
	parameter
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: "'b.a.t.m.a.n@lists.open-mesh.org'" <b.a.t.m.a.n@lists.open-mesh.org>

I'm still not sure about
buf[sizeof(buf)-1] = '\0';
and
command[command_len - 1] = '\0';
lines.

As far as I know snprintf appends '\0', so "buf" will always have null terminator. And so command will always have \0.

Should I rebase my commit to after new public commits?

Is there a link to code style used in project?

Thanks you,
Anatoliy

On 03/15/2015 11:47 PM, Sven Eckelmann wrote:
>> @@ -118,6 +123,10 @@ struct globals {
>>  	int unix_sock;
>>  	const char *unix_path;
>>  
>> +	const char *update_command;
>> +	struct list_head changed_data_types;
>> +	uint8_t changed_data_type_count;
>> +
> uint8_t is not enough to store the amount of changed data types. If
> data_type 0-255 are changed then it would have a count of 256 - which
> overflows changed_data_type_count and then ends up again as 0. This would
> completely kill this functionality because the list will never change
> again (it already has all types and can never remove any types) and
> thus this value will also never change again.
>
>> @@ -61,6 +61,7 @@ static void alfred_usage(void)
>>  	printf("\n");
>>  	printf("  -u, --unix-path [path]              path to unix socket used for client-server\n");
>>  	printf("                                      communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");
>> +	printf("  -c, --update-command                path to command to call on data change\n");
> command is not something with a path. So "path to command" doesn't sound
> right. Maybe just drop the "path to" part. 
>
>> +static void execute_update_command(struct globals *globals)
>> +{
>> +	pid_t script_pid;
>> +	size_t command_len;
>> +	char *command;
>> +	struct changed_data_type *data_type, *is;
>> +	/* data type is uint8_t, so 255 is maximum (3 chars)
>> +	 * space for appending + NULL
>> +	 */
>> +	char buf[5]; 
>> +
>> +
> Please remove the extra trailing whitespace after "buf[5];".
>
> Please remove the extra (second) blank line.
>
>> +	if (!globals->update_command || !globals->changed_data_type_count)
>> +		return;
>> +
>> +	/* length of script + 4 bytes per data type (space +3 chars)
>> +	 * + 1 for NULL
>> +	 */
> Can you change the NULL in the comment to "terminating null byte"?
> NULL just looks like it has something to do with pointers.
> (same in the comment above for buf)
>
>> +	command_len = strlen(globals->update_command);
>> +	command_len += 4 * globals->changed_data_type_count + 1;
>> +	command = malloc(command_len);
>> +	if (!command)
>> +		return;
>> +
>> +	strncpy(command, globals->update_command, command_len - 1);
>> +	list_for_each_entry_safe(data_type, is, &globals->changed_data_types,
>> +				 list) {
>> +		/* append the datatype to command line */
>> +		snprintf(buf, sizeof(buf), " %d", data_type->data_type);
>> +		buf[sizeof(buf)-1] = '\0';
> Please add a space before and after the '-' operator.
>
>> +
>> +		strncat(command, buf, command_len - strlen(command) - 1);
>> +
>> +		/* clean the list */
>> +		list_del(&data_type->list);
>> +		free(data_type);
>> +	}
>> +	globals->changed_data_type_count = 0;
>> +	command[command_len - 1] = '\0';
> This \0 has to be moved directly after the strncpy to be useful.
> The strncat is already expecting command to be \0 terminated.
>
> Kind regards,
> 	Sven

