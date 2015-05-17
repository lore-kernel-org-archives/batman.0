Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 17 May 2015 02:22:22 +0200
Message-Id: <1431822145-3794-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv6 0/3] batman-adv: Unicasting multicast
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
To: b.a.t.m.a.n@lists.open-mesh.org

The last round of multicast patches send to the batman-adv mailinglist
to add support for the multicast optimizations in bridged scenarios, too,
unfortunately had one major conceptual flaw: It could lead to packet loss.
It's not sufficient to have the unicasting of reports implemented on
bridge-nodes only. Nodes without bridges need to treat reports the same
way.

The issue is described in detail here:

https://www.open-mesh.org/projects/batman-adv/wiki/Multicast-optimizations-listener-reports


Cheers, Linus

-----

Changelog:
v6:
 * compat: copied copyright headers from original upstream c files
 * compat: unified ordering in compat c files:
   -> copyright header, then includes, then kernel specific functions
v5:
 * Removed RFC tag: Needed exports got merged to net-next and are going to
   be available with Linux 4.2
 * Redid compat solution - now fully backwards compatible down to 2.6.33
v4:
 * excluded bridge part from this patchset, they should
   hopefully be added to net-next soon
 * Added a compat solution (PATCH 3/3)
 * Removed Kconfig-depends as by David's suggestion the needed parsing
   functions for MLD are going to be forced built-ins even if IPv6 is
   going to be built as a module
 * Removed unused variable 'int ret' in batadv_mcast_is_report_ipv6()
 * Adjusted to new folder structure
v3:
 * Adding Kconfig-depends and #if's
   (so basically adding similar dependancy constraints as the bridge code
    has, except that there are no depends if batman-adv gets compiled without
    multicast optimizations)
   -> the case of IPv6=M and batman-adv=y is still impossible if multicast
      optimizations are enabled; but I don't see the practical demand for that
      either - people who use IPv6 as a module will probably also want to
      use batman-adv as a module
v2:
 * various bugfixes (now runtime tested, too - should(tm) work)
 * added netdev+bridge mailinglists
