From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  1 Dec 2008 21:11:57 +0100
Message-Id: <1228162317-31331-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
References: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Don't convert new_hna_len from int16_t to
	int and back to int16_t
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/batman.c |    2 +-
 batman/os.h     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/batman/batman.c b/batman/batman.c
index 0c17f33..392dd1e 100644
--- a/batman/batman.c
+++ b/batman/batman.c
@@ -255,7 +255,7 @@ static int hna_buff_delete(struct hna_element *buf, int *buf_len, struct hna_ele
  * a situation where no route is present.
  */
 void update_hna(struct orig_node *orig_node, unsigned char *new_hna,
-				int new_hna_len, struct neigh_node *old_router)
+				int16_t new_hna_len, struct neigh_node *old_router)
 {
 	unsigned char *old_hna;
 	int old_hna_len;
diff --git a/batman/os.h b/batman/os.h
index 5531bae..da61d18 100644
--- a/batman/os.h
+++ b/batman/os.h
@@ -38,7 +38,7 @@ void addr_to_string( uint32_t addr, char *str, int32_t len );
 
 int8_t is_aborted(void);
 void update_hna(struct orig_node *orig_node, unsigned char *new_hna, 
-				int new_hna_len, struct neigh_node *old_router);
+				int16_t new_hna_len, struct neigh_node *old_router);
 void handler(int32_t sig);
 void segmentation_fault(int32_t sig) NO_RETURN;
 void restore_and_exit(uint8_t is_sigsegv) NO_RETURN;
-- 
1.6.0.4

