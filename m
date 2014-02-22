Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 22 Feb 2014 16:20:06 +0100
Message-Id: <1393082406-3615-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: properly align constant
	assignments
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

All the assignments in packet.h are properly aligned.
Also the multicast constants have to have a similar shape.

Introduced by 1c090349e2f65d19a7f356cc0b61f13644c53bb6
("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 packet.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/packet.h b/packet.h
index feaa336..c7f6eef 100644
--- a/packet.h
+++ b/packet.h
@@ -97,9 +97,9 @@ enum batadv_icmp_packettype {
  * @BATADV_MCAST_WANT_ALL_IPV6: we want all IPv6 multicast packets
  */
 enum batadv_mcast_flags {
-	BATADV_MCAST_WANT_ALL_UNSNOOPABLES = BIT(0),
-	BATADV_MCAST_WANT_ALL_IPV4 = BIT(1),
-	BATADV_MCAST_WANT_ALL_IPV6 = BIT(2),
+	BATADV_MCAST_WANT_ALL_UNSNOOPABLES	= BIT(0),
+	BATADV_MCAST_WANT_ALL_IPV4		= BIT(1),
+	BATADV_MCAST_WANT_ALL_IPV6		= BIT(2),
 };
 
 /* tt data subtypes */
-- 
1.8.4.5

