Return-Path: <zukky@bb.banban.jp>
Message-ID: <4C7720F1.5030604@bb.banban.jp>
Date: Fri, 27 Aug 2010 11:20:33 +0900
From: Kazuki Shimada <zukky@bb.banban.jp>
MIME-Version: 1.0
References: <4C6437BF.9080909@web.de>
	<201008210801.17503.lindner_marek@yahoo.de>
	<4C760EEB.4000001@bb.banban.jp>
	<201008261028.35755.sven.eckelmann@gmx.de>
In-Reply-To: <201008261028.35755.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] problem openwrt-trunk + ath5k + batman-adv-devel
 in my case
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

  Hi, Sven.

> How did you connect? Using serial console or using lan (from output I would
> guess serial console).
Yes, it's serial console.

> Does the hang always happen?
Yes.

> Can you add printks in hard-interface.c around the call of
> hardif_remove_interface inside hard_if_event to check if it stops inside that
> function and if it does then please try to add more printks inside of
> hardif_remove_interface and hardif_disable_interface.
I added printk() in hard-interface.c and soft-interface.c.
This is it.

-----------------------------------------------------------------------------------------------------------------------------------------------
root@OpenWrt:/# cd /etc/config/
root@OpenWrt:/etc/config# cat batman-adv

config 'mesh' 'bat0'
         option 'interfaces' 'wlan0'
         option 'orig_interval'
         option 'log_level'
         option 'aggregate_ogm'
         option 'vis_mode'
root@OpenWrt:/etc/config# cat network
# Copyright (C) 2006 OpenWrt.org

config interface loopback
         option ifname   lo
         option proto    static
         option ipaddr   127.0.0.1
         option netmask  255.0.0.0

config interface lan
         option ifname   'eth0 eth1 bat0'
         option type     bridge
         option proto    static
         option ipaddr   192.168.2.12
         option netmask  255.255.255.0
root@OpenWrt:/etc/config# cat wireless
config wifi-device  radio0
         option type     mac80211
         option channel  1
         option macaddr  00:0b:6b:2d:f4:91
         option hwmode   11g

         # REMOVE THIS LINE TO ENABLE WIFI:
#       option disabled 1

config wifi-iface
         option device   radio0
#       option network  lan
         option mode     adhoc
         option ssid     mesh1
         option encryption none

config wifi-device  radio1
         option type     mac80211
         option channel  6
         option macaddr  00:0b:6b:2c:15:e3
         option hwmode   11g

         # REMOVE THIS LINE TO ENABLE WIFI:
#       option disabled 1

config wifi-iface
         option device   radio1
#       option network  lan
         option mode     adhoc
         option ssid     mesh2
         option encryption none

root@OpenWrt:/etc/config# /etc/init.d/network restart
br-lan: port 3(bat0) entering disabled state
br-lan: port 1(eth0) entering disabled state
device bat0 left promiscuous mode
br-lan: port 3(bat0) entering disabled state
device eth1 left promiscuous mode
br-lan: port 2(eth1) entering disabled state
device eth0 left promiscuous mode
br-lan: port 1(eth0) entering disabled state
enter hardif_remove_interface
1 hardif_remove_interface
2 hardif_remove_interface
3 hardif_remove_interface
4 hardif_remove_interface
5 hardif_remove_interface
6 hardif_remove_interface
exit hardif_remove_interface
eth0: link down
device eth0 entered promiscuous mode
eth0: link up, speed 100 Mb/s, full duplex
br-lan: port 1(eth0) entering forwarding state
device eth1 entered promiscuous mode
device bat0 entered promiscuous mode
br-lan: port 3(bat0) entering forwarding state
batman_adv: bat0: Interface deactivated: wlan0
enter hardif_remove_interface
enter hardif_disable_interface
batman_adv: bat0: Removing interface: wlan0
1 hardif_disable_interface
2 hardif_disable_interface
3 hardif_disable_interface
4 hardif_disable_interface
5 hardif_disable_interface
6 hardif_disable_interface
7 hardif_disable_interface
8 hardif_disable_interface
9 hardif_disable_interface
10 hardif_disable_interface
enter softif_destroy
1 softif_destroy
2 softif_destroy
3 softif_destroy
-----------------------------------------------------------------------------------------------------------------------------------------------
<hard-interface.c>

void hardif_disable_interface(struct batman_if *batman_if)
{
printk(KERN_ALERT "enter hardif_disable_interface\n");
         struct bat_priv *bat_priv = netdev_priv(batman_if->soft_iface);

         if (batman_if->if_status == IF_ACTIVE)
                 hardif_deactivate_interface(batman_if);

         if (batman_if->if_status != IF_INACTIVE)
                 return;

         bat_info(batman_if->soft_iface, "Removing interface: %s\n",
                  batman_if->net_dev->name);
printk(KERN_ALERT "1 hardif_disable_interface\n");
         dev_remove_pack(&batman_if->batman_adv_ptype);
printk(KERN_ALERT "2 hardif_disable_interface\n");
         if (batman_if->if_status != IF_INACTIVE)
                 return;

         bat_info(batman_if->soft_iface, "Removing interface: %s\n",
                  batman_if->net_dev->name);
printk(KERN_ALERT "1 hardif_disable_interface\n");
         dev_remove_pack(&batman_if->batman_adv_ptype);
printk(KERN_ALERT "2 hardif_disable_interface\n");

         bat_priv->num_ifaces--;
printk(KERN_ALERT "3 hardif_disable_interface\n");
         orig_hash_del_if(batman_if, bat_priv->num_ifaces);
printk(KERN_ALERT "4 hardif_disable_interface\n");

         if (batman_if == bat_priv->primary_if)
                 set_primary_if(bat_priv,
                                
get_active_batman_if(batman_if->soft_iface));

printk(KERN_ALERT "5 hardif_disable_interface\n");
         kfree(batman_if->packet_buff);
printk(KERN_ALERT "6 hardif_disable_interface\n");
         batman_if->packet_buff = NULL;
printk(KERN_ALERT "7 hardif_disable_interface\n");
         batman_if->if_status = IF_NOT_IN_USE;

         /* delete all references to this batman_if */
         purge_orig_ref(bat_priv);
printk(KERN_ALERT "8 hardif_disable_interface\n");
         purge_outstanding_packets(bat_priv, batman_if);
printk(KERN_ALERT "9 hardif_disable_interface\n");
         dev_put(batman_if->soft_iface);
printk(KERN_ALERT "10 hardif_disable_interface\n");

         /* nobody uses this interface anymore */
         if (!bat_priv->num_ifaces)
                 softif_destroy(batman_if->soft_iface);

printk(KERN_ALERT "11 hardif_disable_interface\n");
         batman_if->soft_iface = NULL;
printk(KERN_ALERT "exit hardif_disable_interface\n");
}


static void hardif_remove_interface(struct batman_if *batman_if)
{
printk(KERN_ALERT "enter hardif_remove_interface\n");
         /* first deactivate interface */
         if (batman_if->if_status != IF_NOT_IN_USE)
                 hardif_disable_interface(batman_if);

printk(KERN_ALERT "1 hardif_remove_interface\n");
         if (batman_if->if_status != IF_NOT_IN_USE)
                 return;

printk(KERN_ALERT "2 hardif_remove_interface\n");
         batman_if->if_status = IF_TO_BE_REMOVED;
printk(KERN_ALERT "3 hardif_remove_interface\n");
         list_del_rcu(&batman_if->list);
printk(KERN_ALERT "4 hardif_remove_interface\n");
         sysfs_del_hardif(&batman_if->hardif_obj);
printk(KERN_ALERT "5 hardif_remove_interface\n");
         dev_put(batman_if->net_dev);
printk(KERN_ALERT "6 hardif_remove_interface\n");
         call_rcu(&batman_if->rcu, hardif_free_interface);
printk(KERN_ALERT "exit hardif_remove_interface\n");
}
-----------------------------------------------------------------------------------------------------------------------------------------------
soft-interface.c

void softif_destroy(struct net_device *soft_iface)
{
printk(KERN_ALERT "enter softif_destroy\n");
         debugfs_del_meshif(soft_iface);
printk(KERN_ALERT "1 softif_destroy\n");
         sysfs_del_meshif(soft_iface);
printk(KERN_ALERT "2 softif_destroy\n");
         mesh_free(soft_iface);
printk(KERN_ALERT "3 softif_destroy\n");
         unregister_netdev(soft_iface);
printk(KERN_ALERT "exit softif_destroy\n");
}
-----------------------------------------------------------------------------------------------------------------------------------------------

"exit softif_destroy\n" is not printed out.
unregister_netdev?

Thanks in advance.

Kazuki Shimada

