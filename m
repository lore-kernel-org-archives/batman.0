Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu, 15 May 2014 20:50:52 +0200
Message-Id: <1400179852-4064-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1400179852-4064-1-git-send-email-antonio@meshcoding.com>
References: <1400179852-4064-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: fix local TT check for
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Change introduced by 88e48d7b3340ef07b108eb8a8b3813dd093cc7f7
("batman-adv: make DAT drop ARP requests targeting local clients")
implements a check that prevents DAT from using the caching
mechanism when the client that is supposed to provide a reply
to an arp request is local.

However change brought by be1db4f6615b5e6156c807ea8985171c215c2d57
("batman-adv: make the Distributed ARP Table vlan aware")
has not converted the above check into its vlan aware version
thus making it useless when the local client is behind a vlan.

Fix the behaviour by properly specifying the vlan when
checking for a client being local or not.

Reported-by: Simon Wunderlich <simon@open-mesh.com>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/distributed-arp-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index b25fd64..aa5d494 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
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
1.8.5.5

