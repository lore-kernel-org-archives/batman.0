Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 18 Mar 2016 08:09:40 +0100
Message-ID: <4945319.BvQuBs3oU8@sven-edge>
In-Reply-To: <56EAE3B8.3050808@universe-factory.net>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <56EAE3B8.3050808@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1713583.yLHJlLnX3Z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
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

--nextPart1713583.yLHJlLnX3Z
Content-Type: multipart/mixed; boundary="nextPart3524408.fhnBrciRUx"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart3524408.fhnBrciRUx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 17 March 2016 18:04:56 Matthias Schiffer wrote:
> And here is the new version of the PoC userspace tool.
> Build with:
> 
> gcc -o batnl batnl.c $$(pkg-config --cflags --libs libnl-1) -Wall

Thanks for the patches.

I've only looked at the test querier for a second and I am a little bit 
confused that you access things like attrs[BATADV_ATTR_ALGO_NAME] without 
checking if this is available or that the received message is valid (according 
to the nla_parse policy).

I know that this is only a PoC but wanted to mention it in case somebody wants 
to use it as reference for a batctl/alfred implementation.

I like that the netlink interface doesn't introduce complex structs at the 
moment (but I have to think a little bit about it). The unnamed enums freak me 
out a little bit (names would be nice so it is easier to write kernel-doc for 
it).

I just ran the build_test stuff through your branch so you get an early 
feedback about some common problems. See the attached mail (the unused symbols 
seem to be only symptoms of the build failures with old kernels < 3.12).

Kind regards,
	Sven
=2D-nextPart3524408.fhnBrciRUx
Content-Disposition: attachment; filename="Build check errors found_2016-03-17.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="Build check errors found_2016-03-17.mbox"

MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Build check errors found: 2016-03-17
From: postmaster@open-mesh.org
To: sven
Date: Thu, 17 Mar 2016 22:31:34 +0100 (CET)

Name of failed tests
====================

 * checkpatch master ./net/batman-adv/fragmentation.c
 * headers master
 * kerneldoc master ./net/batman-adv/types.h
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * sparse master linux-3.10 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.11 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.12 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.2 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.3 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.4 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.5 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.6 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.7 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.8 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.9 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.2 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.3 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.4 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.5 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.6 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n

Output of different failed tests
================================

checkpatch master ./net/batman-adv/fragmentation.c
=2D-------------------------------------------------

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    #455: FILE: ./net/batman-adv/fragmentation.c:455:
    +	mtu = min_t(unsigned, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
    
    total: 0 errors, 1 warnings, 0 checks, 516 lines checked


headers master
=2D-------------

    diff --git a/build/net/batman-adv/bat_iv_ogm.c b/build/net/batman-adv/bat_iv_ogm.c
    index 3952e3c..9f85ee3 100644
    --- a/build/net/batman-adv/bat_iv_ogm.c
    +++ b/build/net/batman-adv/bat_iv_ogm.c
    @@ -16,7 +16,10 @@
      */
     
     #include "bat_algo.h" // IWYU pragma: keep
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
     #include <linux/bitmap.h>
    @@ -48,7 +51,6 @@
     #include <linux/types.h>
     #include <linux/workqueue.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bitarray.h"
     #include "hard-interface.h"
     #include "hash.h"
    diff --git a/build/net/batman-adv/bat_v.c b/build/net/batman-adv/bat_v.c
    index 2ff7e69..49928f9 100644
    --- a/build/net/batman-adv/bat_v.c
    +++ b/build/net/batman-adv/bat_v.c
    @@ -16,9 +16,14 @@
      */
     
     #include "bat_algo.h" // IWYU pragma: keep
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
    +#include <linux/errno.h>
    +#include <linux/if_ether.h>
     #include <linux/bug.h>
     #include <linux/cache.h>
     #include <linux/init.h>
    @@ -30,7 +35,6 @@
     #include <linux/types.h>
     #include <linux/workqueue.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bat_v_elp.h"
     #include "bat_v_ogm.h"
     #include "hash.h"
    @@ -38,6 +42,8 @@
     #include "originator.h"
     #include "packet.h"
     
    +struct sk_buff;
    +
     static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
     {
     	int ret;
    diff --git a/build/net/batman-adv/main.c b/build/net/batman-adv/main.c
    index 4702f67..1194cbd 100644
    --- a/build/net/batman-adv/main.c
    +++ b/build/net/batman-adv/main.c
    @@ -48,7 +48,6 @@
     #include <net/dsfield.h>
     #include <net/rtnetlink.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bat_algo.h" // IWYU pragma: keep
     #include "bridge_loop_avoidance.h"
     #include "debugfs.h"
    @@ -57,7 +56,10 @@
     #include "gateway_common.h"
     #include "hard-interface.h"
     #include "icmp_socket.h"
    +#include "linux/netlink.h"
     #include "multicast.h"
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     #include "netlink.h"
     #include "network-coding.h"
     #include "originator.h"
    diff --git a/build/net/batman-adv/main.h b/build/net/batman-adv/main.h
    index 946f09a..5f0be03 100644
    --- a/build/net/batman-adv/main.h
    +++ b/build/net/batman-adv/main.h
    @@ -187,6 +187,7 @@ enum batadv_uev_type {
     #include "types.h"
     
     struct batadv_ogm_packet;
    +struct netlink_callback;
     struct seq_file;
     struct sk_buff;
     
    diff --git a/build/net/batman-adv/netlink.c b/build/net/batman-adv/netlink.c
    index 55cc224..dd1347c 100644
    --- a/build/net/batman-adv/netlink.c
    +++ b/build/net/batman-adv/netlink.c
    @@ -15,13 +15,24 @@
      * along with this program; if not, see <http://www.gnu.org/licenses/>.
      */
     
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
     #include "netlink.h"
     
    +#include <linux/errno.h>
    +#include <linux/fs.h>
    +#include <linux/if_ether.h>
    +#include <linux/init.h>
     #include <linux/netdevice.h>
    +#include <linux/printk.h>
    +#include <linux/rculist.h>
    +#include <linux/rcupdate.h>
    +#include <linux/skbuff.h>
    +#include <linux/stddef.h>
    +#include <linux/types.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "hard-interface.h"
     #include "originator.h"
     #include "soft-interface.h"
    diff --git a/build/net/batman-adv/netlink.h b/build/net/batman-adv/netlink.h
    index 31022d4..2f53795 100644
    --- a/build/net/batman-adv/netlink.h
    +++ b/build/net/batman-adv/netlink.h
    @@ -18,7 +18,12 @@
     #ifndef _NET_BATMAN_ADV_NETLINK_H_
     #define _NET_BATMAN_ADV_NETLINK_H_
     
    +#include <linux/compiler.h>
     #include <net/genetlink.h>
    +#include "linux/genetlink.h"
    +#include "net/netlink.h"
    +
    +struct nlmsghdr;
     
     void batadv_netlink_register(void);
     void batadv_netlink_unregister(void);
    diff --git a/build/net/batman-adv/originator.c b/build/net/batman-adv/originator.c
    index 9cefcce..f5355c6 100644
    --- a/build/net/batman-adv/originator.c
    +++ b/build/net/batman-adv/originator.c
    @@ -16,9 +16,11 @@
      */
     
     #include "originator.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/atomic.h>
    +#include <linux/skbuff.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/fs.h>
    @@ -35,7 +37,6 @@
     #include <linux/workqueue.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "distributed-arp-table.h"
     #include "fragmentation.h"
     #include "gateway_client.h"
    diff --git a/build/net/batman-adv/originator.h b/build/net/batman-adv/originator.h
    index cdef186..6e33c6a 100644
    --- a/build/net/batman-adv/originator.h
    +++ b/build/net/batman-adv/originator.h
    @@ -31,7 +31,9 @@
     
     #include "hash.h"
     
    +struct netlink_callback;
     struct seq_file;
    +struct sk_buff;
     
     bool batadv_compare_orig(const struct hlist_node *node, const void *data2);
     int batadv_originator_init(struct batadv_priv *bat_priv);
    diff --git a/build/net/batman-adv/translation-table.c b/build/net/batman-adv/translation-table.c
    index 055d543..c0b6c4c 100644
    --- a/build/net/batman-adv/translation-table.c
    +++ b/build/net/batman-adv/translation-table.c
    @@ -16,9 +16,13 @@
      */
     
     #include "translation-table.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
    +#include <linux/skbuff.h>
     #include <linux/bitops.h>
     #include <linux/bug.h>
     #include <linux/byteorder/generic.h>
    @@ -43,10 +47,8 @@
     #include <linux/stddef.h>
     #include <linux/string.h>
     #include <linux/workqueue.h>
    -#include <net/net_namespace.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bridge_loop_avoidance.h"
     #include "hard-interface.h"
     #include "hash.h"
    diff --git a/build/net/batman-adv/translation-table.h b/build/net/batman-adv/translation-table.h
    index 889a071..e1a12a9 100644
    --- a/build/net/batman-adv/translation-table.h
    +++ b/build/net/batman-adv/translation-table.h
    @@ -20,6 +20,9 @@
     
     #include "main.h" // IWYU pragma: keep
     
    +struct netlink_callback;
    +struct sk_buff;
    +
     #include <linux/types.h>
     
     struct net_device;


kerneldoc master ./net/batman-adv/types.h
=2D----------------------------------------

    ./net/batman-adv/types.h:1314: warning: No description found for parameter 'bat_neigh_dump'
    ./net/batman-adv/types.h:1314: warning: No description found for parameter 'bat_orig_dump'


smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
=2D--------------------------------------------------------------------------

    /tmp/build/net/batman-adv/routing.c:593 batadv_route_unicast_packet warn: unused return: ethhdr = eth_hdr()


sparse master linux-3.10 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
=2D------------------------------------------------------------------------

    /tmp/build/net/batman-adv/netlink.c:267:44: error: not enough arguments for function genl_register_family_with_ops
    /tmp/build/net/batman-adv/netlink.c: In function 'batadv_netlink_register':
    /tmp/build/net/batman-adv/netlink.c:267:8: error: too few arguments to function 'genl_register_family_with_ops'
      ret = genl_register_family_with_ops(&batadv_netlink_family,
            ^
    In file included from /tmp/build/net/batman-adv/netlink.h:21:0,
                     from /tmp/build/net/batman-adv/netlink.c:19:
    include/net/genetlink.h:125:12: note: declared here
     extern int genl_register_family_with_ops(struct genl_family *family,
                ^
    make[2]: *** [/tmp/build/net/batman-adv/netlink.o] Error 1
    make[1]: *** [_module_/tmp/build/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-3.12 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
=2D------------------------------------------------------------------------

    /tmp/build/net/batman-adv/netlink.c:267:44: error: not enough arguments for function genl_register_family_with_ops
    /tmp/build/net/batman-adv/netlink.c: In function 'batadv_netlink_register':
    /tmp/build/net/batman-adv/netlink.c:267:8: error: too few arguments to function 'genl_register_family_with_ops'
      ret = genl_register_family_with_ops(&batadv_netlink_family,
            ^
    In file included from /tmp/build/net/batman-adv/netlink.h:21:0,
                     from /tmp/build/net/batman-adv/netlink.c:19:
    include/net/genetlink.h:136:19: note: declared here
     static inline int genl_register_family_with_ops(struct genl_family *family,
                       ^
    make[2]: *** [/tmp/build/net/batman-adv/netlink.o] Error 1
    make[1]: *** [_module_/tmp/build/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-3.6 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
=2D-----------------------------------------------------------------------

    /tmp/build/net/batman-adv/bat_iv_ogm.c:2067:41: error: no member 'portid' in struct netlink_skb_parms
    /tmp/build/net/batman-adv/bat_iv_ogm.c:2202:41: error: no member 'portid' in struct netlink_skb_parms
    /tmp/build/net/batman-adv/bat_iv_ogm.c: In function 'batadv_iv_ogm_orig_dump':
    /tmp/build/net/batman-adv/bat_iv_ogm.c:2067:34: error: 'struct netlink_skb_parms' has no member named 'portid'
      int portid = NETLINK_CB(cb->skb).portid;
                                      ^
    /tmp/build/net/batman-adv/bat_iv_ogm.c: In function 'batadv_iv_ogm_neigh_dump':
    /tmp/build/net/batman-adv/bat_iv_ogm.c:2202:34: error: 'struct netlink_skb_parms' has no member named 'portid'
      int portid = NETLINK_CB(cb->skb).portid;
                                      ^
    make[2]: *** [/tmp/build/net/batman-adv/bat_iv_ogm.o] Error 1
    make[1]: *** [_module_/tmp/build/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-3.9 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
=2D-----------------------------------------------------------------------

    /tmp/build/net/batman-adv/netlink.c:267:44: error: not enough arguments for function genl_register_family_with_ops
    /tmp/build/net/batman-adv/netlink.c: In function 'batadv_netlink_register':
    /tmp/build/net/batman-adv/netlink.c:267:8: error: too few arguments to function 'genl_register_family_with_ops'
      ret = genl_register_family_with_ops(&batadv_netlink_family,
            ^
    In file included from /tmp/build/net/batman-adv/netlink.h:21:0,
                     from /tmp/build/net/batman-adv/netlink.c:19:
    include/net/genetlink.h:124:12: note: declared here
     extern int genl_register_family_with_ops(struct genl_family *family,
                ^
    make[2]: *** [/tmp/build/net/batman-adv/netlink.o] Error 1
    make[1]: *** [_module_/tmp/build/net/batman-adv] Error 2
    make: *** [all] Error 2


unused_symbols master linux-3.12 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
=2D--------------------------------------------------------------------------

    batadv_algo_dump
    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_status_update
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_debugfs_add_meshif
    batadv_debugfs_del_meshif
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_bandwidth_set
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_gw_tvlv_container_update
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_get_by_netdev
    batadv_hardif_min_mtu
    batadv_is_my_mac
    batadv_mcast_forw_mode
    batadv_mcast_mla_update
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_socket_receive_packet
    batadv_tvlv_containers_process
    batadv_tvlv_unicast_send
    batadv_update_min_mtu
    batadv_vlan_ap_isola_get
    init_module


unused_symbols master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
=2D--------------------------------------------------------------------------

    batadv_algo_dump
    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_status_update
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_status_update
    batadv_debugfs_add_meshif
    batadv_debugfs_del_meshif
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_bandwidth_set
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_gw_tvlv_container_update
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_get_by_netdev
    batadv_hardif_min_mtu
    batadv_is_my_mac
    batadv_mcast_forw_mode
    batadv_mcast_mla_update
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_socket_receive_packet
    batadv_tvlv_containers_process
    batadv_tvlv_unicast_send
    batadv_update_min_mtu
    batadv_vlan_ap_isola_get
    init_module


wrong namespace symbols master linux-3.6 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
=2D--------------------------------------------------------------------------

    nm: './build/net/batman-adv/*.o': No such file


=2D-nextPart3524408.fhnBrciRUx--
This is a multi-part message in MIME format.

--nextPart3524408.fhnBrciRUx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 17 March 2016 18:04:56 Matthias Schiffer wrote:
> And here is the new version of the PoC userspace tool.
> Build with:
> 
> gcc -o batnl batnl.c $$(pkg-config --cflags --libs libnl-1) -Wall

Thanks for the patches.

I've only looked at the test querier for a second and I am a little bit 
confused that you access things like attrs[BATADV_ATTR_ALGO_NAME] without 
checking if this is available or that the received message is valid (according 
to the nla_parse policy).

I know that this is only a PoC but wanted to mention it in case somebody wants 
to use it as reference for a batctl/alfred implementation.

I like that the netlink interface doesn't introduce complex structs at the 
moment (but I have to think a little bit about it). The unnamed enums freak me 
out a little bit (names would be nice so it is easier to write kernel-doc for 
it).

I just ran the build_test stuff through your branch so you get an early 
feedback about some common problems. See the attached mail (the unused symbols 
seem to be only symptoms of the build failures with old kernels < 3.12).

Kind regards,
	Sven
--nextPart3524408.fhnBrciRUx
Content-Disposition: attachment; filename="Build check errors found_2016-03-17.mbox"
Content-Transfer-Encoding: 7Bit
Content-Type: application/mbox; name="Build check errors found_2016-03-17.mbox"

MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Build check errors found: 2016-03-17
From: postmaster@open-mesh.org
To: sven
Date: Thu, 17 Mar 2016 22:31:34 +0100 (CET)

Name of failed tests
====================

 * checkpatch master ./net/batman-adv/fragmentation.c
 * headers master
 * kerneldoc master ./net/batman-adv/types.h
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * sparse master linux-3.10 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.11 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.12 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.2 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.3 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.4 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.5 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.6 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.7 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.8 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse master linux-3.9 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * sparse master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.10 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.11 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.7 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.8 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * unused_symbols master linux-3.9 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.2 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.2 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.3 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.3 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.4 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.4 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.5 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.5 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.6 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
 * wrong namespace symbols master linux-3.6 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n

Output of different failed tests
================================

checkpatch master ./net/batman-adv/fragmentation.c
--------------------------------------------------

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    #455: FILE: ./net/batman-adv/fragmentation.c:455:
    +	mtu = min_t(unsigned, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
    
    total: 0 errors, 1 warnings, 0 checks, 516 lines checked


headers master
--------------

    diff --git a/build/net/batman-adv/bat_iv_ogm.c b/build/net/batman-adv/bat_iv_ogm.c
    index 3952e3c..9f85ee3 100644
    --- a/build/net/batman-adv/bat_iv_ogm.c
    +++ b/build/net/batman-adv/bat_iv_ogm.c
    @@ -16,7 +16,10 @@
      */
     
     #include "bat_algo.h" // IWYU pragma: keep
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
     #include <linux/bitmap.h>
    @@ -48,7 +51,6 @@
     #include <linux/types.h>
     #include <linux/workqueue.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bitarray.h"
     #include "hard-interface.h"
     #include "hash.h"
    diff --git a/build/net/batman-adv/bat_v.c b/build/net/batman-adv/bat_v.c
    index 2ff7e69..49928f9 100644
    --- a/build/net/batman-adv/bat_v.c
    +++ b/build/net/batman-adv/bat_v.c
    @@ -16,9 +16,14 @@
      */
     
     #include "bat_algo.h" // IWYU pragma: keep
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
    +#include <linux/errno.h>
    +#include <linux/if_ether.h>
     #include <linux/bug.h>
     #include <linux/cache.h>
     #include <linux/init.h>
    @@ -30,7 +35,6 @@
     #include <linux/types.h>
     #include <linux/workqueue.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bat_v_elp.h"
     #include "bat_v_ogm.h"
     #include "hash.h"
    @@ -38,6 +42,8 @@
     #include "originator.h"
     #include "packet.h"
     
    +struct sk_buff;
    +
     static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
     {
     	int ret;
    diff --git a/build/net/batman-adv/main.c b/build/net/batman-adv/main.c
    index 4702f67..1194cbd 100644
    --- a/build/net/batman-adv/main.c
    +++ b/build/net/batman-adv/main.c
    @@ -48,7 +48,6 @@
     #include <net/dsfield.h>
     #include <net/rtnetlink.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bat_algo.h" // IWYU pragma: keep
     #include "bridge_loop_avoidance.h"
     #include "debugfs.h"
    @@ -57,7 +56,10 @@
     #include "gateway_common.h"
     #include "hard-interface.h"
     #include "icmp_socket.h"
    +#include "linux/netlink.h"
     #include "multicast.h"
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     #include "netlink.h"
     #include "network-coding.h"
     #include "originator.h"
    diff --git a/build/net/batman-adv/main.h b/build/net/batman-adv/main.h
    index 946f09a..5f0be03 100644
    --- a/build/net/batman-adv/main.h
    +++ b/build/net/batman-adv/main.h
    @@ -187,6 +187,7 @@ enum batadv_uev_type {
     #include "types.h"
     
     struct batadv_ogm_packet;
    +struct netlink_callback;
     struct seq_file;
     struct sk_buff;
     
    diff --git a/build/net/batman-adv/netlink.c b/build/net/batman-adv/netlink.c
    index 55cc224..dd1347c 100644
    --- a/build/net/batman-adv/netlink.c
    +++ b/build/net/batman-adv/netlink.c
    @@ -15,13 +15,24 @@
      * along with this program; if not, see <http://www.gnu.org/licenses/>.
      */
     
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
     #include "netlink.h"
     
    +#include <linux/errno.h>
    +#include <linux/fs.h>
    +#include <linux/if_ether.h>
    +#include <linux/init.h>
     #include <linux/netdevice.h>
    +#include <linux/printk.h>
    +#include <linux/rculist.h>
    +#include <linux/rcupdate.h>
    +#include <linux/skbuff.h>
    +#include <linux/stddef.h>
    +#include <linux/types.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "hard-interface.h"
     #include "originator.h"
     #include "soft-interface.h"
    diff --git a/build/net/batman-adv/netlink.h b/build/net/batman-adv/netlink.h
    index 31022d4..2f53795 100644
    --- a/build/net/batman-adv/netlink.h
    +++ b/build/net/batman-adv/netlink.h
    @@ -18,7 +18,12 @@
     #ifndef _NET_BATMAN_ADV_NETLINK_H_
     #define _NET_BATMAN_ADV_NETLINK_H_
     
    +#include <linux/compiler.h>
     #include <net/genetlink.h>
    +#include "linux/genetlink.h"
    +#include "net/netlink.h"
    +
    +struct nlmsghdr;
     
     void batadv_netlink_register(void);
     void batadv_netlink_unregister(void);
    diff --git a/build/net/batman-adv/originator.c b/build/net/batman-adv/originator.c
    index 9cefcce..f5355c6 100644
    --- a/build/net/batman-adv/originator.c
    +++ b/build/net/batman-adv/originator.c
    @@ -16,9 +16,11 @@
      */
     
     #include "originator.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/atomic.h>
    +#include <linux/skbuff.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/fs.h>
    @@ -35,7 +37,6 @@
     #include <linux/workqueue.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "distributed-arp-table.h"
     #include "fragmentation.h"
     #include "gateway_client.h"
    diff --git a/build/net/batman-adv/originator.h b/build/net/batman-adv/originator.h
    index cdef186..6e33c6a 100644
    --- a/build/net/batman-adv/originator.h
    +++ b/build/net/batman-adv/originator.h
    @@ -31,7 +31,9 @@
     
     #include "hash.h"
     
    +struct netlink_callback;
     struct seq_file;
    +struct sk_buff;
     
     bool batadv_compare_orig(const struct hlist_node *node, const void *data2);
     int batadv_originator_init(struct batadv_priv *bat_priv);
    diff --git a/build/net/batman-adv/translation-table.c b/build/net/batman-adv/translation-table.c
    index 055d543..c0b6c4c 100644
    --- a/build/net/batman-adv/translation-table.c
    +++ b/build/net/batman-adv/translation-table.c
    @@ -16,9 +16,13 @@
      */
     
     #include "translation-table.h"
    +#include "linux/netlink.h"
     #include "main.h" // IWYU pragma: keep
    +#include "net/genetlink.h"
    +#include "net/netlink.h"
     
     #include <linux/atomic.h>
    +#include <linux/skbuff.h>
     #include <linux/bitops.h>
     #include <linux/bug.h>
     #include <linux/byteorder/generic.h>
    @@ -43,10 +47,8 @@
     #include <linux/stddef.h>
     #include <linux/string.h>
     #include <linux/workqueue.h>
    -#include <net/net_namespace.h>
     #include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    -
     #include "bridge_loop_avoidance.h"
     #include "hard-interface.h"
     #include "hash.h"
    diff --git a/build/net/batman-adv/translation-table.h b/build/net/batman-adv/translation-table.h
    index 889a071..e1a12a9 100644
    --- a/build/net/batman-adv/translation-table.h
    +++ b/build/net/batman-adv/translation-table.h
    @@ -20,6 +20,9 @@
     
     #include "main.h" // IWYU pragma: keep
     
    +struct netlink_callback;
    +struct sk_buff;
    +
     #include <linux/types.h>
     
     struct net_device;


kerneldoc master ./net/batman-adv/types.h
-----------------------------------------

    ./net/batman-adv/types.h:1314: warning: No description found for parameter 'bat_neigh_dump'
    ./net/batman-adv/types.h:1314: warning: No description found for parameter 'bat_orig_dump'


smatch master linux-4.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
---------------------------------------------------------------------------

    /tmp/build/net/batman-adv/routing.c:593 batadv_route_unicast_packet warn: unused return: ethhdr = eth_hdr()


sparse master linux-3.10 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
-------------------------------------------------------------------------

    /tmp/build/net/batman-adv/netlink.c:267:44: error: not enough arguments for function genl_register_family_with_ops
    /tmp/build/net/batman-adv/netlink.c: In function 'batadv_netlink_register':
    /tmp/build/net/batman-adv/netlink.c:267:8: error: too few arguments to function 'genl_register_family_with_ops'
      ret = genl_register_family_with_ops(&batadv_netlink_family,
            ^
    In file included from /tmp/build/net/batman-adv/netlink.h:21:0,
                     from /tmp/build/net/batman-adv/netlink.c:19:
    include/net/genetlink.h:125:12: note: declared here
     extern int genl_register_family_with_ops(struct genl_family *family,
                ^
    make[2]: *** [/tmp/build/net/batman-adv/netlink.o] Error 1
    make[1]: *** [_module_/tmp/build/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-3.12 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
-------------------------------------------------------------------------

    /tmp/build/net/batman-adv/netlink.c:267:44: error: not enough arguments for function genl_register_family_with_ops
    /tmp/build/net/batman-adv/netlink.c: In function 'batadv_netlink_register':
    /tmp/build/net/batman-adv/netlink.c:267:8: error: too few arguments to function 'genl_register_family_with_ops'
      ret = genl_register_family_with_ops(&batadv_netlink_family,
            ^
    In file included from /tmp/build/net/batman-adv/netlink.h:21:0,
                     from /tmp/build/net/batman-adv/netlink.c:19:
    include/net/genetlink.h:136:19: note: declared here
     static inline int genl_register_family_with_ops(struct genl_family *family,
                       ^
    make[2]: *** [/tmp/build/net/batman-adv/netlink.o] Error 1
    make[1]: *** [_module_/tmp/build/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-3.6 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
------------------------------------------------------------------------

    /tmp/build/net/batman-adv/bat_iv_ogm.c:2067:41: error: no member 'portid' in struct netlink_skb_parms
    /tmp/build/net/batman-adv/bat_iv_ogm.c:2202:41: error: no member 'portid' in struct netlink_skb_parms
    /tmp/build/net/batman-adv/bat_iv_ogm.c: In function 'batadv_iv_ogm_orig_dump':
    /tmp/build/net/batman-adv/bat_iv_ogm.c:2067:34: error: 'struct netlink_skb_parms' has no member named 'portid'
      int portid = NETLINK_CB(cb->skb).portid;
                                      ^
    /tmp/build/net/batman-adv/bat_iv_ogm.c: In function 'batadv_iv_ogm_neigh_dump':
    /tmp/build/net/batman-adv/bat_iv_ogm.c:2202:34: error: 'struct netlink_skb_parms' has no member named 'portid'
      int portid = NETLINK_CB(cb->skb).portid;
                                      ^
    make[2]: *** [/tmp/build/net/batman-adv/bat_iv_ogm.o] Error 1
    make[1]: *** [_module_/tmp/build/net/batman-adv] Error 2
    make: *** [all] Error 2


sparse master linux-3.9 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
------------------------------------------------------------------------

    /tmp/build/net/batman-adv/netlink.c:267:44: error: not enough arguments for function genl_register_family_with_ops
    /tmp/build/net/batman-adv/netlink.c: In function 'batadv_netlink_register':
    /tmp/build/net/batman-adv/netlink.c:267:8: error: too few arguments to function 'genl_register_family_with_ops'
      ret = genl_register_family_with_ops(&batadv_netlink_family,
            ^
    In file included from /tmp/build/net/batman-adv/netlink.h:21:0,
                     from /tmp/build/net/batman-adv/netlink.c:19:
    include/net/genetlink.h:124:12: note: declared here
     extern int genl_register_family_with_ops(struct genl_family *family,
                ^
    make[2]: *** [/tmp/build/net/batman-adv/netlink.o] Error 1
    make[1]: *** [_module_/tmp/build/net/batman-adv] Error 2
    make: *** [all] Error 2


unused_symbols master linux-3.12 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
---------------------------------------------------------------------------

    batadv_algo_dump
    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_status_update
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_debugfs_add_meshif
    batadv_debugfs_del_meshif
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_bandwidth_set
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_gw_tvlv_container_update
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_get_by_netdev
    batadv_hardif_min_mtu
    batadv_is_my_mac
    batadv_mcast_forw_mode
    batadv_mcast_mla_update
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_socket_receive_packet
    batadv_tvlv_containers_process
    batadv_tvlv_unicast_send
    batadv_update_min_mtu
    batadv_vlan_ap_isola_get
    init_module


unused_symbols master linux-3.12 cfg: BLA=y DAT=y DEBUG=y NC=y MCAST=y BATMAN_V=n
---------------------------------------------------------------------------

    batadv_algo_dump
    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_status_update
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_status_update
    batadv_debugfs_add_meshif
    batadv_debugfs_del_meshif
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_bandwidth_set
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_gw_tvlv_container_update
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_get_by_netdev
    batadv_hardif_min_mtu
    batadv_is_my_mac
    batadv_mcast_forw_mode
    batadv_mcast_mla_update
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_socket_receive_packet
    batadv_tvlv_containers_process
    batadv_tvlv_unicast_send
    batadv_update_min_mtu
    batadv_vlan_ap_isola_get
    init_module


wrong namespace symbols master linux-3.6 cfg: BLA=y DAT=n DEBUG=y NC=n MCAST=y BATMAN_V=n
---------------------------------------------------------------------------

    nm: './build/net/batman-adv/*.o': No such file


--nextPart3524408.fhnBrciRUx--

--nextPart1713583.yLHJlLnX3Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW66m0AAoJEF2HCgfBJntGoQcQAIuJ/J3uojBzS/OEn1Y68DaT
MVYt2lJZev1Flu52dyaPYDmYPeor0SvYDIREjuLykZXzVm2vxEVMtOB9UpXoqeli
534fuJAOfHsUK9+jwoNQ5CAF0OnSYqJP5UeMH7Lt5/m9Kdpx5w790UR/13XQITOp
+JRBNzf9flrDnoE2IyznSP3vOywS9nz+nXYYcxa9TnkSVZveD2G0qeFUl2CsJ7OP
bVU/gBDNbeH1IjUTDSYDEWVC5bl0IFWa3WC6X2C9Lom03qCYWd4/9MsYljs0Yap0
2vQ584yscWFnAF2Y60VQopHWuYo2OJahQ8neKa3giJYkLsiWpznihJdvlfKwD+Cf
zN1XDgBDxOrarp2hgDUnB2r1+1lIZgfphUU/rn9zR1qjw83qEwGHu6ZktbWE/Mvy
QfteDtsQQwEQg/7K7tv8Ww4RPQ1xKfwQUAaZz7ytNbKKj6R2w0sRGca/ElJJnEgM
S+WVj9XiJpgBduD96wmTm/X0PWZ7fQbKCIB+mKpNbq0c1MQoaOLQM/pHA7W21xsm
Z9ULhCBhRw6vIDYWl5cHKz55a7vIi4ZSzdyQoVri5W2yTXKd55R/jjDnJbwBQ6Yx
OfLEECxXCZNsDIDKNdsVlg4Jyd+Pb3JwoILPyKM1oNPdgghBs/faypKo2nmukbme
juD+XkmxdiJiZ/4NjNMk
=UuWu
-----END PGP SIGNATURE-----

--nextPart1713583.yLHJlLnX3Z--

