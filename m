Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 23 Oct 2018 16:16:21 +0200
Message-ID: <19500073.zgPyDjR2lk@bentobox>
In-Reply-To: <754f0cb793f916471e7a2dbfe1558bee974fea16.camel@sdl.usu.edu>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
 <5881573.Sb6ha2483l@bentobox>
 <754f0cb793f916471e7a2dbfe1558bee974fea16.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6139222.2QLDgQtB6q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <jhaws@sdl.usu.edu>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart6139222.2QLDgQtB6q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 23. Oktober 2018 14:11:41 CEST Jonathan Haws wrote:
[...]
> https://git.open-mesh.org/batctl.git/blob/83faa3126d6cc984fff10760aa975bacec043632:/functions.c#l537
> > and
> > 
> https://git.open-mesh.org/batctl.git/blob/83faa3126d6cc984fff10760aa975bacec043632:/functions.c#l702
> > 
> 
> Are these new routines?  I may have been looking at old code and don't
> remember seeing these there. I'm seeing that these will do what we need
> - perform a request on the network if the entry is not in the cache?

These routines are not in alfred yet - they are in batctl. And we use them 
there for the translate subcommand (translate an IP to the responsible 
originator).

And yes, they check whether the entry is available and if not then they will 
try to send something towards the remote device. They only have to be
adjusted for alfred and integrated in your IPv4 codepath(s).

Kind regards,
	Sven
--nextPart6139222.2QLDgQtB6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvPLTUACgkQXYcKB8Em
e0ZYgg//czvXgMo3LF7ZKrCszXuweoUWArC8bRCChi9SqwxwKS6ynDIXiMTZliim
fptqMQCBnqx2tPMAuK/YgC23q5jzGB8esHJwIemMSwyKSuOKYzG8BR54BykjTDYU
wkhpOsRc6TsXHSIxTc78xEMO2Z/wnpL1VPv76VrXvuhOis8IOtbNug7/ixUfpWvP
NJmUrWQQz0EoBPIXLxtAwEumymlZBInOrmJr+YzJu+/GaBEbKQ/bgKeCCZKIfTUu
HnGRuGfN2t21n4zkc2/pwOpsicLmqGV6O55sgzJ6gndZInO7NNMPwraGmO+MCq3j
3dhFejbEQJYpOYGLKJAaTLfAiyCXMrO15ufM74RGJ+jAa37tsK9NY2I6365VVN9+
VIWc9d+wCF4/jDs9Tq3w5VF3/1PEFwtwPL1ZXKX1ck4/db0aGPFh6tW5mby3546j
SEu4NZ3dsj/B6QVlRgLfCJjsNthDoRhnwD9EFMoh17A3dRnBEEP13gDHVdWIWY6p
yYxtzqK+15v1aKV4BLAi7MF4KZ/7rq45DeS58Np91xLNMBUJYqLDC00cMiDV6i5B
X4O+Neyhc0o/0EiO2cPOzzh0h28WvlqFoKchn01ZrlFs/wuV8sDn0mM30YXP2VJ/
yWsnjluMYmDfKruH82e04keqMe74nSy2mEYHcRDNSNIsEqfJKTE=
=NQ/T
-----END PGP SIGNATURE-----

--nextPart6139222.2QLDgQtB6q--

