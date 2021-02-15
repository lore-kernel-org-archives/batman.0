Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/4] alfred: Allow exactly one interface for secondary mode
Date: Mon, 15 Feb 2021 21:01:24 +0100
Message-Id: <20210215200126.140253-2-sven@narfation.org>
In-Reply-To: <20210215200126.140253-1-sven@narfation.org>
References: <20210215200126.140253-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

A primary alfred daemon allows syncing over more than one interface. But
the secondary alfred daemon needs exactly one interface. But the check for
this property was insufficient because it allowed paramters like
"-i wlan0,asd" when wlan0 is valid and asd is not valid.

The better solution is to really use the number of interfaces given to
alfred instead of the number of interfaces evaluated as "valid".

Fixes: 67ae5f57eedd ("alfred: Add support for multiple interfaces per master")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h  |  1 +
 netsock.c | 11 +++++++++++
 server.c  |  4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/alfred.h b/alfred.h
index 1e2c058..7d6b0b3 100644
--- a/alfred.h
+++ b/alfred.h
@@ -182,6 +182,7 @@ int unix_sock_req_data_finish(struct globals *globals,
 int vis_update_data(struct globals *globals);
 /* netsock.c */
 int netsock_open_all(struct globals *globals);
+size_t netsocket_count_interfaces(struct globals *globals);
 void netsock_close_all(struct globals *globals);
 int netsock_set_interfaces(struct globals *globals, char *interfaces);
 struct interface *netsock_first_interface(struct globals *globals);
diff --git a/netsock.c b/netsock.c
index 367b207..84b0ec3 100644
--- a/netsock.c
+++ b/netsock.c
@@ -471,6 +471,17 @@ int netsock_open_all(struct globals *globals)
 	return num_socks;
 }
 
+size_t netsocket_count_interfaces(struct globals *globals)
+{
+	struct interface *interface;
+	size_t count = 0;
+
+	list_for_each_entry(interface, &globals->interfaces, list)
+		count++;
+
+	return count;
+}
+
 void netsock_reopen(struct globals *globals)
 {
 	struct interface *interface;
diff --git a/server.c b/server.c
index efac5ad..eb2bc8a 100644
--- a/server.c
+++ b/server.c
@@ -371,6 +371,7 @@ int alfred_server(struct globals *globals)
 	int maxsock, ret, recvs;
 	struct timespec last_check, now, tv;
 	fd_set fds, errfds;
+	size_t num_interfaces;
 	int num_socks;
 
 	if (create_hashes(globals))
@@ -397,7 +398,8 @@ int alfred_server(struct globals *globals)
 		return -1;
 	}
 
-	if (num_socks > 1 && globals->opmode == OPMODE_SECONDARY) {
+	num_interfaces = netsocket_count_interfaces(globals);
+	if (num_interfaces > 1 && globals->opmode == OPMODE_SECONDARY) {
 		fprintf(stderr, "More than one interface specified in secondary mode\n");
 		return -1;
 	}
-- 
2.30.0

