Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 19 Mar 2014 09:08:44 +0100
Message-Id: <1395216532-31099-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
References: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 next 03/11] batman-adv: fix multicast
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

Introduced by 86cb16e5ec1e2d75821006e8f4abbec66fb741ac
("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")

Cc: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 multicast.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/multicast.c b/multicast.c
index af3fe49..2d39938 100644
--- a/multicast.c
+++ b/multicast.c
@@ -256,11 +256,11 @@ out:
  * @skb: the IPv4 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
  *
- * Check whether the given IPv4 packet has the potential to
- * be forwarded with a mode more optimal than classic flooding.
+ * Checks whether the given IPv4 packet has the potential to be forwarded with a
+ * mode more optimal than classic flooding.
  *
- * If so then return 0. Otherwise -EINVAL is returned or -ENOMEM if we are
- * out of memory.
+ * If so then returns 0. Otherwise -EINVAL is returned or -ENOMEM in case of
+ * memory allocation failure.
  */
 static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 					     struct sk_buff *skb,
@@ -485,8 +485,8 @@ batadv_mcast_forw_ip_node_get(struct batadv_priv *bat_priv,
  * batadv_mcast_want_forw_unsnoop_node_get - get a node with an unsnoopable flag
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Return an orig_node which has the BATADV_MCAST_WANT_ALL_UNSNOOPABLES flag set
- * and increase its refcount.
+ * Returns an orig_node which has the BATADV_MCAST_WANT_ALL_UNSNOOPABLES flag
+ * set and increases its refcount.
  */
 static struct batadv_orig_node *
 batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
-- 
1.8.3.2

