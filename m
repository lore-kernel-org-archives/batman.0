Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 27 Jan 2017 21:08:17 +0100
Message-ID: <1612313.y6Z9UOyrFW@sven-edge>
In-Reply-To: <20170127143422.GF12187@prodigo.lan>
References: <20170127141044.5317-1-sven@narfation.org>
 <20170127143422.GF12187@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1777683.s85ePg6Sk2";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Avoid buffer overflow while
	querying ARP cache
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1777683.s85ePg6Sk2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 27. Januar 2017 22:34:22 CET Antonio Quartulli wrote:
[...]
> arpreq is already set to 0 few lines above. why not simpling
> "sizeof(arpreq.arp_dev) - 1" as last argument for the strncpy() and avoid the
> line below?
> 
> Or is this required for consistency with the rest of the code?

It is done for consistency.

Kind regards,
	Sven

--nextPart1777683.s85ePg6Sk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliLqLEACgkQXYcKB8Em
e0bzZhAAg2FTWZ+wrV9xTPu+KiesEJjSY8xcfNHjvgjFpykEIL4kCFkEclrWf4G5
tbigm3voZcjroH+QO39zd4nDsk4+b5usrjidIRthf56w+b6UOt8v3KeAQgylwdjg
lRhBuzMVIfTMGHtLuaB49yzcLxlOgRwyL+lLYn28wwar1zCH/5X4CZSYNwRnRnHh
89Z6YzNP+eD1UbM6n4Fx7PUqS8oqgS1MW2c14I7o/o/nCmdJegTV+NbbyKd0NLKq
+LbTi1fgFqf5/ENY70ZJgayzD7gBfsdXebKXPGl+bZ93/A/Gt4jXJEy1mgOkEIii
DHmv9x/kmovRSG5Y/bB2E9P9FM62bAYs5bCsY+97wHeBdf0enZKza17vD8kWzc5l
BeFywpTlGeHbxSnfFP6SnxKDUnFWN6r06BPwhevIH/fkOcM1pm8cE0Aiq+c09oqO
wLIRHxpWXYct/R5a5ED6tf2pPxa6QaYP9vde/wqf83sqy/g/OSNAvw9Vx3Ln9mNS
4KGYHKAmJ5iQ+pihYeJoyfwRlniz7QMyucoJsK/ani2nriPwhYOTDR8Ri5pug7iL
ov79iVT6JkYZq0jZUi0UuuuZgUCrvh4brWSPSSh9W9mh75YZVqpr1hwd7fqyGmef
R2EPq7HsPeXW2UiqUq+KATnXgm3sSZezFB3oADLyVoJpWoRFUk4=
=5lK2
-----END PGP SIGNATURE-----

--nextPart1777683.s85ePg6Sk2--

