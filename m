Return-Path: <anatoliy.lapitskiy@gmail.com>
Message-ID: <55004A9F.3050908@gmail.com>
Date: Wed, 11 Mar 2015 16:01:03 +0200
From: Anatoliy <anatoliy.lapitskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH] alfred: "--update-script" flag for
 specifying a command for, running when new data piece is receviced.
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

Added "--update-script" flag for specifying a command for
  running when new data piece is receviced.

Sometimes it's worth to work on data ASAP after they updated and there
is no time to wait for facters.

Signed-off-by: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>"
---
  alfred.h     | 11 +++++++++++
  main.c       | 10 +++++++++-
  man/alfred.8 |  4 ++++
  recv.c       |  9 ++++++++-
  server.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
  5 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/alfred.h b/alfred.h
index f26c80c..4eed67c 100644
--- a/alfred.h
+++ b/alfred.h
@@ -55,6 +55,11 @@ struct dataset {
      uint8_t local_data;
  };

+struct changed_data_type {
+    int data_type;
+    struct list_head list;
+};
+
  struct transaction_packet {
      struct alfred_push_data_v0 *push;
      struct list_head list;
@@ -118,6 +123,10 @@ struct globals {
      int unix_sock;
      const char *unix_path;

+    const char *update_script;
+    struct list_head changed_data_types;
+    int changed_data_type_count;
+
      struct timespec if_check;

      struct hashtable_t *data_hash;
@@ -134,6 +143,8 @@ extern const struct in6_addr in6addr_localmcast;
  /* server.c */
  int alfred_server(struct globals *globals);
  int set_best_server(struct globals *globals);
+void changed_data_type(struct globals *globals, int arg);
+
  /* client.c */
  int alfred_client_request_data(struct globals *globals);
  int alfred_client_set_data(struct globals *globals);
diff --git a/main.c b/main.c
index e9821be..6b1a5d1 100644
--- a/main.c
+++ b/main.c
@@ -61,6 +61,7 @@ static void alfred_usage(void)
      printf("\n");
      printf("  -u, --unix-path [path]              path to unix socket 
used for client-server\n");
      printf("                                      communication 
(default: \""ALFRED_SOCK_PATH_DEFAULT"\")\n");
+    printf("  -c, --update-script                 path to script to 
call on data change\n");
      printf("  -v, --version                       print the version\n");
      printf("  -h, --help                          this help\n");
      printf("\n");
@@ -153,6 +154,7 @@ static struct globals *alfred_init(int argc, char 
*argv[])
          {"modeswitch",      required_argument,    NULL,    'M'},
          {"change-interface",    required_argument,    NULL, 'I'},
          {"unix-path",        required_argument,    NULL,    'u'},
+        {"update-script",        required_argument,    NULL, 'c'},
          {"version",        no_argument,        NULL,    'v'},
          {"verbose",        no_argument,        NULL,    'd'},
          {NULL,            0,            NULL,    0},
@@ -174,10 +176,13 @@ static struct globals *alfred_init(int argc, char 
*argv[])
      globals->mesh_iface = "bat0";
      globals->unix_path = ALFRED_SOCK_PATH_DEFAULT;
      globals->verbose = 0;
+    globals->update_script = NULL;
+    INIT_LIST_HEAD(&globals->changed_data_types);
+    globals->changed_data_type_count = 0;

      time_random_seed();

-    while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:d", 
long_options,
+    while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:I:u:dc:", 
long_options,
                    &opt_ind)) != -1) {
          switch (opt) {
          case 'r':
@@ -237,6 +242,9 @@ static struct globals *alfred_init(int argc, char 
*argv[])
          case 'd':
              globals->verbose++;
              break;
+        case 'c':
+            globals->update_script = optarg;
+            break;
          case 'v':
              printf("%s %s\n", argv[0], SOURCE_VERSION);
              printf("A.L.F.R.E.D. - Almighty Lightweight Remote Fact 
Exchange Daemon\n");
diff --git a/man/alfred.8 b/man/alfred.8
index a8050ab..872e200 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -114,6 +114,10 @@ still keeping redundancy (by having multiple 
masters). Obviously, at least one
  master must be present in the network to let any data exchange happen. 
Also
  having all nodes in master mode is possible (for maximum decentrality and
  overhead).
+.TP
+\fB\-c\fP, \fB\-\-update-script\fP \fIscriptname\fP
+Specify path to script to call on data change. The script is called with
+data-type list as arguments
  .
  .SH EXAMPLES
  Start an alfred server listening on bridge br0 (assuming that this bridge
diff --git a/recv.c b/recv.c
index e0252eb..0f6f50c 100644
--- a/recv.c
+++ b/recv.c
@@ -40,7 +40,7 @@ static int finish_alfred_push_data(struct globals 
*globals,
                     struct ether_addr mac,
                     struct alfred_push_data_v0 *push)
  {
-    int len, data_len;
+    int len, data_len, new_entry;
      struct alfred_data *data;
      struct dataset *dataset;
      uint8_t *pos;
@@ -57,6 +57,7 @@ static int finish_alfred_push_data(struct globals 
*globals,
          if ((int)(data_len + sizeof(*data)) > len)
              break;

+        new_entry = 0;
          dataset = hash_find(globals->data_hash, data);
          if (!dataset) {
              dataset = malloc(sizeof(*dataset));
@@ -71,6 +72,7 @@ static int finish_alfred_push_data(struct globals 
*globals,
                  free(dataset);
                  goto err;
              }
+            new_entry = 1;
          }
          /* don't overwrite our own data */
          if (dataset->data_source == SOURCE_LOCAL)
@@ -78,6 +80,11 @@ static int finish_alfred_push_data(struct globals 
*globals,

          clock_gettime(CLOCK_MONOTONIC, &dataset->last_seen);

+        /* check that data was changed */
+        if (new_entry || dataset->data.header.length != data_len || 
memcmp(dataset->buf, data->data, data_len) != 0) {
+            changed_data_type(globals, data->header.type);
+        }
+
          /* free old buffer */
          if (dataset->buf) {
              free(dataset->buf);
diff --git a/server.c b/server.c
index 1a3d876..f397de0 100644
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
@@ -138,6 +139,24 @@ int set_best_server(struct globals *globals)
      return 0;
  }

+void changed_data_type(struct globals *globals, int arg)
+{
+    if (!globals->update_script)
+        return;
+
+    struct changed_data_type *data_type = NULL;
+
+    list_for_each_entry(data_type, &globals->changed_data_types, list) {
+        if (data_type->data_type == arg)
+            return;
+    }
+
+    data_type = malloc(sizeof(*data_type));
+    data_type->data_type = arg;
+    list_add(&data_type->list, &globals->changed_data_types);
+    globals->changed_data_type_count++;
+}
+
  static int purge_data(struct globals *globals)
  {
      struct hash_it_t *hashit = NULL;
@@ -153,6 +172,8 @@ static int purge_data(struct globals *globals)
          if (diff.tv_sec < ALFRED_DATA_TIMEOUT)
              continue;

+        changed_data_type(globals, dataset->data.header.type);
+
          hash_remove_bucket(globals->data_hash, hashit);
          free(dataset->buf);
          free(dataset);
@@ -345,6 +366,34 @@ int alfred_server(struct globals *globals)
          }
          purge_data(globals);
          check_if_sockets(globals);
+
+        if (globals->update_script && 
!list_empty(&globals->changed_data_types)) {
+            /* call update script with list of datatypes_changed */
+            char command[strlen(globals->update_script) + 
7*globals->changed_data_type_count];
+            char buf[7];
+            strncpy(command, globals->update_script, sizeof(command));
+
+            struct changed_data_type *data_type, *is;
+            list_for_each_entry_safe(data_type, is, 
&globals->changed_data_types, list) {
+                /* append the datatype to command line */
+                snprintf(buf, sizeof(buf), " %d", data_type->data_type);
+                strncat(command, buf, sizeof(command) - strlen(command));
+
+                /* clean the list */
+                list_del(&data_type->list);
+                free(data_type);
+            }
+
+            printf("executing: %s\n", command);
+
+            signal(SIGCHLD, SIG_IGN);
+            int pid = fork();
+            if (pid == 0) {
+                system(command);
+                exit(0);
+            }
+            globals->changed_data_type_count = 0;
+        }
      }

      netsock_close_all(globals);
-- 
2.1.4

