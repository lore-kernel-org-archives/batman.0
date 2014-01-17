Return-Path: <jow@openwrt.org>
Message-ID: <52D91339.8000906@openwrt.org>
Date: Fri, 17 Jan 2014 12:25:45 +0100
From: Jo-Philipp Wich <jow@openwrt.org>
MIME-Version: 1.0
References: <CAAxzKbR22CvtrPapZkDdXdRL=_dNC-HUzvCWZPi0HZ-h8ZFLQA@mail.gmail.com>
In-Reply-To: <CAAxzKbR22CvtrPapZkDdXdRL=_dNC-HUzvCWZPi0HZ-h8ZFLQA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="aKNQ1eNGoAhaW9AQoXfB2Re6nrXUkrw7x"
Subject: Re: [B.A.T.M.A.N.] Barrier breaking kmod-batman-adv package
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aKNQ1eNGoAhaW9AQoXfB2Re6nrXUkrw7x
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi.

This is likely due to https://dev.openwrt.org/ticket/14776 which should=20
have been fixed with https://github.com/openwrt-routing/packages/commit/b=
5a0b783ee792f070f8bc286575a26217be21b64

The buildbot seems to emit the package again, e.g.
http://downloads.openwrt.org/snapshots/trunk/brcm47xx/packages/kmod-batma=
n-adv_3.10.26%2b2014.0.0-1_brcm47xx.ipk

The ar71xx builds have not been updated yet but will likely appear=20
during the day.

~ Jow


--aKNQ1eNGoAhaW9AQoXfB2Re6nrXUkrw7x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLZEz0ACgkQdputYINPTPPE3wCdFj+FxRwSjF+N6ttpekRQ8l65
jToAn1CFy5DmxDJyqFhCTYeP6JQs51/+
=5v4V
-----END PGP SIGNATURE-----

--aKNQ1eNGoAhaW9AQoXfB2Re6nrXUkrw7x--
