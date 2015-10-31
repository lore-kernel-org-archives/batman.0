Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2015 12:28:07 +0100
Message-ID: <1787438.NkeQ2a2MeO@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3453662.gqKT29lMY8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH 0/2] Kerneldoc fixes and TODOs
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

--nextPart3453662.gqKT29lMY8
Content-Type: multipart/mixed; boundary="nextPart13031541.r4eREZIBmO"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart13031541.r4eREZIBmO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

since a month the daily build_test is reporting the problems [1] with the 
kerneldoc which I reported and started to fix two months ago [2]. 
Unfortunately, no new patches were send until now. I have prepared now two 
patches for the main functions and the network coding part of batman-adv. The 
TODOs (and also partially fixed TODOs) of the remaining three parts (BLA, DAT, 
TT) can be found in the attachments of this mail.


Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/linux-merge/2015-October/002635.html
[2] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-September/013653.html
=2D-nextPart13031541.r4eREZIBmO
Content-Disposition: attachment; filename="TODO-Antonio-Quartulli-antonio-.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="TODO-Antonio-Quartulli-antonio-.patch"

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 31 Oct 2015 10:30:54 +0100
Subject: [PATCH] batman-adv: kerneldoc TODO Antonio Quartulli <antonio@meshcoding.com>
=2D--
 net/batman-adv/distributed-arp-table.c |  4 ++++
 net/batman-adv/translation-table.c     | 21 ++++++++++++++++-----
 net/batman-adv/types.h                 |  2 ++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 9daccdc..496ada2 100644
=2D-- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -738,6 +738,8 @@ static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
 /**
  * batadv_dat_init - initialise the DAT internals
  * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: TODO
  */
 int batadv_dat_init(struct batadv_priv *bat_priv)
 {
@@ -776,6 +778,8 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
  * batadv_dat_cache_seq_print_text - print the local DAT hash table
  * @seq: seq file to print on
  * @offset: not used
+ *
+ * Return: TODO
  */
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 {
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d98476f..a49e9b4 100644
=2D-- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -69,7 +69,9 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 bool roaming);
 
 /**
=2D * batadv_compare_tt
+ * batadv_compare_tt - TODO
+ * @node: TODO
+ * @data2: TODO
  *
  * Return: 1 if they are the same mac addr
  */
@@ -219,6 +221,7 @@ batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
 
 /**
  * batadv_tt_global_hash_count - count the number of orig entries
+ * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the client to count entries for
  * @vid: VLAN identifier
  *
@@ -303,6 +306,7 @@ static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_global_size_mod - change the size by v of the local table
  *  identified by vid
+ * @orig_node: TODO
  * @vid: the VLAN identifier
  * @v: the amount to sum to the global table size
  */
@@ -721,7 +725,6 @@ out:
  *  function reserves the amount of space needed to send the entire global TT
  *  table. In case of success the value is updated with the real amount of
  *  reserved bytes
=2D
  * Allocate the needed amount of memory for the entire TT TVLV and write its
  * header made up by one tvlv_tt_data object and a series of tvlv_tt_vlan_data
  * objects, one per active VLAN served by the originator node.
@@ -1243,7 +1246,9 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 }
 
 /**
=2D * batadv_tt_global_orig_entry_find
+ * batadv_tt_global_orig_entry_find - TODO
+ * @entry: TODO
+ * @orig_node: TODO
  *
  * retrieves the orig_tt_list_entry belonging to orig_node from the
  * batadv_tt_global_entry list
@@ -1274,7 +1279,9 @@ batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 }
 
 /**
=2D * batadv_tt_global_entry_has_orig
+ * batadv_tt_global_entry_has_orig - TODO
+ * @entry: TODO
+ * @orig_node: TODO
  *
  * find out if an orig_node is already in the list of a tt_global_entry.
  *
@@ -2519,6 +2526,8 @@ static void batadv_tt_global_update_crc(struct batadv_priv *bat_priv,
  * @num_vlan: number of tvlv VLAN entries
  * @full_table: ask for the entire translation table if true, while only for the
  *  last TT diff otherwise
+ *
+ * Return: TODO
  */
 static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *dst_orig_node,
@@ -3062,7 +3071,9 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
 }
 
 /**
=2D * batadv_tt_check_roam_count
+ * batadv_tt_check_roam_count - TODO
+ * @bat_priv: the bat priv with all the soft interface information
+ * @client: mac address of the roaming client
  *
  * This function checks whether the client already reached the
  * maximum number of possible roaming phases. In this case the ROAMING_ADV
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7f7a0f1..1a450ac 100644
=2D-- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -772,6 +772,8 @@ struct batadv_softif_vlan {
  * @orig_interval: OGM broadcast interval in milliseconds
  * @hop_penalty: penalty which will be applied to an OGM's tq-field on every hop
  * @log_level: configured log level (see batadv_dbg_level)
+ * @isolation_mark: TODO
+ * @isolation_mark_mask: TODO
  * @bcast_seqno: last sent broadcast packet sequence number
  * @bcast_queue_left: number of remaining buffered broadcast packet slots
  * @batman_queue_left: number of remaining OGM packet slots

=2D-nextPart13031541.r4eREZIBmO
Content-Disposition: attachment; filename="TODO-Simon-Wunderlich-sw-simonw.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="TODO-Simon-Wunderlich-sw-simonw.patch"

From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 31 Oct 2015 10:30:44 +0100
Subject: [PATCH] batman-adv: kerneldoc TODO Simon Wunderlich <sw@simonwunderlich.de>
=2D--
 net/batman-adv/bridge_loop_avoidance.c | 55 +++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 6633c77..2889216 100644
=2D-- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -59,7 +59,9 @@ batadv_bla_send_announce(struct batadv_priv *bat_priv,
 			 struct batadv_bla_backbone_gw *backbone_gw);
 
 /**
=2D * batadv_choose_claim
+ * batadv_choose_claim - TODO
+ * @data: data to hash
+ * @size: size of the hash table
  *
  * Return: the index of the claim
  */
@@ -75,7 +77,9 @@ static inline u32 batadv_choose_claim(const void *data, u32 size)
 }
 
 /**
=2D * batadv_choose_backbone_gw
+ * batadv_choose_backbone_gw - TODO
+ * @data: data to hash
+ * @size: size of the hash table
  *
  * Return: the index of the backbone gateway
  */
@@ -153,7 +157,7 @@ static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
 }
 
 /**
=2D * batadv_claim_hash_find
+ * batadv_claim_hash_find - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @data: search data (may be local/static data)
  *
@@ -385,7 +389,7 @@ out:
 }
 
 /**
=2D * batadv_bla_get_backbone_gw
+ * batadv_bla_get_backbone_gw - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the mac address of the originator
  * @vid: the VLAN ID
@@ -393,6 +397,8 @@ out:
  *
  * searches for the backbone gw or creates a new one if it could not
  * be found.
+ *
+ * Return: TODO
  */
 static struct batadv_bla_backbone_gw *
 batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
@@ -555,7 +561,7 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 }
 
 /**
=2D * batadv_bla_send_announce
+ * batadv_bla_send_announce - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @backbone_gw: our backbone gateway which should be announced
  *
@@ -681,6 +687,10 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_announce - check for ANNOUNCE frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @an_addr: TODO
+ * @backbone_addr: TODO
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -735,6 +745,11 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 
 /**
  * batadv_handle_request - check for REQUEST frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the primary hard interface of this batman soft interface
+ * @backbone_addr: TODO
+ * @ethhdr: ethernet header of a packet
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -763,6 +778,11 @@ static int batadv_handle_request(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_unclaim - check for UNCLAIM frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the primary hard interface of this batman soft interface
+ * @backbone_addr: TODO
+ * @claim_addr: TODO
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -796,6 +816,11 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_claim - check for CLAIM frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the primary hard interface of this batman soft interface
+ * @backbone_addr: TODO
+ * @claim_addr: TODO
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -827,7 +852,7 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 }
 
 /**
=2D * batadv_check_claim_group
+ * batadv_check_claim_group - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the primary interface of this batman interface
  * @hw_src: the Hardware source in the ARP Header
@@ -902,7 +927,7 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 }
 
 /**
=2D * batadv_bla_process_claim
+ * batadv_bla_process_claim - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the primary hard interface of this batman soft interface
  * @skb: the frame to be checked
@@ -1088,7 +1113,7 @@ purge_now:
 }
 
 /**
=2D * batadv_bla_purge_claims
+ * batadv_bla_purge_claims - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the selected primary interface, may be NULL if now is set
  * @now: whether the whole hash shall be wiped now
@@ -1137,7 +1162,7 @@ purge_now:
 }
 
 /**
=2D * batadv_bla_update_orig_address
+ * batadv_bla_update_orig_address - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the new selected primary_if
  * @oldif: the old primary interface, may be NULL
@@ -1329,7 +1354,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 }
 
 /**
=2D * batadv_bla_check_bcast_duplist
+ * batadv_bla_check_bcast_duplist - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: contains the bcast_packet to be checked
  *
@@ -1341,6 +1366,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
  * with a good chance that it is the same packet. If it is furthermore
  * sent by another host, drop it. We allow equal packets from
  * the same host however as this might be intended.
+ *
+ * Return: TODO
  */
 int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				   struct sk_buff *skb)
@@ -1399,7 +1426,7 @@ out:
 }
 
 /**
=2D * batadv_bla_is_backbone_gw_orig
+ * batadv_bla_is_backbone_gw_orig - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: originator mac address
  * @vid: VLAN identifier
@@ -1440,7 +1467,7 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
 }
 
 /**
=2D * batadv_bla_is_backbone_gw
+ * batadv_bla_is_backbone_gw - TODO
  * @skb: the frame to be checked
  * @orig_node: the orig_node of the frame
  * @hdr_size: maximum length of the frame
@@ -1498,7 +1525,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 }
 
 /**
=2D * batadv_bla_rx
+ * batadv_bla_rx - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame
@@ -1594,7 +1621,7 @@ out:
 }
 
 /**
=2D * batadv_bla_tx
+ * batadv_bla_tx - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame

=2D-nextPart13031541.r4eREZIBmO--
This is a multi-part message in MIME format.

--nextPart13031541.r4eREZIBmO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

since a month the daily build_test is reporting the problems [1] with the 
kerneldoc which I reported and started to fix two months ago [2]. 
Unfortunately, no new patches were send until now. I have prepared now two 
patches for the main functions and the network coding part of batman-adv. The 
TODOs (and also partially fixed TODOs) of the remaining three parts (BLA, DAT, 
TT) can be found in the attachments of this mail.


Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/linux-merge/2015-October/002635.html
[2] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-September/013653.html
--nextPart13031541.r4eREZIBmO
Content-Disposition: attachment; filename="TODO-Antonio-Quartulli-antonio-.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="TODO-Antonio-Quartulli-antonio-.patch"

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 31 Oct 2015 10:30:54 +0100
Subject: [PATCH] batman-adv: kerneldoc TODO Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/distributed-arp-table.c |  4 ++++
 net/batman-adv/translation-table.c     | 21 ++++++++++++++++-----
 net/batman-adv/types.h                 |  2 ++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 9daccdc..496ada2 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -738,6 +738,8 @@ static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
 /**
  * batadv_dat_init - initialise the DAT internals
  * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Return: TODO
  */
 int batadv_dat_init(struct batadv_priv *bat_priv)
 {
@@ -776,6 +778,8 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
  * batadv_dat_cache_seq_print_text - print the local DAT hash table
  * @seq: seq file to print on
  * @offset: not used
+ *
+ * Return: TODO
  */
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 {
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d98476f..a49e9b4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -69,7 +69,9 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 bool roaming);
 
 /**
- * batadv_compare_tt
+ * batadv_compare_tt - TODO
+ * @node: TODO
+ * @data2: TODO
  *
  * Return: 1 if they are the same mac addr
  */
@@ -219,6 +221,7 @@ batadv_tt_global_entry_free_ref(struct batadv_tt_global_entry *tt_global_entry)
 
 /**
  * batadv_tt_global_hash_count - count the number of orig entries
+ * @bat_priv: the bat priv with all the soft interface information
  * @addr: the mac address of the client to count entries for
  * @vid: VLAN identifier
  *
@@ -303,6 +306,7 @@ static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_global_size_mod - change the size by v of the local table
  *  identified by vid
+ * @orig_node: TODO
  * @vid: the VLAN identifier
  * @v: the amount to sum to the global table size
  */
@@ -721,7 +725,6 @@ out:
  *  function reserves the amount of space needed to send the entire global TT
  *  table. In case of success the value is updated with the real amount of
  *  reserved bytes
-
  * Allocate the needed amount of memory for the entire TT TVLV and write its
  * header made up by one tvlv_tt_data object and a series of tvlv_tt_vlan_data
  * objects, one per active VLAN served by the originator node.
@@ -1243,7 +1246,9 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_global_orig_entry_find
+ * batadv_tt_global_orig_entry_find - TODO
+ * @entry: TODO
+ * @orig_node: TODO
  *
  * retrieves the orig_tt_list_entry belonging to orig_node from the
  * batadv_tt_global_entry list
@@ -1274,7 +1279,9 @@ batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 }
 
 /**
- * batadv_tt_global_entry_has_orig
+ * batadv_tt_global_entry_has_orig - TODO
+ * @entry: TODO
+ * @orig_node: TODO
  *
  * find out if an orig_node is already in the list of a tt_global_entry.
  *
@@ -2519,6 +2526,8 @@ static void batadv_tt_global_update_crc(struct batadv_priv *bat_priv,
  * @num_vlan: number of tvlv VLAN entries
  * @full_table: ask for the entire translation table if true, while only for the
  *  last TT diff otherwise
+ *
+ * Return: TODO
  */
 static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *dst_orig_node,
@@ -3062,7 +3071,9 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_check_roam_count
+ * batadv_tt_check_roam_count - TODO
+ * @bat_priv: the bat priv with all the soft interface information
+ * @client: mac address of the roaming client
  *
  * This function checks whether the client already reached the
  * maximum number of possible roaming phases. In this case the ROAMING_ADV
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 7f7a0f1..1a450ac 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -772,6 +772,8 @@ struct batadv_softif_vlan {
  * @orig_interval: OGM broadcast interval in milliseconds
  * @hop_penalty: penalty which will be applied to an OGM's tq-field on every hop
  * @log_level: configured log level (see batadv_dbg_level)
+ * @isolation_mark: TODO
+ * @isolation_mark_mask: TODO
  * @bcast_seqno: last sent broadcast packet sequence number
  * @bcast_queue_left: number of remaining buffered broadcast packet slots
  * @batman_queue_left: number of remaining OGM packet slots

--nextPart13031541.r4eREZIBmO
Content-Disposition: attachment; filename="TODO-Simon-Wunderlich-sw-simonw.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="TODO-Simon-Wunderlich-sw-simonw.patch"

From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 31 Oct 2015 10:30:44 +0100
Subject: [PATCH] batman-adv: kerneldoc TODO Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 55 +++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 6633c77..2889216 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -59,7 +59,9 @@ batadv_bla_send_announce(struct batadv_priv *bat_priv,
 			 struct batadv_bla_backbone_gw *backbone_gw);
 
 /**
- * batadv_choose_claim
+ * batadv_choose_claim - TODO
+ * @data: data to hash
+ * @size: size of the hash table
  *
  * Return: the index of the claim
  */
@@ -75,7 +77,9 @@ static inline u32 batadv_choose_claim(const void *data, u32 size)
 }
 
 /**
- * batadv_choose_backbone_gw
+ * batadv_choose_backbone_gw - TODO
+ * @data: data to hash
+ * @size: size of the hash table
  *
  * Return: the index of the backbone gateway
  */
@@ -153,7 +157,7 @@ static void batadv_claim_free_ref(struct batadv_bla_claim *claim)
 }
 
 /**
- * batadv_claim_hash_find
+ * batadv_claim_hash_find - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @data: search data (may be local/static data)
  *
@@ -385,7 +389,7 @@ out:
 }
 
 /**
- * batadv_bla_get_backbone_gw
+ * batadv_bla_get_backbone_gw - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the mac address of the originator
  * @vid: the VLAN ID
@@ -393,6 +397,8 @@ out:
  *
  * searches for the backbone gw or creates a new one if it could not
  * be found.
+ *
+ * Return: TODO
  */
 static struct batadv_bla_backbone_gw *
 batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, u8 *orig,
@@ -555,7 +561,7 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 }
 
 /**
- * batadv_bla_send_announce
+ * batadv_bla_send_announce - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @backbone_gw: our backbone gateway which should be announced
  *
@@ -681,6 +687,10 @@ static void batadv_bla_del_claim(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_announce - check for ANNOUNCE frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @an_addr: TODO
+ * @backbone_addr: TODO
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -735,6 +745,11 @@ static int batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 
 /**
  * batadv_handle_request - check for REQUEST frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the primary hard interface of this batman soft interface
+ * @backbone_addr: TODO
+ * @ethhdr: ethernet header of a packet
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -763,6 +778,11 @@ static int batadv_handle_request(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_unclaim - check for UNCLAIM frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the primary hard interface of this batman soft interface
+ * @backbone_addr: TODO
+ * @claim_addr: TODO
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -796,6 +816,11 @@ static int batadv_handle_unclaim(struct batadv_priv *bat_priv,
 
 /**
  * batadv_handle_claim - check for CLAIM frame
+ * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the primary hard interface of this batman soft interface
+ * @backbone_addr: TODO
+ * @claim_addr: TODO
+ * @vid: the VLAN ID of the frame
  *
  * Return: 1 if handled
  */
@@ -827,7 +852,7 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_check_claim_group
+ * batadv_check_claim_group - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the primary interface of this batman interface
  * @hw_src: the Hardware source in the ARP Header
@@ -902,7 +927,7 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_bla_process_claim
+ * batadv_bla_process_claim - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the primary hard interface of this batman soft interface
  * @skb: the frame to be checked
@@ -1088,7 +1113,7 @@ purge_now:
 }
 
 /**
- * batadv_bla_purge_claims
+ * batadv_bla_purge_claims - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the selected primary interface, may be NULL if now is set
  * @now: whether the whole hash shall be wiped now
@@ -1137,7 +1162,7 @@ purge_now:
 }
 
 /**
- * batadv_bla_update_orig_address
+ * batadv_bla_update_orig_address - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @primary_if: the new selected primary_if
  * @oldif: the old primary interface, may be NULL
@@ -1329,7 +1354,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_bla_check_bcast_duplist
+ * batadv_bla_check_bcast_duplist - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: contains the bcast_packet to be checked
  *
@@ -1341,6 +1366,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
  * with a good chance that it is the same packet. If it is furthermore
  * sent by another host, drop it. We allow equal packets from
  * the same host however as this might be intended.
+ *
+ * Return: TODO
  */
 int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				   struct sk_buff *skb)
@@ -1399,7 +1426,7 @@ out:
 }
 
 /**
- * batadv_bla_is_backbone_gw_orig
+ * batadv_bla_is_backbone_gw_orig - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: originator mac address
  * @vid: VLAN identifier
@@ -1440,7 +1467,7 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
 }
 
 /**
- * batadv_bla_is_backbone_gw
+ * batadv_bla_is_backbone_gw - TODO
  * @skb: the frame to be checked
  * @orig_node: the orig_node of the frame
  * @hdr_size: maximum length of the frame
@@ -1498,7 +1525,7 @@ void batadv_bla_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_bla_rx
+ * batadv_bla_rx - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame
@@ -1594,7 +1621,7 @@ out:
 }
 
 /**
- * batadv_bla_tx
+ * batadv_bla_tx - TODO
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the frame to be checked
  * @vid: the VLAN ID of the frame

--nextPart13031541.r4eREZIBmO--

--nextPart3453662.gqKT29lMY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWNKXHAAoJEF2HCgfBJntGOP8P/2BJMKqWIEO/ay5t4LKuYpCr
zTEPvVVf+wagPUwf0H8G8+cSJ8a/x96EcY1QRo37b7/pWwbPMvlZp9YNHtyz9ScB
EEsYZUVAnhwi8RX+xjbKHNEWe4VUmAIbh6hsMYNyq15AgTT/tH/z6GeJLz9iBKn4
iyZxspZt7ANChdhCp5okRUWT07/m6srKSOyDuZ2lvLnJmvroK3gk6TwFqmArQsLu
D/2dFnWUXKV/qLwoNvGZfffceCUT/FPWBYeV6KRcrG9CTwkh1QMPkSMnfVdBDuat
lrmavYS/tZsFdPWCd+Z28jJE2yIAUSjICRLa/Z2kjjS765YecMtiR099lXFSHUGD
MxNUygIi9oRjiqKjKd5AhoDhF4yH3m/pDuC649zdV0bOxiyo2W6/Sb3WWnqzVDRB
9oJhYOtt+pJ9dz1y5KZaEhXYHDqmkPXKuIsRUyXkgX31tbHtEvYF3mufoKFng/oZ
4EnEprDe2YoUsvDKeYYz/0QRLjBRFQoNETZthAZzEQib53fWYBx8Z3WCq3nBA9V5
3ltIxAURiaY5wDg0JQto1tep8BXWUmzoxwtFPAy+TXek0nXUtZug09MVCBdwLhQT
fHGlopB/0gNBA+3+EGAS0z5i4410rBdw3qzn11hqYkyR81dnNqE5SX4mSKxL0m/s
u/KjuOqi/crKWz1OhCuz
=peZt
-----END PGP SIGNATURE-----

--nextPart3453662.gqKT29lMY8--

