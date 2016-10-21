Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Oct 2016 14:49:42 +0200
Message-ID: <105532917.i5QgYZh4kb@bentobox>
In-Reply-To: <20161005234308.29871-3-linus.luessing@c0d3.blue>
References: <20161005234308.29871-1-linus.luessing@c0d3.blue>
 <20161005234308.29871-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17006681.e6EH3cRGgK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 2/2] batman-adv: fix splat on
	disabling an interface
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

--nextPart17006681.e6EH3cRGgK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 6. Oktober 2016 01:43:08 CEST Linus L=FCssing wrote:
> As long as there is still a reference for a hard interface held, there
> might still be a forwarding packet relying on its attributes.
>=20
> Therefore avoid setting hard_iface->soft_iface to NULL when disabling a
> hard interface.
>=20
> This fixes the following, potential splat:
>=20
[...]
>=20
> What happened here is, that there was still a forw_packet (here: a
> BATMAN IV OGM) in the queue of eth3 with the forw_packet->if_incoming
> set to eth1 and the forw_packet->if_outgoing set to eth3.
>=20
> When eth3 is to be deactivated and removed, then this thread waits for
> the forw_packet queued on eth3 to finish. Because eth1 was deactivated
> and removed earlier and by that had forw_packet->if_incoming->soft_iface,
> set to NULL, the splat when trying to send/flush the OGM on eth3
> occures.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
>=20
> ---
>=20
> Changes in v3:
> * none
>=20
> Changes in v2:
> * none, new patch
> ---
>  net/batman-adv/hard-interface.c | 1 -
>  1 file changed, 1 deletion(-)

Applied in bac7733d06fac28ce68a79bcdf88b2b265600cf2 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/bac7733d06fac28ce68a79b=
cdf88b2b265600cf2

--nextPart17006681.e6EH3cRGgK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYCg7mAAoJEF2HCgfBJntGzGIP+waDdPfxyB9cE/YcYro00kws
pmTF3CbdV2/XtmjwJgbBC47392XijvuGs93odjoeqEP3C7QvYXuL2n7rYyS4h9xi
4LhhIvT7r1C+jvrxAd+C/4R1vC96vUFOI/qfUu63/9kbKnizN8i0XEG4rP6iwFSl
ZjWFoFC2Ie6jSv3T1fUvtLjChXWeC+Vnu7bVxOhYqYSeLDpuY5qnLsKVa2im6dlo
wvFCjf5erVa+/bq/BLeJ7+tNNJbKh41oUA62WvpmQutLc3ZbQS5r9rFQL3hNQu+3
26E2+Q12Ooa7wjiEL07YsgEI7jdOlGC51lILSKHa9VLHMfqgsSCagwrBdqDeQW5D
U9h874jM3ynYsvOV//nyhSD1+cEc6o09t3GosQQMye+1Nuwk4nCUh/6bwr83326z
quvh3hcQFjLXI4xP7tulBEKjCGiJ32gLv6smrwPxyp+DdOAn+L11F8xj2oCykC9K
DO+QiBBG1P8N7TA+TUmrnF7Mg4bnJ5ZqmriLkBskzGLR1av3uAKR/zaNWf1SMZCJ
7F1IQyKAlGyNkXiJZ+bOG1bPT6Ovb3hGIzCBr241jNphSrGqDOgFs5BW/IjaBRMe
BqVngreuGZYtTvo8V+7NFlIuCe8+iy5ZzVfJwOcnMHjAuWSDe6yjrbt4lXg9dMCv
drCmEucQm+xoqQDfd7Zf
=NEZi
-----END PGP SIGNATURE-----

--nextPart17006681.e6EH3cRGgK--

