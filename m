Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri, 31 Dec 2010 16:46:15 +0100
Message-Id: <1293810385-31761-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] NDP patches v4
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi everyone,

thanks for all the feedback and reviewing again. The following updated patches
address Marek's comments and suggestions:
* Introducing a commit for renaming only
* batman_packet_ogm -> ogm_packet, batman_packet_ndp -> ndp_packet
* BAT_UNICAST followed by BAT_UNICAST_FRAG
* structs introduced in the patches where they're used, not earlier
  (ndp_packet, neigh_entry)
* moved own_ndp_send_time to ndp.c
* checkpatch cleaning
* avoid losing ndp-interval setting on interface down/up
* fixed a potential memory leak in error cases
* skb_copy instead of skb_clone
* rebased to trunk
* removal of unnecessary include
* hlist instead of doubly linked list
* added a break in one list traversal
* secure neigh_list with rcu-locking + ref-counting
* rename rq_real_bits to ndp_rq_window
* use msecs_to_jiffies instead of manual HZ multiplication
* fix get_batman_if_by_netdev usage / refcounting
* adding licenses

Furthermore I've changed the following:
* use dev_kfree_skb instead of kfree_skb in case of successful
  ndp packet reception and processing (so no simple NET_RX_DROP return value)
* adding include guards for ndp.h
* use "= seqno - 1" in ndp_create_neighbor(), otherwise ndp_update_neighbor_lq()
  does not update tq/rq/last_valid on first ndp packet

Would be great if someone could check the usage of rcu-locking + refcounting.
I was also a little confused because in "Documentation/RCU/listRCU.txt" list_del_rcu()
and list_add_rcu() are not protected with a spinlock for the list here,
but in the batman-adv code we are usually having those extra locks. Do I have
to leave those spinlocks or can I remove them for adding/deleting entries in the
neigh_list?

Cheers, Linus
