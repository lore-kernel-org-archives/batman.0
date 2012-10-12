Return-Path: <ordex@autistici.org>
Date: Fri, 12 Oct 2012 09:15:59 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121012071559.GB2564@ritirata.org>
References: <507798EE.80305@codigosur.org> <50779CA3.9070208@yahoo.de>
 <5077A77B.3040803@altermundi.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <5077A77B.3040803@altermundi.net>
Subject: Re: [B.A.T.M.A.N.] batman-adv: ap mode with isolation enabled
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2012 at 02:15:39 -0300, NicoEch=C3=A1niz wrote:
>=20
> Is the setup clear enough now? or am I missing the point as to what is
> unclear? Please ask whatever needs to be clarified.
>=20

Hello Nicol=C3=A1s,

I think I got your point. First, you are talking about the "normal" AP isol=
ation
feature that you can enable in hostapd, right? Because in batman-adv we hav=
e our
own (Distributed) AP-isolation but it has different effects and behaviours.

The behaviour is correct: OGMs are broadcast packets. In infrastructure mod=
e,
whatever broadcast packet a station sends gets to the AP which will re-broa=
dcast
it again. In this way every station gets it and from the batman-adv point of
view it is like the packet was received directly from the other sta (the MAC
addresses in the packet say so). Therefore you must enable ap-isolation in
hostapd if you want batman-adv to behave as you expect.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlB3w68ACgkQpGgxIkP9cwdQMQCcCP02se9H/wdtwY1IjXU31k+3
AMsAniAr71Ng41n3EmRyUXQnQotAVwUk
=UCT1
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
