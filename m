Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 24 May 2013 10:02:25 +0200
Message-Id: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Basic Multicast Optimizations
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is the second revision of the basic multicast optimization patches.
It includes one functional fix and many style fixes, thanks to Antonios
feedback.

Three things were not included from these suggestions:

* The default mcast TVLV flags were left as it is not as easy to
switch. (see answer/explanation to [PATCH 2/3])
* for_each_pmc_rcu() was not moved to a commen net header file,
only a TODO was added. Will do that after this code might have
landed in net.


Additionally the limitation of 255 multicast listeners per originator
was removed (it was more a relic of the pre-TT announcement mechanism
and such limitations should be taken care of by the current TT
infrastructure instead).

Cheers, Linus
