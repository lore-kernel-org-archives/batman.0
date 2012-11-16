Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 16 Nov 2012 10:26:56 +0100
Message-ID: <2758031.CBsSgkzjUr@bentobox>
In-Reply-To: <CAK+uisAU3eakeuWkuWXR676vpzdoXtM42uM+A-nTM-73d-G9jQ@mail.gmail.com>
References: <CAK+uisD5AddOnF+o5U4LdFu+7CAnNCJna8wBZL1huHqZyeLOfg@mail.gmail.com>
 <20121001210650.GB15826@pandem0nium>
 <CAK+uisAU3eakeuWkuWXR676vpzdoXtM42uM+A-nTM-73d-G9jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1536392.kqI04ameOZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batman-adv on ethernet
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


--nextPart1536392.kqI04ameOZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 16 November 2012 12:04:08 Donald Gordon wrote:
> Hi
> 
> (sorry for the very late reply)
> 
> On Tue, Oct 2, 2012 at 10:06 AM, Simon Wunderlich
> 
> <simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> > You are about to enable batman-adv on 'eth0' which already is part of a
> > bridge. Unless you know exactly what you are doing this is probably wrong
> > and won't work the way you think it would.
> ...
> 
> > You may want to explain your scenario, maybe we can come up with a
> > solution together.
> I think what I really want to know is the answer to this question.
> 
> In a network with topology:
> 
> node 1: bat0 bridged to wired lan 0, over wifi batman can see node 2
> 
> node 2: bat0 bridged to wired lan 1, over wifi batman can see nodes 1,3
> 
> node 3: bat0 bridged to wired lan 1, over wifi batman can see nodes 2,4
> 
> node 4: bat0 bridged to wired lan 2, over wifi batman can see node 3
> 
> how will packets from wired lan 0 to wired lan 2 make their way
> between nodes 2 and 3?  Will Batman be able to use the wired link or
> will they just go through wifi?

Ethernet is not added as interface to bat0? Then it will only use the wifi-
links for the mesh because it was told to do so by the person creating the 
configuration.

Kind regards,
	Sven
--nextPart1536392.kqI04ameOZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQpgbgAAoJEF2HCgfBJntGde4QAIJPGtuvAVBrulYnwnkXzOWc
E13RwW2IjVB/PS6/JOAJFGId612vhkdvEdjvH3WqYj5xHkwkayp0vK32ZDgm2E9p
1arLHSfhTvYP0rmZW32VFuo/ZCNWj39h0A34A1qj94kx1xSxzZqXRJzPZs7EwvyH
WyCLV9CxTTDD7tY9DcRXXgBnl9O2wW/42B+UYV3SvqLv1TkmWg/FeFNiFojNT8wj
X1Aale/dXpquFN9IMreM50iJ09JXizjzWC0mwFb8AA39gwhlTb+AD9zc8jt3ELWW
1yNW6PSVt/hP8o2k8X1WNvSDCRlrzhjdQecAEfBaS0sotu26KTB6YGrvTwwQaj1i
svWj2pgfGN3NGoSn1Z/ZDwAHnPXuwfomgw0x7TD2ll5si/663pI4pnBozNl4zWvX
eERexYYZiBAV9Titie01fZktp0SaXWiZxGdb9wr0IssZ0BTL9oxXGiwZCeTX9eUe
v7V0s6ZBF7xd1z3+Jj3SBH9fmXx8ISX6e4PSVPT6ogvBs9z/PmqG3RoLLKynZIlO
AnrVrBWWOgNbD9ZIxrxBYkOYmgFKC13Kc2rJq9Sbz9rk0exIyxSHbmzUXRo4n/Y7
vi9Zxd26pHkBIhYerVC7cUMlqEL47+0SbFlPS7LmGSiFVQ3CUuT6x23kIutAuwVD
BGCqwdW8WE5MU6TsWb3z
=DCS8
-----END PGP SIGNATURE-----

--nextPart1536392.kqI04ameOZ--

