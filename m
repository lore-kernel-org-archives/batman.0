Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 29 Mar 2014 11:52:58 +0100
Message-Id: <1396090378-31812-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix local TT check for
	outgoing arp requests in DAT
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Change introduced by d6bd8b36fa1f3d72a6fd5942a6e9bde6ddafcd0d
("batman-adv: make DAT drop ARP requests targeting local clients")
implements a check that prevents DAT from using the caching
mechanism when the client that is supposed to provide a reply
to an arp request is local.

However change brought by 3e26722bc9f248ec4316749fc1957365c0fa5e4b
("batman-adv: make the Distributed ARP Table vlan aware")
has not converted the above check into its vlan aware version
thus making it useless when the local client is behind a vlan.

Fix the behaviour by properly specifying the vlan when
checking for a client being local or not.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 distributed-arp-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 5bb37a8..a5d75be 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -940,8 +940,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * additional DAT answer may trigger kernel warnings about
 		 * a packet coming from the wrong port.
 		 */
-		if (batadv_is_my_client(bat_priv, dat_entry->mac_addr,
-					BATADV_NO_FLAGS)) {
+		if (batadv_is_my_client(bat_priv, dat_entry->mac_addr, vid)) {
 			ret = true;
 			goto out;
 		}
-- 
1.8.3.2

