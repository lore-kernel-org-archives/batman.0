Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 31 Jul 2018 21:58:50 +0200
Message-ID: <3944717.qnnkuJNATG@bentobox>
In-Reply-To: <bb8d1046-af37-dab3-12ce-46455acedbbf@kkk-web.de>
References: <bb8d1046-af37-dab3-12ce-46455acedbbf@kkk-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4358975.jtxWzAc5km";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] BATMAN 2018.1 fails to compile
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
Cc: MK <mailing.m1@kkk-web.de>

--nextPart4358975.jtxWzAc5km
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Dienstag, 31. Juli 2018 21:24:54 CEST MK wrote:
[...]
> make[1]: Verzeichnis =E2=80=9E/lib/modules/4.9.0-7-amd64/build=E2=80=9C w=
ird betreten
> make[1]: *** Keine Regel, um =E2=80=9Emodules=E2=80=9C zu erstellen.  Sch=
luss.
[...]
> This is a debian stretch installation. Someone out there with the same
> problem? Make clean did not help.

Looks like your kernel sources are missing the rules to build modules. Plea=
se=20
install the correct packages.

Kind regards,
	Sven

--nextPart4358975.jtxWzAc5km
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAltgv3oACgkQXYcKB8Em
e0Zk8g/8Cb1ooM7cDoAVMrrwUEyvi6JEcKoGjzHrzkFWE5zVcpXe5576rTzE3894
k8VsRIEOZT2vHwYlcnKvCrZ5SWL0lTkuUFbGocEWGYFeb5R2JeHhLdF2jVFjFZgY
vamu9GyT1NX/xUUifKFksHmmoBlT2ld+qZd+LQ5usfP7ktKP492x7N707KYfRhEm
BvMfmxpzYMVKJB+pwsz/Kai/rH9Dv2t9fZg2CvaZ0Y7ssCmKkBcQQSGiJHLsCTI6
47cb+WvmiH6yvApTvzk47Z+Q9nGEA0Flk6ts6KsoP79B6OsZIt/DleQbIHWGR/0L
lsrRdTU5Q2MNc3tj30G5WmEDv2PPRk3kBIKP+MO+ze1tNCYrikO2A2A/PWc9bMz+
1A1RQ9z4juCbUWfADvGuAZtUyT2hYRM0bjXewwPxLbv2XcjkERfKaqzlXz9/NgJH
XLjIei6lnDc6nQGFcZ5A7I2lXib+eyfBnlfx0gt9PlPjVO3kBzwPq9W1DNONhvRP
iaCFLgZ7chO8gpmLif8j1sT04FlFhRXcn1IJWwz6pZU1wzXhMhXzUz3I8MKVw2S1
orPmCoj+1kyEt51NKf28FoahM79guNOa5MkWvnNpPAnjBe7uzfRtZKJeHskcBa1g
inGx/Qx/Sxig7NpOSWAgdJVy7xnOy8/Z8XLdplfb5+FJRX+t2MA=
=1Wpz
-----END PGP SIGNATURE-----

--nextPart4358975.jtxWzAc5km--

