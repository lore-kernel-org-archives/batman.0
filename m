Return-Path: <linus.luessing@ascom.ch>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri,  4 Feb 2011 16:21:29 +0100
Message-Id: <1296832896-30081-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201102031802.52134.lindner_marek@yahoo.de>
References: <201102031802.52134.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Reordered rcu refcounting, v3
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

Patches [1-4] are untouched, added my stuff on top of it with some fixes:

* Made sure no rcu_read_lock() while gw_deselect() (gw_election(), gw_check_election())
* Removed orig_node null pointer check in gw_get_selected()
* Removed rcu_dereference() for orig_node
* Rebased to marec's last 4 patches
* Made extra patch for bat_priv->curr_gw rcu protection fixes
* Removed the stupid kref_get() removal which was not supposed to be part of this patch [my old 1/3]
* Removed the wrong kref_get() removal [my old 3/3]

It's all based on "batman-adv: Switch order of types.h and compat.h inclusion" (see separate patchset)
which fixes a compile error in my old [2/3] patch.

Note: rcu_dereference() in gw_node_purge() does not seem to be safe yet, there's
no rcu_read_lock(), so another thread, not through gw_node_purge(), might have just
performed a gw_deselect().

Cheers, Linus
