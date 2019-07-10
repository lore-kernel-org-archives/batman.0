Return-Path: <stefan.bader@canonical.com>
Subject: Re: Unknown symbol cfg80211_get_station
References: <cef22736-91db-6a22-6da4-35a4d53a4adc@web.de>
 <7eadb3ab-1b51-e248-6122-a7c3c73383c9@web.de>
 <c60bd64a-127d-229c-3bed-eb59803a54f4@canonical.com>
 <91929546.yq5N1g86sx@bentobox>
From: Stefan Bader <stefan.bader@canonical.com>
Message-ID: <e8205d24-56d7-14fd-6cd8-367791c2c003@canonical.com>
Date: Wed, 10 Jul 2019 10:56:36 +0200
MIME-Version: 1.0
In-Reply-To: <91929546.yq5N1g86sx@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="RjMhftuPXC9laEChtiLJycDLDD0P9fVvK"
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
--RjMhftuPXC9laEChtiLJycDLDD0P9fVvK
Content-Type: multipart/mixed; boundary="30xOA4emvBlS1RY0ALuJ0yKmWAxRmAZTS";
 protected-headers="v1"
From: Stefan Bader <stefan.bader@canonical.com>
To: Sven Eckelmann <sven@narfation.org>
Cc: Moritz Warning <moritzwarning@web.de>, b.a.t.m.a.n@lists.open-mesh.org,
 Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>
Message-ID: <e8205d24-56d7-14fd-6cd8-367791c2c003@canonical.com>
Subject: Re: Unknown symbol cfg80211_get_station
References: <cef22736-91db-6a22-6da4-35a4d53a4adc@web.de>
 <7eadb3ab-1b51-e248-6122-a7c3c73383c9@web.de>
 <c60bd64a-127d-229c-3bed-eb59803a54f4@canonical.com>
 <91929546.yq5N1g86sx@bentobox>
In-Reply-To: <91929546.yq5N1g86sx@bentobox>

--30xOA4emvBlS1RY0ALuJ0yKmWAxRmAZTS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 10:28, Sven Eckelmann wrote:
> On Wednesday, 10 July 2019 10:23:21 CEST Stefan Bader wrote:
>> On 06.07.19 17:22, Moritz Warning wrote:
>>> Thanks Sven for having a good look.
>>>
>>> There is no cfg80211 module present on the system (find /lib/modules/=
4.15.0-1032-aws/ -name *80211*).
>>> Package linux-modules-4.15.0-1032-aws is installed.
>>
>> The aws kernel is intended to be used on instances in the Amazon cloud=
=2E There is
>> no wifi hardware present on those instances, so it generally makes no =
sense to
>> have those modules.
>=20
> Yes, but then please don't compile it in. Otherwise other modules (whic=
h make=20
> sense on a server) build against functions from cfg80211 and *don't* en=
d up with=20
> a nop-stub - just because the actual implementation was compiled as par=
t of the=20
> cfg80211 module (but not shipped).
>=20
>> As Jens pointed out the missing modules are in linux-modules-extra not=
 in
>> linux-modules (the former is not installed by default).
>=20
> Who is Jens and where did he point something out?
>=20
> On Saturday, 6 July 2019 17:22:01 CEST Moritz Warning wrote:
>> The module linux-modules-extra-4.15.0-1032 installs the following file=
s:

Sorry, I meant Moritz ^

>>
>> /lib/modules/4.15.0-1032-gcp/kernel/net/wireless/cfg80211.ko
>> /lib/modules/4.15.0-1032-gke/kernel/net/wireless/cfg80211.ko
>> /lib/modules/4.15.0-1032-azure/kernel/net/wireless/cfg80211.ko
>>
>> But this is not in the *-aws path.
>=20
> It looks to me like Moritz checked it (I didn't) and they were not avai=
lable=20
> for his aws kernel.
>=20
> Kind regards,
> 	Sven
>=20



--30xOA4emvBlS1RY0ALuJ0yKmWAxRmAZTS--

--RjMhftuPXC9laEChtiLJycDLDD0P9fVvK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE2118yvOZTjOV2k0+6Gdd7svuzqMFAl0lqEQACgkQ6Gdd7svu
zqPRvRAA3b0cAk6u3XRGHVHOLR5dhODlzBpOKiB72XZvF7RmPeqEHo7s/r5muwCt
wts+g3O8e5x0mkaE5SyrZEvc1Kcop1+FMVTGmek9GlviFUZY0HHznWcJAa1hhOFa
KZtMIDNE7UhQzTOsvQ12OnvvHHhGPPy1K7VM8fdiwhModpzd5XNUzAcbrTYONadt
Fi8gG8eCh/3sZ86eXW+QIr/NVA0GM8ey1W529vflIOFrLEv//kE0JXrZYa1wBJ/n
MJqiBvxA+6eUehO1c4fLVDg+00jUxWyzXdhvEEAYLZ54w4RSl0q4jmfksypnOfDp
T7G5/qXESz1WF2+H0pWNi7Skkr8/VAra4XaqbCY1noQ656LstjlB6L1LMpkwrvuD
emkc+gdoGJCbaKhZteSvqMNWESMcNj2qzOEzvXq0Ck9KYTKe3dtKNWVUXYliD1JM
bsP5A2UZA4jD0HMcmI+Z7qQ13hxBH4dkbTdsCkhPkuag3BbVWaNdBNpP+GcM41tD
FhwnfQjK9KuPlFM2WI1rYswmunsxmByB2IMmPcHKUHHZ5xKwyskV3KRtjG93BLtY
24Wbnqbucm9kYfozj19+1Bf9oSVL5uP0sq5jmfBd+zHIduxO5eaRm7sVFPLULgeN
QBG/uTLsPY3IgWiliZGfY+JhTWA3VhAK4GFOw9LHVKkZT58oPbA=
=r+OI
-----END PGP SIGNATURE-----

--RjMhftuPXC9laEChtiLJycDLDD0P9fVvK--
