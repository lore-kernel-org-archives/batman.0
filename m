Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  3 Jul 2013 18:33:36 +0200
Message-Id: <1372869216-2514-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv5] batman-adv: make the TT CRC logic VLAN
	specific
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

This change allows nodes to handle the TT table on a
per-VLAN basis. This is needed because nodes may have to
store only some of the global entries advertised by another
node.

In this scenario such nodes would re-create only a partial
global table and would not be able to compute a correct CRC
anymore.

This patch splits the logic and introduces one CRC per VLAN.
In this way a node fetching only some entries belonging to
some VLANs is still able to compute the needed CRCs and
still check the table correctness.

With this patch the shape of the TVLV-TT is changed too
because now a node needs to advertise all the CRCs of all
the VLANs that it is wired to.

The debug output of the local Translation Table now shows
the CRC along with each entry since there is not a common
value for the entire table anymore.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

This patch alone represents the second patchset of the TT-VLAN improvement.
It brings a not negligible change into the TT logic since it is splitting the
CRC mechanism on a per-VLAN basis. Since it is not so easy to digest I decided
to send it alone.

This change is required by an improvement which will come right after: VLAN
based TT filtering for BLA2 enabled nodes (third patchset of the TT-VLAN
feature).

In a few words....
Right now a backbone node rejects any TT entry announced by another backbone.
With this change it will be possible to filter out only those TT entries
belonging to the VLAN where BLA2 is running on. In this way, the others VLANs
will still be able to contact each other.


Cheers,


 compat.c            |   9 +
 compat.h            |   1 +
 originator.c        | 108 +++++++-
 originator.h        |   7 +
 packet.h            |  18 +-
 translation-table.c | 690 +++++++++++++++++++++++++++++++++++++++++-----------
 types.h             |  39 ++-
 7 files changed, 720 insertions(+), 152 deletions(-)

diff --git a/compat.c b/compat.c
index 0a98fb7..fcd5bec 100644
--- a/compat.c
+++ b/compat.c
@@ -27,6 +27,15 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 0, 0)
 
+void batadv_free_rcu_orig_vlan(struct rcu_head *rcu)
+{
+	struct batadv_orig_node_vlan *vlan;
+
+	vlan = container_of(rcu, structbatadv_orig_node_vlan, rcu);
+
+	kfree(vlan);
+}
+
 void batadv_free_rcu_softif_vlan(struct rcu_head *rcu)
 {
 	struct batadv_softif_vlan *vlan;
diff --git a/compat.h b/compat.h
index 457be3d..fd6ee46 100644
--- a/compat.h
+++ b/compat.h
@@ -182,6 +182,7 @@ static const struct { \
 #define kfree_rcu(ptr, rcu_head) call_rcu(&ptr->rcu_head, batadv_free_rcu_##ptr)
 #define vlan_insert_tag(skb, proto, vid) __vlan_put_tag(skb, vid)
 
+void batadv_free_rcu_orig_vlan(struct rcu_head *rcu);
 void batadv_free_rcu_softif_vlan(struct rcu_head *rcu);
 void batadv_free_rcu_tt_global_entry(struct rcu_head *rcu);
 void batadv_free_rcu_gw_node(struct rcu_head *rcu);
diff --git a/originator.c b/originator.c
index a591dc5..0dd0ec1 100644
--- a/originator.c
+++ b/originator.c
@@ -44,6 +44,95 @@ static int batadv_compare_orig(const struct hlist_node *node, const void *data2)
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
 }
 
+/**
+ * batadv_orig_node_vlan_get - get an orig_node_vlan object
+ * @orig_node: the originator servin the VLAN
+ * @vid: the VLAN identifier
+ *
+ * Returns the vlan object identified by vid and belonging to orig_node or NULL
+ * if it does not exist
+ */
+struct batadv_orig_node_vlan *
+batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
+			  unsigned short vid)
+{
+	struct batadv_orig_node_vlan *vlan;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+		if (!atomic_inc_not_zero(&vlan->refcount))
+			continue;
+
+		if (vlan->vid != vid)
+			continue;
+
+		rcu_read_unlock();
+
+		return vlan;
+	}
+	rcu_read_unlock();
+
+	return NULL;
+}
+
+/**
+ * batadv_orig_node_vlan_new - search and possibly create an orig_node_vlan
+ *  object
+ * @orig_node: the originator serving the VLAN
+ * @vid: the VLAN identifier
+ *
+ * Returns NULL in case of failure or the vlan object identified by vid and
+ * belonging to orig_node otherwise. The object is created and added to the list
+ * if it does not exist.
+ *
+ * The object is returned with refcounter increased by 1
+ */
+struct batadv_orig_node_vlan *
+batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
+			  unsigned short vid)
+{
+	struct batadv_orig_node_vlan *vlan;
+
+	spin_lock_bh(&orig_node->vlan_list_lock);
+
+	/* first look if an object for this vid already exists */
+	list_for_each_entry(vlan, &orig_node->vlan_list, list) {
+		if (!atomic_inc_not_zero(&vlan->refcount))
+			continue;
+
+		if (vlan->vid != vid)
+			continue;
+
+		/* there is already an entry for this vid: return it */
+		goto out;
+	}
+
+	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
+	if (!vlan)
+		goto out;
+
+	atomic_set(&vlan->refcount, 2);
+	vlan->vid = vid;
+
+	list_add_rcu(&vlan->list, &orig_node->vlan_list);
+
+out:
+	spin_unlock_bh(&orig_node->vlan_list_lock);
+
+	return vlan;
+}
+
+/**
+ * batadv_orig_node_vlan_free_ref - decrement the refcounter and possibly free
+ *  the originator-vlan object
+ * @orig_vlan: the originator-vlan object to release
+ */
+void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan)
+{
+	if (atomic_dec_and_test(&orig_vlan->refcount))
+		kfree_rcu(orig_vlan, rcu);
+}
+
 int batadv_originator_init(struct batadv_priv *bat_priv)
 {
 	if (bat_priv->orig_hash)
@@ -218,6 +307,7 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 					      const uint8_t *addr)
 {
 	struct batadv_orig_node *orig_node;
+	struct batadv_orig_node_vlan *vlan;
 	int size, i;
 	int hash_added;
 	unsigned long reset_time;
@@ -235,10 +325,12 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 
 	INIT_HLIST_HEAD(&orig_node->neigh_list);
 	INIT_LIST_HEAD(&orig_node->bond_list);
+	INIT_LIST_HEAD(&orig_node->vlan_list);
 	spin_lock_init(&orig_node->ogm_cnt_lock);
 	spin_lock_init(&orig_node->bcast_seqno_lock);
 	spin_lock_init(&orig_node->neigh_list_lock);
 	spin_lock_init(&orig_node->tt_buff_lock);
+	spin_lock_init(&orig_node->vlan_list_lock);
 
 	batadv_nc_init_orig(orig_node);
 
@@ -250,22 +342,30 @@ struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_priv,
 	memcpy(orig_node->orig, addr, ETH_ALEN);
 	batadv_dat_init_orig_node_addr(orig_node);
 	orig_node->router = NULL;
-	orig_node->tt_crc = 0;
 	atomic_set(&orig_node->last_ttvn, 0);
 	orig_node->tt_buff = NULL;
 	orig_node->tt_buff_len = 0;
-	atomic_set(&orig_node->tt_size, 0);
 	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
 	orig_node->bcast_seqno_reset = reset_time;
 	orig_node->batman_seqno_reset = reset_time;
 
 	atomic_set(&orig_node->bond_candidates, 0);
 
+	/* create a vlan object for the "untagged" LAN */
+	vlan = batadv_orig_node_vlan_new(orig_node, BATADV_NO_FLAGS);
+	if (!vlan)
+		goto free_orig_node;
+	/* batadv_orig_node_vlan_new() increases the refcounter.
+	 * Immediately release vlan since it is not needed anymore in this
+	 * context
+	 */
+	batadv_orig_node_vlan_free_ref(vlan);
+
 	size = bat_priv->num_ifaces * sizeof(unsigned long) * BATADV_NUM_WORDS;
 
 	orig_node->bcast_own = kzalloc(size, GFP_ATOMIC);
 	if (!orig_node->bcast_own)
-		goto free_orig_node;
+		goto free_vlan;
 
 	size = bat_priv->num_ifaces * sizeof(uint8_t);
 	orig_node->bcast_own_sum = kzalloc(size, GFP_ATOMIC);
@@ -290,6 +390,8 @@ free_bcast_own_sum:
 	kfree(orig_node->bcast_own_sum);
 free_bcast_own:
 	kfree(orig_node->bcast_own);
+free_vlan:
+	batadv_orig_node_vlan_free_ref(vlan);
 free_orig_node:
 	kfree(orig_node);
 	return NULL;
diff --git a/originator.h b/originator.h
index 7887b84..cc6d686 100644
--- a/originator.h
+++ b/originator.h
@@ -40,6 +40,13 @@ int batadv_orig_hash_add_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num);
 int batadv_orig_hash_del_if(struct batadv_hard_iface *hard_iface,
 			    int max_if_num);
+struct batadv_orig_node_vlan *
+batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
+			  unsigned short vid);
+struct batadv_orig_node_vlan *
+batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
+			  unsigned short vid);
+void batadv_orig_node_vlan_free_ref(struct batadv_orig_node_vlan *orig_vlan);
 
 
 /* hashfunction to choose an entry in a hash table of given size
diff --git a/packet.h b/packet.h
index 08e175a..3f934b1 100644
--- a/packet.h
+++ b/packet.h
@@ -391,14 +391,26 @@ struct batadv_tvlv_gateway_data {
  * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
  * @flags: translation table flags (see batadv_tt_data_flags)
  * @ttvn: translation table version number
- * @reserved: field reserved for future use
- * @crc: crc32 checksum of the local translation table
+ * @vlan_num: number of announced VLANs. In the TVLV this struct is followed by
+ *  one batadv_tvlv_tt_vlan_data object per announced vlan
  */
 struct batadv_tvlv_tt_data {
 	uint8_t flags;
 	uint8_t ttvn;
+	__be16  num_vlan;
+};
+
+/**
+ * struct batadv_tvlv_tt_vlan_data - vlan specific tt data propagated through
+ *  the tt vlv container
+ * @crc: crc32 checksum of the entries belonging to this vlan
+ * @vid: vlan identifier
+ * @reserved: unused, useful for alignment purposes
+ */
+struct batadv_tvlv_tt_vlan_data {
+	__be32	crc;
+	__be16	vid;
 	uint16_t reserved;
-	__be32  crc;
 };
 
 /**
diff --git a/translation-table.c b/translation-table.c
index 7ac5ddc..09d63c0 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -208,13 +208,103 @@ static void batadv_tt_orig_list_entry_free_rcu(struct rcu_head *rcu)
 	kfree(orig_entry);
 }
 
+/**
+ * batadv_tt_local_size_mod - change the size by v of the local table identified
+ *  by vid
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vid: the VLAN identifier of the sub-table to change
+ * @v: the amount to sum to the local table size
+ */
+static void batadv_tt_local_size_mod(struct batadv_priv *bat_priv,
+				     unsigned short vid, int v)
+{
+	struct batadv_softif_vlan *vlan;
+
+	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	if (!vlan)
+		return;
+
+	atomic_add(v, &vlan->tt.num_entries);
+
+	batadv_softif_vlan_free_ref(vlan);
+}
+
+/**
+ * batadv_tt_local_size_inc - increase by one the local table size for the given
+ *  vid
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vid: the VLAN identifier
+ */
+static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
+				     unsigned short vid)
+{
+	batadv_tt_local_size_mod(bat_priv, vid, 1);
+}
+
+/**
+ * batadv_tt_local_size_dec - decrease by one the local table size for the given
+ *  vid
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vid: the VLAN identifier
+ */
+static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
+				     unsigned short vid)
+{
+	batadv_tt_local_size_mod(bat_priv, vid, -1);
+}
+
+/**
+ * batadv_tt_global_size_mod - change the size by v of the local table
+ *  identified by vid
+ * @bat_priv: the bat priv with all the soft interface information
+ * @vid: the VLAN identifier
+ * @v: the amount to sum to the global table size
+ */
+static void batadv_tt_global_size_mod(struct batadv_orig_node *orig_node,
+				      unsigned short vid, int v)
+{
+	struct batadv_orig_node_vlan *vlan;
+
+	vlan = batadv_orig_node_vlan_new(orig_node, vid);
+	if (!vlan)
+		return;
+
+	if (atomic_add_return(v, &vlan->tt.num_entries) == 0)
+		batadv_orig_node_vlan_free_ref(vlan);
+
+	batadv_orig_node_vlan_free_ref(vlan);
+}
+
+/**
+ * batadv_tt_global_size_inc - increase by one the global table size for the
+ *  given vid
+ * @orig_node: the originator which global table size has to be decreased
+ * @vid: the vlan identifier
+ */
+static void batadv_tt_global_size_inc(struct batadv_orig_node *orig_node,
+				      unsigned short vid)
+{
+	batadv_tt_global_size_mod(orig_node, vid, 1);
+}
+
+/**
+ * batadv_tt_global_size_dec - decrease by one the global table size for the
+ *  given vid
+ * @orig_node: the originator which global table size has to be decreased
+ * @vid: the vlan identifier
+ */
+static void batadv_tt_global_size_dec(struct batadv_orig_node *orig_node,
+				      unsigned short vid)
+{
+	batadv_tt_global_size_mod(orig_node, vid, -1);
+}
+
 static void
 batadv_tt_orig_list_entry_free_ref(struct batadv_tt_orig_list_entry *orig_entry)
 {
 	if (!atomic_dec_and_test(&orig_entry->refcount))
 		return;
-	/* to avoid race conditions, immediately decrease the tt counter */
-	atomic_dec(&orig_entry->orig_node->tt_size);
+
 	call_rcu(&orig_entry->rcu, batadv_tt_orig_list_entry_free_rcu);
 }
 
@@ -464,6 +554,122 @@ out:
 }
 
 /**
+ * batadv_tt_prepare_tvlv_global_data - prepare the TVLV TT header to send
+ *  within a TT Response directed to another node
+ * @orig_node: originator for which the TT data has to be prepared
+ * @tt_data: uninitialised pointer to the address of the TVLV buffer
+ * @tt_len: space to reserve for the TT entries. If negative, this function will
+ *  allocate as much space is needed for the full table
+ *
+ * Allocate the needed amount of memory for the entire TT TVLV and write its
+ * header made up by one tvlv_tt_data object and a series of tvlv_tt_vlan_data
+ * objects, one per active VLAN served by the originator node.
+ *
+ * Return the size of the allocated buffer or 0 in case of failure.
+ */
+static uint16_t
+batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
+				   struct batadv_tvlv_tt_data **tt_data,
+				   int32_t tt_len)
+{
+	struct batadv_tvlv_tt_vlan_data *tt_vlan;
+	struct batadv_orig_node_vlan *vlan;
+	uint16_t num_vlan = 0, num_entries = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+		num_vlan++;
+		num_entries += atomic_read(&vlan->tt.num_entries);
+	}
+
+	/* if tt_len is negative, allocate the space needed by the full table */
+	if (tt_len < 0)
+		tt_len = batadv_tt_len(num_entries);
+
+	tt_len += sizeof(**tt_data);
+	tt_len += sizeof(*tt_vlan) * num_vlan;
+
+	*tt_data = kmalloc(tt_len, GFP_ATOMIC);
+	if (!*tt_data) {
+		tt_len = 0;
+		goto out;
+	}
+
+	(*tt_data)->flags = BATADV_NO_FLAGS;
+	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
+	(*tt_data)->num_vlan = htons(num_vlan);
+
+	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+		tt_vlan->vid = htons(vlan->vid);
+		tt_vlan->crc = htonl(vlan->tt.crc);
+
+		tt_vlan++;
+	}
+out:
+	rcu_read_unlock();
+	return tt_len;
+}
+
+/**
+ * batadv_tt_prepare_tvlv_local_data - allocate and prepare the TT TVLV for this
+ *  node
+ * @bat_priv: the bat priv with all the soft interface information
+ * @tt_data: uninitialised pointer to the address of the TVLV buffer
+ * @tt_len: length to reserve to the tt_change. if -1 this function reserves
+ *  the amount of space needed to send the entire local TT table
+ *
+ * Allocate the needed amount of memory for the entire TT TVLV and write its
+ * header made up by one tvlv_tt_data object and a series of tvlv_tt_vlan_data
+ * objects, one per active VLAN.
+ *
+ * Return the size of the allocated buffer or 0 in case of failure.
+ */
+static uint16_t
+batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
+				  struct batadv_tvlv_tt_data **tt_data,
+				  int32_t tt_len)
+{
+	struct batadv_tvlv_tt_vlan_data *tt_vlan;
+	struct batadv_softif_vlan *vlan;
+	uint16_t num_vlan = 0, num_entries = 0;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		num_vlan++;
+		num_entries += atomic_read(&vlan->tt.num_entries);
+	}
+
+	/* if tt_len is negative, allocate the space needed by the full table */
+	if (tt_len < 0)
+		tt_len = batadv_tt_len(num_entries);
+
+	tt_len += sizeof(**tt_data);
+	tt_len += sizeof(*tt_vlan) * num_vlan;
+
+	*tt_data = kmalloc(tt_len, GFP_ATOMIC);
+	if (!*tt_data) {
+		tt_len = 0;
+		goto out;
+	}
+
+	(*tt_data)->flags = BATADV_NO_FLAGS;
+	(*tt_data)->ttvn = atomic_read(&bat_priv->tt.vn);
+	(*tt_data)->num_vlan = htons(num_vlan);
+
+	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		tt_vlan->vid = htons(vlan->vid);
+		tt_vlan->crc = htonl(vlan->tt.crc);
+
+		tt_vlan++;
+	}
+out:
+	rcu_read_unlock();
+	return tt_len;
+}
+
+/**
  * batadv_tt_tvlv_container_update - update the translation table tvlv container
  *  after local tt changes have been committed
  * @bat_priv: the bat priv with all the soft interface information
@@ -473,10 +679,11 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	struct batadv_tt_change_node *entry, *safe;
 	struct batadv_tvlv_tt_data *tt_data;
 	struct batadv_tvlv_tt_change *tt_change;
-	int tt_diff_len = 0, tt_change_len = 0;
+	int tt_diff_len, tt_change_len = 0;
 	int tt_diff_entries_num = 0, tt_diff_entries_count = 0;
+	uint16_t tt_len, change_offset;
 
-	tt_diff_len += batadv_tt_len(atomic_read(&bat_priv->tt.local_changes));
+	tt_diff_len = batadv_tt_len(atomic_read(&bat_priv->tt.local_changes));
 
 	/* if we have too many changes for one packet don't send any
 	 * and wait for the tt table request which will be fragmented
@@ -484,13 +691,16 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	if (tt_diff_len > bat_priv->soft_iface->mtu)
 		tt_diff_len = 0;
 
-	tt_data = kzalloc(sizeof(*tt_data) + tt_diff_len, GFP_ATOMIC);
-	if (!tt_data)
+	tt_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
+						   tt_diff_len);
+	if (!tt_len)
 		return;
 
 	tt_data->flags = BATADV_TT_OGM_DIFF;
-	tt_data->ttvn = atomic_read(&bat_priv->tt.vn);
-	tt_data->crc = htonl(bat_priv->tt.local_crc);
+
+	change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
+	change_offset *= ntohs(tt_data->num_vlan);
+	change_offset += sizeof(*tt_data);
 
 	if (tt_diff_len == 0)
 		goto container_register;
@@ -500,7 +710,8 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	atomic_set(&bat_priv->tt.local_changes, 0);
 
-	tt_change = (struct batadv_tvlv_tt_change *)(tt_data + 1);
+	tt_change = (struct batadv_tvlv_tt_change *)((uint8_t *)tt_data +
+						     change_offset);
 
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
 				 list) {
@@ -537,7 +748,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 
 container_register:
 	batadv_tvlv_container_register(bat_priv, BATADV_TVLV_TT, 1, tt_data,
-				       sizeof(*tt_data) + tt_change_len);
+				       tt_len);
 	kfree(tt_data);
 }
 
@@ -549,7 +760,9 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tt_local_entry *tt_local;
 	struct batadv_hard_iface *primary_if;
+	struct batadv_softif_vlan *vlan;
 	struct hlist_head *head;
+	unsigned short vid;
 	uint32_t i;
 	int last_seen_secs;
 	int last_seen_msecs;
@@ -562,11 +775,10 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	seq_printf(seq,
-		   "Locally retrieved addresses (from %s) announced via TT (TTVN: %u CRC: %#.8x):\n",
-		   net_dev->name, (uint8_t)atomic_read(&bat_priv->tt.vn),
-		   bat_priv->tt.local_crc);
-	seq_printf(seq, "       %-13s  %s %-7s %-10s\n", "Client", "VID",
-		   "Flags", "Last seen");
+		   "Locally retrieved addresses (from %s) announced via TT (TTVN: %u):\n",
+		   net_dev->name, (uint8_t)atomic_read(&bat_priv->tt.vn));
+	seq_printf(seq, "       %-13s  %s %-7s %-9s (%-10s)\n", "Client", "VID",
+		   "Flags", "Last seen", "CRC");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -577,6 +789,7 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 			tt_local = container_of(tt_common_entry,
 						struct batadv_tt_local_entry,
 						common);
+			vid = tt_common_entry->vid;
 			last_seen_jiffies = jiffies - tt_local->last_seen;
 			last_seen_msecs = jiffies_to_msecs(last_seen_jiffies);
 			last_seen_secs = last_seen_msecs / 1000;
@@ -584,7 +797,15 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 
 			no_purge = tt_common_entry->flags & np_flag;
 
-			seq_printf(seq, " * %pM %4i [%c%c%c%c%c] %3u.%03u\n",
+			vlan = batadv_softif_vlan_get(bat_priv, vid);
+			if (!vlan) {
+				seq_printf(seq, "Cannot retrieve VLAN %d\n",
+					   BATADV_PRINT_VID(vid));
+				continue;
+			}
+
+			seq_printf(seq,
+				   " * %pM %4i [%c%c%c%c%c] %3u.%03u   (%#.8x)\n",
 				   tt_common_entry->addr,
 				   BATADV_PRINT_VID(tt_common_entry->vid),
 				   (tt_common_entry->flags &
@@ -597,7 +818,8 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
 				   (tt_common_entry->flags &
 				    BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
 				   no_purge ? 0 : last_seen_secs,
-				   no_purge ? 0 : last_seen_msecs);
+				   no_purge ? 0 : last_seen_msecs,
+				   vlan->tt.crc);
 		}
 		rcu_read_unlock();
 	}
@@ -860,7 +1082,7 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 
 	INIT_HLIST_NODE(&orig_entry->list);
 	atomic_inc(&orig_node->refcount);
-	atomic_inc(&orig_node->tt_size);
+	batadv_tt_global_size_inc(orig_node, tt_global->common.vid);
 	orig_entry->orig_node = orig_node;
 	orig_entry->ttvn = ttvn;
 	atomic_set(&orig_entry->refcount, 2);
@@ -1070,35 +1292,49 @@ static void
 batadv_tt_global_print_entry(struct batadv_tt_global_entry *tt_global_entry,
 			     struct seq_file *seq)
 {
-	struct hlist_head *head;
 	struct batadv_tt_orig_list_entry *orig_entry, *best_entry;
 	struct batadv_tt_common_entry *tt_common_entry;
-	uint16_t flags;
+	struct batadv_orig_node_vlan *vlan;
+	struct hlist_head *head;
 	uint8_t last_ttvn;
+	uint16_t flags;
 
 	tt_common_entry = &tt_global_entry->common;
 	flags = tt_common_entry->flags;
-
 	best_entry = batadv_transtable_best_orig(tt_global_entry);
 	if (best_entry) {
+		vlan = batadv_orig_node_vlan_get(best_entry->orig_node,
+						 tt_common_entry->vid);
+		if (!vlan) {
+			seq_printf(seq,
+				   " * Cannot retrieve VLAN %d for originator %pM\n",
+				   BATADV_PRINT_VID(tt_common_entry->vid),
+				   best_entry->orig_node->orig);
+			goto print_list;
+		}
+
 		last_ttvn = atomic_read(&best_entry->orig_node->last_ttvn);
 		seq_printf(seq,
 			   " %c %pM %4i   (%3u) via %pM     (%3u)   (%#.8x) [%c%c%c]\n",
 			   '*', tt_global_entry->common.addr,
 			   BATADV_PRINT_VID(tt_global_entry->common.vid),
 			   best_entry->ttvn, best_entry->orig_node->orig,
-			   last_ttvn, best_entry->orig_node->tt_crc,
+			   last_ttvn, vlan->tt.crc,
 			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
 			   (flags & BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
 			   (flags & BATADV_TT_CLIENT_TEMP ? 'T' : '.'));
 	}
 
+print_list:
 	head = &tt_global_entry->orig_list;
 
 	hlist_for_each_entry_rcu(orig_entry, head, list) {
 		if (best_entry == orig_entry)
 			continue;
 
+		vlan = batadv_orig_node_vlan_get(orig_entry->orig_node,
+						 tt_common_entry->vid);
+
 		last_ttvn = atomic_read(&orig_entry->orig_node->last_ttvn);
 		seq_printf(seq,
 			   " %c %pM %4d   (%3u) via %pM     (%3u)   [%c%c%c]\n",
@@ -1165,6 +1401,8 @@ batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
 	head = &tt_global_entry->orig_list;
 	hlist_for_each_entry_safe(orig_entry, safe, head, list) {
 		hlist_del_rcu(&orig_entry->list);
+		batadv_tt_global_size_dec(orig_entry->orig_node,
+					  tt_global_entry->common.vid);
 		batadv_tt_orig_list_entry_free_ref(orig_entry);
 	}
 	spin_unlock_bh(&tt_global_entry->list_lock);
@@ -1192,6 +1430,8 @@ batadv_tt_global_del_orig_entry(struct batadv_priv *bat_priv,
 				   tt_global_entry->common.addr,
 				   BATADV_PRINT_VID(vid), message);
 			hlist_del_rcu(&orig_entry->list);
+			batadv_tt_global_size_dec(orig_node,
+						  tt_global_entry->common.vid);
 			batadv_tt_orig_list_entry_free_ref(orig_entry);
 		}
 	}
@@ -1535,6 +1775,7 @@ out:
  *  to the given orig_node
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: originator for which the CRC should be computed
+ * @vid: VLAN identifier for which the CRC32 has to be computed
  *
  * This function computes the checksum for the global table corresponding to a
  * specific originator. In particular, the checksum is computed as follows: For
@@ -1554,7 +1795,8 @@ out:
  * Returns the checksum of the global table of a given originator.
  */
 static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
-				     struct batadv_orig_node *orig_node)
+				     struct batadv_orig_node *orig_node,
+				     unsigned short vid)
 {
 	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
 	struct batadv_tt_common_entry *tt_common;
@@ -1570,6 +1812,12 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 			tt_global = container_of(tt_common,
 						 struct batadv_tt_global_entry,
 						 common);
+			/* compute the CRC only for entries belonging to the
+			 * VLAN identified by the vid passed as parameter
+			 */
+			if (tt_common->vid != vid)
+				continue;
+
 			/* Roaming clients are in the global table for
 			 * consistency only. They don't have to be
 			 * taken into account while computing the
@@ -1604,13 +1852,15 @@ static uint32_t batadv_tt_global_crc(struct batadv_priv *bat_priv,
 /**
  * batadv_tt_local_crc - calculates the checksum of the local table
  * @bat_priv: the bat priv with all the soft interface information
+ * @vid: VLAN identifier for which the CRC32 has to be computed
  *
  * For details about the computation, please refer to the documentation for
  * batadv_tt_global_crc().
  *
  * Returns the checksum of the local table
  */
-static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
+static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv,
+				    unsigned short vid)
 {
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common;
@@ -1622,6 +1872,12 @@ static uint32_t batadv_tt_local_crc(struct batadv_priv *bat_priv)
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common, head, hash_entry) {
+			/* compute the CRC only for entries belonging to the
+			 * VLAN identified by vid
+			 */
+			if (tt_common->vid != vid)
+				continue;
+
 			/* not yet committed clients have not to be taken into
 			 * account while computing the CRC
 			 */
@@ -1753,44 +2009,30 @@ static int batadv_tt_global_valid(const void *entry_ptr,
 }
 
 /**
- * batadv_tt_tvlv_generate - creates tvlv tt data buffer to fill it with the
- *  tt entries from the specified tt hash
+ * batadv_tt_tvlv_generate - fill the tvlv buff it with the tt entries from the
+ *  specified tt hash
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: hash table containing the tt entries
  * @tt_len: expected tvlv tt data buffer length in number of bytes
+ * @tvlv_buff: pointer to the buffer to fill with the TT data
  * @valid_cb: function to filter tt change entries
  * @cb_data: data passed to the filter function as argument
- *
- * Returns pointer to allocated tvlv tt data buffer if operation was
- * successful or NULL otherwise.
  */
-static struct batadv_tvlv_tt_data *
-batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
-			struct batadv_hashtable *hash, uint16_t tt_len,
-			int (*valid_cb)(const void *, const void *),
-			void *cb_data)
+static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
+				    struct batadv_hashtable *hash,
+				    void *tvlv_buff, uint16_t tt_len,
+				    int (*valid_cb)(const void *, const void *),
+				    void *cb_data)
 {
 	struct batadv_tt_common_entry *tt_common_entry;
-	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct hlist_head *head;
 	uint16_t tt_tot, tt_num_entries = 0;
-	ssize_t tvlv_tt_size = sizeof(struct batadv_tvlv_tt_data);
 	uint32_t i;
 
-	if (tvlv_tt_size + tt_len > bat_priv->soft_iface->mtu) {
-		tt_len = bat_priv->soft_iface->mtu - tvlv_tt_size;
-		tt_len -= tt_len % sizeof(struct batadv_tvlv_tt_change);
-	}
-
 	tt_tot = batadv_tt_entries(tt_len);
 
-	tvlv_tt_data = kzalloc(sizeof(*tvlv_tt_data) + tt_len,
-			       GFP_ATOMIC);
-	if (!tvlv_tt_data)
-		goto out;
-
-	tt_change = (struct batadv_tvlv_tt_change *)(tvlv_tt_data + 1);
+	tt_change = (struct batadv_tvlv_tt_change *)tvlv_buff;
 
 	rcu_read_lock();
 	for (i = 0; i < hash->size; i++) {
@@ -1815,9 +2057,89 @@ batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 		}
 	}
 	rcu_read_unlock();
+}
 
-out:
-	return tvlv_tt_data;
+/**
+ * batadv_tt_global_check_crc - check if all the CRCs are correct
+ * @orig_node: originator for which the CRCs have to be checked
+ * @tt_vlan: pointer to the first tvlv VLAN entry
+ * @num_vlan: number of tvlv VLAN entries
+ * @create: if true, create VLAN objects if not found
+ *
+ * Return true if all the received CRCs match the locally stored ones, false
+ * otherwise
+ */
+static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
+				       struct batadv_tvlv_tt_vlan_data *tt_vlan,
+				       uint16_t num_vlan)
+{
+	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
+	struct batadv_orig_node_vlan *vlan;
+	int i;
+
+	/* check if each received CRC matches the locally stored one */
+	for (i = 0; i < num_vlan; i++) {
+		tt_vlan_tmp = tt_vlan + i;
+
+		/* if orig_node is a backbone node for this VLAN, don't check
+		 * the CRC as we ignore all the global entries over it
+		 */
+		if (batadv_bla_is_backbone_gw_orig(orig_node->bat_priv,
+						   orig_node->orig))
+			continue;
+
+		vlan = batadv_orig_node_vlan_get(orig_node,
+						 ntohs(tt_vlan_tmp->vid));
+		if (!vlan)
+			return false;
+
+		if (vlan->tt.crc != ntohl(tt_vlan_tmp->crc))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * batadv_tt_local_update_crc - update all the local CRCs
+ * @bat_priv: the bat priv with all the soft interface information
+ */
+static void batadv_tt_local_update_crc(struct batadv_priv *bat_priv)
+{
+	struct batadv_softif_vlan *vlan;
+
+	/* recompute the global CRC for each VLAN */
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		vlan->tt.crc = batadv_tt_local_crc(bat_priv, vlan->vid);
+	}
+	rcu_read_unlock();
+}
+
+/**
+ * batadv_tt_global_update_crc - update all the global CRCs for this orig_node
+ * @bat_priv: the bat priv with all the soft interface information
+ * @orig_node: the orig_node for which the CRCs have to be updated
+ */
+static void batadv_tt_global_update_crc(struct batadv_priv *bat_priv,
+					struct batadv_orig_node *orig_node)
+{
+	struct batadv_orig_node_vlan *vlan;
+	uint32_t crc;
+
+	/* recompute the global CRC for each VLAN */
+	rcu_read_lock();
+	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
+		/* if orig_node is a backbone node for this VLAN, don't compute
+		 * the CRC as we ignore all the global entries over it
+		 */
+		if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig))
+			continue;
+
+		crc = batadv_tt_global_crc(bat_priv, orig_node, vlan->vid);
+		vlan->tt.crc = crc;
+	}
+	rcu_read_unlock();
 }
 
 /**
@@ -1825,19 +2147,23 @@ out:
  * @bat_priv: the bat priv with all the soft interface information
  * @dst_orig_node: the destination of the message
  * @ttvn: the version number that the source of the message is looking for
- * @tt_crc: the CRC associated with the version number
+ * @tt_vlan: pointer to the first tvlv VLAN object to request
+ * @num_vlan: number of tvlv VLAN entries
  * @full_table: ask for the entire translation table if true, while only for the
  *  last TT diff otherwise
  */
 static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *dst_orig_node,
-				  uint8_t ttvn, uint32_t tt_crc,
-				  bool full_table)
+				  uint8_t ttvn,
+				  struct batadv_tvlv_tt_vlan_data *tt_vlan,
+				  uint16_t num_vlan, bool full_table)
 {
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
-	struct batadv_hard_iface *primary_if;
 	struct batadv_tt_req_node *tt_req_node = NULL;
+	struct batadv_tvlv_tt_vlan_data *tt_vlan_req;
+	struct batadv_hard_iface *primary_if;
 	bool ret = false;
+	int i, size;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
 	if (!primary_if)
@@ -1850,13 +2176,26 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 	if (!tt_req_node)
 		goto out;
 
-	tvlv_tt_data = kzalloc(sizeof(*tvlv_tt_data), GFP_ATOMIC);
+	size = sizeof(*tvlv_tt_data) + sizeof(*tt_vlan_req) * num_vlan;
+	tvlv_tt_data = kzalloc(size, GFP_ATOMIC);
 	if (!tvlv_tt_data)
 		goto out;
 
 	tvlv_tt_data->flags = BATADV_TT_REQUEST;
 	tvlv_tt_data->ttvn = ttvn;
-	tvlv_tt_data->crc = htonl(tt_crc);
+	tvlv_tt_data->num_vlan = htons(num_vlan);
+
+	/* send all the CRCs within the request. This is needed by intermediate
+	 * node to ensure they have the correct table before replying
+	 */
+	tt_vlan_req = (struct batadv_tvlv_tt_vlan_data *)(tvlv_tt_data + 1);
+	for (i = 0; i < num_vlan; i++) {
+		tt_vlan_req->vid = tt_vlan->vid;
+		tt_vlan_req->crc = tt_vlan->crc;
+
+		tt_vlan_req++;
+		tt_vlan++;
+	}
 
 	if (full_table)
 		tvlv_tt_data->flags |= BATADV_TT_FULL_TABLE;
@@ -1867,7 +2206,7 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_REQUEST_TX);
 	batadv_tvlv_unicast_send(bat_priv, primary_if->net_dev->dev_addr,
 				 dst_orig_node->orig, BATADV_TVLV_TT, 1,
-				 tvlv_tt_data, sizeof(*tvlv_tt_data));
+				 tvlv_tt_data, size);
 	ret = true;
 
 out:
@@ -1899,9 +2238,11 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 {
 	struct batadv_orig_node *req_dst_orig_node;
 	struct batadv_orig_node *res_dst_orig_node = NULL;
+	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
-	uint8_t orig_ttvn, req_ttvn;
-	uint16_t tt_len;
+	struct batadv_tvlv_tt_vlan_data *tt_vlan;
+	uint16_t change_offset, tt_len;
+	uint8_t orig_ttvn, req_ttvn, *tvlv_ptr;
 	bool ret = false, full_table;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -1921,9 +2262,11 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	orig_ttvn = (uint8_t)atomic_read(&req_dst_orig_node->last_ttvn);
 	req_ttvn = tt_data->ttvn;
 
+	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
 	/* this node doesn't have the requested data */
 	if (orig_ttvn != req_ttvn ||
-	    tt_data->crc != htonl(req_dst_orig_node->tt_crc))
+	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_vlan,
+					ntohs(tt_data->num_vlan)))
 		goto out;
 
 	/* If the full table has been explicitly requested */
@@ -1940,26 +2283,42 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 		spin_lock_bh(&req_dst_orig_node->tt_buff_lock);
 		tt_len = req_dst_orig_node->tt_buff_len;
 
-		tvlv_tt_data = kzalloc(sizeof(*tvlv_tt_data) + tt_len,
-				       GFP_ATOMIC);
-		if (!tvlv_tt_data)
+		tt_len = batadv_tt_prepare_tvlv_global_data(req_dst_orig_node,
+							    &tvlv_tt_data,
+							    tt_len);
+		if (!tt_len)
 			goto unlock;
 
+		change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
+		change_offset *= ntohs(tvlv_tt_data->num_vlan);
+		change_offset += sizeof(*tvlv_tt_data);
+
+		tvlv_ptr = (uint8_t *)tvlv_tt_data + change_offset;
+		tt_change = (struct batadv_tvlv_tt_change *)tvlv_ptr;
 		/* Copy the last orig_node's OGM buffer */
-		memcpy(tvlv_tt_data + 1, req_dst_orig_node->tt_buff,
+		memcpy(tt_change, req_dst_orig_node->tt_buff,
 		       req_dst_orig_node->tt_buff_len);
 		spin_unlock_bh(&req_dst_orig_node->tt_buff_lock);
 	} else {
-		tt_len = (uint16_t)atomic_read(&req_dst_orig_node->tt_size);
-		tt_len = batadv_tt_len(tt_len);
-
-		tvlv_tt_data = batadv_tt_tvlv_generate(bat_priv,
-						       bat_priv->tt.global_hash,
-						       tt_len,
-						       batadv_tt_global_valid,
-						       req_dst_orig_node);
-		if (!tvlv_tt_data)
+		/* allocate the tvlv, put the tt_data and all the tt_vlan_data
+		 * in the initial part
+		 */
+		tt_len = batadv_tt_prepare_tvlv_global_data(req_dst_orig_node,
+							    &tvlv_tt_data, -1);
+		if (!tt_len)
 			goto out;
+
+		change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
+		change_offset *= ntohs(tvlv_tt_data->num_vlan);
+		change_offset += sizeof(*tvlv_tt_data);
+
+		tvlv_ptr = (uint8_t *)tvlv_tt_data + change_offset;
+		tt_change = (struct batadv_tvlv_tt_change *)tvlv_ptr;
+		/* fill the rest of the tvlv with the real TT entries */
+		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.global_hash,
+					tt_change, tt_len - change_offset,
+					batadv_tt_global_valid,
+					req_dst_orig_node);
 	}
 
 	tvlv_tt_data->flags = BATADV_TT_RESPONSE;
@@ -1976,8 +2335,8 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_TX);
 
 	batadv_tvlv_unicast_send(bat_priv, req_dst_orig_node->orig,
-				 req_src, BATADV_TVLV_TT, 1,
-				 tvlv_tt_data, sizeof(*tvlv_tt_data) + tt_len);
+				 req_src, BATADV_TVLV_TT, 1, tvlv_tt_data,
+				 tt_len);
 
 	ret = true;
 	goto out;
@@ -2008,11 +2367,12 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 				       uint8_t *req_src)
 {
 	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
-	struct batadv_orig_node *orig_node;
 	struct batadv_hard_iface *primary_if = NULL;
-	uint8_t my_ttvn, req_ttvn;
+	struct batadv_tvlv_tt_change *tt_change;
+	struct batadv_orig_node *orig_node;
+	uint8_t my_ttvn, req_ttvn, *tvlv_ptr;
 	bool full_table;
-	uint16_t tt_len;
+	uint16_t tt_len, change_offset;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_REQUEST from %pM for ttvn: %u (me) [%c]\n",
@@ -2045,29 +2405,45 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	 */
 	if (!full_table) {
 		spin_lock_bh(&bat_priv->tt.last_changeset_lock);
-		tt_len = bat_priv->tt.last_changeset_len;
 
-		tvlv_tt_data = kzalloc(sizeof(*tvlv_tt_data) + tt_len,
-				       GFP_ATOMIC);
-		if (!tvlv_tt_data)
+		tt_len = bat_priv->tt.last_changeset_len;
+		tt_len = batadv_tt_prepare_tvlv_local_data(bat_priv,
+							   &tvlv_tt_data,
+							   tt_len);
+		if (!tt_len)
 			goto unlock;
 
+		change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
+		change_offset *= ntohs(tvlv_tt_data->num_vlan);
+		change_offset += sizeof(*tvlv_tt_data);
+
+		tvlv_ptr = (uint8_t *)tvlv_tt_data + change_offset;
+		tt_change = (struct batadv_tvlv_tt_change *)tvlv_ptr;
 		/* Copy the last orig_node's OGM buffer */
-		memcpy(tvlv_tt_data + 1, bat_priv->tt.last_changeset,
+		memcpy(tt_change, bat_priv->tt.last_changeset,
 		       bat_priv->tt.last_changeset_len);
 		spin_unlock_bh(&bat_priv->tt.last_changeset_lock);
 	} else {
-		tt_len = (uint16_t)atomic_read(&bat_priv->tt.local_entry_num);
-		tt_len = batadv_tt_len(tt_len);
 		req_ttvn = (uint8_t)atomic_read(&bat_priv->tt.vn);
 
-		tvlv_tt_data = batadv_tt_tvlv_generate(bat_priv,
-						       bat_priv->tt.local_hash,
-						       tt_len,
-						       batadv_tt_local_valid,
-						       NULL);
-		if (!tvlv_tt_data)
+		/* allocate the tvlv, put the tt_data and all the tt_vlan_data
+		 * in the initial part
+		 */
+		tt_len = batadv_tt_prepare_tvlv_local_data(bat_priv,
+							   &tvlv_tt_data, -1);
+		if (!tt_len)
 			goto out;
+
+		change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
+		change_offset *= ntohs(tvlv_tt_data->num_vlan);
+		change_offset += sizeof(*tvlv_tt_data);
+
+		tvlv_ptr = (uint8_t *)tvlv_tt_data + change_offset;
+		tt_change = (struct batadv_tvlv_tt_change *)tvlv_ptr;
+		/* fill the rest of the tvlv with the real TT entries */
+		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.local_hash,
+					tt_change, tt_len - change_offset,
+					batadv_tt_local_valid, NULL);
 	}
 
 	tvlv_tt_data->flags = BATADV_TT_RESPONSE;
@@ -2083,8 +2459,8 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 	batadv_inc_counter(bat_priv, BATADV_CNT_TT_RESPONSE_TX);
 
 	batadv_tvlv_unicast_send(bat_priv, primary_if->net_dev->dev_addr,
-				 req_src, BATADV_TVLV_TT, 1,
-				 tvlv_tt_data, sizeof(*tvlv_tt_data) + tt_len);
+				 req_src, BATADV_TVLV_TT, 1, tvlv_tt_data,
+				 tt_len);
 
 	goto out;
 
@@ -2159,8 +2535,9 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 }
 
 static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
-				  struct batadv_tvlv_tt_data *tt_data,
-				  uint8_t *resp_src, uint16_t num_entries)
+				  struct batadv_tvlv_tt_change *tt_change,
+				  uint8_t ttvn, uint8_t *resp_src,
+				  uint16_t num_entries)
 {
 	struct batadv_orig_node *orig_node;
 
@@ -2171,9 +2548,8 @@ static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 	/* Purge the old table first.. */
 	batadv_tt_global_del_orig(bat_priv, orig_node, "Received full table");
 
-	_batadv_tt_update_changes(bat_priv, orig_node,
-				  (struct batadv_tvlv_tt_change *)(tt_data + 1),
-				  num_entries, tt_data->ttvn);
+	_batadv_tt_update_changes(bat_priv, orig_node, tt_change, num_entries,
+				  ttvn);
 
 	spin_lock_bh(&orig_node->tt_buff_lock);
 	kfree(orig_node->tt_buff);
@@ -2181,7 +2557,7 @@ static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 	orig_node->tt_buff = NULL;
 	spin_unlock_bh(&orig_node->tt_buff_lock);
 
-	atomic_set(&orig_node->last_ttvn, tt_data->ttvn);
+	atomic_set(&orig_node->last_ttvn, ttvn);
 
 out:
 	if (orig_node)
@@ -2245,6 +2621,8 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	struct batadv_tt_req_node *node, *safe;
 	struct batadv_orig_node *orig_node = NULL;
 	struct batadv_tvlv_tt_change *tt_change;
+	uint8_t *tvlv_ptr = (uint8_t *)tt_data;
+	uint16_t change_offset;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Received TT_RESPONSE from %pM for ttvn %d t_size: %d [%c]\n",
@@ -2259,10 +2637,16 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	if (!orig_node)
 		goto out;
 
+	change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
+	change_offset *= ntohs(tt_data->num_vlan);
+	change_offset += sizeof(*tt_data);
+	tvlv_ptr += change_offset;
+
+	tt_change = (struct batadv_tvlv_tt_change *)tvlv_ptr;
 	if (tt_data->flags & BATADV_TT_FULL_TABLE) {
-		batadv_tt_fill_gtable(bat_priv, tt_data, resp_src, num_entries);
+		batadv_tt_fill_gtable(bat_priv, tt_change, tt_data->ttvn,
+				      resp_src, num_entries);
 	} else {
-		tt_change = (struct batadv_tvlv_tt_change *)(tt_data + 1);
 		batadv_tt_update_changes(bat_priv, orig_node, num_entries,
 					 tt_data->ttvn, tt_change);
 	}
@@ -2278,7 +2662,7 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->tt.req_list_lock);
 
 	/* Recalculate the CRC for this orig_node and store it */
-	orig_node->tt_crc = batadv_tt_global_crc(bat_priv, orig_node);
+	batadv_tt_global_update_crc(bat_priv, orig_node);
 out:
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
@@ -2446,19 +2830,25 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 	kfree(bat_priv->tt.last_changeset);
 }
 
-/* This function will enable or disable the specified flags for all the entries
- * in the given hash table and returns the number of modified entries
+/**
+ * batadv_tt_local_set_flags - set or unset the specified flags on the local
+ *  table and possibly count them in the TT size
+ * @bat_priv: the bat priv with all the soft interface information
+ * @flags: the flag to switch
+ * @enable: whether to set or unset the flag
+ * @count: whether to increase the TT size by the number of changed entries
  */
-static uint16_t batadv_tt_set_flags(struct batadv_hashtable *hash,
-				    uint16_t flags, bool enable)
+static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv,
+				      uint16_t flags, bool enable, bool count)
 {
-	uint32_t i;
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	struct batadv_tt_common_entry *tt_common_entry;
 	uint16_t changed_num = 0;
 	struct hlist_head *head;
-	struct batadv_tt_common_entry *tt_common_entry;
+	uint32_t i;
 
 	if (!hash)
-		goto out;
+		return;
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -2476,11 +2866,15 @@ static uint16_t batadv_tt_set_flags(struct batadv_hashtable *hash,
 				tt_common_entry->flags &= ~flags;
 			}
 			changed_num++;
+
+			if (!count)
+				continue;
+
+			batadv_tt_local_size_inc(bat_priv,
+						 tt_common_entry->vid);
 		}
 		rcu_read_unlock();
 	}
-out:
-	return changed_num;
 }
 
 /* Purge out all the tt local entries marked with BATADV_TT_CLIENT_PENDING */
@@ -2512,7 +2906,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 				   tt_common->addr,
 				   BATADV_PRINT_VID(tt_common->vid));
 
-			atomic_dec(&bat_priv->tt.local_entry_num);
+			batadv_tt_local_size_dec(bat_priv, tt_common->vid);
 			hlist_del_rcu(&tt_common->hash_entry);
 			tt_local = container_of(tt_common,
 						struct batadv_tt_local_entry,
@@ -2530,21 +2924,16 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
  */
 void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
 {
-	uint16_t changed_num = 0;
-
 	if (atomic_read(&bat_priv->tt.local_changes) < 1) {
 		if (!batadv_atomic_dec_not_zero(&bat_priv->tt.ogm_append_cnt))
 			batadv_tt_tvlv_container_update(bat_priv);
 		return;
 	}
 
-	changed_num = batadv_tt_set_flags(bat_priv->tt.local_hash,
-					  BATADV_TT_CLIENT_NEW, false);
+	batadv_tt_local_set_flags(bat_priv, BATADV_TT_CLIENT_NEW, false, true);
 
-	/* all reset entries have to be counted as local entries */
-	atomic_add(changed_num, &bat_priv->tt.local_entry_num);
 	batadv_tt_local_purge_pending_clients(bat_priv);
-	bat_priv->tt.local_crc = batadv_tt_local_crc(bat_priv);
+	batadv_tt_local_update_crc(bat_priv);
 
 	/* Increment the TTVN only once per OGM interval */
 	atomic_inc(&bat_priv->tt.vn);
@@ -2597,25 +2986,28 @@ out:
  *  information received via ogms
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
- * @tt_buff: buffer holding the tt information
+ * @tt_vlan: pointer to the first tvlv VLAN entry
+ * @tt_num_vlan: number of tvlv VLAN entries
+ * @tt_change: pointer to the first entry in the TT buffer
  * @tt_num_changes: number of tt changes inside the tt buffer
  * @ttvn: translation table version number of this changeset
  * @tt_crc: crc32 checksum of orig node's translation table
  */
 static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 				  struct batadv_orig_node *orig_node,
-				  const unsigned char *tt_buff,
-				  uint16_t tt_num_changes, uint8_t ttvn,
-				  uint32_t tt_crc)
+				  const void *tt_buff, uint16_t tt_num_vlan,
+				  struct batadv_tvlv_tt_change *tt_change,
+				  uint16_t tt_num_changes, uint8_t ttvn)
 {
 	uint8_t orig_ttvn = (uint8_t)atomic_read(&orig_node->last_ttvn);
+	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	bool full_table = true;
-	struct batadv_tvlv_tt_change *tt_change;
 
 	/* don't care about a backbone gateways updates. */
 	if (batadv_bla_is_backbone_gw_orig(bat_priv, orig_node->orig))
 		return;
 
+	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)tt_buff;
 	/* orig table not initialised AND first diff is in the OGM OR the ttvn
 	 * increased by one -> we can apply the attached changes
 	 */
@@ -2631,7 +3023,6 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 			goto request_table;
 		}
 
-		tt_change = (struct batadv_tvlv_tt_change *)tt_buff;
 		batadv_tt_update_changes(bat_priv, orig_node, tt_num_changes,
 					 ttvn, tt_change);
 
@@ -2639,7 +3030,7 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 		 * prefer to recompute it to spot any possible inconsistency
 		 * in the global table
 		 */
-		orig_node->tt_crc = batadv_tt_global_crc(bat_priv, orig_node);
+		batadv_tt_global_update_crc(bat_priv, orig_node);
 
 		/* The ttvn alone is not enough to guarantee consistency
 		 * because a single value could represent different states
@@ -2650,21 +3041,24 @@ static void batadv_tt_update_orig(struct batadv_priv *bat_priv,
 		 * checking the CRC value is mandatory to detect the
 		 * inconsistency
 		 */
-		if (orig_node->tt_crc != tt_crc)
+		if (!batadv_tt_global_check_crc(orig_node, tt_vlan,
+						tt_num_vlan))
 			goto request_table;
 	} else {
 		/* if we missed more than one change or our tables are not
 		 * in sync anymore -> request fresh tt data
 		 */
 		if (!orig_node->tt_initialised || ttvn != orig_ttvn ||
-		    orig_node->tt_crc != tt_crc) {
+		    !batadv_tt_global_check_crc(orig_node, tt_vlan,
+						tt_num_vlan)) {
 request_table:
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "TT inconsistency for %pM. Need to retrieve the correct information (ttvn: %u last_ttvn: %u crc: %#.8x last_crc: %#.8x num_changes: %u)\n",
-				   orig_node->orig, ttvn, orig_ttvn, tt_crc,
-				   orig_node->tt_crc, tt_num_changes);
+				   "TT inconsistency for %pM. Need to retrieve the correct information (ttvn: %u last_ttvn: %u num_changes: %u)\n",
+				   orig_node->orig, ttvn, orig_ttvn,
+				   tt_num_changes);
 			batadv_send_tt_request(bat_priv, orig_node, ttvn,
-					       tt_crc, full_table);
+					       tt_vlan, tt_num_vlan,
+					       full_table);
 			return;
 		}
 	}
@@ -2759,12 +3153,13 @@ out:
  */
 static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig,
-					  uint8_t flags,
-					  void *tvlv_value,
+					  uint8_t flags, void *tvlv_value,
 					  uint16_t tvlv_value_len)
 {
+	struct batadv_tvlv_tt_vlan_data *tt_vlan;
+	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
-	uint16_t num_entries;
+	uint16_t num_entries, num_vlan;
 
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
@@ -2772,11 +3167,19 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	tt_data = (struct batadv_tvlv_tt_data *)tvlv_value;
 	tvlv_value_len -= sizeof(*tt_data);
 
+	num_vlan = ntohs(tt_data->num_vlan);
+
+	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
+		return;
+
+	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
+	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
+	tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
+
 	num_entries = batadv_tt_entries(tvlv_value_len);
 
-	batadv_tt_update_orig(bat_priv, orig,
-			      (unsigned char *)(tt_data + 1),
-			      num_entries, tt_data->ttvn, ntohl(tt_data->crc));
+	batadv_tt_update_orig(bat_priv, orig, tt_vlan, num_vlan, tt_change,
+			      num_entries, tt_data->ttvn);
 }
 
 /**
@@ -2797,7 +3200,7 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 					     uint16_t tvlv_value_len)
 {
 	struct batadv_tvlv_tt_data *tt_data;
-	uint16_t num_entries;
+	uint16_t tt_vlan_len, tt_num_entries;
 	char tt_flag;
 	bool ret;
 
@@ -2807,7 +3210,14 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 	tt_data = (struct batadv_tvlv_tt_data *)tvlv_value;
 	tvlv_value_len -= sizeof(*tt_data);
 
-	num_entries = batadv_tt_entries(tvlv_value_len);
+	tt_vlan_len = sizeof(struct batadv_tvlv_tt_vlan_data);
+	tt_vlan_len *= ntohs(tt_data->num_vlan);
+
+	if (tvlv_value_len < tt_vlan_len)
+		return NET_RX_SUCCESS;
+
+	tvlv_value_len -= tt_vlan_len;
+	tt_num_entries = batadv_tt_entries(tvlv_value_len);
 
 	switch (tt_data->flags & BATADV_TT_DATA_TYPE_MASK) {
 	case BATADV_TT_REQUEST:
@@ -2835,7 +3245,7 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
 
 		if (batadv_is_my_mac(bat_priv, dst)) {
 			batadv_handle_tt_response(bat_priv, tt_data,
-						  src, num_entries);
+						  src, tt_num_entries);
 			return NET_RX_SUCCESS;
 		}
 
diff --git a/types.h b/types.h
index 0fbf07c..e0b8ca0 100644
--- a/types.h
+++ b/types.h
@@ -107,6 +107,32 @@ struct batadv_frag_list_entry {
 };
 
 /**
+ * struct batadv_vlan_tt - VLAN specific TT attributes
+ * @crc: CRC32 checksum of the entries belonging to this vlan
+ * @num_entries: number of TT entries for this VLAN
+ */
+struct batadv_vlan_tt {
+	uint32_t crc;
+	atomic_t num_entries;
+};
+
+/**
+ * batadv_orig_node_vlan - VLAN specific data per orig_node
+ * @vid: the VLAN identifier
+ * @tt: VLAN specific TT attributes
+ * @list: list node for orig_node::vlan_list
+ * @refcount: number of context where this object is currently in use
+ * @rcu: struct used for freeing in a RCU-safe manner
+ */
+struct batadv_orig_node_vlan {
+	unsigned short vid;
+	struct batadv_vlan_tt tt;
+	struct list_head list;
+	atomic_t refcount;
+	struct rcu_head rcu;
+};
+
+/**
  * struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
  * @orig: originator ethernet address
  * @primary_addr: hosts primary interface address
@@ -120,12 +146,10 @@ struct batadv_frag_list_entry {
  * @batman_seqno_reset: time when the batman seqno window was reset
  * @capabilities: announced capabilities of this originator
  * @last_ttvn: last seen translation table version number
- * @tt_crc: CRC of the translation table
  * @tt_buff: last tt changeset this node received from the orig node
  * @tt_buff_len: length of the last tt changeset this node received from the
  *  orig node
  * @tt_buff_lock: lock that protects tt_buff and tt_buff_len
- * @tt_size: number of global TT entries announced by the orig node
  * @tt_initialised: bool keeping track of whether or not this node have received
  *  any translation table information from the orig node yet
  * @last_real_seqno: last and best known sequence number
@@ -150,6 +174,9 @@ struct batadv_frag_list_entry {
  * @in_coding_list_lock: protects in_coding_list
  * @out_coding_list_lock: protects out_coding_list
  * @fragments: array with heads for fragment chains
+ * @vlan_list: a list of orig_node_vlan structs, one per VLAN served by the
+ *  originator represented by this object
+ * @vlan_list_lock: lock protecting vlan_list
  */
 struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
@@ -165,11 +192,9 @@ struct batadv_orig_node {
 	unsigned long batman_seqno_reset;
 	uint8_t capabilities;
 	atomic_t last_ttvn;
-	uint32_t tt_crc;
 	unsigned char *tt_buff;
 	int16_t tt_buff_len;
 	spinlock_t tt_buff_lock; /* protects tt_buff & tt_buff_len */
-	atomic_t tt_size;
 	bool tt_initialised;
 	uint32_t last_real_seqno;
 	uint8_t last_ttl;
@@ -197,6 +222,8 @@ struct batadv_orig_node {
 	spinlock_t out_coding_list_lock; /* Protects out_coding_list */
 #endif
 	struct batadv_frag_table_entry fragments[BATADV_FRAG_BUFFER_COUNT];
+	struct list_head vlan_list;
+	spinlock_t vlan_list_lock; /* protects vlan_list */
 };
 
 /**
@@ -402,8 +429,6 @@ struct batadv_priv_tt {
 	spinlock_t changes_list_lock; /* protects changes */
 	spinlock_t req_list_lock; /* protects req_list */
 	spinlock_t roam_list_lock; /* protects roam_list */
-	atomic_t local_entry_num;
-	uint32_t local_crc;
 	unsigned char *last_changeset;
 	int16_t last_changeset_len;
 	/* protects last_changeset & last_changeset_len */
@@ -535,6 +560,7 @@ struct batadv_priv_nc {
  * @vid: VLAN identifier
  * @kobj: kobject for sysfs vlan subdirectory
  * @ap_isolation: AP isolation state
+ * @tt: TT private attributes (VLAN specific)
  * @list: list node for bat_priv::softif_vlan_list
  * @refcount: number of context where this object is currently in use
  * @rcu: struct used for freeing in a RCU-safe manner
@@ -543,6 +569,7 @@ struct batadv_softif_vlan {
 	unsigned short vid;
 	struct kobject *kobj;
 	atomic_t ap_isolation;		/* boolean */
+	struct batadv_vlan_tt tt;
 	struct hlist_node list;
 	atomic_t refcount;
 	struct rcu_head rcu;
-- 
1.8.1.5

