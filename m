Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 19 Mar 2014 18:57:30 +0100
Message-Id: <1395251855-30765-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395251855-30765-1-git-send-email-antonio@meshcoding.com>
References: <1395251747-27289-1-git-send-email-antonio@meshcoding.com>
 <1395251855-30765-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 next 06/11] batman-adv: fix multicast
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

Introduced by 90ad6a40c80323805be1e86504385de2bd861f0a
("batman-adv: Modified forwarding behaviour for multicast packets")

Cc: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 multicast.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/multicast.c b/multicast.c
index 5bc0703..25b2632 100644
--- a/multicast.c
+++ b/multicast.c
@@ -288,11 +288,11 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
  * @skb: the IPv6 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
  *
- * Check whether the given IPv6 packet has the potential to
- * be forwarded with a mode more optimal than classic flooding.
+ * Checks whether the given IPv6 packet has the potential to be forwarded with a
+ * mode more optimal than classic flooding.
  *
- * If so then return 0. Otherwise -EINVAL is returned or -ENOMEM if we are
- * out of memory.
+ * If so then returns 0. Otherwise -EINVAL is returned or -ENOMEM if we are out
+ * of memory.
  */
 static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 					     struct sk_buff *skb,
@@ -328,11 +328,11 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
  * @skb: the multicast frame to check
  * @is_unsnoopable: stores whether the destination is snoopable
  *
- * Check whether the given multicast ethernet frame has the potential to
- * be forwarded with a mode more optimal than classic flooding.
+ * Checks whether the given multicast ethernet frame has the potential to be
+ * forwarded with a mode more optimal than classic flooding.
  *
- * If so then return 0. Otherwise -EINVAL is returned or -ENOMEM if we are
- * out of memory.
+ * If so then returns 0. Otherwise -EINVAL is returned or -ENOMEM if we are out
+ * of memory.
  */
 static int batadv_mcast_forw_mode_check(struct batadv_priv *bat_priv,
 					struct sk_buff *skb,
@@ -386,7 +386,7 @@ static int batadv_mcast_forw_want_all_ip_count(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: the ether header containing the multicast destination
  *
- * Return an orig_node matching the multicast address provided by ethhdr
+ * Returns an orig_node matching the multicast address provided by ethhdr
  * via a translation table lookup. This increases the returned nodes refcount.
  */
 static struct batadv_orig_node *
@@ -508,7 +508,7 @@ unlock:
  * @skb: The multicast packet to check
  * @orig: an originator to be set to forward the skb to
  *
- * Return the forwarding mode as enum batadv_forw_mode and in case of
+ * Returns the forwarding mode as enum batadv_forw_mode and in case of
  * BATADV_FORW_SINGLE set the orig to the single originator the skb
  * should be forwarded to.
  */
-- 
1.8.3.2

