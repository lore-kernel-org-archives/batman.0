Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 19 Mar 2014 09:08:48 +0100
Message-Id: <1395216532-31099-7-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
References: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 next 07/11] batman-adv: fix multicast
	kerneldoc
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

The kerneldoc should always use the third person singular in
the long function description.
Moreover it should always try use up to 80 chars per line.

Introduced by f2ed1502191a37abb39e3e2c80cca07f0f3bb411
("batman-adv: Send multicast packets to nodes with a WANT_ALL flag")

Cc: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 multicast.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/multicast.c b/multicast.c
index 99dff87..b74bd18 100644
--- a/multicast.c
+++ b/multicast.c
@@ -369,9 +369,9 @@ static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: ethernet header of a packet
  *
- * Return the number of nodes which want all IPv4 multicast traffic if
- * the given ethhdr is from an IPv4 packet or the number of nodes which want
- * all IPv6 traffic if it matches an IPv6 packet.
+ * Returns the number of nodes which want all IPv4 multicast traffic if the
+ * given ethhdr is from an IPv4 packet or the number of nodes which want all
+ * IPv6 traffic if it matches an IPv6 packet.
  */
 static int batadv_mcast_forw_want_all_ip_count(struct batadv_priv *bat_priv,
 					       struct ethhdr *ethhdr)
@@ -407,8 +407,8 @@ batadv_mcast_forw_tt_node_get(struct batadv_priv *bat_priv,
  * batadv_mcast_want_forw_ipv4_node_get - get a node with an ipv4 flag
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Return an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 flag set
- * and increase its refcount.
+ * Returns an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 flag set and
+ * increases its refcount.
  */
 static struct batadv_orig_node *
 batadv_mcast_forw_ipv4_node_get(struct batadv_priv *bat_priv)
@@ -434,8 +434,8 @@ unlock:
  * batadv_mcast_want_forw_ipv6_node_get - get a node with an ipv6 flag
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Return an orig_node which has the BATADV_MCAST_WANT_ALL_IPV6 flag set
- * and increase its refcount.
+ * Returns an orig_node which has the BATADV_MCAST_WANT_ALL_IPV6 flag set
+ * and increases its refcount.
  */
 static struct batadv_orig_node *
 batadv_mcast_forw_ipv6_node_get(struct batadv_priv *bat_priv)
@@ -462,9 +462,9 @@ unlock:
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: an ethernet header to determine the protocol family from
  *
- * Return an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 or
- * BATADV_MCAST_WANT_ALL_IPV6 flag, depending on the provided ethhdr, set
- * and increase its refcount.
+ * Returns an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 or
+ * BATADV_MCAST_WANT_ALL_IPV6 flag, depending on the provided ethhdr, set and
+ * increases its refcount.
  */
 static struct batadv_orig_node *
 batadv_mcast_forw_ip_node_get(struct batadv_priv *bat_priv,
-- 
1.8.3.2

