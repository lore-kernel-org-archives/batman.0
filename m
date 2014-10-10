Return-Path: <antonio@meshcoding.com>
Message-ID: <543774CC.4050807@meshcoding.com>
Date: Fri, 10 Oct 2014 07:55:24 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <A533453E-8AA5-4ADE-9E76-E0A56CA8130A@gmail.com>
In-Reply-To: <A533453E-8AA5-4ADE-9E76-E0A56CA8130A@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h2qtSuELbvaabCMMeFgS4A3pjbiaFRixU"
Subject: Re: [B.A.T.M.A.N.] help for batman-adv with monitor WiFi card
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h2qtSuELbvaabCMMeFgS4A3pjbiaFRixU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi jammy,

On 09/10/14 05:26, jammy wrote:
>=20
> Hi all=EF=BC=8C
>=20
> Now i have build a mesh network with batman-adv routing algorithm=EF=BC=
=88batman-adv-2014.2.0=EF=BC=89and Linux 3.3.8. Each mesh node have one W=
iFi card which is configued to the adhoc mode =EF=BC=88according to the s=
uggestion of openmesh website=EF=BC=89and 11A protocol.
>=20
> But the data rate between two mesh nodes is only 8Mbps=EF=BC=8Cwhile if=
 I configure the same WiFi card in mesh node to AP mode and client mode=EF=
=BC=8Cthe datarate between them can achive 40Mbps.
>=20
> I think the reason of the low data rate is caused by the adhoc mode=EF=BC=
=88my wireless driver is ath9k=EF=BC=8Cthe datarate of adhoc mode is slow=
er indeed=EF=BC=89
>=20
> My questions are=EF=BC=9A
> 1. How can I raise the data rate to 30M+ if I use the adhoc mode=EF=BC=9F=


As far as I know ath9k works usually well in adhoc mode and can reach
much higher datarates. In any case the problem is likely to be ath9k
specific, so batman-adv can't do much for that.

> 2. can I use the monitor mode of WiFi card with batman-adv=EF=BC=9Fsome=
one tells that it can be done=EF=BC=8Cbut when I batctl addif wlan0 =EF=BC=
=88wlan0 is configured in monitor=EF=BC=89=EF=BC=8Cit shows that interfac=
e type not support by batman-adv.
>=20

you cannot add a monitor interface to batman-adv (as explained by the
message), but you should be able to create to interfaces: an adhoc one
to use with batman-adv and a monitor one to use for your purposes.

This is what most people do.


Cheers,

--=20
Antonio Quartulli


--h2qtSuELbvaabCMMeFgS4A3pjbiaFRixU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUN3TRAAoJEJgn97Bh2u9eHOkP/jr3m0R4PRQze9oQR9RfWXir
S/cWRWd6YLcNjQ04tE00L3Dxrlxkc4IPadNI19VHETwYjXRj3EkOCBEYVIk0MHxl
gVEHrw8LuCNJJUDyPT5soPG8+Oz9EzZBiBvT3GzOa0vunLqHPRfRdfWnB3EWb+7M
663NCdkSMng8FTtHq2JoJYZ1Dmx7F7c5wp/fR4OSjmUlx+poPBUv/s04s2GTO7PJ
sd48D5Z5CsVCol49ZE5s0GUKSBmoMYudpxj7TDEuLvObrnl5N+qHqLj7bGsdd4ce
/IRmWmwI+pZd4bYTNJXLFZHCYGxuk5u/gPfN8R4r8SVN8yjjCn7VQkW3tpsu6yvF
gsHf+qFT+B9thxN4KvgqLAI2O1PuKGpPnaaiOJPhMZUUV8GqP5DznudL1Qhkc2QI
ljKIqWGqWyXxiChOAcQB9grNQLx7znGeIeZtkEOuVkVd0o41iIifM4QPgt4L3JHi
bcCp3DLwPFlpaDC88rh/bMKuV7uyV+mU4NYjiMAiKgZJHKRIAXrgUZ4BoaqWG1HC
rBWeu9D/Yc2ctHq/PxdBq9jUbqXiSOagB5r+mVgB6EKJWNk3Ud0HSzzx8ryZe9uu
FuPyTeOjBLK1aeLOtDakDIJl2PxyomOj6IhVJrVj18G/FO6nTjyQXnsFVINDGSse
utm2akswDJsVPX4A5ihQ
=iTc6
-----END PGP SIGNATURE-----

--h2qtSuELbvaabCMMeFgS4A3pjbiaFRixU--
