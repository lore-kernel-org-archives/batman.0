From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 24 Nov 2008 12:08:26 +0100
Message-Id: <1227524906-12097-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Don't create different definitions of
	variables from header
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Declaration of variables in header files must be marked extern or they will
create new definition in all files which include it. This could create
collisions on different architectures or by using different linkers.
A different effect is the misfeature of the program when different files access
these variable and think they would use the same variable in memory.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-userspace/batman-adv.h |    2 +-
 batman-experimental/batman.h      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/batman-adv-userspace/batman-adv.h b/batman-adv-userspace/batman-adv.h
index 6c0aed3..33c5412 100644
--- a/batman-adv-userspace/batman-adv.h
+++ b/batman-adv-userspace/batman-adv.h
@@ -134,7 +134,7 @@ extern uint32_t pref_gateway;
 extern unsigned char *hna_buff;
 
 extern struct gw_node *curr_gateway;
-pthread_t curr_gateway_thread_id;
+extern pthread_t curr_gateway_thread_id;
 
 extern uint8_t found_ifs;
 extern int32_t receive_max_sock;
diff --git a/batman-experimental/batman.h b/batman-experimental/batman.h
index 8bcb48d..5fe64f6 100644
--- a/batman-experimental/batman.h
+++ b/batman-experimental/batman.h
@@ -568,7 +568,7 @@ extern struct list_head_first notun_list;
 
 extern struct unix_if unix_if;
 
-struct vis_if *vis_if;
+extern struct vis_if *vis_if;
 
 extern pthread_t gw_thread_id;
 
-- 
1.6.0.4

