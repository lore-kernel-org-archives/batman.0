Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 16 Jun 2015 17:10:21 +0200
Message-Id: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv4 maint 0/5] Fixes for parallel OGM processing
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

Hi,

Here are five fixes which address potential problems with parallel OGM
processing. For the multicast subsystem the issues can be quite severe
as found and pointed out by Sven here [0].

Cheers, Linus

[0]: https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-June/013193.html

-----

Changelog v4:

* [PATCHv4 maint 5/5]:
  * Shortened if...BUG() to BUG_ON()

Changelog v3:

* [PATCHv3 maint 5/5]:
  * added kerneldoc for new mcast_handler_lock in types.h

Changelog v2:

* Split [PATCH maint 1/2] into [PATCHv2 {1,2,3,4}/5]
* [PATCHv2 maint 5/5]:
  * moved mcast_flags initialization outside of spinlock
  * added spinlock in batadv_mcast_purge_orig()
    (not strictly necessary bc. if we are here then the orig-node is
     out-of-scope as it's going to be kfree'd a few instructions later
     - but added for style reasons / to avoid future errors)
  * added hlist_unhashed()+BUG() calls
    (again, shouldn't be necessary as the checks and new spinlock should
     avoid this case. But since the safety of hlist_del_rcu() isn't
     directly obvious, better adding these annotations and to avoid
     future regressions with kernel panics)

PS: Thanks to Marek for the suggestions.

