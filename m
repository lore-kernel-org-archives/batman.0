Return-Path: <antonio@meshcoding.com>
Message-ID: <5305CE85.6020201@meshcoding.com>
Date: Thu, 20 Feb 2014 10:44:37 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <4F5A043B-6BFB-46F0-9D14-BDF07F2533E0@gmx.de>
 <530521C0.8060705@meshcoding.com>
 <2BC074F4-9F03-4D7D-A0CD-AF66ABB7DAB9@gmx.de>
 <5305308C.5090605@meshcoding.com> <20140220085433.GD11878@lunn.ch>
 <5305C4C5.8090504@meshcoding.com> <20140220090903.GF11878@lunn.ch>
In-Reply-To: <20140220090903.GF11878@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ghHvPjIXONsrdFMjoDHDIQkhKTSLA5Fdr"
Subject: Re: [B.A.T.M.A.N.] Suggestion for routing improvement on poor links
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ghHvPjIXONsrdFMjoDHDIQkhKTSLA5Fdr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/02/14 10:09, Andrew Lunn wrote:
> On Thu, Feb 20, 2014 at 10:03:01AM +0100, Antonio Quartulli wrote:
>> On 20/02/14 09:54, Andrew Lunn wrote:
>>> The routing protocol is known to have problems when a node suddenly
>>> disappears. A received OGM is what triggers updates to the metric. If=

>>> you stop receiving OGMs the metric is no longer updated until the nod=
e
>>> is purged as dead. This for example causes problems with
>>> nomadic/mobile nodes. They can go around a corner, loss line of sight=
,
>>> but still be considered the best route until purged as dead.
>>
>> But if you keep receiving OGMs via another neighbour you will have a
>> route switch *before* the old nexthop is considered as dead.
>=20
> Hi Antonio

Hi Andrew,

>=20
> That is not what i have seen in practice. Because the metric is good,
> and does not degrade,=20

The missing degradation is the part where I don't agree.

Just to be sure we are understanding each other, I am talking about the
scenario depicted in this picture:

http://www.open-mesh.org/attachments/download/52/triangle.png

'A' is the source node and 'B' is our destination. B moves and breaks
the line-of-sight with A, thus making the A<->B link unusable at all (we
assume that now packet loss on A<->B is 100%).

At this point A still receives B's OGMs via N1.

According to batadv_iv_ogm_orig_update() (in bat_iv_ogm.c) each time a
packet with a _new_seqno_ is received the global window of _each_
neighbour for the given originator is shifted by one slot and the
averages are computed again.

This operation makes the average degrade because we are now averaging
N-1 old values and one 0 (with N being the size of the global window).
On the next OGM it will be worse: average on N-2 values and two 0s. And
so on..

Doesn't this mean that the metric is degrading (consider that the metric
is the average)?

Later in the same function, after having shifted all the windows and
recomputed all the averages, batman-adv checks if the route switch can
now happen:

1076   if (router_ifinfo->bat_iv.tq_avg > neigh_ifinfo->bat_iv.tq_avg)

(tq_avg of the current router is compared to tq_avg of the neighbour
from which we have received the OGM)

At some point this condition will evaluate to false.

> it stays as the best route. That is one of the
> reasons Linus developed NDP while at Ascom.
>

Of course the current mechanism is far from being "fast", therefore we
all wait for NDP/ELP to make the whole thing much more responsive :-)


Cheers,

--=20
Antonio Quartulli


--ghHvPjIXONsrdFMjoDHDIQkhKTSLA5Fdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTBc6JAAoJEEKTMo6mOh1VHAUP/3wxjgus1CkjZTidMtZYen4C
6V+pu5dDclo7XpAmo6a0hQIf5o+4ytOm3bj1GNvkX1+MChhTnIdLYigc7tUaSUIE
eVlZt5OTrFYR1peGLB6TpeX5JtjoPJupumthYfLnSXjINlLm/7StmRLQPOznLJwP
Jwm0lYryus6qQ9lFj36PgcVRk/XADYUwmlca0AV8Xsuj7NaAvCgs4axXRGGlpITi
xmt97dbFcggcFu+VfZU+VytS4PsQtLJxHFSqeC9+6Xyu1fR6/Ce3pTyVylWoUte2
df981SOqR1khxo4A+cgP/m6eyjMCDPTlZ1exyF2+nOLBmnsCxO8AVnEAX0hHSj0f
SPA5ZrXJtBwKcxCzFMhrY1WI+xa1+Wcxt+ECH7/Rad7kdwom6aLDhfd95j87mglg
Y6ZwoJueaVooe7VKHYyG4ZwnNo9YhxSTBgCxhMF4zBQd/SmQGaz1aD55Rd++fl6B
kMBmm9lx7VcSxj62TjP1aRTzQAnfuyU8RXI4RMdiH4abEVLZXbye8NL1retZ3ITK
AfxTh1j1upSm6heBAsHkd5WAat4TaTha2QoWg+GETSGQDrgMgoW0nvJCtJnZ4/B1
SA5WqdTeD9yVPn1z4r7dGd2vQqe3cHlMOpNkcP+dYGEF8LAA1Llog1P/5TX6Ixdd
WZBSkZuYiQhBUvMnkeon
=J+Ts
-----END PGP SIGNATURE-----

--ghHvPjIXONsrdFMjoDHDIQkhKTSLA5Fdr--
