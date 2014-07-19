Return-Path: <antonio@meshcoding.com>
Message-ID: <53CA3F5F.5070701@meshcoding.com>
Date: Sat, 19 Jul 2014 11:50:23 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1405410077-28764-1-git-send-email-martin@hundeboll.net>
 <1405410077-28764-13-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405410077-28764-13-git-send-email-martin@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="59tcES03JweQ4IhWuRXhm3trgxW7d6WQt"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 13/13] batman-adv: kernel doc fixes for
 types.h
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--59tcES03JweQ4IhWuRXhm3trgxW7d6WQt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 15/07/14 09:41, Martin Hundeb=C3=B8ll wrote:
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

> ---
>  types.h | 46 +++++++++++++++++++++-------------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
>=20
> diff --git a/types.h b/types.h
> index 8854c05..4018479 100644
> --- a/types.h
> +++ b/types.h
> @@ -24,9 +24,8 @@
> =20
>  #ifdef CONFIG_BATMAN_ADV_DAT
> =20
> -/**
> - * batadv_dat_addr_t - it is the type used for all DHT addresses. If i=
t is
> - *  changed, BATADV_DAT_ADDR_MAX is changed as well.
> +/* batadv_dat_addr_t - it is the type used for all DHT addresses. If i=
t is
> + * changed, BATADV_DAT_ADDR_MAX is changed as well.
>   *
>   * *Please be careful: batadv_dat_addr_t must be UNSIGNED*
>   */
> @@ -46,15 +45,13 @@ enum batadv_dhcp_recipient {
>  	BATADV_DHCP_TO_CLIENT,
>  };
> =20
> -/**
> - * BATADV_TT_REMOTE_MASK - bitmask selecting the flags that are sent o=
ver the
> - *  wire only
> +/* BATADV_TT_REMOTE_MASK - bitmask selecting the flags that are sent o=
ver the
> + * wire only
>   */
>  #define BATADV_TT_REMOTE_MASK	0x00FF
> =20
> -/**
> - * BATADV_TT_SYNC_MASK - bitmask of the flags that need to be kept in =
sync
> - *  among the nodes. These flags are used to compute the global/local =
CRC
> +/* BATADV_TT_SYNC_MASK - bitmask of the flags that need to be kept in =
sync
> + * among the nodes. These flags are used to compute the global/local C=
RC
>   */
>  #define BATADV_TT_SYNC_MASK	0x00F0
> =20
> @@ -202,11 +199,11 @@ struct batadv_orig_bat_iv {
>   * @primary_addr: hosts primary interface address
>   * @ifinfo_list: list for routers per outgoing interface
>   * @last_bonding_candidate: pointer to last ifinfo of last used router=

> - * @batadv_dat_addr_t:  address of the orig node in the distributed ha=
sh
> + * @dat_addr: address of the orig node in the distributed hash
>   * @last_seen: time when last packet from this node was received
>   * @bcast_seqno_reset: time when the broadcast seqno window was reset
>   * @mcast_flags: multicast flags announced by the orig node
> - * @mcast_want_all_unsnoop_node: a list node for the
> + * @mcast_want_all_unsnoopables_node: a list node for the
>   *  mcast.want_all_unsnoopables list
>   * @mcast_want_all_ipv4_node: a list node for the mcast.want_all_ipv4 =
list
>   * @mcast_want_all_ipv6_node: a list node for the mcast.want_all_ipv6 =
list
> @@ -333,9 +330,8 @@ struct batadv_gw_node {
>   * @ifinfo_lock: lock protecting private ifinfo members and list
>   * @if_incoming: pointer to incoming hard interface
>   * @last_seen: when last packet via this neighbor was received
> - * @last_ttl: last received ttl from this neigh node
> + * @refcount: number of contexts the object is used
>   * @rcu: struct used for freeing in an RCU-safe manner
> - * @bat_iv: B.A.T.M.A.N. IV private structure
>   */
>  struct batadv_neigh_node {
>  	struct hlist_node list;
> @@ -385,13 +381,13 @@ struct batadv_neigh_ifinfo {
>  	struct rcu_head rcu;
>  };
> =20
> +#ifdef CONFIG_BATMAN_ADV_BLA
>  /**
>   * struct batadv_bcast_duplist_entry - structure for LAN broadcast sup=
pression
> - * @orig[ETH_ALEN]: mac address of orig node orginating the broadcast
> + * @orig: mac address of orig node orginating the broadcast
>   * @crc: crc32 checksum of broadcast payload
>   * @entrytime: time when the broadcast packet was received
>   */
> -#ifdef CONFIG_BATMAN_ADV_BLA
>  struct batadv_bcast_duplist_entry {
>  	uint8_t orig[ETH_ALEN];
>  	__be32 crc;
> @@ -533,9 +529,10 @@ struct batadv_priv_tt {
>  	struct delayed_work work;
>  };
> =20
> +#ifdef CONFIG_BATMAN_ADV_BLA
>  /**
>   * struct batadv_priv_bla - per mesh interface bridge loope avoidance =
data
> - * @num_requests; number of bla requests in flight
> + * @num_requests: number of bla requests in flight
>   * @claim_hash: hash table containing mesh nodes this host has claimed=

>   * @backbone_hash: hash table containing all detected backbone gateway=
s
>   * @bcast_duplist: recently received broadcast packets array (for broa=
dcast
> @@ -545,7 +542,6 @@ struct batadv_priv_tt {
>   * @claim_dest: local claim data (e.g. claim group)
>   * @work: work queue callback item for cleanups & bla announcements
>   */
> -#ifdef CONFIG_BATMAN_ADV_BLA
>  struct batadv_priv_bla {
>  	atomic_t num_requests;
>  	struct batadv_hashtable *claim_hash;
> @@ -559,6 +555,7 @@ struct batadv_priv_bla {
>  };
>  #endif
> =20
> +#ifdef CONFIG_BATMAN_ADV_DEBUG
>  /**
>   * struct batadv_priv_debug_log - debug logging data
>   * @log_buff: buffer holding the logs (ring bufer)
> @@ -567,7 +564,6 @@ struct batadv_priv_bla {
>   * @lock: lock protecting log_buff, log_start & log_end
>   * @queue_wait: log reader's wait queue
>   */
> -#ifdef CONFIG_BATMAN_ADV_DEBUG
>  struct batadv_priv_debug_log {
>  	char log_buff[BATADV_LOG_BUF_LEN];
>  	unsigned long log_start;
> @@ -609,13 +605,13 @@ struct batadv_priv_tvlv {
>  	spinlock_t handler_list_lock; /* protects handler_list */
>  };
> =20
> +#ifdef CONFIG_BATMAN_ADV_DAT
>  /**
>   * struct batadv_priv_dat - per mesh interface DAT private data
>   * @addr: node DAT address
>   * @hash: hashtable representing the local ARP cache
>   * @work: work queue callback item for cache purging
>   */
> -#ifdef CONFIG_BATMAN_ADV_DAT
>  struct batadv_priv_dat {
>  	batadv_dat_addr_t addr;
>  	struct batadv_hashtable *hash;
> @@ -730,6 +726,8 @@ struct batadv_softif_vlan {
>   * @orig_interval: OGM broadcast interval in milliseconds
>   * @hop_penalty: penalty which will be applied to an OGM's tq-field on=
 every hop
>   * @log_level: configured log level (see batadv_dbg_level)
> + * @isolation_mark: mark to use in ap isolation when filtering packets=

> + * @isolation_mark_mask: mask of bits to check when filtering packets
>   * @bcast_seqno: last sent broadcast packet sequence number
>   * @bcast_queue_left: number of remaining buffered broadcast packet sl=
ots
>   * @batman_queue_left: number of remaining OGM packet slots
> @@ -757,7 +755,7 @@ struct batadv_softif_vlan {
>   * @dat: distributed arp table data
>   * @mcast: multicast data
>   * @network_coding: bool indicating whether network coding is enabled
> - * @batadv_priv_nc: network coding data
> + * @nc: network coding data
>   */
>  struct batadv_priv {
>  	atomic_t mesh_state;
> @@ -855,6 +853,7 @@ struct batadv_socket_packet {
>  	uint8_t icmp_packet[BATADV_ICMP_MAX_PACKET_SIZE];
>  };
> =20
> +#ifdef CONFIG_BATMAN_ADV_BLA
>  /**
>   * struct batadv_bla_backbone_gw - batman-adv gateway bridged into the=
 LAN
>   * @orig: originator address of backbone node (mac address of primary =
iface)
> @@ -871,7 +870,6 @@ struct batadv_socket_packet {
>   * @refcount: number of contexts the object is used
>   * @rcu: struct used for freeing in an RCU-safe manner
>   */
> -#ifdef CONFIG_BATMAN_ADV_BLA
>  struct batadv_bla_backbone_gw {
>  	uint8_t orig[ETH_ALEN];
>  	unsigned short vid;
> @@ -889,7 +887,7 @@ struct batadv_bla_backbone_gw {
>   * struct batadv_bla_claim - claimed non-mesh client structure
>   * @addr: mac address of claimed non-mesh client
>   * @vid: vlan id this client was detected on
> - * @batadv_bla_backbone_gw: pointer to backbone gw claiming this clien=
t
> + * @backbone_gw: pointer to backbone gw claiming this client
>   * @lasttime: last time we heard of claim (locals only)
>   * @hash_entry: hlist node for batadv_priv_bla::claim_hash
>   * @refcount: number of contexts the object is used
> @@ -1204,9 +1202,7 @@ struct batadv_dat_candidate {
>   * struct batadv_tvlv_container - container for tvlv appended to OGMs
>   * @list: hlist node for batadv_priv_tvlv::container_list
>   * @tvlv_hdr: tvlv header information needed to construct the tvlv
> - * @value_len: length of the buffer following this struct which contai=
ns
> - *  the actual tvlv payload
> - * @refcount: number of contexts the object is used
> + * @refcount: number of contexts the object is used in
>   */
>  struct batadv_tvlv_container {
>  	struct hlist_node list;
>=20

--=20
Antonio Quartulli


--59tcES03JweQ4IhWuRXhm3trgxW7d6WQt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTyj9jAAoJEJgn97Bh2u9ePC4QAKB/R7LNYKyewrRvJ3APitMj
nuuOv2AgVCGhuUFlQIuA5NBgLMBtApjbwcOPbHiLNOMQ/pkrnLAp739J+RUmlTqG
CIpkNkp/uP+9GikJWdfSLbTMyDwVZeScw7RoePGtJjLfMlt+4Mil96apl7jzA0JQ
oVMUKIkx3K5AOmvJk+Hh45nPlQDcR9arP2+BVSAH7MHeVspoIcvNPVFRWd7IbSN4
mj5gYY5j3lkiL7Refe7TQGoY9I6/m6wlAhaZ5O41oR1ccbqss1FNrE9zEgqG2EyQ
edOojtT43mCVkW30oDCZjvW9t32a6AHvnhH3UzeaaUoPIFByCUa/0Co1sNO4AlLh
2Az0XiHiCmSMpYsBXYenKM4hLSCJ7o58frJi6VdIh6Zk3G0tmKm6SmxeLZTxxP5M
i0YRUhwG2CppNBGDmf5CuJS2mo7em7X8BlMrOqyqYj86Ei0GX2VqHJmQqicOZRxq
3O/NifvWDtaOcllla7rm+yR5ilzq6XET0XN5Ybbuo+X4jVhKAR5WdxKu4BdIhAc0
n9xY24A5nPvaHmZ7F5spF6SBLbS+RUZ0b7i1y+YnxxYCWpW4X6SvDqBsci8uO6wz
lRs1LWUniIoKtwZgxEnZk4mRCnRV4LK1SViJnZOLGiwx1RTyRRRo+G70U4PXDI/Q
Dh46kzmWp9cUQd9cLWVH
=XbK1
-----END PGP SIGNATURE-----

--59tcES03JweQ4IhWuRXhm3trgxW7d6WQt--
