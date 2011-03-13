Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 13 Mar 2011 20:52:20 +0100
Message-Id: <1300045945-28734-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] Various fixes and clean-ups
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

For one thing, I've changed the orig_node->router dereference as discussed on IRC,
now using an extra getter method for that to reduce the lines of code for
rcu-dereferencing, rcu-locking and refcounting for the router pointer
and to make it easier to keep track of the right refcounting (Patch 4/5). Note,
that the previous version was pretty simple, by just using rcu_dereference() everywhere.
However, this current version is a little more invasive, so would be great if
someone could double check that I didn't introduce any new mem-leaks or
null-pointer-dereferences due to wrong refcounting. It already took me quite
some time to find and squash two bugs I had introduced with this, so
there might be even more in there. I double checked it myself and
also tested it in a 4 node chain toplogy vm setup, though.

For Patch 5/5, I've removed the "TQ value" from the patch subject. For the TQ
window locking is definitely needed, whether tq_avg needs locking as well still
needs to be checked. If so, that could be done with a separate patch though.

Patches 1,2,3 are just some smaller changes. Let me know what you think about them.

Cheers, Linus
