Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Wed, 23 Jan 2013 18:11:54 +0100
Message-Id: <4b41fb1f387acd24ecab6e4e47b2126b6dbddb5a.1358961079.git.mschiffer@universe-factory.net>
In-Reply-To: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
In-Reply-To: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: filter out invalid DAT
	entries
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

Due to duplicate address detection and other strange ARP packets, sometimes
entries with broadcast MAC addresses or unspecified IP addresses would get into
the Distributed ARP Table. This patch prevents these and some other kinds of
invalid entries from getting into the DAT.

Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
---
 distributed-arp-table.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 9f4cff3..e28be57 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -274,6 +274,18 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
 
+	/* filter invalid MAC addresses that are sometimes used as
+	 * destinations of ARP replies
+	 */
+	if (is_zero_ether_addr(mac_addr) || is_multicast_ether_addr(mac_addr))
+		return;
+
+	/* ARP requests with unspecified source address are used for
+	 * duplicate address detection, we don't want those in the DAT either
+	 */
+	if (!ip)
+		return;
+
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
-- 
1.8.1.1

