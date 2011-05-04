Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  4 May 2011 10:06:28 +0200
Message-Id: <1304496393-16405-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] kfree_rcu patches
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

Paul E. McKenney <paulmck@linux.vnet.ibm.com> proposed some changes
which will reduce the amount of "kfree only" rcu-callback functions. The
batman-adv compatibility layer has to add a similar functionality to
support older kernels.

I wanted to propose a solution which should be discussed before the
kfree_rcu functionality enters Linus' kernel and our master branch.

The amount of kfree_rcu_* function was reduced to support only a maximum
offset of 256 to any 'struct rcu_head' inside a struct. This should be
enough for the current version and supported architectures. Offsets of
4096 are supported by Paul E. McKenney's implementation, but our
workaround would increase the size of the final module too much
(personal opinion).

~~~ These patches should *NOT* enter the batman-adv repo right now ~~~~~

Kind regards,
	Sven
