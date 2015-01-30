Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 30 Jan 2015 09:14:01 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150130081401.GA6925@odroid>
References: <b4fac27152a34dd39d59ca0b83de0157a8f7805f.1422326992.git.mschiffer@universe-factory.net>
 <2512638.rHeWM5fpXe@giomium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2512638.rHeWM5fpXe@giomium>
Subject: Re: [B.A.T.M.A.N.] [OpenWrt-Devel] [PATCH netifd] bridge: allow
 enabling or disabling the multicast querier independently of IGMP snooping
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tue, Jan 27, 2015 at 11:48:09AM +0100, Gioacchino Mazzurco wrote:
> Reading this mail seems that who installa batman-adv nodes should do this 
> setting manually, doesn't batman-adv know/(can estimate) who is the goode node 
> were to put the querier?
> 

Like Matthias said, the selection process is an "upper layer
thing" (from the batman-adv point of view). The querier with
the lowest IP address will become the selected querier as
specified by the IGMP/MLD RFCs.

> What happen if we have the querier on every node?

To be honest, I'm not 100% sure. For what is implemented so far,
it might actually work out with no downsides. If the node/querier
with the lowest IP happens to be behind a bad, lossy wifi link and
two consecutive IGMP/MLD query messages from this selected querier
get lost then one of the other potential queriers should take over
within a five seconds window.

This should work out well if you have a planned, structured mesh
network with a few dozen nodes where you made sure that each node
is well connected to the rest of the mesh.

If you're having a mesh network with some hundreds of nodes
with potentially many behind bad wifi links, I'd get a little
nervous... it'd be like running your IPv6 network (IPv6 relies on
multicast) on a large, wobbly jelly.


My general suggestion at the moment is, to only have queriers
enabled on a few well- and redundantly connected nodes close to
the center of the mesh if you want to use the bridge multicast
snooping feature in your mesh network).

Cheers, Linus


PS: batman-adv has no multicast optimizations for bridges or
traffic other than link-local yet, btw. Still, queriers behind
unreliable wifi links could be an issue even with multicast
optimzations disabled in batman-adv and multicast snooping enabled
in the bridge.

PPS: Have spent some time thinking about implementing an IGMP/MLD
proxy in the bridge and/or batman-adv lately. It's just that so
many complicated workarounds have piled up thanks to the old
(and in my opinion broken...) MLDv1/IGMPv1/IGMPv2 (MLDv2+IGMPv3
are cool though) which we didn't all notice before implementing
and testing things. Now I'd happily trade that for some "layer
violations". And enterprise switches are doing just that, too,
afaik (aggregating IGMP/MLD reports and stuff like that for
instance).
