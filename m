Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@saxnet.de>
Date: Sun, 30 Jan 2011 05:39:08 +0100
Message-Id: <1296362366-3852-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] B.A.T.M.A.N.-Advanced Multicast Optimizations, v3
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

here's the third iteration of the multicast patches which is mainly some
bugfixing, smaller but also slightly larger restructuring.
Thanks for the feedback again!

Cheers, Linus

= Changelog v3 =

* rebasing to commit [8bb3d9422707a7814ac804acbc00569dd017288c]
* 4B-aligning for 'struct mcast_entry', adding __packed attribute [01/19]
* converted  mcast_forw_table and subsequent lists to hlists
  [10/19], [11/19], [12/19], [13/19]
* splitted mcast_forw_table_seq_print_text into several functions
  [11/19]
* shorter rcu-locking when printing to sysfs, only in seq_print_if_entry
  [11/19]
* add missing spin_lock initilization [10/19]
* fix logic for break_flag in tracker_packet_for_each() macro [07/19]
* compat.h, should be "#define MC_LIST struct netdev_hw_addr" instead [03/19]
* adding mcast duplicate check seqno lock [17/19]
* fixed rcu-locking in route_mcast_tracker_packet(),
  in fact, using refcounting there now [07/19]
* restructuring route_mcast_tracker_packet(), merging two loops
* also delete dest from tracker packet if unknown originator
  in zero_tracker_packet() [07/19]
* compactify check-code in zero_tracker_packet() [07/19]
* don't use index i like nexthop_tracker_packets[i] in skb sending loop in
  route_mcast_tracker_packet(), it has the wrong base [07/19]
* use hash_find() instead of own orig_node look-up in zero_tracker_packt()
  and add_router_of_dest() [07/19]
* reserve dest_entries on heap instead of stack, >4k is too much for the stack
  [07/19]
* rename dest_entries_list to dest_entries_buckets, trying to clarify its
  purpose [07/19]
* add comment for find_mca_match() [07/19]
* move comments for zero_tracker_packet() and shrink_tracker_packet()
to the correct patches [10/19]
* remove wrong comment for sync_orig() (duplicate of sync_table()) [10/19]
* remove variable name defines for net_device multicast lists [03/19]
* directly create & use SKBs for tracker_packets [07/19], [09/19]
* moving stuff from mcast_proact_tracker_prepare() to build_tracker_packet_skb()
  [07/19]
* only create methods / variables / defines / macros in patches that need them
  (this changed the BAT_MCAST/MCAST_TRACKER define numbers)
  -[01/19], -[03/19]
* use rcu-locking for mcast_forw_table, +[18]
