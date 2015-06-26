Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 26 Jun 2015 14:43:38 +0200
Message-ID: <1546214.ho8OvXx5F8@prime>
In-Reply-To: <1434893777-17618-2-git-send-email-linus.luessing@c0d3.blue>
References: <1434893777-17618-1-git-send-email-linus.luessing@c0d3.blue>
 <1434893777-17618-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2520966.GeXXIMWB2y";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/1] batman-adv: Always flood IGMP/MLD
	reports
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


--nextPart2520966.GeXXIMWB2y
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Sunday 21 June 2015 15:36:17 Linus L=C3=BCssing wrote:
> With this patch IGMP or MLD reports are always flooded. This is
> necessary for the upcoming bridge integration:
>=20
> An IGMPv2/MLDv1 querier does not actively join the multicast group th=
e
> reports are sent to. Because of this, this would lead to snooping
> bridges/switches not being able to learn of multicast listeners in th=
e
> mesh and wrongly shutting down ports for multicast traffic to the mes=
h,
> leading to packet loss.
>=20
> This patch increments the multicast tvlv version number to 2.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>

After discussing with Linus, I agree that we should use the more simple=
=20
approach and focus our optimizations effort on actual multicast traffic=
 instead=20
of the reports. I think this approach is much more simpler and easier t=
o debug=20
=2D since the multicast subject itself is complex enough on its own.

The patch is pretty much straight forward, most of the code is actually=
=20
adopted from the Linux kernel. Therefore:

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Thank you!
    Simon

--nextPart2520966.GeXXIMWB2y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlWNSPoACgkQrzg/fFk7axaPsgCgzI4TlzfnWSqW5xdCo/RPfdb9
o1wAn2guJyoHffAP2xwj2Dw9YQWpoP/M
=HAG+
-----END PGP SIGNATURE-----

--nextPart2520966.GeXXIMWB2y--

