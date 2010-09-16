Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 16 Sep 2010 22:18:33 +0200
Message-Id: <1284668317-19890-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Initial rcu locking patchset
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
To: b.a.t.m.a.n@lists.open-mesh.net

Hi,

I tried to check through the code and identify problems not yet mentioned by
Paul E. McKenney. They were found by reading through
Documentation/RCU/checklist.txt and related documents in the folder.

It doesn't address the reference counting problem for gw_nodes and interfaces.
Those leaks are happen in gw_election, get_batman_if_by_netdev and
get_active_batman_if. We must increase the refcnt (using atomic_inc) inside the
rcu_read_lock()..rcu_read_unlock() before we attach to the structure it
"leaks". When another function now removed it from its usage context
(primary_if, usage on stack, ...) then atomic_dec_and_test the refcnt. If it is
decremented to zero then we can issue the call_rcu to the freeing function. So
"put" of those functions is not allowed inside an rcu_read_lock. As said before
the hold must always be called inside a rcu_read_lock.

Best regards,
	Sven
