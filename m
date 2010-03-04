Return-Path: <post@tiwoc.de>
Message-ID: <4B8FBAAA.7060406@tiwoc.de>
Date: Thu, 04 Mar 2010 14:50:34 +0100
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH v2] batctl: avoid parsing bat-hosts multiple
	times
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Currently, running batctl from the home directory leads to warnings
("Warning - mac already known") if ~/bat-hosts exists. This is caused by
batctl parsing both "~/bat-hosts" and "bat-hosts" which happen to be the
same file when the working directory is ~

This patch adds duplicate file name detection to bat_hosts_init() to
avoid these warnings.

Signed-off-by: Daniel Seither <post@tiwoc.de>
---
Index: batctl/bat-hosts.c
===================================================================
--- batctl/bat-hosts.c	(revision 1579)
+++ batctl/bat-hosts.c	(working copy)
@@ -23,6 +23,7 @@

 #include <stdio.h>
 #include <stdint.h>
+#include <limits.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
@@ -144,9 +145,11 @@

 void bat_hosts_init(void)
 {
-	unsigned int i;
+	unsigned int i, j, parse;
 	char confdir[CONF_DIR_LEN];
 	char *homedir;
+	size_t locations = sizeof(bat_hosts_path) / sizeof(char *);
+	char *normalized[locations];

 	host_hash = hash_new(64, compare_mac, choose_mac);

@@ -157,7 +160,7 @@

 	homedir = getenv("HOME");

-	for (i = 0; i < sizeof(bat_hosts_path) / sizeof(char *); i++) {
+	for (i = 0; i < locations; i++) {
 		strcpy(confdir, "");

 		if (strlen(bat_hosts_path[i]) >= 2
@@ -169,9 +172,29 @@
 			strncpy(confdir, bat_hosts_path[i], CONF_DIR_LEN);
 			confdir[CONF_DIR_LEN - 1] = '\0';
 		}
-
-		parse_hosts_file(&host_hash, confdir);
+		
+		normalized[i] = realpath(confdir, NULL);
+		if (normalized[i] == NULL)
+			continue;
+		
+		/* check for duplicates: don't parse the same file twice */	
+		parse = 1;
+		for (j = 0; j < i; j++) {
+			if (normalized[j] == NULL)
+				continue;
+				
+			if (strncmp(normalized[i], normalized[j], CONF_DIR_LEN) == 0) {
+				parse = 0;
+				break;
+			}
+		}
+	
+		if (parse && (normalized[i] != NULL))
+			parse_hosts_file(&host_hash, normalized[i]);
 	}
+	
+	for (i = 0; i < locations; i++)
+		free(normalized[i]);
 }

 struct bat_host *bat_hosts_find_by_name(char *name)
