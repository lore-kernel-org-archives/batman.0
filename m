Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Fri, 26 Dec 2014 12:41:24 +0100
Message-Id: <1419594103-10928-8-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH v2 07/26] batman-adv: split tvlv into a
	seperate file
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

The main file includes a lot of helper functions. tvlv is a seperate set
of functions so we should split them into a seperate file. There is no
need for tvlv to be implemented in main.c.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Makefile.kbuild         |   1 +
 bat_iv_ogm.c            |   1 +
 distributed-arp-table.c |   1 +
 gateway_common.c        |   1 +
 main.c                  | 568 ----------------------------------------------
 main.h                  |  35 ---
 multicast.c             |   1 +
 network-coding.c        |   1 +
 routing.c               |   1 +
 translation-table.c     |   1 +
 tvlv.c                  | 592 ++++++++++++++++++++++++++++++++++++++++++++++++
 tvlv.h                  |  62 +++++
 12 files changed, 662 insertions(+), 603 deletions(-)
 create mode 100644 tvlv.c
 create mode 100644 tvlv.h

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 96fa99b3a409..a8c34baddd63 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -36,4 +36,5 @@ batman-adv-y += send.o
 batman-adv-y += soft-interface.o
 batman-adv-y += sysfs.o
 batman-adv-y += translation-table.o
+batman-adv-y += tvlv.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 10eada270015..20295c5e5121 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -23,6 +23,7 @@
 #include "gateway_client.h"
 #include "hard-interface.h"
 #include "send.h"
+#include "tvlv.h"
 #include "bat_algo.h"
 #include "network-coding.h"
 #include "log.h"
diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index e2f0677a5a01..e3deff63d393 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -29,6 +29,7 @@
 #include "types.h"
 #include "translation-table.h"
 #include "log.h"
+#include "tvlv.h"
 
 static void batadv_dat_purge(struct work_struct *work);
 
diff --git a/gateway_common.c b/gateway_common.c
index cbef7fd97971..c2dfcc03ddfa 100644
--- a/gateway_common.c
+++ b/gateway_common.c
@@ -19,6 +19,7 @@
 #include "gateway_common.h"
 #include "gateway_client.h"
 #include "log.h"
+#include "tvlv.h"
 
 /**
  * batadv_parse_gw_bandwidth - parse supplied string buffer to extract download
diff --git a/main.c b/main.c
index 00a1107109e8..cff31bb9bb14 100644
--- a/main.c
+++ b/main.c
@@ -623,574 +623,6 @@ __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
 }
 
 /**
- * batadv_tvlv_handler_free_ref - decrement the tvlv handler refcounter and
- *  possibly free it
- * @tvlv_handler: the tvlv handler to free
- */
-static void
-batadv_tvlv_handler_free_ref(struct batadv_tvlv_handler *tvlv_handler)
-{
-	if (atomic_dec_and_test(&tvlv_handler->refcount))
-		kfree_rcu(tvlv_handler, rcu);
-}
-
-/**
- * batadv_tvlv_handler_get - retrieve tvlv handler from the tvlv handler list
- *  based on the provided type and version (both need to match)
- * @bat_priv: the bat priv with all the soft interface information
- * @type: tvlv handler type to look for
- * @version: tvlv handler version to look for
- *
- * Returns tvlv handler if found or NULL otherwise.
- */
-static struct batadv_tvlv_handler
-*batadv_tvlv_handler_get(struct batadv_priv *bat_priv,
-			 uint8_t type, uint8_t version)
-{
-	struct batadv_tvlv_handler *tvlv_handler_tmp, *tvlv_handler = NULL;
-
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(tvlv_handler_tmp,
-				 &bat_priv->tvlv.handler_list, list) {
-		if (tvlv_handler_tmp->type != type)
-			continue;
-
-		if (tvlv_handler_tmp->version != version)
-			continue;
-
-		if (!atomic_inc_not_zero(&tvlv_handler_tmp->refcount))
-			continue;
-
-		tvlv_handler = tvlv_handler_tmp;
-		break;
-	}
-	rcu_read_unlock();
-
-	return tvlv_handler;
-}
-
-/**
- * batadv_tvlv_container_free_ref - decrement the tvlv container refcounter and
- *  possibly free it
- * @tvlv: the tvlv container to free
- */
-static void batadv_tvlv_container_free_ref(struct batadv_tvlv_container *tvlv)
-{
-	if (atomic_dec_and_test(&tvlv->refcount))
-		kfree(tvlv);
-}
-
-/**
- * batadv_tvlv_container_get - retrieve tvlv container from the tvlv container
- *  list based on the provided type and version (both need to match)
- * @bat_priv: the bat priv with all the soft interface information
- * @type: tvlv container type to look for
- * @version: tvlv container version to look for
- *
- * Has to be called with the appropriate locks being acquired
- * (tvlv.container_list_lock).
- *
- * Returns tvlv container if found or NULL otherwise.
- */
-static struct batadv_tvlv_container
-*batadv_tvlv_container_get(struct batadv_priv *bat_priv,
-			   uint8_t type, uint8_t version)
-{
-	struct batadv_tvlv_container *tvlv_tmp, *tvlv = NULL;
-
-	hlist_for_each_entry(tvlv_tmp, &bat_priv->tvlv.container_list, list) {
-		if (tvlv_tmp->tvlv_hdr.type != type)
-			continue;
-
-		if (tvlv_tmp->tvlv_hdr.version != version)
-			continue;
-
-		if (!atomic_inc_not_zero(&tvlv_tmp->refcount))
-			continue;
-
-		tvlv = tvlv_tmp;
-		break;
-	}
-
-	return tvlv;
-}
-
-/**
- * batadv_tvlv_container_list_size - calculate the size of the tvlv container
- *  list entries
- * @bat_priv: the bat priv with all the soft interface information
- *
- * Has to be called with the appropriate locks being acquired
- * (tvlv.container_list_lock).
- *
- * Returns size of all currently registered tvlv containers in bytes.
- */
-static uint16_t batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
-{
-	struct batadv_tvlv_container *tvlv;
-	uint16_t tvlv_len = 0;
-
-	hlist_for_each_entry(tvlv, &bat_priv->tvlv.container_list, list) {
-		tvlv_len += sizeof(struct batadv_tvlv_hdr);
-		tvlv_len += ntohs(tvlv->tvlv_hdr.len);
-	}
-
-	return tvlv_len;
-}
-
-/**
- * batadv_tvlv_container_remove - remove tvlv container from the tvlv container
- *  list
- * @tvlv: the to be removed tvlv container
- *
- * Has to be called with the appropriate locks being acquired
- * (tvlv.container_list_lock).
- */
-static void batadv_tvlv_container_remove(struct batadv_tvlv_container *tvlv)
-{
-	if (!tvlv)
-		return;
-
-	hlist_del(&tvlv->list);
-
-	/* first call to decrement the counter, second call to free */
-	batadv_tvlv_container_free_ref(tvlv);
-	batadv_tvlv_container_free_ref(tvlv);
-}
-
-/**
- * batadv_tvlv_container_unregister - unregister tvlv container based on the
- *  provided type and version (both need to match)
- * @bat_priv: the bat priv with all the soft interface information
- * @type: tvlv container type to unregister
- * @version: tvlv container type to unregister
- */
-void batadv_tvlv_container_unregister(struct batadv_priv *bat_priv,
-				      uint8_t type, uint8_t version)
-{
-	struct batadv_tvlv_container *tvlv;
-
-	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
-	tvlv = batadv_tvlv_container_get(bat_priv, type, version);
-	batadv_tvlv_container_remove(tvlv);
-	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
-}
-
-/**
- * batadv_tvlv_container_register - register tvlv type, version and content
- *  to be propagated with each (primary interface) OGM
- * @bat_priv: the bat priv with all the soft interface information
- * @type: tvlv container type
- * @version: tvlv container version
- * @tvlv_value: tvlv container content
- * @tvlv_value_len: tvlv container content length
- *
- * If a container of the same type and version was already registered the new
- * content is going to replace the old one.
- */
-void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
-				    uint8_t type, uint8_t version,
-				    void *tvlv_value, uint16_t tvlv_value_len)
-{
-	struct batadv_tvlv_container *tvlv_old, *tvlv_new;
-
-	if (!tvlv_value)
-		tvlv_value_len = 0;
-
-	tvlv_new = kzalloc(sizeof(*tvlv_new) + tvlv_value_len, GFP_ATOMIC);
-	if (!tvlv_new)
-		return;
-
-	tvlv_new->tvlv_hdr.version = version;
-	tvlv_new->tvlv_hdr.type = type;
-	tvlv_new->tvlv_hdr.len = htons(tvlv_value_len);
-
-	memcpy(tvlv_new + 1, tvlv_value, ntohs(tvlv_new->tvlv_hdr.len));
-	INIT_HLIST_NODE(&tvlv_new->list);
-	atomic_set(&tvlv_new->refcount, 1);
-
-	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
-	tvlv_old = batadv_tvlv_container_get(bat_priv, type, version);
-	batadv_tvlv_container_remove(tvlv_old);
-	hlist_add_head(&tvlv_new->list, &bat_priv->tvlv.container_list);
-	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
-}
-
-/**
- * batadv_tvlv_realloc_packet_buff - reallocate packet buffer to accomodate
- *  requested packet size
- * @packet_buff: packet buffer
- * @packet_buff_len: packet buffer size
- * @min_packet_len: requested packet minimum size
- * @additional_packet_len: requested additional packet size on top of minimum
- *  size
- *
- * Returns true of the packet buffer could be changed to the requested size,
- * false otherwise.
- */
-static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
-					    int *packet_buff_len,
-					    int min_packet_len,
-					    int additional_packet_len)
-{
-	unsigned char *new_buff;
-
-	new_buff = kmalloc(min_packet_len + additional_packet_len, GFP_ATOMIC);
-
-	/* keep old buffer if kmalloc should fail */
-	if (!new_buff)
-		return false;
-
-	memcpy(new_buff, *packet_buff, min_packet_len);
-	kfree(*packet_buff);
-	*packet_buff = new_buff;
-	*packet_buff_len = min_packet_len + additional_packet_len;
-
-	return true;
-}
-
-/**
- * batadv_tvlv_container_ogm_append - append tvlv container content to given
- *  OGM packet buffer
- * @bat_priv: the bat priv with all the soft interface information
- * @packet_buff: ogm packet buffer
- * @packet_buff_len: ogm packet buffer size including ogm header and tvlv
- *  content
- * @packet_min_len: ogm header size to be preserved for the OGM itself
- *
- * The ogm packet might be enlarged or shrunk depending on the current size
- * and the size of the to-be-appended tvlv containers.
- *
- * Returns size of all appended tvlv containers in bytes.
- */
-uint16_t batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
-					  unsigned char **packet_buff,
-					  int *packet_buff_len,
-					  int packet_min_len)
-{
-	struct batadv_tvlv_container *tvlv;
-	struct batadv_tvlv_hdr *tvlv_hdr;
-	uint16_t tvlv_value_len;
-	void *tvlv_value;
-	bool ret;
-
-	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
-	tvlv_value_len = batadv_tvlv_container_list_size(bat_priv);
-
-	ret = batadv_tvlv_realloc_packet_buff(packet_buff, packet_buff_len,
-					      packet_min_len, tvlv_value_len);
-
-	if (!ret)
-		goto end;
-
-	if (!tvlv_value_len)
-		goto end;
-
-	tvlv_value = (*packet_buff) + packet_min_len;
-
-	hlist_for_each_entry(tvlv, &bat_priv->tvlv.container_list, list) {
-		tvlv_hdr = tvlv_value;
-		tvlv_hdr->type = tvlv->tvlv_hdr.type;
-		tvlv_hdr->version = tvlv->tvlv_hdr.version;
-		tvlv_hdr->len = tvlv->tvlv_hdr.len;
-		tvlv_value = tvlv_hdr + 1;
-		memcpy(tvlv_value, tvlv + 1, ntohs(tvlv->tvlv_hdr.len));
-		tvlv_value = (uint8_t *)tvlv_value + ntohs(tvlv->tvlv_hdr.len);
-	}
-
-end:
-	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
-	return tvlv_value_len;
-}
-
-/**
- * batadv_tvlv_call_handler - parse the given tvlv buffer to call the
- *  appropriate handlers
- * @bat_priv: the bat priv with all the soft interface information
- * @tvlv_handler: tvlv callback function handling the tvlv content
- * @ogm_source: flag indicating wether the tvlv is an ogm or a unicast packet
- * @orig_node: orig node emitting the ogm packet
- * @src: source mac address of the unicast packet
- * @dst: destination mac address of the unicast packet
- * @tvlv_value: tvlv content
- * @tvlv_value_len: tvlv content length
- *
- * Returns success if handler was not found or the return value of the handler
- * callback.
- */
-static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
-				    struct batadv_tvlv_handler *tvlv_handler,
-				    bool ogm_source,
-				    struct batadv_orig_node *orig_node,
-				    uint8_t *src, uint8_t *dst,
-				    void *tvlv_value, uint16_t tvlv_value_len)
-{
-	if (!tvlv_handler)
-		return NET_RX_SUCCESS;
-
-	if (ogm_source) {
-		if (!tvlv_handler->ogm_handler)
-			return NET_RX_SUCCESS;
-
-		if (!orig_node)
-			return NET_RX_SUCCESS;
-
-		tvlv_handler->ogm_handler(bat_priv, orig_node,
-					  BATADV_NO_FLAGS,
-					  tvlv_value, tvlv_value_len);
-		tvlv_handler->flags |= BATADV_TVLV_HANDLER_OGM_CALLED;
-	} else {
-		if (!src)
-			return NET_RX_SUCCESS;
-
-		if (!dst)
-			return NET_RX_SUCCESS;
-
-		if (!tvlv_handler->unicast_handler)
-			return NET_RX_SUCCESS;
-
-		return tvlv_handler->unicast_handler(bat_priv, src,
-						     dst, tvlv_value,
-						     tvlv_value_len);
-	}
-
-	return NET_RX_SUCCESS;
-}
-
-/**
- * batadv_tvlv_containers_process - parse the given tvlv buffer to call the
- *  appropriate handlers
- * @bat_priv: the bat priv with all the soft interface information
- * @ogm_source: flag indicating wether the tvlv is an ogm or a unicast packet
- * @orig_node: orig node emitting the ogm packet
- * @src: source mac address of the unicast packet
- * @dst: destination mac address of the unicast packet
- * @tvlv_value: tvlv content
- * @tvlv_value_len: tvlv content length
- *
- * Returns success when processing an OGM or the return value of all called
- * handler callbacks.
- */
-int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
-				   bool ogm_source,
-				   struct batadv_orig_node *orig_node,
-				   uint8_t *src, uint8_t *dst,
-				   void *tvlv_value, uint16_t tvlv_value_len)
-{
-	struct batadv_tvlv_handler *tvlv_handler;
-	struct batadv_tvlv_hdr *tvlv_hdr;
-	uint16_t tvlv_value_cont_len;
-	uint8_t cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
-	int ret = NET_RX_SUCCESS;
-
-	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
-		tvlv_hdr = tvlv_value;
-		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
-		tvlv_value = tvlv_hdr + 1;
-		tvlv_value_len -= sizeof(*tvlv_hdr);
-
-		if (tvlv_value_cont_len > tvlv_value_len)
-			break;
-
-		tvlv_handler = batadv_tvlv_handler_get(bat_priv,
-						       tvlv_hdr->type,
-						       tvlv_hdr->version);
-
-		ret |= batadv_tvlv_call_handler(bat_priv, tvlv_handler,
-						ogm_source, orig_node,
-						src, dst, tvlv_value,
-						tvlv_value_cont_len);
-		if (tvlv_handler)
-			batadv_tvlv_handler_free_ref(tvlv_handler);
-		tvlv_value = (uint8_t *)tvlv_value + tvlv_value_cont_len;
-		tvlv_value_len -= tvlv_value_cont_len;
-	}
-
-	if (!ogm_source)
-		return ret;
-
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(tvlv_handler,
-				 &bat_priv->tvlv.handler_list, list) {
-		if ((tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND) &&
-		    !(tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CALLED))
-			tvlv_handler->ogm_handler(bat_priv, orig_node,
-						  cifnotfound, NULL, 0);
-
-		tvlv_handler->flags &= ~BATADV_TVLV_HANDLER_OGM_CALLED;
-	}
-	rcu_read_unlock();
-
-	return NET_RX_SUCCESS;
-}
-
-/**
- * batadv_tvlv_ogm_receive - process an incoming ogm and call the appropriate
- *  handlers
- * @bat_priv: the bat priv with all the soft interface information
- * @batadv_ogm_packet: ogm packet containing the tvlv containers
- * @orig_node: orig node emitting the ogm packet
- */
-void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
-			     struct batadv_ogm_packet *batadv_ogm_packet,
-			     struct batadv_orig_node *orig_node)
-{
-	void *tvlv_value;
-	uint16_t tvlv_value_len;
-
-	if (!batadv_ogm_packet)
-		return;
-
-	tvlv_value_len = ntohs(batadv_ogm_packet->tvlv_len);
-	if (!tvlv_value_len)
-		return;
-
-	tvlv_value = batadv_ogm_packet + 1;
-
-	batadv_tvlv_containers_process(bat_priv, true, orig_node, NULL, NULL,
-				       tvlv_value, tvlv_value_len);
-}
-
-/**
- * batadv_tvlv_handler_register - register tvlv handler based on the provided
- *  type and version (both need to match) for ogm tvlv payload and/or unicast
- *  payload
- * @bat_priv: the bat priv with all the soft interface information
- * @optr: ogm tvlv handler callback function. This function receives the orig
- *  node, flags and the tvlv content as argument to process.
- * @uptr: unicast tvlv handler callback function. This function receives the
- *  source & destination of the unicast packet as well as the tvlv content
- *  to process.
- * @type: tvlv handler type to be registered
- * @version: tvlv handler version to be registered
- * @flags: flags to enable or disable TVLV API behavior
- */
-void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
-				  void (*optr)(struct batadv_priv *bat_priv,
-					       struct batadv_orig_node *orig,
-					       uint8_t flags,
-					       void *tvlv_value,
-					       uint16_t tvlv_value_len),
-				  int (*uptr)(struct batadv_priv *bat_priv,
-					      uint8_t *src, uint8_t *dst,
-					      void *tvlv_value,
-					      uint16_t tvlv_value_len),
-				  uint8_t type, uint8_t version, uint8_t flags)
-{
-	struct batadv_tvlv_handler *tvlv_handler;
-
-	tvlv_handler = batadv_tvlv_handler_get(bat_priv, type, version);
-	if (tvlv_handler) {
-		batadv_tvlv_handler_free_ref(tvlv_handler);
-		return;
-	}
-
-	tvlv_handler = kzalloc(sizeof(*tvlv_handler), GFP_ATOMIC);
-	if (!tvlv_handler)
-		return;
-
-	tvlv_handler->ogm_handler = optr;
-	tvlv_handler->unicast_handler = uptr;
-	tvlv_handler->type = type;
-	tvlv_handler->version = version;
-	tvlv_handler->flags = flags;
-	atomic_set(&tvlv_handler->refcount, 1);
-	INIT_HLIST_NODE(&tvlv_handler->list);
-
-	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
-	hlist_add_head_rcu(&tvlv_handler->list, &bat_priv->tvlv.handler_list);
-	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
-}
-
-/**
- * batadv_tvlv_handler_unregister - unregister tvlv handler based on the
- *  provided type and version (both need to match)
- * @bat_priv: the bat priv with all the soft interface information
- * @type: tvlv handler type to be unregistered
- * @version: tvlv handler version to be unregistered
- */
-void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
-				    uint8_t type, uint8_t version)
-{
-	struct batadv_tvlv_handler *tvlv_handler;
-
-	tvlv_handler = batadv_tvlv_handler_get(bat_priv, type, version);
-	if (!tvlv_handler)
-		return;
-
-	batadv_tvlv_handler_free_ref(tvlv_handler);
-	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
-	hlist_del_rcu(&tvlv_handler->list);
-	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
-	batadv_tvlv_handler_free_ref(tvlv_handler);
-}
-
-/**
- * batadv_tvlv_unicast_send - send a unicast packet with tvlv payload to the
- *  specified host
- * @bat_priv: the bat priv with all the soft interface information
- * @src: source mac address of the unicast packet
- * @dst: destination mac address of the unicast packet
- * @type: tvlv type
- * @version: tvlv version
- * @tvlv_value: tvlv content
- * @tvlv_value_len: tvlv content length
- */
-void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
-			      uint8_t *dst, uint8_t type, uint8_t version,
-			      void *tvlv_value, uint16_t tvlv_value_len)
-{
-	struct batadv_unicast_tvlv_packet *unicast_tvlv_packet;
-	struct batadv_tvlv_hdr *tvlv_hdr;
-	struct batadv_orig_node *orig_node;
-	struct sk_buff *skb = NULL;
-	unsigned char *tvlv_buff;
-	unsigned int tvlv_len;
-	ssize_t hdr_len = sizeof(*unicast_tvlv_packet);
-	bool ret = false;
-
-	orig_node = batadv_orig_hash_find(bat_priv, dst);
-	if (!orig_node)
-		goto out;
-
-	tvlv_len = sizeof(*tvlv_hdr) + tvlv_value_len;
-
-	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + hdr_len + tvlv_len);
-	if (!skb)
-		goto out;
-
-	skb->priority = TC_PRIO_CONTROL;
-	skb_reserve(skb, ETH_HLEN);
-	tvlv_buff = skb_put(skb, sizeof(*unicast_tvlv_packet) + tvlv_len);
-	unicast_tvlv_packet = (struct batadv_unicast_tvlv_packet *)tvlv_buff;
-	unicast_tvlv_packet->packet_type = BATADV_UNICAST_TVLV;
-	unicast_tvlv_packet->version = BATADV_COMPAT_VERSION;
-	unicast_tvlv_packet->ttl = BATADV_TTL;
-	unicast_tvlv_packet->reserved = 0;
-	unicast_tvlv_packet->tvlv_len = htons(tvlv_len);
-	unicast_tvlv_packet->align = 0;
-	ether_addr_copy(unicast_tvlv_packet->src, src);
-	ether_addr_copy(unicast_tvlv_packet->dst, dst);
-
-	tvlv_buff = (unsigned char *)(unicast_tvlv_packet + 1);
-	tvlv_hdr = (struct batadv_tvlv_hdr *)tvlv_buff;
-	tvlv_hdr->version = version;
-	tvlv_hdr->type = type;
-	tvlv_hdr->len = htons(tvlv_value_len);
-	tvlv_buff += sizeof(*tvlv_hdr);
-	memcpy(tvlv_buff, tvlv_value, tvlv_value_len);
-
-	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
-		ret = true;
-
-out:
-	if (skb && !ret)
-		kfree_skb(skb);
-	if (orig_node)
-		batadv_orig_node_free_ref(orig_node);
-}
-
-/**
  * batadv_get_vid - extract the VLAN identifier from skb if any
  * @skb: the buffer containing the packet
  * @header_len: length of the batman header preceding the ethernet header
diff --git a/main.h b/main.h
index 1cd4ebdbe060..013de2f7ee11 100644
--- a/main.h
+++ b/main.h
@@ -287,41 +287,6 @@ static inline uint64_t batadv_sum_counter(struct batadv_priv *bat_priv,
  * The macro is inspired by the similar macro TCP_SKB_CB() in tcp.h.
  */
 #define BATADV_SKB_CB(__skb)       ((struct batadv_skb_cb *)&((__skb)->cb[0]))
-
-void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
-				    uint8_t type, uint8_t version,
-				    void *tvlv_value, uint16_t tvlv_value_len);
-uint16_t batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
-					  unsigned char **packet_buff,
-					  int *packet_buff_len,
-					  int packet_min_len);
-void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
-			     struct batadv_ogm_packet *batadv_ogm_packet,
-			     struct batadv_orig_node *orig_node);
-void batadv_tvlv_container_unregister(struct batadv_priv *bat_priv,
-				      uint8_t type, uint8_t version);
-
-void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
-				  void (*optr)(struct batadv_priv *bat_priv,
-					       struct batadv_orig_node *orig,
-					       uint8_t flags,
-					       void *tvlv_value,
-					       uint16_t tvlv_value_len),
-				  int (*uptr)(struct batadv_priv *bat_priv,
-					      uint8_t *src, uint8_t *dst,
-					      void *tvlv_value,
-					      uint16_t tvlv_value_len),
-				  uint8_t type, uint8_t version, uint8_t flags);
-void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
-				    uint8_t type, uint8_t version);
-int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
-				   bool ogm_source,
-				   struct batadv_orig_node *orig_node,
-				   uint8_t *src, uint8_t *dst,
-				   void *tvlv_buff, uint16_t tvlv_buff_len);
-void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
-			      uint8_t *dst, uint8_t type, uint8_t version,
-			      void *tvlv_value, uint16_t tvlv_value_len);
 unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len);
 bool batadv_vlan_ap_isola_get(struct batadv_priv *bat_priv, unsigned short vid);
 
diff --git a/multicast.c b/multicast.c
index b24e4bb64fb5..abc410b7e705 100644
--- a/multicast.c
+++ b/multicast.c
@@ -20,6 +20,7 @@
 #include "originator.h"
 #include "hard-interface.h"
 #include "translation-table.h"
+#include "tvlv.h"
 
 /**
  * batadv_mcast_mla_softif_get - get softif multicast listeners
diff --git a/network-coding.c b/network-coding.c
index 93190fc25f76..68b1f9c880cd 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -25,6 +25,7 @@
 #include "hard-interface.h"
 #include "routing.h"
 #include "log.h"
+#include "tvlv.h"
 
 static struct lock_class_key batadv_nc_coding_hash_lock_class_key;
 static struct lock_class_key batadv_nc_decoding_hash_lock_class_key;
diff --git a/routing.c b/routing.c
index 07205591b05f..99b31499941b 100644
--- a/routing.c
+++ b/routing.c
@@ -28,6 +28,7 @@
 #include "network-coding.h"
 #include "fragmentation.h"
 #include "log.h"
+#include "tvlv.h"
 
 #include <linux/if_vlan.h>
 
diff --git a/translation-table.c b/translation-table.c
index be75a2ac543e..2d0bad466b68 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -26,6 +26,7 @@
 #include "bridge_loop_avoidance.h"
 #include "multicast.h"
 #include "log.h"
+#include "tvlv.h"
 
 #include <linux/crc32c.h>
 
diff --git a/tvlv.c b/tvlv.c
new file mode 100644
index 000000000000..43f9d9456f42
--- /dev/null
+++ b/tvlv.c
@@ -0,0 +1,592 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/netdevice.h>
+
+#include "main.h"
+#include "tvlv.h"
+#include "types.h"
+#include "originator.h"
+#include "send.h"
+
+/**
+ * batadv_tvlv_handler_free_ref - decrement the tvlv handler refcounter and
+ *  possibly free it
+ * @tvlv_handler: the tvlv handler to free
+ */
+static void
+batadv_tvlv_handler_free_ref(struct batadv_tvlv_handler *tvlv_handler)
+{
+	if (atomic_dec_and_test(&tvlv_handler->refcount))
+		kfree_rcu(tvlv_handler, rcu);
+}
+
+/**
+ * batadv_tvlv_handler_get - retrieve tvlv handler from the tvlv handler list
+ *  based on the provided type and version (both need to match)
+ * @bat_priv: the bat priv with all the soft interface information
+ * @type: tvlv handler type to look for
+ * @version: tvlv handler version to look for
+ *
+ * Returns tvlv handler if found or NULL otherwise.
+ */
+static struct batadv_tvlv_handler
+*batadv_tvlv_handler_get(struct batadv_priv *bat_priv,
+			 uint8_t type, uint8_t version)
+{
+	struct batadv_tvlv_handler *tvlv_handler_tmp, *tvlv_handler = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tvlv_handler_tmp,
+				 &bat_priv->tvlv.handler_list, list) {
+		if (tvlv_handler_tmp->type != type)
+			continue;
+
+		if (tvlv_handler_tmp->version != version)
+			continue;
+
+		if (!atomic_inc_not_zero(&tvlv_handler_tmp->refcount))
+			continue;
+
+		tvlv_handler = tvlv_handler_tmp;
+		break;
+	}
+	rcu_read_unlock();
+
+	return tvlv_handler;
+}
+
+/**
+ * batadv_tvlv_container_free_ref - decrement the tvlv container refcounter and
+ *  possibly free it
+ * @tvlv: the tvlv container to free
+ */
+static void batadv_tvlv_container_free_ref(struct batadv_tvlv_container *tvlv)
+{
+	if (atomic_dec_and_test(&tvlv->refcount))
+		kfree(tvlv);
+}
+
+/**
+ * batadv_tvlv_container_get - retrieve tvlv container from the tvlv container
+ *  list based on the provided type and version (both need to match)
+ * @bat_priv: the bat priv with all the soft interface information
+ * @type: tvlv container type to look for
+ * @version: tvlv container version to look for
+ *
+ * Has to be called with the appropriate locks being acquired
+ * (tvlv.container_list_lock).
+ *
+ * Returns tvlv container if found or NULL otherwise.
+ */
+static struct batadv_tvlv_container
+*batadv_tvlv_container_get(struct batadv_priv *bat_priv,
+			   uint8_t type, uint8_t version)
+{
+	struct batadv_tvlv_container *tvlv_tmp, *tvlv = NULL;
+
+	hlist_for_each_entry(tvlv_tmp, &bat_priv->tvlv.container_list, list) {
+		if (tvlv_tmp->tvlv_hdr.type != type)
+			continue;
+
+		if (tvlv_tmp->tvlv_hdr.version != version)
+			continue;
+
+		if (!atomic_inc_not_zero(&tvlv_tmp->refcount))
+			continue;
+
+		tvlv = tvlv_tmp;
+		break;
+	}
+
+	return tvlv;
+}
+
+/**
+ * batadv_tvlv_container_list_size - calculate the size of the tvlv container
+ *  list entries
+ * @bat_priv: the bat priv with all the soft interface information
+ *
+ * Has to be called with the appropriate locks being acquired
+ * (tvlv.container_list_lock).
+ *
+ * Returns size of all currently registered tvlv containers in bytes.
+ */
+static uint16_t batadv_tvlv_container_list_size(struct batadv_priv *bat_priv)
+{
+	struct batadv_tvlv_container *tvlv;
+	uint16_t tvlv_len = 0;
+
+	hlist_for_each_entry(tvlv, &bat_priv->tvlv.container_list, list) {
+		tvlv_len += sizeof(struct batadv_tvlv_hdr);
+		tvlv_len += ntohs(tvlv->tvlv_hdr.len);
+	}
+
+	return tvlv_len;
+}
+
+/**
+ * batadv_tvlv_container_remove - remove tvlv container from the tvlv container
+ *  list
+ * @tvlv: the to be removed tvlv container
+ *
+ * Has to be called with the appropriate locks being acquired
+ * (tvlv.container_list_lock).
+ */
+static void batadv_tvlv_container_remove(struct batadv_tvlv_container *tvlv)
+{
+	if (!tvlv)
+		return;
+
+	hlist_del(&tvlv->list);
+
+	/* first call to decrement the counter, second call to free */
+	batadv_tvlv_container_free_ref(tvlv);
+	batadv_tvlv_container_free_ref(tvlv);
+}
+
+/**
+ * batadv_tvlv_container_unregister - unregister tvlv container based on the
+ *  provided type and version (both need to match)
+ * @bat_priv: the bat priv with all the soft interface information
+ * @type: tvlv container type to unregister
+ * @version: tvlv container type to unregister
+ */
+void batadv_tvlv_container_unregister(struct batadv_priv *bat_priv,
+				      uint8_t type, uint8_t version)
+{
+	struct batadv_tvlv_container *tvlv;
+
+	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
+	tvlv = batadv_tvlv_container_get(bat_priv, type, version);
+	batadv_tvlv_container_remove(tvlv);
+	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
+}
+
+/**
+ * batadv_tvlv_container_register - register tvlv type, version and content
+ *  to be propagated with each (primary interface) OGM
+ * @bat_priv: the bat priv with all the soft interface information
+ * @type: tvlv container type
+ * @version: tvlv container version
+ * @tvlv_value: tvlv container content
+ * @tvlv_value_len: tvlv container content length
+ *
+ * If a container of the same type and version was already registered the new
+ * content is going to replace the old one.
+ */
+void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
+				    uint8_t type, uint8_t version,
+				    void *tvlv_value, uint16_t tvlv_value_len)
+{
+	struct batadv_tvlv_container *tvlv_old, *tvlv_new;
+
+	if (!tvlv_value)
+		tvlv_value_len = 0;
+
+	tvlv_new = kzalloc(sizeof(*tvlv_new) + tvlv_value_len, GFP_ATOMIC);
+	if (!tvlv_new)
+		return;
+
+	tvlv_new->tvlv_hdr.version = version;
+	tvlv_new->tvlv_hdr.type = type;
+	tvlv_new->tvlv_hdr.len = htons(tvlv_value_len);
+
+	memcpy(tvlv_new + 1, tvlv_value, ntohs(tvlv_new->tvlv_hdr.len));
+	INIT_HLIST_NODE(&tvlv_new->list);
+	atomic_set(&tvlv_new->refcount, 1);
+
+	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
+	tvlv_old = batadv_tvlv_container_get(bat_priv, type, version);
+	batadv_tvlv_container_remove(tvlv_old);
+	hlist_add_head(&tvlv_new->list, &bat_priv->tvlv.container_list);
+	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
+}
+
+/**
+ * batadv_tvlv_realloc_packet_buff - reallocate packet buffer to accomodate
+ *  requested packet size
+ * @packet_buff: packet buffer
+ * @packet_buff_len: packet buffer size
+ * @min_packet_len: requested packet minimum size
+ * @additional_packet_len: requested additional packet size on top of minimum
+ *  size
+ *
+ * Returns true of the packet buffer could be changed to the requested size,
+ * false otherwise.
+ */
+static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
+					    int *packet_buff_len,
+					    int min_packet_len,
+					    int additional_packet_len)
+{
+	unsigned char *new_buff;
+
+	new_buff = kmalloc(min_packet_len + additional_packet_len, GFP_ATOMIC);
+
+	/* keep old buffer if kmalloc should fail */
+	if (!new_buff)
+		return false;
+
+	memcpy(new_buff, *packet_buff, min_packet_len);
+	kfree(*packet_buff);
+	*packet_buff = new_buff;
+	*packet_buff_len = min_packet_len + additional_packet_len;
+
+	return true;
+}
+
+/**
+ * batadv_tvlv_container_ogm_append - append tvlv container content to given
+ *  OGM packet buffer
+ * @bat_priv: the bat priv with all the soft interface information
+ * @packet_buff: ogm packet buffer
+ * @packet_buff_len: ogm packet buffer size including ogm header and tvlv
+ *  content
+ * @packet_min_len: ogm header size to be preserved for the OGM itself
+ *
+ * The ogm packet might be enlarged or shrunk depending on the current size
+ * and the size of the to-be-appended tvlv containers.
+ *
+ * Returns size of all appended tvlv containers in bytes.
+ */
+uint16_t batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
+					  unsigned char **packet_buff,
+					  int *packet_buff_len,
+					  int packet_min_len)
+{
+	struct batadv_tvlv_container *tvlv;
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	uint16_t tvlv_value_len;
+	void *tvlv_value;
+	bool ret;
+
+	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
+	tvlv_value_len = batadv_tvlv_container_list_size(bat_priv);
+
+	ret = batadv_tvlv_realloc_packet_buff(packet_buff, packet_buff_len,
+					      packet_min_len, tvlv_value_len);
+
+	if (!ret)
+		goto end;
+
+	if (!tvlv_value_len)
+		goto end;
+
+	tvlv_value = (*packet_buff) + packet_min_len;
+
+	hlist_for_each_entry(tvlv, &bat_priv->tvlv.container_list, list) {
+		tvlv_hdr = tvlv_value;
+		tvlv_hdr->type = tvlv->tvlv_hdr.type;
+		tvlv_hdr->version = tvlv->tvlv_hdr.version;
+		tvlv_hdr->len = tvlv->tvlv_hdr.len;
+		tvlv_value = tvlv_hdr + 1;
+		memcpy(tvlv_value, tvlv + 1, ntohs(tvlv->tvlv_hdr.len));
+		tvlv_value = (uint8_t *)tvlv_value + ntohs(tvlv->tvlv_hdr.len);
+	}
+
+end:
+	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
+	return tvlv_value_len;
+}
+
+/**
+ * batadv_tvlv_call_handler - parse the given tvlv buffer to call the
+ *  appropriate handlers
+ * @bat_priv: the bat priv with all the soft interface information
+ * @tvlv_handler: tvlv callback function handling the tvlv content
+ * @ogm_source: flag indicating wether the tvlv is an ogm or a unicast packet
+ * @orig_node: orig node emitting the ogm packet
+ * @src: source mac address of the unicast packet
+ * @dst: destination mac address of the unicast packet
+ * @tvlv_value: tvlv content
+ * @tvlv_value_len: tvlv content length
+ *
+ * Returns success if handler was not found or the return value of the handler
+ * callback.
+ */
+static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
+				    struct batadv_tvlv_handler *tvlv_handler,
+				    bool ogm_source,
+				    struct batadv_orig_node *orig_node,
+				    uint8_t *src, uint8_t *dst,
+				    void *tvlv_value, uint16_t tvlv_value_len)
+{
+	if (!tvlv_handler)
+		return NET_RX_SUCCESS;
+
+	if (ogm_source) {
+		if (!tvlv_handler->ogm_handler)
+			return NET_RX_SUCCESS;
+
+		if (!orig_node)
+			return NET_RX_SUCCESS;
+
+		tvlv_handler->ogm_handler(bat_priv, orig_node,
+					  BATADV_NO_FLAGS,
+					  tvlv_value, tvlv_value_len);
+		tvlv_handler->flags |= BATADV_TVLV_HANDLER_OGM_CALLED;
+	} else {
+		if (!src)
+			return NET_RX_SUCCESS;
+
+		if (!dst)
+			return NET_RX_SUCCESS;
+
+		if (!tvlv_handler->unicast_handler)
+			return NET_RX_SUCCESS;
+
+		return tvlv_handler->unicast_handler(bat_priv, src,
+						     dst, tvlv_value,
+						     tvlv_value_len);
+	}
+
+	return NET_RX_SUCCESS;
+}
+
+/**
+ * batadv_tvlv_containers_process - parse the given tvlv buffer to call the
+ *  appropriate handlers
+ * @bat_priv: the bat priv with all the soft interface information
+ * @ogm_source: flag indicating wether the tvlv is an ogm or a unicast packet
+ * @orig_node: orig node emitting the ogm packet
+ * @src: source mac address of the unicast packet
+ * @dst: destination mac address of the unicast packet
+ * @tvlv_value: tvlv content
+ * @tvlv_value_len: tvlv content length
+ *
+ * Returns success when processing an OGM or the return value of all called
+ * handler callbacks.
+ */
+int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
+				   bool ogm_source,
+				   struct batadv_orig_node *orig_node,
+				   uint8_t *src, uint8_t *dst,
+				   void *tvlv_value, uint16_t tvlv_value_len)
+{
+	struct batadv_tvlv_handler *tvlv_handler;
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	uint16_t tvlv_value_cont_len;
+	uint8_t cifnotfound = BATADV_TVLV_HANDLER_OGM_CIFNOTFND;
+	int ret = NET_RX_SUCCESS;
+
+	while (tvlv_value_len >= sizeof(*tvlv_hdr)) {
+		tvlv_hdr = tvlv_value;
+		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
+		tvlv_value = tvlv_hdr + 1;
+		tvlv_value_len -= sizeof(*tvlv_hdr);
+
+		if (tvlv_value_cont_len > tvlv_value_len)
+			break;
+
+		tvlv_handler = batadv_tvlv_handler_get(bat_priv,
+						       tvlv_hdr->type,
+						       tvlv_hdr->version);
+
+		ret |= batadv_tvlv_call_handler(bat_priv, tvlv_handler,
+						ogm_source, orig_node,
+						src, dst, tvlv_value,
+						tvlv_value_cont_len);
+		if (tvlv_handler)
+			batadv_tvlv_handler_free_ref(tvlv_handler);
+		tvlv_value = (uint8_t *)tvlv_value + tvlv_value_cont_len;
+		tvlv_value_len -= tvlv_value_cont_len;
+	}
+
+	if (!ogm_source)
+		return ret;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tvlv_handler,
+				 &bat_priv->tvlv.handler_list, list) {
+		if ((tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND) &&
+		    !(tvlv_handler->flags & BATADV_TVLV_HANDLER_OGM_CALLED))
+			tvlv_handler->ogm_handler(bat_priv, orig_node,
+						  cifnotfound, NULL, 0);
+
+		tvlv_handler->flags &= ~BATADV_TVLV_HANDLER_OGM_CALLED;
+	}
+	rcu_read_unlock();
+
+	return NET_RX_SUCCESS;
+}
+
+/**
+ * batadv_tvlv_ogm_receive - process an incoming ogm and call the appropriate
+ *  handlers
+ * @bat_priv: the bat priv with all the soft interface information
+ * @batadv_ogm_packet: ogm packet containing the tvlv containers
+ * @orig_node: orig node emitting the ogm packet
+ */
+void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
+			     struct batadv_ogm_packet *batadv_ogm_packet,
+			     struct batadv_orig_node *orig_node)
+{
+	void *tvlv_value;
+	uint16_t tvlv_value_len;
+
+	if (!batadv_ogm_packet)
+		return;
+
+	tvlv_value_len = ntohs(batadv_ogm_packet->tvlv_len);
+	if (!tvlv_value_len)
+		return;
+
+	tvlv_value = batadv_ogm_packet + 1;
+
+	batadv_tvlv_containers_process(bat_priv, true, orig_node, NULL, NULL,
+				       tvlv_value, tvlv_value_len);
+}
+
+/**
+ * batadv_tvlv_handler_register - register tvlv handler based on the provided
+ *  type and version (both need to match) for ogm tvlv payload and/or unicast
+ *  payload
+ * @bat_priv: the bat priv with all the soft interface information
+ * @optr: ogm tvlv handler callback function. This function receives the orig
+ *  node, flags and the tvlv content as argument to process.
+ * @uptr: unicast tvlv handler callback function. This function receives the
+ *  source & destination of the unicast packet as well as the tvlv content
+ *  to process.
+ * @type: tvlv handler type to be registered
+ * @version: tvlv handler version to be registered
+ * @flags: flags to enable or disable TVLV API behavior
+ */
+void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
+				  void (*optr)(struct batadv_priv *bat_priv,
+					       struct batadv_orig_node *orig,
+					       uint8_t flags,
+					       void *tvlv_value,
+					       uint16_t tvlv_value_len),
+				  int (*uptr)(struct batadv_priv *bat_priv,
+					      uint8_t *src, uint8_t *dst,
+					      void *tvlv_value,
+					      uint16_t tvlv_value_len),
+				  uint8_t type, uint8_t version, uint8_t flags)
+{
+	struct batadv_tvlv_handler *tvlv_handler;
+
+	tvlv_handler = batadv_tvlv_handler_get(bat_priv, type, version);
+	if (tvlv_handler) {
+		batadv_tvlv_handler_free_ref(tvlv_handler);
+		return;
+	}
+
+	tvlv_handler = kzalloc(sizeof(*tvlv_handler), GFP_ATOMIC);
+	if (!tvlv_handler)
+		return;
+
+	tvlv_handler->ogm_handler = optr;
+	tvlv_handler->unicast_handler = uptr;
+	tvlv_handler->type = type;
+	tvlv_handler->version = version;
+	tvlv_handler->flags = flags;
+	atomic_set(&tvlv_handler->refcount, 1);
+	INIT_HLIST_NODE(&tvlv_handler->list);
+
+	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
+	hlist_add_head_rcu(&tvlv_handler->list, &bat_priv->tvlv.handler_list);
+	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
+}
+
+/**
+ * batadv_tvlv_handler_unregister - unregister tvlv handler based on the
+ *  provided type and version (both need to match)
+ * @bat_priv: the bat priv with all the soft interface information
+ * @type: tvlv handler type to be unregistered
+ * @version: tvlv handler version to be unregistered
+ */
+void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
+				    uint8_t type, uint8_t version)
+{
+	struct batadv_tvlv_handler *tvlv_handler;
+
+	tvlv_handler = batadv_tvlv_handler_get(bat_priv, type, version);
+	if (!tvlv_handler)
+		return;
+
+	batadv_tvlv_handler_free_ref(tvlv_handler);
+	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
+	hlist_del_rcu(&tvlv_handler->list);
+	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
+	batadv_tvlv_handler_free_ref(tvlv_handler);
+}
+
+/**
+ * batadv_tvlv_unicast_send - send a unicast packet with tvlv payload to the
+ *  specified host
+ * @bat_priv: the bat priv with all the soft interface information
+ * @src: source mac address of the unicast packet
+ * @dst: destination mac address of the unicast packet
+ * @type: tvlv type
+ * @version: tvlv version
+ * @tvlv_value: tvlv content
+ * @tvlv_value_len: tvlv content length
+ */
+void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
+			      uint8_t *dst, uint8_t type, uint8_t version,
+			      void *tvlv_value, uint16_t tvlv_value_len)
+{
+	struct batadv_unicast_tvlv_packet *unicast_tvlv_packet;
+	struct batadv_tvlv_hdr *tvlv_hdr;
+	struct batadv_orig_node *orig_node;
+	struct sk_buff *skb = NULL;
+	unsigned char *tvlv_buff;
+	unsigned int tvlv_len;
+	ssize_t hdr_len = sizeof(*unicast_tvlv_packet);
+	bool ret = false;
+
+	orig_node = batadv_orig_hash_find(bat_priv, dst);
+	if (!orig_node)
+		goto out;
+
+	tvlv_len = sizeof(*tvlv_hdr) + tvlv_value_len;
+
+	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + hdr_len + tvlv_len);
+	if (!skb)
+		goto out;
+
+	skb->priority = TC_PRIO_CONTROL;
+	skb_reserve(skb, ETH_HLEN);
+	tvlv_buff = skb_put(skb, sizeof(*unicast_tvlv_packet) + tvlv_len);
+	unicast_tvlv_packet = (struct batadv_unicast_tvlv_packet *)tvlv_buff;
+	unicast_tvlv_packet->packet_type = BATADV_UNICAST_TVLV;
+	unicast_tvlv_packet->version = BATADV_COMPAT_VERSION;
+	unicast_tvlv_packet->ttl = BATADV_TTL;
+	unicast_tvlv_packet->reserved = 0;
+	unicast_tvlv_packet->tvlv_len = htons(tvlv_len);
+	unicast_tvlv_packet->align = 0;
+	ether_addr_copy(unicast_tvlv_packet->src, src);
+	ether_addr_copy(unicast_tvlv_packet->dst, dst);
+
+	tvlv_buff = (unsigned char *)(unicast_tvlv_packet + 1);
+	tvlv_hdr = (struct batadv_tvlv_hdr *)tvlv_buff;
+	tvlv_hdr->version = version;
+	tvlv_hdr->type = type;
+	tvlv_hdr->len = htons(tvlv_value_len);
+	tvlv_buff += sizeof(*tvlv_hdr);
+	memcpy(tvlv_buff, tvlv_value, tvlv_value_len);
+
+	if (batadv_send_skb_to_orig(skb, orig_node, NULL) != NET_XMIT_DROP)
+		ret = true;
+
+out:
+	if (skb && !ret)
+		kfree_skb(skb);
+	if (orig_node)
+		batadv_orig_node_free_ref(orig_node);
+}
diff --git a/tvlv.h b/tvlv.h
new file mode 100644
index 000000000000..26436c01bc78
--- /dev/null
+++ b/tvlv.h
@@ -0,0 +1,62 @@
+/* Copyright (C) 2007-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _NET_BATMAN_ADV_TVLV_H_
+#define _NET_BATMAN_ADV_TVLV_H_
+
+#include <linux/types.h>
+
+struct batadv_priv;
+struct batadv_ogm_packet;
+struct batadv_orig_node;
+
+void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
+				    uint8_t type, uint8_t version,
+				    void *tvlv_value, uint16_t tvlv_value_len);
+uint16_t batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
+					  unsigned char **packet_buff,
+					  int *packet_buff_len,
+					  int packet_min_len);
+void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
+			     struct batadv_ogm_packet *batadv_ogm_packet,
+			     struct batadv_orig_node *orig_node);
+void batadv_tvlv_container_unregister(struct batadv_priv *bat_priv,
+				      uint8_t type, uint8_t version);
+
+void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
+				  void (*optr)(struct batadv_priv *bat_priv,
+					       struct batadv_orig_node *orig,
+					       uint8_t flags,
+					       void *tvlv_value,
+					       uint16_t tvlv_value_len),
+				  int (*uptr)(struct batadv_priv *bat_priv,
+					      uint8_t *src, uint8_t *dst,
+					      void *tvlv_value,
+					      uint16_t tvlv_value_len),
+				  uint8_t type, uint8_t version, uint8_t flags);
+void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv,
+				    uint8_t type, uint8_t version);
+int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
+				   bool ogm_source,
+				   struct batadv_orig_node *orig_node,
+				   uint8_t *src, uint8_t *dst,
+				   void *tvlv_buff, uint16_t tvlv_buff_len);
+void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, uint8_t *src,
+			      uint8_t *dst, uint8_t type, uint8_t version,
+			      void *tvlv_value, uint16_t tvlv_value_len);
+
+#endif  /* _NET_BATMAN_ADV_TVLV_H_ */
-- 
2.1.3

