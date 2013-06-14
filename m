Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 14 Jun 2013 11:02:02 +0200
Message-Id: <1371200525-2011-1-git-send-email-linus.luessing@web.de>
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

This is the fifth revision of the basic multicast optimization patches.

It fixes two bugs:

For one thing packets to the IPv6 all-hosts-link-scope multicast address
(ff02::1) were optimized, too. However this is the one link local address
which we should not never optimize (see RFC4541, section 3 [1]).

For another since commit 87d4a282 ("batman-adv: remove useless find_router look up"
the unicast-forwarding of multicast packets was broken and I had
only runtime tested the patches based on an older commit
(before 87d4a282 such unicast-forwarding was "only" broken if
a gateway-server was present).


Also note that rebasing on top of the TT-VLAN patches wasn't trivial:
Simply resolving the rebase complaints resulted in subtle runtime
bugs. A few lines in the counting methods added to translation-table.c
needed changes.

Cheers, Linus


[1]: Considerations for Internet Group Management Protocol (IGMP)
     and Multicast Listener Discovery (MLD) Snooping Switches
     -> "Packets with the all hosts link-scope address should be forwarded
         on all ports."
     https://tools.ietf.org/html/rfc4541
