Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 3 Feb 2011 11:01:26 +0100
References: <1296352379-1546-2-git-send-email-sven@narfation.org>
	<201102022242.52008.sven@narfation.org>
	<20110203095525.GA21622@Sellars>
In-Reply-To: <20110203095525.GA21622@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8424106.zMhYrK4xWl";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201102031101.27870.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Re: batman-adv: Correct rcu refcounting
	for gw_node
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart8424106.zMhYrK4xWl
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> > I think it should look that way:
> > > -       struct gw_node *curr_gw;
> > > +       struct gw_node __rcu *curr_gw;
>=20
> Eh, had been looking at whatisRCU.txt and there gbl_foo in section
> 3 did not have a "__rcu" (actually I hadn't seen that in any of the
> documentations before).

$ git show v2.6.37:Documentation/RCU/checklist.txt|grep __rcu

That document explains it quite well how the sparse check works and why you=
=20
must use __rcu to say "hey, this is a pointer which is used in a special wa=
y).

Best regards,
	Sven

--nextPart8424106.zMhYrK4xWl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJNSnz2AAoJEF2HCgfBJntGMJkP/RSZK/L8xLsheVWYCYoa8eQr
IXrtiBURzeHk6poMbHE2QHFOANVZjmihxzF78HxEsWxRI5czy1t3Y2t/OU/+p2ch
DGMbm4s0D0Ux2rhLvXeQXb8cetXMFxsEs7sUL9I7OcCIpwIYT64AcrU7MEx+xKl+
55sGluVBwDG22Fg4Z1DL5cSjbVI6U3JmYfaGU3k1u+F0Xz0yEMcHH3xuphCKjQr0
dr4rkTRjjzANjVno57y/qRO4IF/zjkDorT8UG+InbZlFrw6aU6vXbwPFOHdetEYZ
Rm4SfubMYgn/DG9YW/3lro+wl6O1eUGlkOraZ11HPuAguJM8/umIf2x+ooV2ujfy
sYpLxqeKcF0PFOzZhJynjDCklr2BIEZmyA7SJfMf5KpP9gTPmbhUKHX+nBWW3EmJ
Lp93p51VKE6NcR1q4GiwcOrcTDchUNd9OMHhx72LC3jEIRMEYbhcxXxWSo5GOMBB
19817I0N1IPFcChBy8+NnjJV0eQv/V1yuQs89SztSfu3u/Eql3g9+zrfBRaOdSK4
oLX0388ugrzrhhJltfV6nwAQErLTe8byL+bQ9AE47mijubF03PHXc1Wu2ujv6Qus
spAH4iiTO7TeQ/uwlx2G5HoqL+ISZSV9aGo3noiDEJv5dF+CSfCsD2t9lIS69yGm
R3yUH/mhH2LN8ACLu1pL
=rTA6
-----END PGP SIGNATURE-----

--nextPart8424106.zMhYrK4xWl--
