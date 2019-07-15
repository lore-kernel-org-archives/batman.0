Return-Path: <stefan.bader@canonical.com>
Subject: Re: Unknown symbol cfg80211_get_station
References: <cef22736-91db-6a22-6da4-35a4d53a4adc@web.de>
 <91929546.yq5N1g86sx@bentobox>
 <e8205d24-56d7-14fd-6cd8-367791c2c003@canonical.com>
 <10352586.3EjdGBoHHf@bentobox>
From: Stefan Bader <stefan.bader@canonical.com>
Message-ID: <af494410-d3a2-4602-644a-1eab1536f9b6@canonical.com>
Date: Mon, 15 Jul 2019 18:04:43 +0200
MIME-Version: 1.0
In-Reply-To: <10352586.3EjdGBoHHf@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Jz5acOXULUKKPOTZteNzga0PwSOS7espV"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Moritz Warning <moritzwarning@web.de>, b.a.t.m.a.n@lists.open-mesh.org, Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jz5acOXULUKKPOTZteNzga0PwSOS7espV
Content-Type: multipart/mixed; boundary="jGDNfkLvlki88l2aPJKiimRem5f8EtqBB";
 protected-headers="v1"
From: Stefan Bader <stefan.bader@canonical.com>
To: Sven Eckelmann <sven@narfation.org>
Cc: Moritz Warning <moritzwarning@web.de>, b.a.t.m.a.n@lists.open-mesh.org,
 Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>
Message-ID: <af494410-d3a2-4602-644a-1eab1536f9b6@canonical.com>
Subject: Re: Unknown symbol cfg80211_get_station
References: <cef22736-91db-6a22-6da4-35a4d53a4adc@web.de>
 <91929546.yq5N1g86sx@bentobox>
 <e8205d24-56d7-14fd-6cd8-367791c2c003@canonical.com>
 <10352586.3EjdGBoHHf@bentobox>
In-Reply-To: <10352586.3EjdGBoHHf@bentobox>

--jGDNfkLvlki88l2aPJKiimRem5f8EtqBB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 11:56, Sven Eckelmann wrote:
> On Wednesday, 10 July 2019 10:56:36 CEST Stefan Bader wrote:
> [...]
>>>> As Jens pointed out the missing modules are in linux-modules-extra n=
ot in
>>>> linux-modules (the former is not installed by default).
>>>
>>> Who is Jens and where did he point something out?
>>>
>>> On Saturday, 6 July 2019 17:22:01 CEST Moritz Warning wrote:
>>>> The module linux-modules-extra-4.15.0-1032 installs the following fi=
les:
>>
>> Sorry, I meant Moritz ^
>=20
> But he said something else. Or maybe I misunderstood him.
>=20
> I think Moritz meant that he didn't find the cfg80211.ko for his kernel=
=2E And=20
> thus cannot run batman-adv due to the missing dependency (which was int=
roduced=20
> because the kernel was compiled with cfg80211 but the cfg80211.ko was t=
hen not=20
> shipped).
>=20
> I also just tried to find linux-modules-extra-4.15.0-1032 but there are=
 only=20
> following packages in bionic:
>=20
> * linux-modules-extra-4.15.0-1032-azure
> * linux-modules-extra-4.15.0-1032-gcp
> * linux-modules-extra-4.15.0-1032-gke

Sorry for the late reply. This was discussed internally now and we will b=
e
working on getting this resolved (by starting to ship modules-extra for a=
ws, too).

-Stefan

>=20
> There is none which looks like it is for aws (something like=20
> linux-modules-extra-4.15.0-1032-aws).
>=20
> Kind regards,
> 	Sven
>=20



--jGDNfkLvlki88l2aPJKiimRem5f8EtqBB--

--Jz5acOXULUKKPOTZteNzga0PwSOS7espV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE2118yvOZTjOV2k0+6Gdd7svuzqMFAl0spBsACgkQ6Gdd7svu
zqPGoQ/8C8mqtRpbQpqHQAUEDiZgbg4I5eeYCWRh0WWEITbxqwUWWVKJJn2Un1MC
HYsU9JnqU7a8UZbzQ0mf3bIC0cqIo4TbeDM7luaO1P1yCe59gDz52iZKCNE0GYYg
6lp/fd54a1xPM7JjC+uwrtS95Y9g5Z4zQM3uSyoaYMtlgnrzoNgSCXJfDQwHKJra
3d288ooAO3kMs9hvrW+K1lAjoZrA6vU2WDLkvcHMZcqSGpSuAjTnQGrm2Pwhz5gM
727ywEk2Zu+hO7O3EHWiMMaPNbOqwQryUWmhIQcXfIK+9/5231UVur5iFtGYKC6L
JhkArNpAlOwBgQ6XhQ7sY/LUHQeHVTj9JF/YUMNGunySysa8jemLfGv+9qhRARhm
CJ2TJs5YYyQdDx44DDhK8j+B2YgYQvYyuYv38wT+PEhTuLYZHGsv8uKGMGUtZ4T2
kBOpNjteyMY1WMpt17zZVQaf709eMKXMD+4VZ6r6T1+fYIBEgzkI8n/lq1IivD8Y
XrS2cbwkENhi/tC8w1cEI4XqcXeA1W5EoyP5Q9ZBXyWhADsa4IC+M7k/N11iX3p5
+e+2SgJ1/DlhjKpCL4sIAFUtoLHf77zVa/+xo68+KfvZpFH3ckWCZtz+bZI5IfKJ
c+l5vkqKXyBgXMbSd3l+pdjjfSsfFeQ/MAuzjuT8ByPFSHMv5/Q=
=WDEo
-----END PGP SIGNATURE-----

--Jz5acOXULUKKPOTZteNzga0PwSOS7espV--
