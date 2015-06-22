Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 22 Jun 2015 19:55:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150622175526.GC3796@odroid>
References: <1434893777-17618-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1434893777-17618-1-git-send-email-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/1] batman-adv: Always flood IGMP/MLD
 reports
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

I was asked to give some abstract, non-technical explanation for
this drastic change to the previous patchsets':

There are conceptual issues with the always-unicast approach for
some, maybe rare scenarios.

(One could argue on the technical level though whether we'd care
about these issues - the bridge for instance doesn't and has a
manual switch as a workaround to change to always-flood for
specific bridge ports; and I generally wouldn't care for a Freifunk
mesh network either but think I found a "better approach" for less
overhead there)

Cheers, Linus


On Sun, Jun 21, 2015 at 03:36:16PM +0200, Linus Lüssing wrote:
> The last round of multicast patches send to the batman-adv mailinglist
> to add support for the multicast optimizations in bridged scenarios, too,
> unfortunately had one major conceptual flaw: It could lead to packet loss.
> It's not sufficient to have the unicasting of reports implemented on
> bridge-nodes only. Nodes without bridges need to either unicast them, too
> or as done with this patch flood them uncoditionally.
> 
> The issue is described in detail here:
> 
> https://www.open-mesh.org/projects/batman-adv/wiki/Multicast-optimizations-listener-reports
> 
> 
> This patch substitutes and greatly simplifies the following patchset:
> "batman-adv: Unicasting multicast reports to querier-node only"
> 
> The reason for doing this is, that I think the disadvantages of this
> simpler approach noted in the wikipage above (e.g. report overhead in
> large mesh networks) can be better compensated by segmenting the
> IGMP/MLD domain via ebtables (drop all queries and reports coming out
> of bat0 or before entering bat0) and the "multicast_router" bridge
> port flag on bat0 (flood all multicast to this bat0 port, let
> batman-adv deal with the optimizations from here on). Segmenting the
> IGMP/MLD domain also has the nice advantage of being able to run a
> querier on every mesh node which therefore is a way more decentral
> approach.
> 
> Cheers, Linus
> 
> -----
> 
> Changelog
> 
> v1:
>  * Removed query snooping and state
>  * Squashed all three patches into one
>  * Renamed "batadv_mcast_tvlv_ogm_handler_v1()" to *_v2()
>  * Added explicit icmpv6.h include
>  * Rebased on top of master
> 
> Old changelog of
> "batman-adv: Unicasting multicast reports to querier-node only"
> v6:
>  * compat: copied copyright headers from original upstream c files
>  * compat: unified ordering in compat c files:
>    -> copyright header, then includes, then kernel specific functions
> v5:
>  * Removed RFC tag: Needed exports got merged to net-next and are going to
>    be available with Linux 4.2
>  * Redid compat solution - now fully backwards compatible down to 2.6.33
> v4:
>  * excluded bridge part from this patchset, they should
>    hopefully be added to net-next soon
>  * Added a compat solution (PATCH 3/3)
>  * Removed Kconfig-depends as by David's suggestion the needed parsing
>    functions for MLD are going to be forced built-ins even if IPv6 is
>    going to be built as a module
>  * Removed unused variable 'int ret' in batadv_mcast_is_report_ipv6()
>  * Adjusted to new folder structure
> v3:
>  * Adding Kconfig-depends and #if's
>    (so basically adding similar dependancy constraints as the bridge code
>     has, except that there are no depends if batman-adv gets compiled without
>     multicast optimizations)
>    -> the case of IPv6=M and batman-adv=y is still impossible if multicast
>       optimizations are enabled; but I don't see the practical demand for that
>       either - people who use IPv6 as a module will probably also want to
>       use batman-adv as a module
> v2:
>  * various bugfixes (now runtime tested, too - should(tm) work)
>  * added netdev+bridge mailinglists
