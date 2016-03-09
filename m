Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 09 Mar 2016 22:11:43 +0100
Message-ID: <13752331.CEKO7ckMJS@sven-edge>
In-Reply-To: <1457484919-3935-1-git-send-email-a@unstable.cc>
References: <1457484919-3935-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1830590.OvPRFxRBMf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix typ0 in kerneldoc
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1830590.OvPRFxRBMf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Wednesday 09 March 2016 08:55:19 Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/batman-adv/distributed-arp-table.c
> b/net/batman-adv/distributed-arp-table.c index 919a8d2..ab79f3a 10064=
4
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
> @@ -717,7 +717,7 @@ void batadv_dat_status_update(struct net_device
> *net_dev) }
>=20
>  /**
> - * batadv_gw_tvlv_ogm_handler_v1 - process incoming dat tvlv contain=
er
> + * batadv_dat_tvlv_ogm_handler_v1 - process incoming dat tvlv contai=
ner
>   * @bat_priv: the bat priv with all the soft interface information
>   * @orig: the orig_node of the ogm
>   * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_=
flags)

You've missed some (see
https://git.open-mesh.org/batman-adv.git/commit/94399934a5e050073e1146e=
cfc48fe58ac3551b3
for the update patch):

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/br=
idge_loop_avoidance.c
index 642167f..f0075ff 100644
=2D-- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1576,7 +1576,7 @@ bool batadv_bla_is_backbone_gw(struct sk_buff *sk=
b,
 }
=20
 /**
=2D * batadv_bla_init - free all bla structures
+ * batadv_bla_free - free all bla structures
  * @bat_priv: the bat priv with all the soft interface information
  *
  * for softinterface free or module unload
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/di=
stributed-arp-table.c
index 919a8d2..ab79f3a 100644
=2D-- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -717,7 +717,7 @@ void batadv_dat_status_update(struct net_device *ne=
t_dev)
 }
=20
 /**
=2D * batadv_gw_tvlv_ogm_handler_v1 - process incoming dat tvlv container=

+ * batadv_dat_tvlv_ogm_handler_v1 - process incoming dat tvlv containe=
r
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the orig_node of the ogm
  * @flags: flags indicating the tvlv state (see batadv_tvlv_handler_fl=
ags)
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.=
c
index 14d0013..df449a0 100644
=2D-- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -337,7 +337,7 @@ err:
 }
=20
 /**
=2D * batadv_socket_receive_packet - schedule an icmp packet to be sent t=
o
+ * batadv_socket_add_packet - schedule an icmp packet to be sent to
  *  userspace on an icmp socket.
  * @socket_client: the socket this packet belongs to
  * @icmph: pointer to the header of the icmp packet
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e602408..1565df0 100644
=2D-- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -296,7 +296,8 @@ static inline bool batadv_compare_eth(const void *d=
ata1, const void *data2)
 }
=20
 /**
=2D * has_timed_out - compares current time (jiffies) and timestamp + tim=
eout
+ * batadv_has_timed_out - compares current time (jiffies) and timestam=
p +
+ *  timeout
  * @timestamp:=09=09base value to compare with (in jiffies)
  * @timeout:=09=09added to base value before comparing (in millisecond=
s)
  *
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 8caa2c7..c32f24f 100644
=2D-- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -394,7 +394,8 @@ static int batadv_mcast_forw_mode_check(struct bata=
dv_priv *bat_priv,
 }
=20
 /**
=2D * batadv_mcast_want_all_ip_count - count nodes with unspecific mcast =
interest
+ * batadv_mcast_forw_want_all_ip_count - count nodes with unspecific m=
cast
+ *  interest
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: ethernet header of a packet
  *
@@ -433,7 +434,7 @@ batadv_mcast_forw_tt_node_get(struct batadv_priv *b=
at_priv,
 }
=20
 /**
=2D * batadv_mcast_want_forw_ipv4_node_get - get a node with an ipv4 flag=

+ * batadv_mcast_forw_ipv4_node_get - get a node with an ipv4 flag
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_IPV4 flag =
set and
@@ -460,7 +461,7 @@ batadv_mcast_forw_ipv4_node_get(struct batadv_priv =
*bat_priv)
 }
=20
 /**
=2D * batadv_mcast_want_forw_ipv6_node_get - get a node with an ipv6 flag=

+ * batadv_mcast_forw_ipv6_node_get - get a node with an ipv6 flag
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_IPV6 flag =
set
@@ -487,7 +488,7 @@ batadv_mcast_forw_ipv6_node_get(struct batadv_priv =
*bat_priv)
 }
=20
 /**
=2D * batadv_mcast_want_forw_ip_node_get - get a node with an ipv4/ipv6 f=
lag
+ * batadv_mcast_forw_ip_node_get - get a node with an ipv4/ipv6 flag
  * @bat_priv: the bat priv with all the soft interface information
  * @ethhdr: an ethernet header to determine the protocol family from
  *
@@ -511,7 +512,7 @@ batadv_mcast_forw_ip_node_get(struct batadv_priv *b=
at_priv,
 }
=20
 /**
=2D * batadv_mcast_want_forw_unsnoop_node_get - get a node with an unsnoo=
pable flag
+ * batadv_mcast_forw_unsnoop_node_get - get a node with an unsnoopable=
 flag
  * @bat_priv: the bat priv with all the soft interface information
  *
  * Return: an orig_node which has the BATADV_MCAST_WANT_ALL_UNSNOOPABL=
ES flag
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index e63d6a5..84d5a1e 100644
=2D-- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -289,7 +289,7 @@ void batadv_neigh_node_put(struct batadv_neigh_node=
 *neigh_node)
 }
=20
 /**
=2D * batadv_orig_node_get_router - router to the originator depending on=
 iface
+ * batadv_orig_router_get - router to the originator depending on ifac=
e
  * @orig_node: the orig node for the router
  * @if_outgoing: the interface where the payload packet has been recei=
ved or
  *  the OGM should be sent to
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 8a8d7ca..0796dfd 100644
=2D-- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -501,7 +501,7 @@ struct batadv_coded_packet {
 #pragma pack()
=20
 /**
=2D * struct batadv_unicast_tvlv - generic unicast packet with tvlv paylo=
ad
+ * struct batadv_unicast_tvlv_packet - generic unicast packet with tvl=
v payload
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the genereal header
  * @ttl: time to live for this packet, part of the genereal header
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-inte=
rface.c
index 7679f3a..bae24c0 100644
=2D-- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -539,7 +539,7 @@ struct batadv_softif_vlan *batadv_softif_vlan_get(s=
truct batadv_priv *bat_priv,
 }
=20
 /**
=2D * batadv_create_vlan - allocate the needed resources for a new vlan
+ * batadv_softif_create_vlan - allocate the needed resources for a new=
 vlan
  * @bat_priv: the bat priv with all the soft interface information
  * @vid: the VLAN identifier
  *

--nextPart1830590.OvPRFxRBMf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4JGPAAoJEF2HCgfBJntG5RMP/3ZJyi5tOYS0hShkvCo9Orqw
q/3546MHCYw7EUECi+IoGF6bOrowmztB8lb2fI/rLrrQsbOTEn8KISkosVtf4QGC
rO77FIYzpWpl3keTgijIPB/8JVjZI7iBGKSYPfgauTOKmIdoMc73Qk7M28PhEfjS
QEGglOSyC3zyAnqQnzDAy39r3UZxvb6PkmqVrwH2eZU7rJTb2Cl1YjqYNvVKh8NL
cff7sKrOAYMxZ9sFYeNV8GZjWm3+Yq6gysfcf3xUZvo1UaGJlssT9pgQHSriCFyT
28DJjPfp/bxjJ2vbunAD/Xd7jouQef/aogD0tQj5M3K3Zz4LoeGlcrrSPGVeuVIq
wxbCMkjucEk3hAeoBgQzM6dKSqrcY6XLFHw5adcQSHdLKbeO+wPqgTHiST7ydTyV
wanwUfTDR4ve/8/b8j8Bb9USy8PgvF19VETX3uD9nGKsqRPL33oDxF+l6FNAIQqS
dQ+3gM2HXxejH0vXFBM3MMdtBgwmHcOKMTs/VHczbedxoLNLA15L6VcQ7+Bjr2Fw
9uoZdCNgHcbM409EpexWLKNLl/QWscpBZLOXuxWcDuMuLfGncaWRI2Ryj7iLGrP3
g1DXkv9I+0Wg3A+9QIKvT18M7rTtgrz6PkKCWaWduzSjwGiZ7nfJ2Z8RiKON+afj
SofBDxEoSJtrGjMfezpz
=58/v
-----END PGP SIGNATURE-----

--nextPart1830590.OvPRFxRBMf--

