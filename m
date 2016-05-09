Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 09 May 2016 20:29:21 +0200
Message-ID: <1680132.z76VCK1c2R@bentobox>
In-Reply-To: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
References: <1462817239-18104-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1558777.t2NPrWuSP4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 00/12] netns and netlink support
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

--nextPart1558777.t2NPrWuSP4
Content-Type: multipart/mixed; boundary="nextPart1849581.vX7EfrdFzp"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart1849581.vX7EfrdFzp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 09 May 2016 20:07:07 Andrew Lunn wrote:
> This patchset completes netns support, by disabling debugfs entries
> when not in the default name space, and correctly handling interface
> stack loops when the parent is in a different name space.
> 
> It additionally adds netlink support for most of the information found
> in debugfs, and is netns awaire.

Attached is a tarball with the v4 version rebased on the two initial patches
from=20the tp_meter patchset. The patches include many TODOs in the kernel-doc
which should be replaced with actual docs.

The batctl patch was not yet rebased.

I've removed following change in your v4 patchset:

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 71b63e7..0455e54 100644
=2D-- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1416,7 +1416,8 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	int ret;
 	int ifindex, hard_ifindex;
 
=2D	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
+	ifindex = batadv_netlink_get_ifindex(cb->nlh,
+					     BATADV_ATTR_MESH_IFINDEX);
 	if (!ifindex)
 		return -EINVAL;

I've also added the diff between your patchset and the one attached tarball. I
hope you can see that nothing evil was done :)

Kind regards,
	Sven
=2D-nextPart1849581.vX7EfrdFzp
Content-Disposition: attachment; filename="rebased_split_netlink.tar.gz"
Content-Transfer-Encoding: base64
Content-Type: application/x-compressed-tar; name="rebased_split_netlink.tar.gz"

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
H3LUswEA4AEA

=2D-nextPart1849581.vX7EfrdFzp
Content-Disposition: attachment; filename="andrew_netlink-ecsv_netlink.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="andrew_netlink-ecsv_netlink.diff"

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e47274..ff0322d 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9,4 +9,5 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-net-batman-adv
 F:	Documentation/ABI/testing/sysfs-class-net-mesh
 F:	Documentation/networking/batman-adv.txt
+F:	include/uapi/linux/batman_adv.h
 F:	net/batman-adv/
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 6a97a2c..4c8e526 100644
=2D-- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -56,7 +56,44 @@ enum batadv_tt_client_flags {
 	BATADV_TT_CLIENT_TEMP	 = (1 << 11),
 };
 
=2Denum {
+/**
+ * enum batadv_nl_attrs - batman-adv netlink attributes
+ *
+ * @BATADV_ATTR_UNSPEC: unspecified attribute to catch errors
+ * @BATADV_ATTR_VERSION: batman-adv version string
+ * @BATADV_ATTR_ALGO_NAME: name of routing algorithm
+ * @BATADV_ATTR_MESH_IFINDEX: index of the batman-adv interface
+ * @BATADV_ATTR_MESH_IFNAME: name of the batman-adv interface
+ * @BATADV_ATTR_MESH_ADDRESS: mac address of the batman-adv interface
+ * @BATADV_ATTR_HARD_IFINDEX: index of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_IFNAME: name of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_ADDRESS: mac address of the non-batman-adv interface
+ * @BATADV_ATTR_ACTIVE: TODO
+ * @BATADV_ATTR_ORIG_ADDRESS: TODO
+ * @BATADV_ATTR_TT_ADDRESS: TODO
+ * @BATADV_ATTR_TT_TTVN: TODO
+ * @BATADV_ATTR_TT_LAST_TTVN: TODO
+ * @BATADV_ATTR_TT_CRC32: TODO
+ * @BATADV_ATTR_TT_VID: TODO
+ * @BATADV_ATTR_TT_FLAGS: TODO
+ * @BATADV_ATTR_FLAG_BEST: TODO
+ * @BATADV_ATTR_LAST_SEEN_MSECS: TODO
+ * @BATADV_ATTR_NEIGH_ADDRESS: TODO
+ * @BATADV_ATTR_TQ: TODO
+ * @BATADV_ATTR_THROUGHPUT: TODO
+ * @BATADV_ATTR_BANDWIDTH_UP: TODO
+ * @BATADV_ATTR_BANDWIDTH_DOWN: TODO
+ * @BATADV_ATTR_ROUTER: TODO
+ * @BATADV_ATTR_BLA_OWN: TODO
+ * @BATADV_ATTR_BLA_ADDRESS: TODO
+ * @BATADV_ATTR_BLA_VID: TODO
+ * @BATADV_ATTR_BLA_BACKBONE: TODO
+ * @BATADV_ATTR_BLA_CRC: TODO
+ * @__BATADV_ATTR_AFTER_LAST: internal use
+ * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
+ * @BATADV_ATTR_MAX: highest attribute number currently defined
+ */
+enum batadv_nl_attrs {
 	BATADV_ATTR_UNSPEC,
 	BATADV_ATTR_VERSION,
 	BATADV_ATTR_ALGO_NAME,
@@ -87,15 +124,32 @@ enum {
 	BATADV_ATTR_BLA_VID,
 	BATADV_ATTR_BLA_BACKBONE,
 	BATADV_ATTR_BLA_CRC,
=2D	__BATADV_ATTR_MAX,
+	/* add attributes above here, update the policy in netlink.c */
+	__BATADV_ATTR_AFTER_LAST,
+	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
+	BATADV_ATTR_MAX = __BATADV_ATTR_AFTER_LAST - 1
 };
 
=2D#define BATADV_ATTR_MAX (__BATADV_ATTR_MAX - 1)
=2D
=2Denum {
+/**
+ * enum batadv_nl_commands - supported batman-adv netlink commands
+ *
+ * @BATADV_CMD_UNSPEC: unspecified command to catch errors
+ * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv device
+ * @BATADV_CMD_GET_ROUTING_ALGOS: TODO
+ * @BATADV_CMD_GET_HARDIFS: TODO
+ * @BATADV_CMD_GET_TRANSTABLE_LOCAL: TODO
+ * @BATADV_CMD_GET_TRANSTABLE_GLOBAL: TODO
+ * @BATADV_CMD_GET_ORIGINATORS: TODO
+ * @BATADV_CMD_GET_NEIGHBORS: TODO
+ * @BATADV_CMD_GET_GATEWAYS: TODO
+ * @BATADV_CMD_GET_BLA_CLAIM: TODO
+ * @__BATADV_CMD_AFTER_LAST: internal use
+ * @BATADV_CMD_MAX: highest used command number
+ */
+enum batadv_nl_commands {
 	BATADV_CMD_UNSPEC,
=2D	BATADV_CMD_GET_ROUTING_ALGOS,
 	BATADV_CMD_GET_MESH_INFO,
+	BATADV_CMD_GET_ROUTING_ALGOS,
 	BATADV_CMD_GET_HARDIFS,
 	BATADV_CMD_GET_TRANSTABLE_LOCAL,
 	BATADV_CMD_GET_TRANSTABLE_GLOBAL,
@@ -103,9 +157,9 @@ enum {
 	BATADV_CMD_GET_NEIGHBORS,
 	BATADV_CMD_GET_GATEWAYS,
 	BATADV_CMD_GET_BLA_CLAIM,
=2D	__BATADV_CMD_MAX,
+	/* add new commands above here */
+	__BATADV_CMD_AFTER_LAST,
+	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
 };
 
=2D#define BATADV_CMD_MAX (__BATADV_CMD_MAX - 1)
=2D
 #endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 9abfdbb..0558ed2 100644
=2D-- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1980,6 +1980,14 @@ next:
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+/**
+ * batadv_iv_ogm_neigh_get_tq_avg - TODO
+ * @neigh_node: TODO
+ * @if_outgoing: TODO
+ * @tq_avg: TODO
+ *
+ * Return: TODO
+ */
 static bool
 batadv_iv_ogm_neigh_get_tq_avg(struct batadv_neigh_node *neigh_node,
 			       struct batadv_hard_iface *if_outgoing,
@@ -1997,6 +2005,19 @@ batadv_iv_ogm_neigh_get_tq_avg(struct batadv_neigh_node *neigh_node,
 	return true;
 }
 
+/**
+ * batadv_iv_ogm_orig_dump_subentry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @orig_node: TODO
+ * @neigh_node: TODO
+ * @best: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_iv_ogm_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 				 struct batadv_priv *bat_priv,
@@ -2045,6 +2066,18 @@ batadv_iv_ogm_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_iv_ogm_orig_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @orig_node: TODO
+ * @sub_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_iv_ogm_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			      struct batadv_priv *bat_priv,
@@ -2093,6 +2126,19 @@ batadv_iv_ogm_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_iv_ogm_orig_dump_bucket - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @head: TODO
+ * @idx_s: TODO
+ * @sub: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_iv_ogm_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_priv *bat_priv,
@@ -2122,6 +2168,13 @@ batadv_iv_ogm_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_iv_ogm_orig_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ */
 static void
 batadv_iv_ogm_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
 			struct batadv_priv *bat_priv,
@@ -2202,6 +2255,15 @@ static void batadv_iv_neigh_print(struct batadv_priv *bat_priv,
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+/**
+ * batadv_iv_ogm_neigh_dump_neigh - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @hardif_neigh: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_hardif_neigh_node *hardif_neigh)
@@ -2232,6 +2294,17 @@ batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_iv_ogm_neigh_dump_hardif - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @hard_iface: TODO
+ * @idx_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_iv_ogm_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 				struct batadv_priv *bat_priv,
@@ -2257,6 +2330,13 @@ batadv_iv_ogm_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_iv_ogm_neigh_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ * @bat_priv: TODO
+ * @single_hardif: TODO
+ */
 static void
 batadv_iv_ogm_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 			 struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 5daa300..e244b5f 100644
=2D-- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -212,6 +212,15 @@ static void batadv_v_neigh_print(struct batadv_priv *bat_priv,
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+/**
+ * batadv_v_neigh_dump_neigh - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @hardif_neigh: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			  struct batadv_hardif_neigh_node *hardif_neigh)
@@ -246,6 +255,17 @@ batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_v_neigh_dump_hardif - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @hard_iface: TODO
+ * @idx_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_v_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 			   struct batadv_priv *bat_priv,
@@ -270,6 +290,13 @@ batadv_v_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_v_neigh_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ * @bat_priv: TODO
+ * @single_hardif: TODO
+ */
 static void
 batadv_v_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 		    struct batadv_priv *bat_priv,
@@ -380,6 +407,19 @@ next:
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+/**
+ * batadv_v_orig_dump_subentry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @orig_node: TODO
+ * @neigh_node: TODO
+ * @best: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 			    struct batadv_priv *bat_priv,
@@ -434,6 +474,18 @@ batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_v_orig_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @orig_node: TODO
+ * @sub_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_v_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			 struct batadv_priv *bat_priv,
@@ -473,6 +525,19 @@ batadv_v_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_v_orig_dump_bucket - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @head: TODO
+ * @idx_s: TODO
+ * @sub: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_v_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 			  struct batadv_priv *bat_priv,
@@ -501,6 +566,13 @@ batadv_v_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_v_orig_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ */
 static void
 batadv_v_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
 		   struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 7f38aea..dedf89e 100644
=2D-- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -670,6 +670,16 @@ out:
 	return 0;
 }
 
+/**
+ * batadv_gw_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @gw_node: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 		     struct batadv_priv *bat_priv,
@@ -732,6 +742,13 @@ out:
 	return ret;
 }
 
+/**
+ * batadv_gw_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ *
+ * Return: TODO
+ */
 int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 3127d28..7683da4 100644
=2D-- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -615,6 +615,15 @@ int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+/**
+ * batadv_algo_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_algo_ops: TODO
+ *
+ * Return: TODO
+ */
 static int batadv_algo_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 				  struct batadv_algo_ops *bat_algo_ops)
 {
@@ -636,6 +645,13 @@ static int batadv_algo_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_algo_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ *
+ * Return: TODO
+ */
 int batadv_algo_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	int portid = NETLINK_CB(cb->skb).portid;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 671d5b6..c68497f 100644
=2D-- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -20,6 +20,7 @@
 
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/genetlink.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/netdevice.h>
@@ -30,6 +31,8 @@
 #include <linux/skbuff.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -49,13 +52,51 @@ struct genl_family batadv_netlink_family = {
 	.netnsok = true,
 };
 
+static struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
+	[BATADV_ATTR_VERSION]		= { .type = NLA_STRING },
+	[BATADV_ATTR_ALGO_NAME]		= { .type = NLA_STRING },
+	[BATADV_ATTR_MESH_IFINDEX]	= { .type = NLA_U32 },
+	[BATADV_ATTR_MESH_IFNAME]	= { .type = NLA_STRING },
+	[BATADV_ATTR_MESH_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_HARD_IFINDEX]	= { .type = NLA_U32 },
+	[BATADV_ATTR_HARD_IFNAME]	= { .type = NLA_STRING },
+	[BATADV_ATTR_HARD_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_ACTIVE]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_ORIG_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_TT_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_TT_TTVN]		= { .type = NLA_U8 },
+	[BATADV_ATTR_TT_LAST_TTVN]	= { .type = NLA_U8 },
+	[BATADV_ATTR_TT_CRC32]		= { .type = NLA_U32 },
+	[BATADV_ATTR_TT_VID]		= { .type = NLA_U16 },
+	[BATADV_ATTR_TT_FLAGS]		= { .type = NLA_U32 },
+	[BATADV_ATTR_FLAG_BEST]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_LAST_SEEN_MSECS]	= { .type = NLA_U32 },
+	[BATADV_ATTR_NEIGH_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_TQ]		= { .type = NLA_U8 },
+	[BATADV_ATTR_BANDWIDTH_UP]	= { .type = NLA_U32 },
+	[BATADV_ATTR_BANDWIDTH_DOWN]	= { .type = NLA_U32 },
+	[BATADV_ATTR_ROUTER]		= { .len = ETH_ALEN },
+	[BATADV_ATTR_BLA_OWN]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_BLA_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_BLA_VID]		= { .type = NLA_U16 },
+	[BATADV_ATTR_BLA_BACKBONE]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_BLA_CRC]		= { .type = NLA_U16 },
+};
+
+/**
+ * batadv_netlink_mesh_info_put - Fill generic information about mesh interface
+ * @msg: netlink message to be sent back
+ * @soft_iface: interface for which the data should be taken
+ *
+ *  Return: 0 on success, < 0 on error
+ */
 static int
 batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
 {
=2D	int ret = -ENOBUFS;
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_hard_iface *primary_if = NULL;
 	struct net_device *hard_iface;
+	int ret = -ENOBUFS;
 
 	if (nla_put_string(msg, BATADV_ATTR_VERSION, BATADV_SOURCE_VERSION) ||
 	    nla_put_string(msg, BATADV_ATTR_ALGO_NAME,
@@ -88,15 +129,22 @@ batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
 	return ret;
 }
 
+/**
+ * batadv_netlink_mesh_info_put - Handle BATADV_CMD_GET_MESH_INFO
+ * @skb: received netlink message
+ * @info: receiver information
+ *
+ * Return: 0 on success, < 0 on error
+ */
 static int
 batadv_netlink_get_mesh_info(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
=2D	int ret;
+	struct net_device *soft_iface;
 	struct sk_buff *msg = NULL;
 	void *msg_head;
 	int ifindex;
=2D	struct net_device *soft_iface;
+	int ret;
 
 	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
 		return -EINVAL;
@@ -141,6 +189,15 @@ batadv_netlink_get_mesh_info(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+/**
+ * batadv_netlink_dump_hardif_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @hard_iface: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_netlink_dump_hardif_entry(struct sk_buff *msg, u32 portid, u32 seq,
 				 struct batadv_hard_iface *hard_iface)
@@ -174,6 +231,13 @@ batadv_netlink_dump_hardif_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_netlink_dump_hardifs - TODO
+ * @msg: TODO
+ * @cb: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
 {
@@ -224,23 +288,18 @@ batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
 	return msg->len;
 }
 
=2Dstatic struct nla_policy batadv_netlink_policy[BATADV_ATTR_MAX + 1] = {
=2D	[BATADV_ATTR_MESH_IFINDEX]	= { .type = NLA_U32 },
=2D	[BATADV_ATTR_HARD_IFINDEX]	= { .type = NLA_U32 },
=2D};
=2D
 static struct genl_ops batadv_netlink_ops[] = {
 	{
=2D		.cmd = BATADV_CMD_GET_ROUTING_ALGOS,
+		.cmd = BATADV_CMD_GET_MESH_INFO,
 		.flags = GENL_ADMIN_PERM,
 		.policy = batadv_netlink_policy,
=2D		.dumpit = batadv_algo_dump,
+		.doit = batadv_netlink_get_mesh_info,
 	},
 	{
=2D		.cmd = BATADV_CMD_GET_MESH_INFO,
+		.cmd = BATADV_CMD_GET_ROUTING_ALGOS,
 		.flags = GENL_ADMIN_PERM,
 		.policy = batadv_netlink_policy,
=2D		.doit = batadv_netlink_get_mesh_info,
+		.dumpit = batadv_algo_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_HARDIFS,
@@ -286,6 +345,9 @@ static struct genl_ops batadv_netlink_ops[] = {
 	},
 };
 
+/**
+ * batadv_netlink_register - Register batadv genl netlink family
+ */
 void __init batadv_netlink_register(void)
 {
 	int ret;
@@ -296,6 +358,9 @@ void __init batadv_netlink_register(void)
 		pr_warn("unable to register netlink family");
 }
 
+/**
+ * batadv_netlink_unregister - Unregister batadv genl netlink family
+ */
 void batadv_netlink_unregister(void)
 {
 	genl_unregister_family(&batadv_netlink_family);
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index ae0eeb9..89b7c5b 100644
=2D-- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -28,6 +28,13 @@ struct nlmsghdr;
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
 
+/**
+ * batadv_netlink_get_ifindex - TODO
+ * @nlh: TODO
+ * @attrtype: TODO
+ *
+ * Return: TODO
+ */
 static inline int
 batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
 {
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0455e54..71b63e7 100644
=2D-- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1416,8 +1416,7 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	int ret;
 	int ifindex, hard_ifindex;
 
=2D	ifindex = batadv_netlink_get_ifindex(cb->nlh,
=2D					     BATADV_ATTR_MESH_IFINDEX);
+	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
 	if (!ifindex)
 		return -EINVAL;
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index be42b12..6a1eba3 100644
=2D-- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1063,6 +1063,16 @@ out:
 	return 0;
 }
 
+/**
+ * batadv_tt_local_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @common: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			   struct batadv_priv *bat_priv,
@@ -1111,6 +1121,17 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_tt_local_dump_bucket - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @head: TODO
+ * @idx_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 			    struct batadv_priv *bat_priv,
@@ -1137,6 +1158,13 @@ batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_tt_local_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ *
+ * Return: TODO
+ */
 int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(cb->skb->sk);
@@ -1841,6 +1869,17 @@ out:
 	return 0;
 }
 
+/**
+ * batadv_tt_global_dump_subentry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @common: TODO
+ * @orig: TODO
+ * @best: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_tt_common_entry *common,
@@ -1890,6 +1929,17 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_tt_global_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @common: TODO
+ * @sub_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_tt_global_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			    struct batadv_priv *bat_priv,
@@ -1922,6 +1972,18 @@ batadv_tt_global_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_tt_global_dump_bucket - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @head: TODO
+ * @idx_s: TODO
+ * @sub: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_tt_global_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 			     struct batadv_priv *bat_priv,
@@ -1949,6 +2011,13 @@ batadv_tt_global_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_tt_global_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ *
+ * Return: TODO
+ */
 int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(cb->skb->sk);

=2D-nextPart1849581.vX7EfrdFzp--
This is a multi-part message in MIME format.

--nextPart1849581.vX7EfrdFzp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 09 May 2016 20:07:07 Andrew Lunn wrote:
> This patchset completes netns support, by disabling debugfs entries
> when not in the default name space, and correctly handling interface
> stack loops when the parent is in a different name space.
> 
> It additionally adds netlink support for most of the information found
> in debugfs, and is netns awaire.

Attached is a tarball with the v4 version rebased on the two initial patches
from the tp_meter patchset. The patches include many TODOs in the kernel-doc
which should be replaced with actual docs.

The batctl patch was not yet rebased.

I've removed following change in your v4 patchset:

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 71b63e7..0455e54 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1416,7 +1416,8 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	int ret;
 	int ifindex, hard_ifindex;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
+	ifindex = batadv_netlink_get_ifindex(cb->nlh,
+					     BATADV_ATTR_MESH_IFINDEX);
 	if (!ifindex)
 		return -EINVAL;

I've also added the diff between your patchset and the one attached tarball. I
hope you can see that nothing evil was done :)

Kind regards,
	Sven
--nextPart1849581.vX7EfrdFzp
Content-Disposition: attachment; filename="rebased_split_netlink.tar.gz"
Content-Transfer-Encoding: base64
Content-Type: application/x-compressed-tar; name="rebased_split_netlink.tar.gz"

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
H3LUswEA4AEA

--nextPart1849581.vX7EfrdFzp
Content-Disposition: attachment; filename="andrew_netlink-ecsv_netlink.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="andrew_netlink-ecsv_netlink.diff"

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e47274..ff0322d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9,4 +9,5 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-net-batman-adv
 F:	Documentation/ABI/testing/sysfs-class-net-mesh
 F:	Documentation/networking/batman-adv.txt
+F:	include/uapi/linux/batman_adv.h
 F:	net/batman-adv/
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 6a97a2c..4c8e526 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -56,7 +56,44 @@ enum batadv_tt_client_flags {
 	BATADV_TT_CLIENT_TEMP	 = (1 << 11),
 };
 
-enum {
+/**
+ * enum batadv_nl_attrs - batman-adv netlink attributes
+ *
+ * @BATADV_ATTR_UNSPEC: unspecified attribute to catch errors
+ * @BATADV_ATTR_VERSION: batman-adv version string
+ * @BATADV_ATTR_ALGO_NAME: name of routing algorithm
+ * @BATADV_ATTR_MESH_IFINDEX: index of the batman-adv interface
+ * @BATADV_ATTR_MESH_IFNAME: name of the batman-adv interface
+ * @BATADV_ATTR_MESH_ADDRESS: mac address of the batman-adv interface
+ * @BATADV_ATTR_HARD_IFINDEX: index of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_IFNAME: name of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_ADDRESS: mac address of the non-batman-adv interface
+ * @BATADV_ATTR_ACTIVE: TODO
+ * @BATADV_ATTR_ORIG_ADDRESS: TODO
+ * @BATADV_ATTR_TT_ADDRESS: TODO
+ * @BATADV_ATTR_TT_TTVN: TODO
+ * @BATADV_ATTR_TT_LAST_TTVN: TODO
+ * @BATADV_ATTR_TT_CRC32: TODO
+ * @BATADV_ATTR_TT_VID: TODO
+ * @BATADV_ATTR_TT_FLAGS: TODO
+ * @BATADV_ATTR_FLAG_BEST: TODO
+ * @BATADV_ATTR_LAST_SEEN_MSECS: TODO
+ * @BATADV_ATTR_NEIGH_ADDRESS: TODO
+ * @BATADV_ATTR_TQ: TODO
+ * @BATADV_ATTR_THROUGHPUT: TODO
+ * @BATADV_ATTR_BANDWIDTH_UP: TODO
+ * @BATADV_ATTR_BANDWIDTH_DOWN: TODO
+ * @BATADV_ATTR_ROUTER: TODO
+ * @BATADV_ATTR_BLA_OWN: TODO
+ * @BATADV_ATTR_BLA_ADDRESS: TODO
+ * @BATADV_ATTR_BLA_VID: TODO
+ * @BATADV_ATTR_BLA_BACKBONE: TODO
+ * @BATADV_ATTR_BLA_CRC: TODO
+ * @__BATADV_ATTR_AFTER_LAST: internal use
+ * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
+ * @BATADV_ATTR_MAX: highest attribute number currently defined
+ */
+enum batadv_nl_attrs {
 	BATADV_ATTR_UNSPEC,
 	BATADV_ATTR_VERSION,
 	BATADV_ATTR_ALGO_NAME,
@@ -87,15 +124,32 @@ enum {
 	BATADV_ATTR_BLA_VID,
 	BATADV_ATTR_BLA_BACKBONE,
 	BATADV_ATTR_BLA_CRC,
-	__BATADV_ATTR_MAX,
+	/* add attributes above here, update the policy in netlink.c */
+	__BATADV_ATTR_AFTER_LAST,
+	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
+	BATADV_ATTR_MAX = __BATADV_ATTR_AFTER_LAST - 1
 };
 
-#define BATADV_ATTR_MAX (__BATADV_ATTR_MAX - 1)
-
-enum {
+/**
+ * enum batadv_nl_commands - supported batman-adv netlink commands
+ *
+ * @BATADV_CMD_UNSPEC: unspecified command to catch errors
+ * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv device
+ * @BATADV_CMD_GET_ROUTING_ALGOS: TODO
+ * @BATADV_CMD_GET_HARDIFS: TODO
+ * @BATADV_CMD_GET_TRANSTABLE_LOCAL: TODO
+ * @BATADV_CMD_GET_TRANSTABLE_GLOBAL: TODO
+ * @BATADV_CMD_GET_ORIGINATORS: TODO
+ * @BATADV_CMD_GET_NEIGHBORS: TODO
+ * @BATADV_CMD_GET_GATEWAYS: TODO
+ * @BATADV_CMD_GET_BLA_CLAIM: TODO
+ * @__BATADV_CMD_AFTER_LAST: internal use
+ * @BATADV_CMD_MAX: highest used command number
+ */
+enum batadv_nl_commands {
 	BATADV_CMD_UNSPEC,
-	BATADV_CMD_GET_ROUTING_ALGOS,
 	BATADV_CMD_GET_MESH_INFO,
+	BATADV_CMD_GET_ROUTING_ALGOS,
 	BATADV_CMD_GET_HARDIFS,
 	BATADV_CMD_GET_TRANSTABLE_LOCAL,
 	BATADV_CMD_GET_TRANSTABLE_GLOBAL,
@@ -103,9 +157,9 @@ enum {
 	BATADV_CMD_GET_NEIGHBORS,
 	BATADV_CMD_GET_GATEWAYS,
 	BATADV_CMD_GET_BLA_CLAIM,
-	__BATADV_CMD_MAX,
+	/* add new commands above here */
+	__BATADV_CMD_AFTER_LAST,
+	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
 };
 
-#define BATADV_CMD_MAX (__BATADV_CMD_MAX - 1)
-
 #endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 9abfdbb..0558ed2 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1980,6 +1980,14 @@ next:
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+/**
+ * batadv_iv_ogm_neigh_get_tq_avg - TODO
+ * @neigh_node: TODO
+ * @if_outgoing: TODO
+ * @tq_avg: TODO
+ *
+ * Return: TODO
+ */
 static bool
 batadv_iv_ogm_neigh_get_tq_avg(struct batadv_neigh_node *neigh_node,
 			       struct batadv_hard_iface *if_outgoing,
@@ -1997,6 +2005,19 @@ batadv_iv_ogm_neigh_get_tq_avg(struct batadv_neigh_node *neigh_node,
 	return true;
 }
 
+/**
+ * batadv_iv_ogm_orig_dump_subentry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @orig_node: TODO
+ * @neigh_node: TODO
+ * @best: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_iv_ogm_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 				 struct batadv_priv *bat_priv,
@@ -2045,6 +2066,18 @@ batadv_iv_ogm_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_iv_ogm_orig_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @orig_node: TODO
+ * @sub_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_iv_ogm_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			      struct batadv_priv *bat_priv,
@@ -2093,6 +2126,19 @@ batadv_iv_ogm_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_iv_ogm_orig_dump_bucket - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @head: TODO
+ * @idx_s: TODO
+ * @sub: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_iv_ogm_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_priv *bat_priv,
@@ -2122,6 +2168,13 @@ batadv_iv_ogm_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_iv_ogm_orig_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ */
 static void
 batadv_iv_ogm_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
 			struct batadv_priv *bat_priv,
@@ -2202,6 +2255,15 @@ static void batadv_iv_neigh_print(struct batadv_priv *bat_priv,
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+/**
+ * batadv_iv_ogm_neigh_dump_neigh - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @hardif_neigh: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_hardif_neigh_node *hardif_neigh)
@@ -2232,6 +2294,17 @@ batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_iv_ogm_neigh_dump_hardif - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @hard_iface: TODO
+ * @idx_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_iv_ogm_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 				struct batadv_priv *bat_priv,
@@ -2257,6 +2330,13 @@ batadv_iv_ogm_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_iv_ogm_neigh_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ * @bat_priv: TODO
+ * @single_hardif: TODO
+ */
 static void
 batadv_iv_ogm_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 			 struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 5daa300..e244b5f 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -212,6 +212,15 @@ static void batadv_v_neigh_print(struct batadv_priv *bat_priv,
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+/**
+ * batadv_v_neigh_dump_neigh - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @hardif_neigh: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			  struct batadv_hardif_neigh_node *hardif_neigh)
@@ -246,6 +255,17 @@ batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_v_neigh_dump_hardif - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @hard_iface: TODO
+ * @idx_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_v_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 			   struct batadv_priv *bat_priv,
@@ -270,6 +290,13 @@ batadv_v_neigh_dump_hardif(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_v_neigh_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ * @bat_priv: TODO
+ * @single_hardif: TODO
+ */
 static void
 batadv_v_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb,
 		    struct batadv_priv *bat_priv,
@@ -380,6 +407,19 @@ next:
 		seq_puts(seq, "No batman nodes in range ...\n");
 }
 
+/**
+ * batadv_v_orig_dump_subentry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @orig_node: TODO
+ * @neigh_node: TODO
+ * @best: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 			    struct batadv_priv *bat_priv,
@@ -434,6 +474,18 @@ batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_v_orig_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @orig_node: TODO
+ * @sub_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_v_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			 struct batadv_priv *bat_priv,
@@ -473,6 +525,19 @@ batadv_v_orig_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_v_orig_dump_bucket - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ * @head: TODO
+ * @idx_s: TODO
+ * @sub: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_v_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 			  struct batadv_priv *bat_priv,
@@ -501,6 +566,13 @@ batadv_v_orig_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_v_orig_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ * @bat_priv: TODO
+ * @if_outgoing: TODO
+ */
 static void
 batadv_v_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
 		   struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 7f38aea..dedf89e 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -670,6 +670,16 @@ out:
 	return 0;
 }
 
+/**
+ * batadv_gw_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @gw_node: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 		     struct batadv_priv *bat_priv,
@@ -732,6 +742,13 @@ out:
 	return ret;
 }
 
+/**
+ * batadv_gw_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ *
+ * Return: TODO
+ */
 int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct batadv_hard_iface *primary_if = NULL;
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 3127d28..7683da4 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -615,6 +615,15 @@ int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+/**
+ * batadv_algo_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_algo_ops: TODO
+ *
+ * Return: TODO
+ */
 static int batadv_algo_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 				  struct batadv_algo_ops *bat_algo_ops)
 {
@@ -636,6 +645,13 @@ static int batadv_algo_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_algo_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ *
+ * Return: TODO
+ */
 int batadv_algo_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	int portid = NETLINK_CB(cb->skb).portid;
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 671d5b6..c68497f 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -20,6 +20,7 @@
 
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/genetlink.h>
 #include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/netdevice.h>
@@ -30,6 +31,8 @@
 #include <linux/skbuff.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
@@ -49,13 +52,51 @@ struct genl_family batadv_netlink_family = {
 	.netnsok = true,
 };
 
+static struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
+	[BATADV_ATTR_VERSION]		= { .type = NLA_STRING },
+	[BATADV_ATTR_ALGO_NAME]		= { .type = NLA_STRING },
+	[BATADV_ATTR_MESH_IFINDEX]	= { .type = NLA_U32 },
+	[BATADV_ATTR_MESH_IFNAME]	= { .type = NLA_STRING },
+	[BATADV_ATTR_MESH_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_HARD_IFINDEX]	= { .type = NLA_U32 },
+	[BATADV_ATTR_HARD_IFNAME]	= { .type = NLA_STRING },
+	[BATADV_ATTR_HARD_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_ACTIVE]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_ORIG_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_TT_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_TT_TTVN]		= { .type = NLA_U8 },
+	[BATADV_ATTR_TT_LAST_TTVN]	= { .type = NLA_U8 },
+	[BATADV_ATTR_TT_CRC32]		= { .type = NLA_U32 },
+	[BATADV_ATTR_TT_VID]		= { .type = NLA_U16 },
+	[BATADV_ATTR_TT_FLAGS]		= { .type = NLA_U32 },
+	[BATADV_ATTR_FLAG_BEST]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_LAST_SEEN_MSECS]	= { .type = NLA_U32 },
+	[BATADV_ATTR_NEIGH_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_TQ]		= { .type = NLA_U8 },
+	[BATADV_ATTR_BANDWIDTH_UP]	= { .type = NLA_U32 },
+	[BATADV_ATTR_BANDWIDTH_DOWN]	= { .type = NLA_U32 },
+	[BATADV_ATTR_ROUTER]		= { .len = ETH_ALEN },
+	[BATADV_ATTR_BLA_OWN]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_BLA_ADDRESS]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_BLA_VID]		= { .type = NLA_U16 },
+	[BATADV_ATTR_BLA_BACKBONE]	= { .len = ETH_ALEN },
+	[BATADV_ATTR_BLA_CRC]		= { .type = NLA_U16 },
+};
+
+/**
+ * batadv_netlink_mesh_info_put - Fill generic information about mesh interface
+ * @msg: netlink message to be sent back
+ * @soft_iface: interface for which the data should be taken
+ *
+ *  Return: 0 on success, < 0 on error
+ */
 static int
 batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
 {
-	int ret = -ENOBUFS;
 	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
 	struct batadv_hard_iface *primary_if = NULL;
 	struct net_device *hard_iface;
+	int ret = -ENOBUFS;
 
 	if (nla_put_string(msg, BATADV_ATTR_VERSION, BATADV_SOURCE_VERSION) ||
 	    nla_put_string(msg, BATADV_ATTR_ALGO_NAME,
@@ -88,15 +129,22 @@ batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
 	return ret;
 }
 
+/**
+ * batadv_netlink_mesh_info_put - Handle BATADV_CMD_GET_MESH_INFO
+ * @skb: received netlink message
+ * @info: receiver information
+ *
+ * Return: 0 on success, < 0 on error
+ */
 static int
 batadv_netlink_get_mesh_info(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
-	int ret;
+	struct net_device *soft_iface;
 	struct sk_buff *msg = NULL;
 	void *msg_head;
 	int ifindex;
-	struct net_device *soft_iface;
+	int ret;
 
 	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
 		return -EINVAL;
@@ -141,6 +189,15 @@ batadv_netlink_get_mesh_info(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+/**
+ * batadv_netlink_dump_hardif_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @hard_iface: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_netlink_dump_hardif_entry(struct sk_buff *msg, u32 portid, u32 seq,
 				 struct batadv_hard_iface *hard_iface)
@@ -174,6 +231,13 @@ batadv_netlink_dump_hardif_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_netlink_dump_hardifs - TODO
+ * @msg: TODO
+ * @cb: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
 {
@@ -224,23 +288,18 @@ batadv_netlink_dump_hardifs(struct sk_buff *msg, struct netlink_callback *cb)
 	return msg->len;
 }
 
-static struct nla_policy batadv_netlink_policy[BATADV_ATTR_MAX + 1] = {
-	[BATADV_ATTR_MESH_IFINDEX]	= { .type = NLA_U32 },
-	[BATADV_ATTR_HARD_IFINDEX]	= { .type = NLA_U32 },
-};
-
 static struct genl_ops batadv_netlink_ops[] = {
 	{
-		.cmd = BATADV_CMD_GET_ROUTING_ALGOS,
+		.cmd = BATADV_CMD_GET_MESH_INFO,
 		.flags = GENL_ADMIN_PERM,
 		.policy = batadv_netlink_policy,
-		.dumpit = batadv_algo_dump,
+		.doit = batadv_netlink_get_mesh_info,
 	},
 	{
-		.cmd = BATADV_CMD_GET_MESH_INFO,
+		.cmd = BATADV_CMD_GET_ROUTING_ALGOS,
 		.flags = GENL_ADMIN_PERM,
 		.policy = batadv_netlink_policy,
-		.doit = batadv_netlink_get_mesh_info,
+		.dumpit = batadv_algo_dump,
 	},
 	{
 		.cmd = BATADV_CMD_GET_HARDIFS,
@@ -286,6 +345,9 @@ static struct genl_ops batadv_netlink_ops[] = {
 	},
 };
 
+/**
+ * batadv_netlink_register - Register batadv genl netlink family
+ */
 void __init batadv_netlink_register(void)
 {
 	int ret;
@@ -296,6 +358,9 @@ void __init batadv_netlink_register(void)
 		pr_warn("unable to register netlink family");
 }
 
+/**
+ * batadv_netlink_unregister - Unregister batadv genl netlink family
+ */
 void batadv_netlink_unregister(void)
 {
 	genl_unregister_family(&batadv_netlink_family);
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index ae0eeb9..89b7c5b 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -28,6 +28,13 @@ struct nlmsghdr;
 void batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
 
+/**
+ * batadv_netlink_get_ifindex - TODO
+ * @nlh: TODO
+ * @attrtype: TODO
+ *
+ * Return: TODO
+ */
 static inline int
 batadv_netlink_get_ifindex(const struct nlmsghdr *nlh, int attrtype)
 {
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0455e54..71b63e7 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1416,8 +1416,7 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	int ret;
 	int ifindex, hard_ifindex;
 
-	ifindex = batadv_netlink_get_ifindex(cb->nlh,
-					     BATADV_ATTR_MESH_IFINDEX);
+	ifindex = batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDEX);
 	if (!ifindex)
 		return -EINVAL;
 
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index be42b12..6a1eba3 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1063,6 +1063,16 @@ out:
 	return 0;
 }
 
+/**
+ * batadv_tt_local_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @common: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			   struct batadv_priv *bat_priv,
@@ -1111,6 +1121,17 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_tt_local_dump_bucket - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @head: TODO
+ * @idx_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 			    struct batadv_priv *bat_priv,
@@ -1137,6 +1158,13 @@ batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_tt_local_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ *
+ * Return: TODO
+ */
 int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(cb->skb->sk);
@@ -1841,6 +1869,17 @@ out:
 	return 0;
 }
 
+/**
+ * batadv_tt_global_dump_subentry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @common: TODO
+ * @orig: TODO
+ * @best: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_tt_common_entry *common,
@@ -1890,6 +1929,17 @@ batadv_tt_global_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 	return -EMSGSIZE;
 }
 
+/**
+ * batadv_tt_global_dump_entry - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @common: TODO
+ * @sub_s: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_tt_global_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 			    struct batadv_priv *bat_priv,
@@ -1922,6 +1972,18 @@ batadv_tt_global_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_tt_global_dump_bucket - TODO
+ * @msg: TODO
+ * @portid: TODO
+ * @seq: TODO
+ * @bat_priv: TODO
+ * @head: TODO
+ * @idx_s: TODO
+ * @sub: TODO
+ *
+ * Return: TODO
+ */
 static int
 batadv_tt_global_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 			     struct batadv_priv *bat_priv,
@@ -1949,6 +2011,13 @@ batadv_tt_global_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 	return 0;
 }
 
+/**
+ * batadv_tt_global_dump - TODO
+ * @msg: TODO
+ * @cb: TODO
+ *
+ * Return: TODO
+ */
 int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(cb->skb->sk);

--nextPart1849581.vX7EfrdFzp--

--nextPart1558777.t2NPrWuSP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMNcBAAoJEF2HCgfBJntGgZAQAJvcPeVN+4ukueocjAPArLEi
84dp9ItWdewVQn0D7hc0/lduUKt4PQX61/as2A4JVyyHcQSt/0fMIPA0XGy912XO
3vOCoKodbVn8oBaX7wijaE1UnT54E/BYxh0oEyFYPQ0AMqRmlYH+8Hn5ekijB5Om
N4M0X1Njk4pIaHhlVjLiuMJ1pX4bX3/5Dt4o28OMYhva3Lfih4gZhXrQ2HqA4eFz
nL5qvF0hS45AUINAcZdpi3tQyZZnoBOw/OSjR2jnhWq49xaLnzfqGTTzxsOxJt1p
U7rIjIhMG1BGhMmb+U8tjPEsnbXwDPpK6BKaRlmFKY1jB9RefdG8z4Ppe6LjYM3l
t2Ob/GSR7y56e0D6sgEj/Sbdg/bc/ZDgYL68HamrLoVXrRyQPGnJieEoeQpwpwAV
jL3I/QpAfL4psLOFeSFdh4sfYfsVu5C2lkA9j8ItY2h9AIFnJn8ff3znhLiWLZq5
g6rrAFGt2rIqdNhGwPsmHXqU7w9uvls9b9cuUvucHoCDc3uYJJDHFrZnH+GtPUkc
vq6RAJ7VX+8DJMZbFxsV/3MFq5spBrMLO/cHMGnsQhPyZI6yoWg2/m1gd+nrpiXx
a+nTR60HGHaXDwsuK53bswoWut2SYGr3VB7l4z5evYOpx12ueujeRYIaaqLBG40j
Xi7hJYOmSel3Agpko/e/
=liMG
-----END PGP SIGNATURE-----

--nextPart1558777.t2NPrWuSP4--

