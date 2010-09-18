Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 18 Sep 2010 21:01:16 +0200
Message-Id: <1284836482-23431-7-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
References: <1284836482-23431-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 06/12] Staging: batman-adv: Always protect
	list_for_each_entry_rcu with RCU
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

receive_bat_packet is not called with rcu_read_lock so we must ensure by
ourself that we protect list_for_each_entry_rcu using the correct RCU
locks.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 drivers/staging/batman-adv/routing.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 2cf8cf9..58aa99e 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -563,6 +563,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		batman_packet->tq, batman_packet->ttl, batman_packet->version,
 		has_directlink_flag);
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
 		if (batman_if->if_status != IF_ACTIVE)
 			continue;
@@ -585,6 +586,7 @@ void receive_bat_packet(struct ethhdr *ethhdr,
 		if (compare_orig(ethhdr->h_source, broadcast_addr))
 			is_broadcast = 1;
 	}
+	rcu_read_unlock();
 
 	if (batman_packet->version != COMPAT_VERSION) {
 		bat_dbg(DBG_BATMAN, bat_priv,
-- 
1.7.2.3

