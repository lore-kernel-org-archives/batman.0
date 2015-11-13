Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 13 Nov 2015 20:46:21 +0100
Message-Id: <1447443981-28246-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: Remove recursive bat-on-bat
	netdevice check
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
Cc: Jetmir Gigollai <jetmir_gigollaj@web.de>

batman-adv checks in different situation if a new device is already on top
of a different batman-adv device. This is done by getting the iflink of a
device and all its parent. It assumes that this iflink is always a parent
device in an acyclic graph. But this assumption is broken by devices like
veth which are actually a pair of two devices linked to each other. The
recursive check would therefore get veth0 when calling dev_get_iflink on
veth1. And it gets veth0 when calling dev_get_iflink with veth1.

Creating a veth pair and loading batman-adv freezes parts of the system

    ip link add veth0 type veth peer name veth1
    modprobe batman-adv

An RCU stall will be detected on the system which cannot be fixed.

    INFO: rcu_sched self-detected stall on CPU
            1: (5264 ticks this GP) idle=3e9/140000000000001/0
    softirq=144683/144686 fqs=5249
             (t=5250 jiffies g=46 c=45 q=43)
    Task dump for CPU 1:
    insmod          R  running task        0   247    245 0x00000008
     ffffffff8151f140 ffffffff8107888e ffff88000fd141c0 ffffffff8151f140
     0000000000000000 ffffffff81552df0 ffffffff8107b420 0000000000000001
     ffff88000e3fa700 ffffffff81540b00 ffffffff8107d667 0000000000000001
    Call Trace:
     <IRQ>  [<ffffffff8107888e>] ? rcu_dump_cpu_stacks+0x7e/0xd0
     [<ffffffff8107b420>] ? rcu_check_callbacks+0x3f0/0x6b0
     [<ffffffff8107d667>] ? hrtimer_run_queues+0x47/0x180
     [<ffffffff8107cf9d>] ? update_process_times+0x2d/0x50
     [<ffffffff810873fb>] ? tick_handle_periodic+0x1b/0x60
     [<ffffffff810290ae>] ? smp_trace_apic_timer_interrupt+0x5e/0x90
     [<ffffffff813bbae2>] ? apic_timer_interrupt+0x82/0x90
     <EOI>  [<ffffffff812c3fd7>] ? __dev_get_by_index+0x37/0x40
     [<ffffffffa0031f3e>] ? batadv_hard_if_event+0xee/0x3a0 [batman_adv]
     [<ffffffff812c5801>] ? register_netdevice_notifier+0x81/0x1a0
    [...]

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Cc: Jetmir Gigollai <jetmir_gigollaj@web.de>
---
 compat-include/linux/netdevice.h |  6 ------
 net/batman-adv/hard-interface.c  | 42 ----------------------------------------
 2 files changed, 48 deletions(-)

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index f19f624..0e4fcc8 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -111,10 +111,4 @@ static inline int batadv_netdev_set_master(struct net_device *slave,
 
 #endif /* < KERNEL_VERSION(3, 17, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 1, 0)
-
-#define dev_get_iflink(_net_dev) ((_net_dev)->iflink)
-
-#endif /* < KERNEL_VERSION(3, 19, 0) */
-
 #endif	/* _NET_BATMAN_ADV_COMPAT_LINUX_NETDEVICE_H_ */
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bef9147..0c2643d 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -75,44 +75,6 @@ out:
 	return hard_iface;
 }
 
-/**
- * batadv_is_on_batman_iface - check if a device is a batman iface descendant
- * @net_dev: the device to check
- *
- * If the user creates any virtual device on top of a batman-adv interface, it
- * is important to prevent this new interface to be used to create a new mesh
- * network (this behaviour would lead to a batman-over-batman configuration).
- * This function recursively checks all the fathers of the device passed as
- * argument looking for a batman-adv soft interface.
- *
- * Return: true if the device is descendant of a batman-adv mesh interface (or
- * if it is a batman-adv interface itself), false otherwise
- */
-static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
-{
-	struct net_device *parent_dev;
-	bool ret;
-
-	/* check if this is a batman-adv mesh interface */
-	if (batadv_softif_is_valid(net_dev))
-		return true;
-
-	/* no more parents..stop recursion */
-	if (dev_get_iflink(net_dev) == 0 ||
-	    dev_get_iflink(net_dev) == net_dev->ifindex)
-		return false;
-
-	/* recurse over the parent device */
-	parent_dev = __dev_get_by_index(&init_net, dev_get_iflink(net_dev));
-	/* if we got a NULL parent_dev there is something broken.. */
-	if (WARN(!parent_dev, "Cannot find parent device"))
-		return false;
-
-	ret = batadv_is_on_batman_iface(parent_dev);
-
-	return ret;
-}
-
 static int batadv_is_valid_iface(const struct net_device *net_dev)
 {
 	if (net_dev->flags & IFF_LOOPBACK)
@@ -124,10 +86,6 @@ static int batadv_is_valid_iface(const struct net_device *net_dev)
 	if (net_dev->addr_len != ETH_ALEN)
 		return 0;
 
-	/* no batman over batman */
-	if (batadv_is_on_batman_iface(net_dev))
-		return 0;
-
 	return 1;
 }
 
-- 
2.6.2

