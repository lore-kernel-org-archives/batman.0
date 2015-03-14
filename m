Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Mar 2015 02:07:29 +0100
Message-ID: <4259215.0z9X6lndZN@sven-edge>
In-Reply-To: <1426253971-12677-1-git-send-email-anatoliy.lapitskiy@gmail.com>
References: <1426253971-12677-1-git-send-email-anatoliy.lapitskiy@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18055988.AjioGDWQcz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] alfred: Add "--update-script"
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
To: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart18055988.AjioGDWQcz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> --- a/man/alfred.8
> +++ b/man/alfred.8
> @@ -114,6 +114,10 @@ still keeping redundancy (by having multiple masters). Obviously, at least one
>  master must be present in the network to let any data exchange happen. Also
>  having all nodes in master mode is possible (for maximum decentrality and
>  overhead).
> +.TP
> +\fB\-c\fP, \fB\-\-update-script\fP \fIscriptname\fP
> +Specify script (or binary) to call on data change. It will be called
> +with data-type list as arguments.

Maybe it can be changed to use the term "command". At least this is how it
is described in the manpage for ssh, bash, git-filter-branch or even
system(3).


> @@ -78,6 +82,11 @@ static int finish_alfred_push_data(struct globals *globals,
>  
>  		clock_gettime(CLOCK_MONOTONIC, &dataset->last_seen);
>  
> +		/* check that data was changed */
> +		if (new_entry_created || dataset->data.header.length != data_len
> +		    || memcmp(dataset->buf, data->data, data_len) != 0)
> +			changed_data_type(globals, data->header.type);
> +

Logical continuations should be on the previous line

> +static void execute_script(struct globals *globals)
> +{
> +	pid_t script_pid;
> +	int command_len;

I think this should be size_t and not int.

> +	char *command;
> +	struct changed_data_type *data_type, *is;
> +	char buf[5]; /* data type is uint8_t, so 255 is maximum (3 chars) 

Please remove trailing whitespace

> +		        + space for appending + NULL */

Please replace the 8 spaces used for indentation with a single tab

I personally would prefer to have the long comment on a separate line.
And I think alfred uses the David-Miller-block-comment-style:

	/* data type is uint8_t, so 255 is maximum (3 chars) + space for
	 * appending + NULL
	 */
	char buf[5]; 

> +
> +	/* length of script +4 bytes per data type (space +3 chars) +1 for NULL */
> +	command_len = strlen(globals->update_script)
> +	            + 4 * globals->changed_data_type_count + 1;

Please replace the 8 spaces used for indentation with a single tab.

Please move the + to the previous line. Or better write it like:

command_len = strlen(globals->update_script);
command_len += 4 * globals->changed_data_type_count + 1;

> +	command = malloc(command_len);
> +	if (!command)
> +		return;
> +
> +	strncpy(command, globals->update_script, sizeof(command));

Sry, this doesn't work. Why do you limit the length to sizeof(char *)? This is
8 byte on my 64-bit system and 4 byte on my 32 bit system.

Even when the length calculation would be correct, could you please add the
\0 byte which isn't automatically added by strncpy:

command[command_len - 1] = '\0';

This is just in case someone will play around with the code in the future
and messes up the command_len calculation.

> +	list_for_each_entry_safe(data_type, is, &globals->changed_data_types, list) {
> +		/* append the datatype to command line */
> +		snprintf(buf, sizeof(buf), " %d", data_type->data_type);

See \0 comment from before.

> @@ -294,6 +356,9 @@ int alfred_server(struct globals *globals)
>  		return -1;
>  	}
>  
> +	/* don't let zombies to eat brains */
> +	signal(SIGCHLD, SIG_IGN);
> +

Could you implement it like the signal(...) already in main.c?

> @@ -345,6 +410,12 @@ int alfred_server(struct globals *globals)
>  		}
>  		purge_data(globals);
>  		check_if_sockets(globals);
> +
> +		if (globals->update_script && !list_empty(&globals->changed_data_types)) {
> +			/* call update script with list of datatypes_changed */
> +			execute_script(globals);
> +			globals->changed_data_type_count = 0;

This = 0 looks wrong here. What happens when the execute_script
returns before the list_for_each_entry_safe finishes (possible
in your current implementation)? Now changed_data_type_count is 0
and globals->changed_data_types is not empty.

The next call of execute_script will not allocate enough room to store
the command + its arguments. As result the arguments added to the command
are incorrect.

You could move this completely inside the execute_script function.
Including the if-precondition-check (you can even split it in two smaller
checks inside the function).

Kind regards,
	Sven
--nextPart18055988.AjioGDWQcz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVA4nXAAoJEF2HCgfBJntGXw0QAIUW9wQ5ZWqEBplIPdCDmFyS
/30RWZ1qSejmGcJhhQmS8uNrDgXIQsouYZKY9YPTQgDMelga+yEitmLkrt8VYtOd
2PP62p4nyxslvgCLQgmqi1ik08YRgtwuMiY69fwICvd4GeURb0CyYsE8NKzUEKgl
WVMDantl4GVia7MYeyL0XNEcazRlGsh5NV26SrKmdNrzc1NyMdXPXpST8UeGOl0g
AUoekDAjn5KfwGbJKoF6POFvXLKKtMs7hjtmZIzbfY3jvTNPMSX3SoXWDfsv94Ch
0tBibJxnL/LWgQDQBQqal9M+yfiwCpGMaTN7NWDoRFK6YKTGbGrWV9lORDN2S/X8
Ho95ZQQOYuXSeqtl26v17cr8NRr9HICHGItB4mmWN4HYxVd3AgfU1k9chcMnj4l6
yqLHiy1AQ6gz4oqXXRb1ryTNvMKJ/QC2gLbUBmLFiYJKTs+9zJdXfzicNZSHRVN0
i1EXSwTLMhRI6urKzDpq0/hZ5aOAMoXNTXJ5/fOd9fqvyLaqNs1tK9P5/bK4ryLu
FVBGmPxfI09ORDmFooe4gmqunJUL/n0f5C0bmTHmaq8XdxYVPOKKyCTeExkSns9G
4q4r4Ch4YA6IKMagQbuwmJvxY6TCEDfKpqMgLfMv4Uj5VAqD/2cAOJ+vseXG9eE6
wu7TxmuDIQ2MR5GYLz/+
=vJ9c
-----END PGP SIGNATURE-----

--nextPart18055988.AjioGDWQcz--

