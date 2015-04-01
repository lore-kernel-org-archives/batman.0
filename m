Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Wed,  1 Apr 2015 10:04:35 +0200
Message-Id: <1427875479-9240-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH RFCv2 0/4] batman-adv: Unicasting multicast
 reports to querier-node only
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
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

The last round of multicast patches send to the batman-adv mailinglist
to add support for the multicast optimizations in bridged scenarios, too,
unfortunately had one major conceptual flaw: It could lead to packet loss.
It's not sufficient to have the unicasting of reports implemented on
bridge-nodes only. Nodes without bridges need to treat reports the same
way.

The issue is described in detail here:

https://www.open-mesh.org/projects/batman-adv/wiki/Multicast-optimizations-listener-reports


I'd also be interested in what the netdev/bridge people think about
patches #1 and #2 in particular, therefore including the according mailinglists
now.

Cheers, Linus


Changelog:
v2:
 * various bugfixes (now runtime tested, too - should(tm) work)
 * added netdev+bridge mailinglists

