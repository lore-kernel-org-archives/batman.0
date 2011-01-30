Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Jan 2011 02:52:55 +0100
Message-Id: <1296352379-1546-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] Reordered rcu refcounting
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

Hi,

I told Linus and Marek that the implementation of some datastructures using
reference counting and RCUs must be redesigned. The problem is that call_rcu
should only be used when the reference count is zero because multiple call_rcu
cannot be initiated at the same time. The next problem is that we may try to
access an element with the refcount 0 when we try to traverse a rcu protected
list. This problem cannot be solved by kref - thus we have to use atomic_t
again to _not_ increase the reference count when it was already zero.

Marek asked me what we must change - I try to summarize those things in the
following patches. They aren't tested and should only be seen as suggestions
what must be done to finish the "remove orig_hash lock"-patches.

If you try these patches then please keep in mind that they will sell your soul
to the next confectioner (for some cookies or a pie).

More information can be found inside Documentation/RCU/rcuref.txt

Btw, maybe I've found a bug inside the find_router with enabled bonding (see
"BUG" in patch 4).

Best regards,
	Sven
