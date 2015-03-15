Return-Path: <anatoliy.lapitskiy@gmail.com>
From: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>
Date: Sun, 15 Mar 2015 13:30:15 +0200
Message-Id: <1426419015-31756-1-git-send-email-anatoliy.lapitskiy@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH v4] alfred: Add "--update-command" parameter
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
To: b.a.t.m.a.n@lists.open-mesh.org

The "--update-command" parameter is created for adding a hook to run when
new information is received.

At the moment "alfred-facters" are run by cron once per every 5 minutes.
For some tasks (like sharing dhcp leases) it can be too slow.

Signed-off-by: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>
---
 alfred.h     | 11 +++++++++
 main.c       | 12 +++++++++-
 man/alfred.8 |  4 ++++
 recv.c       | 10 ++++++++
 server.c     | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/alfred.h b/alfred.h
index f26c80c..bbd48c0 100644
--- a/alfred.h
+++ b/alfred.h
@@ -55,6 +55,11 @@ struct dataset {
 	uint8_t local_data;
 };
 
+struct changed_data_type {
+	uint8_t data_type;
+	struct list_head list;
+};
+
 struct transaction_packet {
 	struct alfred_push_data_v0 *push;
 	struct list_head list;
@@ -118,6 +123,10 @@ struct globals {
 	int unix_sock;
 	const char *unix_path;
 
+	const char *update_command;
+	struct list_head changed_data_types;
+	uint8_t changed_data_type_count;
+
 	struct timespec if_check;
 
 	struct hashtable_t *data_hash;
@@ -134,6 +143,8 @@ extern const struct in6_addr in6addr_localmcast;
 /* server.c */
 int alfred_server(struct globals *globals);
 int set_best_server(struct globals *globals);
+void changed_data_type(struct globals *globals, uint8_t arg);
+
 /* client.c */
 int alfred_client_request_data(struct globals *globals);
 int alfred_client_set_data(struct globals *globals);
diff --git a/main.c b/main.c
index e9821be..499c5d0 100644
--- a/main.c
+++ b/main.c
@@ -61,6 +61,7 @@ static void alfred_usage(void)
 	printf("\n");
 	printf("  -u, --unix-path [path]              path to unix socket used for client-server\n");
 	printf("                                      communication (default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");
+	printf("  -c, --update-command                path to command to call on data change\n");
 	printf("  -v, --version                       print the version\n");
 	printf("  -h, --help                          this help\n");
 	printf("\n");
@@ -153,6 +154,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{"modeswitch",  	required_argument,	NULL,	'M'},
 		{"change-interface",	required_argument,	NULL,	'I'},
 		{"unix-path",		required_argument,	NULL,	'u'},
+		{"update-command",	required_argument,	NULL,	'c'},
 		{"version",		no_argument,		NULL,	'v'},
 		{"verbose",		no_argument,		NULL,	'd'},
 		{NULL,			0,			NULL,	0},
@@ -174,10 +176,13 @@ static struct globals *alfred_init(int argc, char *argv[])
 	globals->mesh_iface = "bat0";
 	globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
 	globals->verbose = 0;
+	globals->update_command = NULL;
+	INIT_LIST_HEAD(&globals->changed_data_types);
+	globals->changed_data_type_count = 0;
 
 	time_random_seed();
 
-	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:d", long_options,
+	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
 		case 'r':
@@ -237,6 +242,9 @@ static struct globals *alfred_init(int argc, char *argv[])
 		case 'd':
 			globals->verbose++;
 			break;
+		case 'c':
+			globals->update_command = optarg;
+			break;
 		case 'v':
 			printf("%s %s\n", argv[0], SOURCE_VERSION);
 			printf("A.L.F.R.E.D. - Almighty Lightweight Remote Fact Exchange Daemon\n");
@@ -250,6 +258,8 @@ static struct globals *alfred_init(int argc, char *argv[])
 
 	if (signal(SIGPIPE, SIG_IGN) == SIG_ERR)
 		perror("could not register SIGPIPE handler");
+	if (signal(SIGCHLD, SIG_IGN) == SIG_ERR)
+		perror("could not register SIGCHLD handler");
 	return globals;
 }
 
diff --git a/man/alfred.8 b/man/alfred.8
index a8050ab..e21bb55 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -114,6 +114,10 @@ still keeping redundancy (by having multiple masters). Obviously, at least one
 master must be present in the network to let any data exchange happen. Also
 having all nodes in master mode is possible (for maximum decentrality and
 overhead).
+.TP
+\fB\-c\fP, \fB\-\-update-command\fP \fIcommand\fP
+Specify command to execute on data change. It will be called with data-type list
+as arguments.
 .
 .SH EXAMPLES
 Start an alfred server listening on bridge br0 (assuming that this bridge
diff --git a/recv.c b/recv.c
index e0252eb..2a3a45a 100644
--- a/recv.c
+++ b/recv.c
@@ -22,6 +22,7 @@
 #include <errno.h>
 #include <net/ethernet.h>
 #include <netinet/in.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -41,6 +42,7 @@ static int finish_alfred_push_data(struct globals *globals,
 				   struct alfred_push_data_v0 *push)
 {
 	int len, data_len;
+	bool new_entry_created;
 	struct alfred_data *data;
 	struct dataset *dataset;
 	uint8_t *pos;
@@ -57,6 +59,7 @@ static int finish_alfred_push_data(struct globals *globals,
 		if ((int)(data_len + sizeof(*data)) > len)
 			break;
 
+		new_entry_created = false;
 		dataset = hash_find(globals->data_hash, data);
 		if (!dataset) {
 			dataset = malloc(sizeof(*dataset));
@@ -71,6 +74,7 @@ static int finish_alfred_push_data(struct globals *globals,
 				free(dataset);
 				goto err;
 			}
+			new_entry_created = true;
 		}
 		/* don't overwrite our own data */
 		if (dataset->data_source == SOURCE_LOCAL)
@@ -78,6 +82,12 @@ static int finish_alfred_push_data(struct globals *globals,
 
 		clock_gettime(CLOCK_MONOTONIC, &dataset->last_seen);
 
+		/* check that data was changed */
+		if (new_entry_created ||
+		    dataset->data.header.length != data_len ||
+		    memcmp(dataset->buf, data->data, data_len) != 0)
+			changed_data_type(globals, data->header.type);
+
 		/* free old buffer */
 		if (dataset->buf) {
 			free(dataset->buf);
diff --git a/server.c b/server.c
index 1a3d876..5e31695 100644
--- a/server.c
+++ b/server.c
@@ -23,6 +23,7 @@
 #include <inttypes.h>
 #include <net/ethernet.h>
 #include <net/if.h>
+#include <signal.h>
 #include <stddef.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -138,6 +139,27 @@ int set_best_server(struct globals *globals)
 	return 0;
 }
 
+void changed_data_type(struct globals *globals, uint8_t arg)
+{
+	struct changed_data_type *data_type = NULL;
+
+	if (!globals->update_command)
+		return;
+
+	list_for_each_entry(data_type, &globals->changed_data_types, list) {
+		if (data_type->data_type == arg)
+			return;
+	}
+
+	data_type = malloc(sizeof(*data_type));
+	if (!data_type)
+		return;
+
+	data_type->data_type = arg;
+	list_add(&data_type->list, &globals->changed_data_types);
+	globals->changed_data_type_count++;
+}
+
 static int purge_data(struct globals *globals)
 {
 	struct hash_it_t *hashit = NULL;
@@ -153,6 +175,8 @@ static int purge_data(struct globals *globals)
 		if (diff.tv_sec < ALFRED_DATA_TIMEOUT)
 			continue;
 
+		changed_data_type(globals, dataset->data.header.type);
+
 		hash_remove_bucket(globals->data_hash, hashit);
 		free(dataset->buf);
 		free(dataset);
@@ -261,6 +285,57 @@ static void check_if_sockets(struct globals *globals)
 		check_if_socket(interface);
 }
 
+static void execute_update_command(struct globals *globals)
+{
+	pid_t script_pid;
+	size_t command_len;
+	char *command;
+	struct changed_data_type *data_type, *is;
+	/* data type is uint8_t, so 255 is maximum (3 chars)
+	 * space for appending + NULL
+	 */
+	char buf[5]; 
+
+
+	if (!globals->update_command || !globals->changed_data_type_count)
+		return;
+
+	/* length of script + 4 bytes per data type (space +3 chars)
+	 * + 1 for NULL
+	 */
+	command_len = strlen(globals->update_command);
+	command_len += 4 * globals->changed_data_type_count + 1;
+	command = malloc(command_len);
+	if (!command)
+		return;
+
+	strncpy(command, globals->update_command, command_len - 1);
+	list_for_each_entry_safe(data_type, is, &globals->changed_data_types,
+				 list) {
+		/* append the datatype to command line */
+		snprintf(buf, sizeof(buf), " %d", data_type->data_type);
+		buf[sizeof(buf)-1] = '\0';
+
+		strncat(command, buf, command_len - strlen(command) - 1);
+
+		/* clean the list */
+		list_del(&data_type->list);
+		free(data_type);
+	}
+	globals->changed_data_type_count = 0;
+	command[command_len - 1] = '\0';
+
+	printf("executing: %s\n", command);
+
+	script_pid = fork();
+	if (script_pid == 0) {
+		system(command);
+		exit(0);
+	}
+
+	free(command);
+}
+
 int alfred_server(struct globals *globals)
 {
 	int maxsock, ret, recvs;
@@ -345,6 +420,7 @@ int alfred_server(struct globals *globals)
 		}
 		purge_data(globals);
 		check_if_sockets(globals);
+		execute_update_command(globals);
 	}
 
 	netsock_close_all(globals);
-- 
2.1.4

