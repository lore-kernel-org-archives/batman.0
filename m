Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 08 May 2018 20:36:23 +0200
Message-ID: <5192480.36YCKUTViS@sven-edge>
In-Reply-To: <20180508164130.8633-1-mareklindner@neomailbox.ch>
References: <20180508164130.8633-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6784022.7JZtmBBcXA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC 0/6] B.A.T.M.A.N. V - fallback to tp meter
 estimation if throughput otherwise not available
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart6784022.7JZtmBBcXA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Name of failed tests
====================

ecsv/pu
-------

 * checkpatch ./net/batman-adv/bat_v_elp.c
 * checkpatch ./net/batman-adv/tp_meter.c
 * checkpatch ./net/batman-adv/types.h
 * headers
 * kerneldoc ./net/batman-adv/routing.c
 * kerneldoc ./net/batman-adv/tp_meter.c
 * kerneldoc ./net/batman-adv/types.h
 * kerneldoc include/uapi/linux/batadv_packet.h
 * smatch linux-3.10 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-3.10 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-3.11 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-3.15 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-3.16 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch linux-3.16 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-3.18 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch linux-3.19 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch linux-3.19 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-3.4 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-3.5 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-3.7 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-4.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch linux-4.10 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-4.10 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch linux-4.11 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch linux-4.12 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch linux-4.15 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-4.4 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-4.6 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
 * smatch linux-4.6 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-4.8 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=y CONFIG_BATMAN_ADV_MCAST=n CONFIG_BATMAN_ADV_BATMAN_V=n
 * smatch linux-4.9 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
 * sparse linux-3.10 cfg: BLA=n DAT=y DEBUGFS=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse linux-3.10 cfg: BLA=y DAT=y DEBUGFS=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse linux-3.11 cfg: BLA=y DAT=n DEBUGFS=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse linux-3.15 cfg: BLA=y DAT=y DEBUGFS=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse linux-3.16 cfg: BLA=y DAT=n DEBUGFS=y DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse linux-3.16 cfg: BLA=y DAT=y DEBUGFS=n DEBUG=n NC=y MCAST=y BATMAN_V=n
 * sparse linux-3.18 cfg: BLA=y DAT=y DEBUGFS=y DEBUG=y NC=y MCAST=y BATMAN_V=y
 * sparse linux-3.19 cfg: BLA=n DAT=n DEBUGFS=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse linux-3.19 cfg: BLA=n DAT=y DEBUGFS=n DEBUG=n NC=y MCAST=y BATMAN_V=n
 * sparse linux-3.4 cfg: BLA=y DAT=n DEBUGFS=n DEBUG=n NC=y MCAST=n BATMAN_V=n
 * sparse linux-3.5 cfg: BLA=y DAT=n DEBUGFS=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse linux-3.7 cfg: BLA=n DAT=n DEBUGFS=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse linux-4.0 cfg: BLA=y DAT=n DEBUGFS=n DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse linux-4.10 cfg: BLA=n DAT=y DEBUGFS=y DEBUG=y NC=y MCAST=y BATMAN_V=n
 * sparse linux-4.10 cfg: BLA=y DAT=n DEBUGFS=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse linux-4.11 cfg: BLA=y DAT=n DEBUGFS=y DEBUG=y NC=n MCAST=n BATMAN_V=y
 * sparse linux-4.12 cfg: BLA=y DAT=n DEBUGFS=y DEBUG=y NC=n MCAST=y BATMAN_V=y
 * sparse linux-4.15 cfg: BLA=y DAT=y DEBUGFS=y DEBUG=n NC=y MCAST=y BATMAN_V=n
 * sparse linux-4.4 cfg: BLA=n DAT=y DEBUGFS=y DEBUG=n NC=n MCAST=y BATMAN_V=n
 * sparse linux-4.6 cfg: BLA=y DAT=n DEBUGFS=y DEBUG=n NC=n MCAST=y BATMAN_V=y
 * sparse linux-4.6 cfg: BLA=y DAT=y DEBUGFS=y DEBUG=n NC=n MCAST=n BATMAN_V=n
 * sparse linux-4.8 cfg: BLA=y DAT=y DEBUGFS=n DEBUG=n NC=y MCAST=n BATMAN_V=n
 * sparse linux-4.9 cfg: BLA=n DAT=y DEBUGFS=y DEBUG=y NC=n MCAST=y BATMAN_V=n


Output of different failed tests
================================

ecsv/pu: checkpatch ./net/batman-adv/bat_v_elp.c
------------------------------------------------

    WARNING: line over 80 characters
    #183: FILE: ./net/batman-adv/bat_v_elp.c:183:
    +   last_tp_run_msecs = jiffies_to_msecs(jiffies - neigh->bat_v.last_tp_meter_run);
    
    total: 0 errors, 1 warnings, 0 checks, 604 lines checked

ecsv/pu: checkpatch ./net/batman-adv/tp_meter.c
-----------------------------------------------

    WARNING: line over 80 characters
    #238: FILE: ./net/batman-adv/tp_meter.c:238:
    +           cookie = batadv_tp_session_cookie(tp_vars->session, tp_vars->icmp_uid);
    
    WARNING: line over 80 characters
    #241: FILE: ./net/batman-adv/tp_meter.c:241:
    +                   batadv_netlink_tpmeter_notify(bat_priv, tp_vars->other_end,
    
    WARNING: line over 80 characters
    #249: FILE: ./net/batman-adv/tp_meter.c:249:
    +                                         BATADV_TP_REASON_COMPLETE, test_time,
    
    WARNING: line over 80 characters
    #287: FILE: ./net/batman-adv/tp_meter.c:287:
    +                                   struct batadv_hardif_neigh_node *hardif_neigh)
    
    WARNING: line over 80 characters
    #291: FILE: ./net/batman-adv/tp_meter.c:291:
    +           batadv_netlink_tpmeter_notify(bat_priv, dst, reason, 0, 0, cookie);
    
    CHECK: Please don't use multiple blank lines
    #643: FILE: ./net/batman-adv/tp_meter.c:643:
    +
    +
    
    ERROR: code indent should use tabs where possible
    #966: FILE: ./net/batman-adv/tp_meter.c:966:
    +        /* init work item that will actually execute the test and schedule it */$
    
    ERROR: code indent should use tabs where possible
    #967: FILE: ./net/batman-adv/tp_meter.c:967:
    +        INIT_WORK(&tp_vars->test_work, batadv_tp_send);$
    
    WARNING: please, no spaces at the start of a line
    #967: FILE: ./net/batman-adv/tp_meter.c:967:
    +        INIT_WORK(&tp_vars->test_work, batadv_tp_send);$
    
    ERROR: code indent should use tabs where possible
    #968: FILE: ./net/batman-adv/tp_meter.c:968:
    +        queue_work(batadv_tp_meter_queue, &tp_vars->test_work);$
    
    WARNING: please, no spaces at the start of a line
    #968: FILE: ./net/batman-adv/tp_meter.c:968:
    +        queue_work(batadv_tp_meter_queue, &tp_vars->test_work);$
    
    WARNING: line over 80 characters
    #981: FILE: ./net/batman-adv/tp_meter.c:981:
    +                u32 test_length, u32 *cookie, enum batadv_tp_meter_caller caller)
    
    WARNING: line over 80 characters
    #999: FILE: ./net/batman-adv/tp_meter.c:999:
    +           batadv_tp_caller_init_error(bat_priv, caller, BATADV_TP_REASON_TOO_MANY,
    
    WARNING: Possible unnecessary 'out of memory' message
    #1006: FILE: ./net/batman-adv/tp_meter.c:1006:
    +   if (!tp_vars) {
    +           batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
    
    WARNING: line over 80 characters
    #1009: FILE: ./net/batman-adv/tp_meter.c:1009:
    +           batadv_tp_caller_init_error(bat_priv, caller, BATADV_TP_REASON_MEMORY_ERROR,
    
    ERROR: code indent should use tabs where possible
    #1543: FILE: ./net/batman-adv/tp_meter.c:1543:
    +                          struct batadv_hard_iface *recv_if,$
    
    WARNING: please, no spaces at the start of a line
    #1543: FILE: ./net/batman-adv/tp_meter.c:1543:
    +                          struct batadv_hard_iface *recv_if,$
    
    ERROR: code indent should use tabs where possible
    #1544: FILE: ./net/batman-adv/tp_meter.c:1544:
    +                          struct sk_buff *skb)$
    
    WARNING: please, no spaces at the start of a line
    #1544: FILE: ./net/batman-adv/tp_meter.c:1544:
    +                          struct sk_buff *skb)$
    
    total: 5 errors, 13 warnings, 1 checks, 1588 lines checked

ecsv/pu: checkpatch ./net/batman-adv/types.h
--------------------------------------------

    WARNING: line over 80 characters
    #587: FILE: ./net/batman-adv/types.h:587:
    +   /** @tp_meter_running: tp meter measurements towards this neighbor in progress */
    
    CHECK: Avoid using bool structure members because of possible alignment issues - see: https://lkml.org/lkml/2017/11/21/384
    #588: FILE: ./net/batman-adv/types.h:588:
    +   bool tp_meter_running;
    
    WARNING: line over 80 characters
    #590: FILE: ./net/batman-adv/types.h:590:
    +   /** @last_tp_meter_run: timestamp of last tp meter measurement completion */
    
    ERROR: code indent should use tabs where possible
    #1367: FILE: ./net/batman-adv/types.h:1367:
    +        /** @caller: caller of tp meter session (user space or ELP) */$
    
    ERROR: code indent should use tabs where possible
    #1370: FILE: ./net/batman-adv/types.h:1370:
    +        /** @sending: sending binary semaphore: 1 if sending, 0 is not */$
    
    ERROR: code indent should use tabs where possible
    #1379: FILE: ./net/batman-adv/types.h:1379:
    +        /** @test_work: work item for the test process */$
    
    ERROR: code indent should use tabs where possible
    #1382: FILE: ./net/batman-adv/types.h:1382:
    +        /** @test_length: test length in milliseconds */$
    
    total: 4 errors, 2 warnings, 1 checks, 2455 lines checked

ecsv/pu: headers
----------------

    diff --git a/build/net/batman-adv/bat_v_elp.h b/build/net/batman-adv/bat_v_elp.h
    index d87886b..cc6af92 100644
    --- a/build/net/batman-adv/bat_v_elp.h
    +++ b/build/net/batman-adv/bat_v_elp.h
    @@ -19,6 +19,8 @@
     #ifndef _NET_BATMAN_ADV_BAT_V_ELP_H_
     #define _NET_BATMAN_ADV_BAT_V_ELP_H_
     
     #include "main.h" // IWYU pragma: keep
    +
    +#include <linux/types.h>
     
     struct sk_buff;
    diff --git a/build/net/batman-adv/tp_meter.c b/build/net/batman-adv/tp_meter.c
    index 770a95d..442580a 100644
    --- a/build/net/batman-adv/tp_meter.c
    +++ b/build/net/batman-adv/tp_meter.c
    @@ -17,6 +17,8 @@
      */
     
     #include "tp_meter.h"
     #include "main.h" // IWYU pragma: keep
     
     #include <linux/atomic.h>
    @@ -24,7 +26,7 @@
     #include <linux/byteorder/generic.h>
     #include <linux/cache.h>
     #include <linux/compiler.h>
    -#include <linux/err.h>
    +#include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/gfp.h>
     #include <linux/if_ether.h>
    @@ -35,7 +37,6 @@
     #include <linux/list.h>
    +#include <linux/log2.h>
     #include <linux/netdevice.h>
     #include <linux/param.h>
    -#include <linux/printk.h>
     #include <linux/random.h>
     #include <linux/rculist.h>
     #include <linux/rcupdate.h>
    @@ -51,12 +52,12 @@
     #include <uapi/linux/batadv_packet.h>
     #include <uapi/linux/batman_adv.h>
     
    +#include "bat_v_elp.h"
     #include "hard-interface.h"
     #include "log.h"
     #include "netlink.h"
     #include "originator.h"
     #include "send.h"
    -#include "bat_v_elp.h"
     
     /**
      * BATADV_TP_DEF_TEST_LENGTH - Default test length if not specified by the user

ecsv/pu: kerneldoc ./net/batman-adv/routing.c
---------------------------------------------

    ./net/batman-adv/routing.c:234: warning: Function parameter or member 'recv_if' not described in 'batadv_recv_my_icmp_packet'

ecsv/pu: kerneldoc ./net/batman-adv/tp_meter.c
----------------------------------------------

    ./net/batman-adv/tp_meter.c:288: warning: Function parameter or member 'hardif_neigh' not described in 'batadv_tp_caller_init_error'
    ./net/batman-adv/tp_meter.c:620: warning: Function parameter or member 'bat_priv' not described in 'batadv_tp_send_msg'
    ./net/batman-adv/tp_meter.c:620: warning: Excess function parameter 'src' description in 'batadv_tp_send_msg'
    ./net/batman-adv/tp_meter.c:620: warning: Excess function parameter 'orig_node' description in 'batadv_tp_send_msg'
    ./net/batman-adv/tp_meter.c:889: warning: Function parameter or member 'work' not described in 'batadv_tp_send'
    ./net/batman-adv/tp_meter.c:889: warning: Excess function parameter 'arg' description in 'batadv_tp_send'
    ./net/batman-adv/tp_meter.c:982: warning: Function parameter or member 'neigh' not described in 'batadv_tp_start'
    ./net/batman-adv/tp_meter.c:1194: warning: Function parameter or member 'tp_vars' not described in 'batadv_tp_send_ack'
    ./net/batman-adv/tp_meter.c:1194: warning: Excess function parameter 'dst' description in 'batadv_tp_send_ack'
    ./net/batman-adv/tp_meter.c:1389: warning: Function parameter or member 'recv_if' not described in 'batadv_tp_init_recv'
    ./net/batman-adv/tp_meter.c:1461: warning: Function parameter or member 'recv_if' not described in 'batadv_tp_recv_msg'
    ./net/batman-adv/tp_meter.c:1545: warning: Function parameter or member 'recv_if' not described in 'batadv_tp_meter_recv'
    ./net/batman-adv/tp_meter.c:1570: warning: No description found for return value of 'batadv_tp_meter_init'

ecsv/pu: kerneldoc ./net/batman-adv/types.h
-------------------------------------------

    ./net/batman-adv/types.h:1469: warning: Function parameter or member 'hardif_neigh' not described in 'batadv_tp_vars'

ecsv/pu: kerneldoc include/uapi/linux/batadv_packet.h
-----------------------------------------------------

    include/uapi/linux/batadv_packet.h:359: warning: Enum value 'BATADV_TP_MSG_LINK' not described in enum 'batadv_icmp_tp_subtype'

ecsv/pu: smatch linux-4.0 CONFIG_BATMAN_ADV_BLA=y CONFIG_BATMAN_ADV_DAT=n CONFIG_BATMAN_ADV_DEBUGFS=n CONFIG_BATMAN_ADV_DEBUG=n CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=y
---------------------------------------------------------------------------

    /home/build_test/build_env/tmp.CtNjyfTqvL/build/net/batman-adv/tp_meter.c:1086 batadv_tp_start() error:  locking inconsistency.  We assume 'spin_lock:&bat_priv->tp_list_lock' is both locked and unlocked at the start.
    /home/build_test/build_env/tmp.CtNjyfTqvL/build/net/batman-adv/tp_meter.c:1086 batadv_tp_start() error:  locking inconsistency.  We assume 'bottom_half:' is both locked and unlocked at the start.
    /home/build_test/build_env/tmp.CtNjyfTqvL/build/net/batman-adv/tp_meter.c:1086 batadv_tp_start() warn: inconsistent returns 'spin_lock:&bat_priv->tp_list_lock'.
      Locked on:   line 1011
      Unlocked on: line 1001
                   line 1086
    /home/build_test/build_env/tmp.CtNjyfTqvL/build/net/batman-adv/tp_meter.c:1086 batadv_tp_start() warn: inconsistent returns 'bottom_half:'.
      Locked on:   line 1011
      Unlocked on: line 1001
                   line 1086

ecsv/pu: smatch linux-4.9 CONFIG_BATMAN_ADV_BLA=n CONFIG_BATMAN_ADV_DAT=y CONFIG_BATMAN_ADV_DEBUGFS=y CONFIG_BATMAN_ADV_DEBUG=y CONFIG_BATMAN_ADV_NC=n CONFIG_BATMAN_ADV_MCAST=y CONFIG_BATMAN_ADV_BATMAN_V=n
---------------------------------------------------------------------------

    /home/build_test/build_env/tmp.CtNjyfTqvL/build/net/batman-adv/tp_meter.c:1086 batadv_tp_start() error:  locking inconsistency.  We assume 'spin_lock:&bat_priv->tp_list_lock' is both locked and unlocked at the start.
    /home/build_test/build_env/tmp.CtNjyfTqvL/build/net/batman-adv/tp_meter.c:1086 batadv_tp_start() error:  locking inconsistency.  We assume 'bottom_half:' is both locked and unlocked at the start.

ecsv/pu: sparse linux-4.9 cfg: BLA=n DAT=y DEBUGFS=y DEBUG=y NC=n MCAST=y BATMAN_V=n
---------------------------------------------------------------------------

    /home/build_test/build_env/tmp.CtNjyfTqvL/build/net/batman-adv/tp_meter.c:996:31: warning: context imbalance in 'batadv_tp_start' - unexpected unlock


Statistics
==========

ecsv/pu
-------

Failed tests:                54
Started build tests:         30
Tested Linux versions:       21
Tested configs:              27
--nextPart6784022.7JZtmBBcXA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrx7igACgkQXYcKB8Em
e0bm2g//WlwH0wLOvKTzs//eZH1uIo7CDlXsVV/kbjZR9UzX0NalzFLP9jG1aj6J
ZCmqIFL2mFmOAvW2QXEvFyPdgG1idJJMnBKBZpYlfaIHCJqJMWNHWCAv41YnJvHp
uzD7EiknOOnf1eJMy/xT57i++BgNzeJ7qCU2MCTlkChXG/Q3mqaAebTWMSCmInI4
TR35GrsyGWkm2LPrYBMpmTXC76P0a5OYrWA36ilYMh35rdPJGzNXZKJm8cTByCuI
WstYHiz2XZ5q/WHQnOaopEzr7mzdvcuPtr9kCjEDy0pEsfwkkYw3SepSUNvOJG+a
tiGzF022lkzDT8R2uV6m9bAXvdgZk1acJmn3P0X7jopvVfnk9VQKH7/EWVnra50F
J6gN2xkJa9VjvilSMWuj/eDoIrZZaEv6w/7Alvb0Ec6zCISGkIgnEa3H2aN8AzTU
ujilQuF+iB5E/djHjxvPmGyVKcWUfEFWtx7OPe7K0AZvSVLpMLldkIZsBei7K5b6
KcqmnBZtBgDJKrsKalsytiCJfHlnHy56pR+KZ+X7lWsqyKgkuwjqsl625gYsyblS
8FmPaElX3RfcC8Yoxfy3qOfr3JuE0AbD++jr4vqjtAUuakCpLMP0+IybRTkQuWTR
TcMyey0Tl/fOuedyHMHLIRN96L3I0o9Oxt4XY9E//Bxbg9fhsPk=
=nO6H
-----END PGP SIGNATURE-----

--nextPart6784022.7JZtmBBcXA--



