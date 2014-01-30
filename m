Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 30 Jan 2014 15:52:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20140130125206.GA23793@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] question about min_t() casting in
	batadv_hardif_min_mtu()
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
To: sven@narfation.org, Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hello Batman devs,

I always worry when I see people do min_t(int, foo, bar) and there are
a couple cases which concern me in batman.

Changing the mtu is allowed for people who have admin rights in their
namespace.  In other words we check:
	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
as opposed to:
	if (!capable(net->user_ns, CAP_NET_ADMIN))
So mtu has security implications.

net/batman-adv/hard-interface.c
   240  int batadv_hardif_min_mtu(struct net_device *soft_iface)
   241  {
   242          struct batadv_priv *bat_priv = netdev_priv(soft_iface);
   243          const struct batadv_hard_iface *hard_iface;
   244          int min_mtu = ETH_DATA_LEN;
   245  
   246          rcu_read_lock();
   247          list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
   248                  if ((hard_iface->if_status != BATADV_IF_ACTIVE) &&
   249                      (hard_iface->if_status != BATADV_IF_TO_BE_ACTIVATED))
   250                          continue;
   251  
   252                  if (hard_iface->soft_iface != soft_iface)
   253                          continue;
   254  
   255                  min_mtu = min_t(int, hard_iface->net_dev->mtu, min_mtu);
                                        ^^^
Ok.  This is fine because dev_set_mtu() will not allow negative mtus.

   256          }
   257          rcu_read_unlock();
   258  
   259          atomic_set(&bat_priv->packet_size_max, min_mtu);
   260  
   261          if (atomic_read(&bat_priv->fragmentation) == 0)
   262                  goto out;
   263  
   264          /* with fragmentation enabled the maximum size of internally generated
   265           * packets such as translation table exchanges or tvlv containers, etc
   266           * has to be calculated
   267           */
   268          min_mtu = min_t(int, min_mtu, BATADV_FRAG_MAX_FRAG_SIZE);
                                ^^^
Still fine.

   269          min_mtu -= sizeof(struct batadv_frag_packet);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I worry that this could be negative.

   270          min_mtu *= BATADV_FRAG_MAX_FRAGMENTS;
   271          atomic_set(&bat_priv->packet_size_max, min_mtu);
                                                       ^^^^^^^
Could a negative cause problems here?

   272  
   273          /* with fragmentation enabled we can fragment external packets easily */
   274          min_mtu = min_t(int, min_mtu, ETH_DATA_LEN);
                ^^^^^^^
min_mtu would still be negative here.

   275  
   276  out:
   277          return min_mtu - batadv_max_header_len();
   278  }

regards,
dan carpenter
