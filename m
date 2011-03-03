Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Thu,  3 Mar 2011 20:09:01 +0100
Message-Id: <1299179342-15418-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] Null pointer dereference, ticket #146
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

By accident I've typed in a mesh interface name for batman-adv which
already existed as a real interface. This produces a null pointer
dereference in orig_hash_add_if():
http://www.open-mesh.org/ticket/146

The attached patch shall illustrate the problem, but I'm not quite
satisfied with it. Although it seems to "fix" the problem and gets
rid of the call trace, it is probably still very racy. Does anyone
have an idea for a more sane but equally easy check to fix the issue?
Or is the only sane solution to hold an rcu-lock and compare the
hard_iface->soft_iface in hardif_enable_interface() with every
hard-iface->net_dev from the hardif_list?

Cheers, Linus
