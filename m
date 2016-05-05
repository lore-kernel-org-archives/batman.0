Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 05 May 2016 17:10:28 +0200
Message-ID: <2301460.z7t4xX8ItU@sven-edge>
In-Reply-To: <20160505144727.GO11201@prodigo.lan>
References: <1457775018-16546-1-git-send-email-sven@narfation.org>
 <2831615.2xmdSus33c@voltaire> <20160505144727.GO11201@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart24789468.TVpdl2UbTm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] batman-adv: use static string for
	table headers
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

--nextPart24789468.TVpdl2UbTm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 05 May 2016 22:47:27 Antonio Quartulli wrote:
[...]
> > >  net/batman-adv/bat_iv_ogm.c            | 8 +++-----
> > >  net/batman-adv/bat_v.c                 | 9 ++++-----
> > >  net/batman-adv/bridge_loop_avoidance.c | 7 +++----
> > >  net/batman-adv/distributed-arp-table.c | 4 ++--
> > >  net/batman-adv/translation-table.c     | 9 ++++-----
> > >  5 files changed, 16 insertions(+), 21 deletions(-)
> > 
> > Applied in revision f7be1df.
> 
> The Gateway table was missed here ..

Yes, it was also not part your first patch:
 https://patchwork.open-mesh.org/patch/3599/

Kind regards,
	Sven
--nextPart24789468.TVpdl2UbTm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXK2JkAAoJEF2HCgfBJntGB0oQANTTdjxp/4iyMfp1nI+Ufr3R
1EvBLmLUgZ7asiL/AYuJtuf0HXahZ8rN/5KFVGItGAiEkv4hd4jDvfA4pLVakv3m
0TencIPD52+EbkEGNGw3raMuo7+2MJ12avLIYYW4yIc33qrDLXdbCCWR1IdolA8m
yMjqYW9BeS3mI+7nFeAfuehbLswLuVecnPq5N7VJ9A7XODI/UXVUPp4KWYhoWttZ
TsvjSu8Zx2KP9aM4QQiHEP5rx7B0AQ9TIEhXkT9RVvti3kmc/vI+6T+v0IEyKU6i
AcunoOabK9zRIE4qtybemIxVbhT+O7N+4lyCyk3qOVJL2bPqw4uPjeaoEtsuPGir
iwavHf3vLEGzoJHvC/STZ8LJ09TVaLZfkMUeQow7v1atAwTEocU2g101rsd8BLvZ
/PTiQtkFJUuKJ54Zhna67AL2A8o3O1KS9x3YV8hw/z0oxCTrhzdQOUGS7c7knMD1
kl/6YhtJ9plGx/7noFMuGjFWSKh12KS8Xw9m4qZJRDtX/vjcDRZBcXRoaGIdQ6DI
mvOmQ8rB+sujPZqg+nllTsc7y3hZEkCSh2r/c7e2zO5NB90fpiv3I1y+yqFKXmtG
XSTxR79UJ3bxGrr2SvZSyV4tFScLKULW1BVY5j8acauzUlFB0AZThA9fdHP0hFKE
oT0uKTn+si7JHTABjnai
=n9XY
-----END PGP SIGNATURE-----

--nextPart24789468.TVpdl2UbTm--

