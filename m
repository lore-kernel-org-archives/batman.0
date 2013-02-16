Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 16 Feb 2013 13:50:52 +0100
Message-Id: <1361019052-17476-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: make
	batadv_softif_destroy_netlink() static
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

batadv_softif_destroy_netlink() is used in the file where it is defined only,
therefore it must be static.

Introduced by 5317331775c3168b8155b03ec89b1c4c508b9043 ("batman-adv: Allow to
use rntl_link for device creation/deletion")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 soft-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 39caefa..403b8c4 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -653,8 +653,8 @@ void batadv_softif_destroy_sysfs(struct net_device *soft_iface)
  * @soft_iface: the to-be-removed batman-adv interface
  * @head: list pointer
  */
-void batadv_softif_destroy_netlink(struct net_device *soft_iface,
-				   struct list_head *head)
+static void batadv_softif_destroy_netlink(struct net_device *soft_iface,
+					  struct list_head *head)
 {
 	struct batadv_hard_iface *hard_iface;
 
-- 
1.8.1.2

