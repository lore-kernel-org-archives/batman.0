Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Wed, 9 Sep 2020 17:03:58 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH maint v2 3/4] batman-adv: mcast: fix duplicate mcast
 packets in BLA backbone from mesh
Message-ID: <20200909150358.GC2391@otheros>
References: <20200904182803.8428-1-linus.luessing@c0d3.blue>
 <20200904182803.8428-4-linus.luessing@c0d3.blue>
 <2973088.WcO1NEu1zB@prime>
 <20200909145357.GB2391@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200909145357.GB2391@otheros>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Sep 09, 2020 at 04:53:57PM +0200, Linus L=C3=BCssing wrote:
> So the only solution I could think of for now is
> excluding DHCPv6 from multicast feature in TX of the originator...
> (in batadv_mcast_forw_mode_check_ipv6(), adding excludes for
> ff02::1:2 and ff05::1:3).

And there is also no way for a random node in the mesh to figure out
if two or more other nodes share the same LAN via BLA, right?

That would have been the other option, to avoid sending a
multicast-in-unicast packet via the multicast feature to multiple
such nodes in the first place.
