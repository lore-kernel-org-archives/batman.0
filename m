Return-Path: <roland.volkmann@t-online.de>
References: <56F5AF2F.6060904@t-online.de> <3883397.RfpiZdWGix@bentobox>
 <20160329175957.GA6539@r2d2.s.lihas.de> <4605306.DPF6tJRphQ@sven-edge>
From: Roland Volkmann <roland.volkmann@t-online.de>
Message-ID: <56FB11B7.10103@t-online.de>
Date: Wed, 30 Mar 2016 01:37:27 +0200
MIME-Version: 1.0
In-Reply-To: <4605306.DPF6tJRphQ@sven-edge>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

Sven Eckelmann schrieb am 29.03.2016 um 20:55:
> On Tuesday 29 March 2016 19:59:57 Adrian Reyer wrote:
> [...]
>> It is two different things, the num_bcasts in my understanding is 
>> about how many times the originator sends out its packets to assume 
>> everyone has received it. The flag we talk about is about if anyone 
>> receiving that packet on an interface has to send it out on that very 
>> interface at all, e.g. it is about everyone reachable via that 
>> interface sees the same neighbours (e.g. switch) or a different group 
>> (e.g. wlan adhoc) 
> Thats why I said that it would have to be split into *sameif and *otherif.
>
> And btw. it is not about the originator. It is handled in
> batadv_send_outstanding_bcast_packet at the same place where you want to have
> the no_rebroadcast check. no_rebroadcast in the patch we are talking [1,2]
> about is currently just ignoring the num_bcasts of a hard-interface for some
> situations (when forw_packet->skb->dev == hard_iface->net_dev).

Let's have a look to the source code. The interesting part is function 
"static void batadv_send_outstanding_bcast_packet(struct work_struct 
*work)" in file "send.c". There you will find

     soft_iface = forw_packet->if_incoming->soft_iface;
[...]
     /* rebroadcast packet */
     rcu_read_lock();
     list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
         if (hard_iface->soft_iface != soft_iface)   /* !!! */
             continue;

         if (forw_packet->num_packets >= hard_iface->num_bcasts)
             continue;

The if-Statement marked with /* !!! */ results in "true", if 
incoming-interface isn't identical to outgoing-interface. Because the 
patch is included after this line, it is relevant for resending 
broadcasts to the incoming interface only.

Here is an updated version of the patch as it is used in current master 
branch of gluon matching batman-adv 2016.0:

+ net/batman-adv/hard-interface.c                    |  2 +
+ net/batman-adv/send.c                              |  4 ++
+ net/batman-adv/sysfs.c                             | 59 
++++++++++++++++++++++
+ net/batman-adv/types.h                             |  1 +
+ 4 files changed, 66 insertions(+)
+
+diff --git a/net/batman-adv/hard-interface.c 
b/net/batman-adv/hard-interface.c
+index aea4d06..66a703d 100644
+--- a/net/batman-adv/hard-interface.c
++++ b/net/batman-adv/hard-interface.c
+@@ -657,6 +657,8 @@ batadv_hardif_add_interface(struct net_device *net_dev)
+     /* extra reference for return */
+     atomic_set(&hard_iface->refcount, 2);
+
++    atomic_set(&hard_iface->no_rebroadcast, 0);
++
+     batadv_check_known_mac_addr(hard_iface->net_dev);
+     list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
+
+diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
+index c188f46..145f7cb 100644
+--- a/net/batman-adv/send.c
++++ b/net/batman-adv/send.c
+@@ -535,6 +535,10 @@ static void 
batadv_send_outstanding_bcast_packet(struct work_struct *work)
+         if (forw_packet->num_packets >= hard_iface->num_bcasts)
+             continue;
+
++        if (atomic_read(&hard_iface->no_rebroadcast) &&
++            forw_packet->skb->dev == hard_iface->net_dev)
++            continue;
++
+         /* send a copy of the saved skb */
+         skb1 = skb_clone(forw_packet->skb, GFP_ATOMIC);
+         if (skb1)
+diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
+index f38d7b7..600633c 100644
+--- a/net/batman-adv/sysfs.c
++++ b/net/batman-adv/sysfs.c
+@@ -131,6 +131,17 @@ struct batadv_attribute batadv_attr_vlan_##_name = 
{    \
+     .store  = _store,                \
+ }
+
++/* Use this, if you have customized show and store functions
++ * for hard interface attrs
++ */
++#define BATADV_ATTR_HIF(_name, _mode, _show, _store)    \
++struct batadv_attribute batadv_attr_hif_##_name = {    \
++    .attr = {.name = __stringify(_name),        \
++         .mode = _mode },            \
++    .show   = _show,                \
++    .store  = _store,                \
++};
++
+ /* Use this, if you have customized show and store functions */
+ #define BATADV_ATTR(_name, _mode, _show, _store)    \
+ struct batadv_attribute batadv_attr_##_name = {        \
+@@ -241,6 +252,52 @@ ssize_t batadv_show_vlan_##_name(struct kobject 
*kobj,            \
+     static BATADV_ATTR_VLAN(_name, _mode, batadv_show_vlan_##_name,    \
+                 batadv_store_vlan_##_name)
+
++#define BATADV_ATTR_HIF_STORE_BOOL(_name, _post_func)         \
++ssize_t batadv_store_hif_##_name(struct kobject *kobj,         \
++                 struct attribute *attr, char *buff,    \
++                 size_t count)                \
++{                                    \
++    struct net_device *net_dev = batadv_kobj_to_netdev(kobj);    \
++    struct batadv_hard_iface *hard_iface; \
++    size_t res;                            \
++                                    \
++    hard_iface = batadv_hardif_get_by_netdev(net_dev);     \
++    if (!hard_iface)                        \
++        return 0;                        \
++                                    \
++    res = __batadv_store_bool_attr(buff, count, _post_func,        \
++                          attr, &hard_iface->_name,    \
++                          hard_iface->soft_iface); \
++    batadv_hardif_free_ref(hard_iface);                \
++    return res;                            \
++}
++
++#define BATADV_ATTR_HIF_SHOW_BOOL(_name)                \
++ssize_t batadv_show_hif_##_name(struct kobject *kobj,         \
++                struct attribute *attr, char *buff)    \
++{                                    \
++    struct net_device *net_dev = batadv_kobj_to_netdev(kobj);    \
++    struct batadv_hard_iface *hard_iface; \
++    size_t res;                            \
++                                    \
++    hard_iface = batadv_hardif_get_by_netdev(net_dev);     \
++    if (!hard_iface)                        \
++        return 0;                        \
++                                    \
++    res = sprintf(buff, "%s\n",                    \
++              atomic_read(&hard_iface->_name) == 0 ?        \
++                "disabled" : "enabled");        \
++    batadv_hardif_free_ref(hard_iface);                \
++    return res;                            \
++}
++
++/* Use this, if you are going to turn a [name] in the vlan struct on 
or off */
++#define BATADV_ATTR_HIF_BOOL(_name, _mode, _post_func)         \
++    static BATADV_ATTR_HIF_STORE_BOOL(_name, _post_func)        \
++    static BATADV_ATTR_HIF_SHOW_BOOL(_name)     \
++    static BATADV_ATTR_HIF(_name, _mode, batadv_show_hif_##_name,    \
++                   batadv_store_hif_##_name)
++
+ static int batadv_store_bool_attr(char *buff, size_t count,
+                   struct net_device *net_dev,
+                   const char *attr_name, atomic_t *attr,
+@@ -870,10 +927,12 @@ static ssize_t batadv_show_iface_status(struct 
kobject *kobj,
+ static BATADV_ATTR(mesh_iface, S_IRUGO | S_IWUSR, batadv_show_mesh_iface,
+            batadv_store_mesh_iface);
+ static BATADV_ATTR(iface_status, S_IRUGO, batadv_show_iface_status, NULL);
++BATADV_ATTR_HIF_BOOL(no_rebroadcast, S_IRUGO | S_IWUSR, NULL);
+
+ static struct batadv_attribute *batadv_batman_attrs[] = {
+     &batadv_attr_mesh_iface,
+     &batadv_attr_iface_status,
++    &batadv_attr_hif_no_rebroadcast,
+     NULL,
+ };
+
+diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
+index 5e8c8df..913f104 100644
+--- a/net/batman-adv/types.h
++++ b/net/batman-adv/types.h
+@@ -120,6 +120,7 @@ struct batadv_hard_iface {
+     struct hlist_head neigh_list;
+     /* neigh_list_lock protects: neigh_list */
+     spinlock_t neigh_list_lock;
++    atomic_t no_rebroadcast;
+ };
+
+ /**
+--
+2.7.0
+



Best regards,
Roland.

