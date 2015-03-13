Return-Path: <anatoliy.lapitskiy@gmail.com>
Message-ID: <5502BBBF.2030801@gmail.com>
Date: Fri, 13 Mar 2015 12:28:15 +0200
From: Anatoliy <anatoliy.lapitskiy@gmail.com>
MIME-Version: 1.0
References: <1426158361-6090-1-git-send-email-anatoliy.lapitskiy@gmail.com>
 <5077509.urIbKZALzi@bentobox>
In-Reply-To: <5077509.urIbKZALzi@bentobox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] Added "--update-script" flag for
 specifying a command for running when new data piece is receviced.
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

Thank you very much for the review.
I have some notes below.

Anatoliy


On 03/13/2015 10:35 AM, Sven Eckelmann wrote:
> On Thursday 12 March 2015 13:06:01 Anatoliy Lapitskiy wrote:
>> Sometimes it's worth to work on data ASAP after they updated and there
>> is no time to wait for facters.
>>
>> Signed-off-by: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>"
>
> Why is there a double-quote at the end of the Signed-off-by?
>
> The prefix "alfred: " is missing in the subject
>
> The subject is quite long but the description is quite short.
> Can you make the subject shorter and explain the rest better
> in the description?
>
> Further comments to the code can be found below.
>
>> ---
>>  alfred.h     | 11 +++++++++++
>>  main.c       | 10 +++++++++-
>>  man/alfred.8 |  4 ++++
>>  recv.c       |  9 ++++++++-
>>  server.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 81 insertions(+), 2 deletions(-)
>>
>> diff --git a/alfred.h b/alfred.h
>> index f26c80c..4eed67c 100644
>> --- a/alfred.h
>> +++ b/alfred.h
>> @@ -55,6 +55,11 @@ struct dataset {
>>  	uint8_t local_data;
>>  };
>>  
>> +struct changed_data_type {
>> +	int data_type;
> Data types are always uint8_t. Why are they becoming int here?
>
>> +	struct list_head list;
>> +};
>> +
>>  struct transaction_packet {
>>  	struct alfred_push_data_v0 *push;
>>  	struct list_head list;
>> @@ -118,6 +123,10 @@ struct globals {
>>  	int unix_sock;
>>  	const char *unix_path;
>>  
>> +	const char *update_script;
>> +	struct list_head changed_data_types;
>> +	int changed_data_type_count;
>> +
> Why is the counter signed?
>
>>  	struct timespec if_check;
>>  
>>  	struct hashtable_t *data_hash;
>> @@ -134,6 +143,8 @@ extern const struct in6_addr in6addr_localmcast;
>>  /* server.c */
>>  int alfred_server(struct globals *globals);
>>  int set_best_server(struct globals *globals);
>> +void changed_data_type(struct globals *globals, int arg);
>> +
> Data types are always uint8_t. Why are they becoming int here?
>
>>  /* client.c */
>>  int alfred_client_request_data(struct globals *globals);
>>  int alfred_client_set_data(struct globals *globals);
>> diff --git a/main.c b/main.c
>> index e9821be..6b1a5d1 100644
>> --- a/main.c
>> +++ b/main.c
>> @@ -61,6 +61,7 @@ static void alfred_usage(void)
>>  	printf("\n");
>>  	printf("  -u, --unix-path [path]              path to unix socket used for client-server\n");
>>  	printf("                                      communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");
>> +	printf("  -c, --update-script                 path to script to call on data change\n");
>>  	printf("  -v, --version                       print the version\n");
>>  	printf("  -h, --help                          this help\n");
>>  	printf("\n");
>> @@ -153,6 +154,7 @@ static struct globals *alfred_init(int argc, char *argv[])
>>  		{"modeswitch",  	required_argument,	NULL,	'M'},
>>  		{"change-interface",	required_argument,	NULL,	'I'},
>>  		{"unix-path",		required_argument,	NULL,	'u'},
>> +		{"update-script",		required_argument,	NULL,	'c'},
>>  		{"version",		no_argument,		NULL,	'v'},
>>  		{"verbose",		no_argument,		NULL,	'd'},
>>  		{NULL,			0,			NULL,	0},
> Fix your tabs here. Your line is unaligned starting with the required_argument
>
>> @@ -174,10 +176,13 @@ static struct globals *alfred_init(int argc, char *argv[])
>>  	globals->mesh_iface = "bat0";
>>  	globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
>>  	globals->verbose = 0;
>> +	globals->update_script = NULL;
>> +	INIT_LIST_HEAD(&globals->changed_data_types);
>> +	globals->changed_data_type_count = 0;
>>  
>>  	time_random_seed();
>>  
>> -	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:d", long_options,
>> +	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:", long_options,
>>  				  &opt_ind)) != -1) {
>>  		switch (opt) {
>>  		case 'r':
>> @@ -237,6 +242,9 @@ static struct globals *alfred_init(int argc, char *argv[])
>>  		case 'd':
>>  			globals->verbose++;
>>  			break;
>> +		case 'c':
>> +			globals->update_script = optarg;
>> +			break;
>>  		case 'v':
>>  			printf("%s %s\n", argv[0], SOURCE_VERSION);
>>  			printf("A.L.F.R.E.D. - Almighty Lightweight Remote Fact Exchange Daemon\n");
>> diff --git a/man/alfred.8 b/man/alfred.8
>> index a8050ab..872e200 100644
>> --- a/man/alfred.8
>> +++ b/man/alfred.8
>> @@ -114,6 +114,10 @@ still keeping redundancy (by having multiple masters). Obviously, at least one
>>  master must be present in the network to let any data exchange happen. Also
>>  having all nodes in master mode is possible (for maximum decentrality and
>>  overhead).
>> +.TP
>> +\fB\-c\fP, \fB\-\-update-script\fP \fIscriptname\fP
>> +Specify path to script to call on data change. The script is called with
>> +data-type list as arguments
>>  .
>>  .SH EXAMPLES
>>  Start an alfred server listening on bridge br0 (assuming that this bridge
>> diff --git a/recv.c b/recv.c
>> index e0252eb..0f6f50c 100644
>> --- a/recv.c
>> +++ b/recv.c
>> @@ -40,7 +40,7 @@ static int finish_alfred_push_data(struct globals *globals,
>>  				   struct ether_addr mac,
>>  				   struct alfred_push_data_v0 *push)
>>  {
>> -	int len, data_len;
>> +	int len, data_len, new_entry;
>>  	struct alfred_data *data;
>>  	struct dataset *dataset;
>>  	uint8_t *pos;
> Has anyone a better name for new_entry? I don't really like it because
> it sounds to me like a variable that stores the pointer to a new object.
"new_entry_created"?
btw, it could be bool as it's just a flag. can I use <stdbool.h> from C99?
>
>> @@ -57,6 +57,7 @@ static int finish_alfred_push_data(struct globals *globals,
>>  		if ((int)(data_len + sizeof(*data)) > len)
>>  			break;
>>  
>> +		new_entry = 0;
>>  		dataset = hash_find(globals->data_hash, data);
>>  		if (!dataset) {
>>  			dataset = malloc(sizeof(*dataset));
>> @@ -71,6 +72,7 @@ static int finish_alfred_push_data(struct globals *globals,
>>  				free(dataset);
>>  				goto err;
>>  			}
>> +			new_entry = 1;
>>  		}
>>  		/* don't overwrite our own data */
>>  		if (dataset->data_source == SOURCE_LOCAL)
>> @@ -78,6 +80,11 @@ static int finish_alfred_push_data(struct globals *globals,
>>  
>>  		clock_gettime(CLOCK_MONOTONIC, &dataset->last_seen);
>>  
>> +		/* check that data was changed */
>> +		if (new_entry || dataset->data.header.length != data_len || memcmp(dataset->buf, data->data, data_len) != 0) {
>> +			changed_data_type(globals, data->header.type);
>> +		}
>> +
> Please reduce the length of your lines. I know that alfred is not always
> using a maximum of 80 character per lines but we don't have to add more
> of these overlong lines.
>
> Dont use { } around single line scopes after if/while/for/...
>
>>  		/* free old buffer */
>>  		if (dataset->buf) {
>>  			free(dataset->buf);
>> diff --git a/server.c b/server.c
>> index 1a3d876..f397de0 100644
>> --- a/server.c
>> +++ b/server.c
>> @@ -23,6 +23,7 @@
>>  #include <inttypes.h>
>>  #include <net/ethernet.h>
>>  #include <net/if.h>
>> +#include <signal.h>
>>  #include <stddef.h>
>>  #include <stdint.h>
>>  #include <stdio.h>
>> @@ -138,6 +139,24 @@ int set_best_server(struct globals *globals)
>>  	return 0;
>>  }
>>  
>> +void changed_data_type(struct globals *globals, int arg)
>> +{
>> +	if (!globals->update_script)
>> +		return;
>> +
>> +	struct changed_data_type *data_type = NULL;
> Please don't mix variable declarations and code. Try to keep the
> declarations at the beginning.
>
>> +
>> +	list_for_each_entry(data_type, &globals->changed_data_types, list) {
>> +		if (data_type->data_type == arg)
>> +			return;
>> +	}
>> +
>> +	data_type = malloc(sizeof(*data_type));
>> +	data_type->data_type = arg;
>> +	list_add(&data_type->list, &globals->changed_data_types);
> You are dereferencing something which could be NULL. Here from the
> man page:
>
> "On error, these functions return NULL."
>
>> +	globals->changed_data_type_count++;
>> +}
>> +
>>  static int purge_data(struct globals *globals)
>>  {
>>  	struct hash_it_t *hashit = NULL;
>> @@ -153,6 +172,8 @@ static int purge_data(struct globals *globals)
>>  		if (diff.tv_sec < ALFRED_DATA_TIMEOUT)
>>  			continue;
>>  
>> +		changed_data_type(globals, dataset->data.header.type);
>> +
>>  		hash_remove_bucket(globals->data_hash, hashit);
>>  		free(dataset->buf);
>>  		free(dataset);
>> @@ -345,6 +366,34 @@ int alfred_server(struct globals *globals)
>>  		}
>>  		purge_data(globals);
>>  		check_if_sockets(globals);
>> +
>> +		if (globals->update_script && !list_empty(&globals->changed_data_types)) {
>> +			/* call update script with list of datatypes_changed */
>> +			char command[strlen(globals->update_script) + 7*globals->changed_data_type_count];
> Please don't use variable length arrays.
>
> Please fix your spacing around operands.
>
> The calculation of the command length is complete bogus.
Agree. it should be length of update_script + 4 * changed count (3 for data type as maximum is "255" + space) + 1 for NULL.
I will add a comment about it.
>
>> +			char buf[7];
>> +			strncpy(command, globals->update_script, sizeof(command));
> Please make sure the the command is null terminated after strncpy.
>
> Also add a blank line after the declarations.
>
> Similar problem like the command buffer length... why the random chosen
> number 7 for the buffer length? It is too small for your data type
> (btw your data type for data_type is not fixed size), it doesn't include
> space for the \0 byte at the end.
yes, 7 isn't correct number. The correct number is 5 (3 for data type which is 255 maximum + 1 for space + 1 for NULL)
I will add a comment about it.
>
>> +
>> +			struct changed_data_type *data_type, *is;
>> +			list_for_each_entry_safe(data_type, is, &globals->changed_data_types, list) {
>> +				/* append the datatype to command line */
>> +				snprintf(buf, sizeof(buf), " %d", data_type->data_type);
> Please make sure the the command is null terminated after strncpy
>
> Also add a blank line after the declarations.
>
> Please don't mix variable declarations and code. Try to keep the
> declarations at the beginning.
>
>> +				strncat(command, buf, sizeof(command) - strlen(command));
> Make sure that there is enough room in command for the final \0 which is
> appended by strncat. Currently it will just write over the end of the
> buffer.
>
>> +
>> +				/* clean the list */
>> +				list_del(&data_type->list);
>> +				free(data_type);
>> +			}
>> +
>> +			printf("executing: %s\n", command);
>> +
>> +			signal(SIGCHLD, SIG_IGN);
> Why is the signal "handler" set always before fork?
>
>> +			int pid = fork();
>> +			if (pid == 0) {
>> +				system(command);
> Why do you want to execute the command using the system shell? Maybe you
> wanted to use something from the exec* family instead.
In case if user will set shell script as "update-script" parameter, exec* won't work.
Of course, I can add "sh", "-c" to exec* parameters, but what advantages this method will have then?
>
> Please don't mix variable declarations and code. Try to keep the
> declarations at the beginning.
>
>> +				exit(0);
>> +			}
>> +			globals->changed_data_type_count = 0;
>> +		}
>>  	}
>>  
>>  	netsock_close_all(globals);
>>
> Please move this large block to an extra function.
>
> Maybe there are more thing but I have to stop the review now.
Again, thank you very much for review.
Is there a link for code style used?
>
> Kind regards,
> 	Sven
>

