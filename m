Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 11 May 2013 19:23:24 +0200
Message-Id: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
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

This set of patches is the first one for a more efficient, group aware
multicast forwarding infrastructure in batman-adv.

This initial set mainly consists of the integration of announcing the
location of multicast listeners via the translation table mechanism to
be able to find out which batman-adv nodes are actually interested in
certain multicast traffic. As well as the signalizing of this
announcement capability via a new multicast TVLV.

Finally some basic multicast forwarding opitimizations are introduced:
If all nodes signalized the MLA capability then link-local IPv6 traffic
will be dropped if there is no interested listener or gets forwarded
via a batman-adv unicast packet if there is just one node interested
in the data.


For now, these optimizations only apply if all nodes in the mesh have
no bridge interface on top their bat0 interface. However making it
possible with bridges, too, and other features are on the roadmap. See
the according wiki page for details [1].


[1]: http://www.open-mesh.org/projects/batman-adv/wiki/Multicast-ideas-updated#Roadmap

