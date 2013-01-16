Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <50F60591.2060507@altermundi.net>
Date: Tue, 15 Jan 2013 22:42:41 -0300
From: =?ISO-8859-1?Q?NicoEch=E1niz?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <B9683C50-CBE6-40F6-B084-187E41B04CE4@stephan.homeunix.net>
 <201301081415.31205.lindner_marek@yahoo.de> <50EC4AC5.60103@altermundi.net>
 <201301091430.14138.lindner_marek@yahoo.de>
 <F7DD3319-4F27-44BC-AA36-3484FAA44BBA@stephan.homeunix.net>
 <50EDAB34.3090402@altermundi.net>
 <60B0DDED-DFFE-4284-963B-851D7C74DE97@stephan.homeunix.net>
In-Reply-To: <60B0DDED-DFFE-4284-963B-851D7C74DE97@stephan.homeunix.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Hi all,

I wanted to share this proposal we arrived at after discussion with some Al=
terMundi hackers, so we can discuss it during our future IRC session. I've =
previously shared it with yanosz, who had some observations that he can bet=
ter explain, but agreed on this initial assumption which triggered the prop=
osal:

The scenario we see in our networks is that over a certain link quality whi=
ch is considered acceptable, we want the clients to choose the gw with bett=
er bandwidth. So if for example this quality floor is TQ 100, then if a gw =
has 6Mbit/s advertised b/w and another has 3Mbit/s, the clients that see th=
is gateways with a TQ above 100 will choose the faster one between them.


We observed that in the current implementation, advertized gateway throughp=
ut is used to modify the final gw selection by publishing unrealistic bandw=
idth. The proposal tries to fix this, as well as the "dynamic switching" fo=
r selection class 1. Looking at the current code involved we also believe i=
t would allow to make the implementation simpler.


This would be the proposed options:

gw_sel_class [1,2]
 1 will consider gw throughput, 2 will only consider TQ. When using selecti=
on class 1, clients will switch gateways if one with better throughput beco=
mes available and reachable with a TQ above gw_tq_floor (see below). Defaul=
ts to 2.

gw_tq_floor
 Only relevant for gw_sel_class 1. Above this TQ floor, the gw with the
best advertised throughput will be chosen.* Defaults to 100(?)

gw_tq_threshold
 TQ delta that triggers a gw switch in the client. If gw_sel_class is 1,
the tq_threshold will only be considered to choose between two or more
gateways advertising the same winning throughput on the net. Defaults to 20.



The old config options would be deprecated but to maintain backwards compat=
ibility, if gw_sel_class is set to... say 20, it would be internally transl=
ated as:
gw_sel_class 2
gw_tq_threshold 20


I believe this proposal maintains current behavior for sel_class>1 while IM=
HO it better handles sel_class 1.


Cheers,
NicoEch=E1niz


* if no gw can be reached with TQ over the tq_floor, the client should choo=
se one anyway, probably the one with better TQ; this should be discussed fu=
rther. Another option would be to choose no gateway and the network admins =
should fix the net :) or lower the tq_floor values.
