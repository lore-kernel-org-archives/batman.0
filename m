Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 19 Mar 2014 18:41:50 +0100
Message-Id: <1395250917-19621-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395250917-19621-1-git-send-email-antonio@meshcoding.com>
References: <1395250917-19621-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv3 next 04/11] batman-adv: fix multicast
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

Introduced by commit 01d665e054254618353ec8d9ea43d1a138de6e6d
("batman-adv: Multicast Listener Announcements via Translation Table")

Cc: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 multicast.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/multicast.c b/multicast.c
index 2d39938..afacf82 100644
--- a/multicast.c
+++ b/multicast.c
@@ -27,7 +27,7 @@
  * Collect multicast addresses of the local multicast listeners
  * on the given soft interface, dev, in the given mcast_list.
  *
- * Return -ENOMEM on memory allocation error or the number of
+ * Returns -ENOMEM on memory allocation error or the number of
  * items added to the mcast_list otherwise.
  */
 static int batadv_mcast_mla_softif_get(struct net_device *dev,
@@ -59,7 +59,7 @@ static int batadv_mcast_mla_softif_get(struct net_device *dev,
  * @mcast_addr: the multicast address to check
  * @mcast_list: the list with multicast addresses to search in
  *
- * Return true if the given address is already in the given list.
+ * Returns true if the given address is already in the given list.
  * Otherwise returns false.
  */
 static bool batadv_mcast_mla_is_duplicate(uint8_t *mcast_addr,
@@ -78,7 +78,7 @@ static bool batadv_mcast_mla_is_duplicate(uint8_t *mcast_addr,
  * batadv_mcast_mla_list_free - free a list of multicast addresses
  * @mcast_list: the list to free
  *
- * Remove and free all items in the given mcast_list.
+ * Removes and frees all items in the given mcast_list.
  */
 static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
 {
@@ -96,7 +96,7 @@ static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
  * @bat_priv: the bat priv with all the soft interface information
  * @mcast_list: a list of addresses which should _not_ be removed
  *
- * Retract the announcement of any multicast listener from the
+ * Retracts the announcement of any multicast listener from the
  * translation table except the ones listed in the given mcast_list.
  *
  * If mcast_list is NULL then all are retracted.
@@ -128,7 +128,7 @@ static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the soft interface information
  * @mcast_list: a list of addresses which are going to get added
  *
- * Add multicast listener announcements from the given mcast_list to the
+ * Adds multicast listener announcements from the given mcast_list to the
  * translation table if they have not been added yet.
  */
 static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
@@ -159,7 +159,7 @@ static void batadv_mcast_mla_tt_add(struct batadv_priv *bat_priv,
  * batadv_mcast_has_bridge - check whether the soft-iface is bridged
  * @bat_priv: the bat priv with all the soft interface information
  *
- * Check whether there is a bridge on top of our soft interface. Return
+ * Checks whether there is a bridge on top of our soft interface. Returns
  * true if so, false otherwise.
  */
 static bool batadv_mcast_has_bridge(struct batadv_priv *bat_priv)
-- 
1.8.3.2

