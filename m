Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 16 Nov 2014 10:14:43 +0100
Message-ID: <1448250.Hgypd91p29@sven-edge>
In-Reply-To: <2704279.HXZgGAggkv@sven-edge>
References: <069201cffe76$c6b720c0$54256240$@dslx.net>
 <20141116062826.GA2469@odroid> <2704279.HXZgGAggkv@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2638857.6CbcfWE2mp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Current OpenWrt build
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


--nextPart2638857.6CbcfWE2mp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 16 November 2014 09:50:43 Sven Eckelmann wrote:
> Hm, I am now not sure if we switched topics again. Maybe you can enlighten
> us. Jay was not perfectly clear in his first mail what what he actually
> wanted to know. His second mail was refining his question to something like
> "tell me if I can deploy batman-adv from OpenWrt because I've read the term
> 'crash' somewhere". I am sure that your critism of OpenWrt is valid and a
> good point to make. But maybe we can make your answer a little bit more
> understandable (at least for me):

Linus just explained me some of the problems in batman-adv. I don't know about
the bridge patches. These part can be explained by him.

> You are saying something about "outstanding multicast issues and patches"
> without defining what it means in this mails.

At least some patches [1] completely went under the radar and just got applied
to the repo in the maint [2, 3]. These are not part of any OpenWrt feed I know
of.

> Are there known missing patches/issues for batman-adv which would break
> "common setups"? If yes, why is multicast_mode enabled by default in
> batman-adv?

Yes, there are at least two known problems in batman-adv which are now fixed
in maint and can be cherry picked by you. Otherwise these problems
would enable multicast optimization when some nodes have bridges (which they
shouldn't). This is a bug a not missing feature. So it is still valid that
multicast_mode is enabled by default.

I would guess that you can either disable multicast_mode  or apply the
patches.

> Are there "only" missing patches/issues in the bridge code (the ones you've
> linked to in the other mail [1]) of OpenWrt which breaks batman-adv with
> multicast_mode? If yes, why is multicast_mode enabled by default in
> batman-adv?

I cannot really answer this and will leave it to Linus.

> Are there "only" missing patches/issues in the bridge code (the ones you've
> linked to in the other mail [1]) of OpenWrt which breaks batman-adv even
> without multicast_mode?

I cannot really answer this and will leave it to Linus.

> Are these missing patches/issues only about bridges + multicast and not
> about batman-adv?

There are at least some batman-adv unrelated problems in OpenWrt with
multicast and bridges [4].

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-October/012486.html
[2] http://git.open-mesh.org/batman-adv.git/commit/33fdd2cb9fe20d90bc6bff369c9b57e849b317b6
[3] http://git.open-mesh.org/batman-adv.git/commit/9e9d48e829cd93ffbb5ced323caf046ebe963394
[4] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-November/012554.html

--nextPart2638857.6CbcfWE2mp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUaGsGAAoJEF2HCgfBJntGtAQP/0oEStIaNQAg0lQQCbar2IM4
yN5ac6L5oCJEvuyP17DIu8FJSDntTM+lLeBB6zeqA/m00iKSBVxwG/P+qNIQxjfA
aabLsYw2fSzhrXt5jSrv4jfUG1cVUOm1TpPPe+2HlJVNNvln6Piw/fQH3dL7Lp10
ZcFpu/altLTEtSFKECDD7CYG3N/bhg2n0TpMTZdQ7OheerUKlWGJz7mu5N8RjVZv
yYbFI/jg5WtOoGV8+X80BieZN3eEhz5r1zi5FOUCrJU6HLxmCdjJyRvaedwcUr24
Ray0VsyfonRLci66p0YZG2dcurGuu63Z1gxU4GL+KpVq4t5kLnDSerIEb+T6PXsM
t8CeqWuP1k4alRq5qySAQMHoHux6g+Kdg9CBzeE+9bplWDlF8b3EieuRjocTEfBt
H62irSNlfmKvXudIr5Dqsx3sBswYyAEr52OEeumFZdlHjlUoNN3UI3MSGV16PDAY
g6okZd0UC1JWDYPNDvbqCmS86YZO3exSZO/yhr6Qjo94MpfQBCj6MElLqTuvLZcf
YWVBHLG/b44cgizKaTfZ+VvIvWE/RzZm7FnMRWfMf8EbTBephGiDJkUfsEVILaqW
mrbns6P1GBjl3+qnopVu+RhwNH/bbp4SbrkVTRxF4T9O8lXVbuvcmhnsYhvFSeeL
2G12tb0srmOzdHxeJlYG
=oVB1
-----END PGP SIGNATURE-----

--nextPart2638857.6CbcfWE2mp--

