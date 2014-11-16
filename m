Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Nov 2014 16:53:57 +0800
Message-ID: <1676843.nBZ6j67u22@diderot>
In-Reply-To: <1414644048-5792-2-git-send-email-linus.luessing@c0d3.blue>
References: <1414644048-5792-1-git-send-email-linus.luessing@c0d3.blue>
 <1414644048-5792-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2438349.qGXhggb935";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: fix counter for
	multicast supporting nodes
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


--nextPart2438349.qGXhggb935
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday 30 October 2014 05:40:46 Linus L=FCssing wrote:
> A miscounting of nodes having multicast optimizations enabled can lea=
d
> to multicast packet loss in the following scenario:
>=20
> If the first OGM a node receives from another one has no multicast
> optimizations support (no multicast tvlv) then we are missing to
> increase the counter. This potentially leads to the wrong assumption
> that we could safely use multicast optimizations.
>=20
> Fixings this by increasing the counter if the initial OGM has the
> multicast TVLV unset, too.
>=20
> Introduced by 77ec494490d60d89b42cd01d5dbf8dee04503623
> ("batman-adv: Announce new capability via multicast TVLV")
>=20
> Reported-by: Tobias Hachmer <tobias@hachmer.de>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  multicast.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied in revision 33fdd2c.

Thanks,
Marek

--nextPart2438349.qGXhggb935
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUaGYpAAoJEFNVTo/uthzAzzcIALJkUd70aATA2vCAblTWLFeW
MVEoqm6Lg9MBlTVTmS9Tx/FK+YsemetVaRGhYZAiynAL0MJFr6sfY6XhFj1cSZl6
ePbDPmpnFyJN8w2yoGb8cfv3gqHuv00FN0OkqgU4eBw5hKMNZO6Ur/7/PCXNlMCx
/GsIhPC8nM/oGHr6oMnvW86CtQucHF9hFD4XLujS74byzOq9V/T88/+HW9UDgwMF
X2uSnFV0hpAKDROZWqNdrsw5xJMLzTpi9h/4GCcmmlf823pqd38CDrseJiRx6p8b
xh46EnVFGbPp4plF6ZOJJKU/K7gtIOAWOztfbrYBUsw+29BiJOZGf2pDp+t9Qt0=
=6DlD
-----END PGP SIGNATURE-----

--nextPart2438349.qGXhggb935--

