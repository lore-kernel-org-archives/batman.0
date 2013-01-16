Return-Path: <ff@stephan.homeunix.net>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1085)
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@stephan.homeunix.net>
In-Reply-To: <50F60591.2060507@altermundi.net>
Date: Wed, 16 Jan 2013 12:38:09 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <9822A153-15B1-4F16-B109-B1F3A569A108@stephan.homeunix.net>
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <201301081415.31205.lindner_marek@yahoo.de> <50EC4AC5.60103@altermundi.net>
 <201301091430.14138.lindner_marek@yahoo.de>
 <F7DD3319-4F27-44BC-AA36-3484FAA44BBA@stephan.homeunix.net>
 <50EDAB34.3090402@altermundi.net>
 <60B0DDED-DFFE-4284-963B-851D7C74DE97@stephan.homeunix.net>
 <50F60591.2060507@altermundi.net>
Subject: Re: [B.A.T.M.A.N.] Unterstanding gateway-mode - why do nodes have a
	"sticky" gateway
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

Hello world!

I'm back:

Am 16.01.2013 um 02:42 schrieb NicoEch=E1niz:

> I wanted to share this proposal we arrived at after discussion with =
some AlterMundi hackers, so we can discuss it during our future IRC =
session. I've previously shared it with yanosz, who had some =
observations that he can better explain, but agreed on this initial =
assumption which triggered the proposal:

I'll be available on IRC this evening (20:00 CET) - sadly, I'ven't found =
any other contributers in our freifunk-community?

>=20
> The scenario we see in our networks is that over a certain link =
quality which is considered acceptable, we want the clients to choose =
the gw with better bandwidth. So if for example this quality floor is TQ =
100, then if a gw has 6Mbit/s advertised b/w and another has 3Mbit/s, =
the clients that see this gateways with a TQ above 100 will choose the =
faster one between them.
>=20
>=20
> We observed that in the current implementation, advertized gateway =
throughput is used to modify the final gw selection by publishing =
unrealistic bandwidth. The proposal tries to fix this, as well as the =
"dynamic switching" for selection class 1. Looking at the current code =
involved we also believe it would allow to make the implementation =
simpler.
>=20
>=20
> This would be the proposed options:
>=20
> gw_sel_class [1,2]
> 1 will consider gw throughput, 2 will only consider TQ. When using =
selection class 1, clients will switch gateways if one with better =
throughput becomes available and reachable with a TQ above gw_tq_floor =
(see below). Defaults to 2.
>=20
> gw_tq_floor
> Only relevant for gw_sel_class 1. Above this TQ floor, the gw with the
> best advertised throughput will be chosen.* Defaults to 100(?)
>=20
> gw_tq_threshold
> TQ delta that triggers a gw switch in the client. If gw_sel_class is =
1,
> the tq_threshold will only be considered to choose between two or more
> gateways advertising the same winning throughput on the net. Defaults =
to 20.

Well - I still think, that having a fixed gw_tq_floor may cause unstable =
gateway-selections if tq oscillates around gw_tq_floor.
Perhaps we can discuss this in detail.

Thanks,
Keep smiling
yanosz=
