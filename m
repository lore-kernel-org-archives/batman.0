Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Unknown symbol cfg80211_get_station
Date: Wed, 10 Jul 2019 11:56:18 +0200
Message-ID: <10352586.3EjdGBoHHf@bentobox>
In-Reply-To: <e8205d24-56d7-14fd-6cd8-367791c2c003@canonical.com>
References: <cef22736-91db-6a22-6da4-35a4d53a4adc@web.de>
 <91929546.yq5N1g86sx@bentobox>
 <e8205d24-56d7-14fd-6cd8-367791c2c003@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2860183.0W94i3AjuZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Stefan Bader <stefan.bader@canonical.com>
Cc: Moritz Warning <moritzwarning@web.de>, b.a.t.m.a.n@lists.open-mesh.org, Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>

--nextPart2860183.0W94i3AjuZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 10 July 2019 10:56:36 CEST Stefan Bader wrote:
[...]
> >> As Jens pointed out the missing modules are in linux-modules-extra not in
> >> linux-modules (the former is not installed by default).
> > 
> > Who is Jens and where did he point something out?
> > 
> > On Saturday, 6 July 2019 17:22:01 CEST Moritz Warning wrote:
> >> The module linux-modules-extra-4.15.0-1032 installs the following files:
> 
> Sorry, I meant Moritz ^

But he said something else. Or maybe I misunderstood him.

I think Moritz meant that he didn't find the cfg80211.ko for his kernel. And 
thus cannot run batman-adv due to the missing dependency (which was introduced 
because the kernel was compiled with cfg80211 but the cfg80211.ko was then not 
shipped).

I also just tried to find linux-modules-extra-4.15.0-1032 but there are only 
following packages in bionic:

* linux-modules-extra-4.15.0-1032-azure
* linux-modules-extra-4.15.0-1032-gcp
* linux-modules-extra-4.15.0-1032-gke

There is none which looks like it is for aws (something like 
linux-modules-extra-4.15.0-1032-aws).

Kind regards,
	Sven

--nextPart2860183.0W94i3AjuZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0ltkIACgkQXYcKB8Em
e0aAfRAApXem234OPMx1XoX9WsdRYNAfSGntheief8N8q7jEsdu+iHoh8KTNHaCu
yFFN2VmYHtxukhRxLeCeYvHLZ45NMgX9qsGRAcq/sB+R2ZrxGmHE1g5QHe+maY0J
NuCm0EN7Xh66tRtm5O4sNYJ4ioer2I4GCAkPPO8RI4ZwNHgr69WOK4VNNtKKvd2M
3SG7a+XW27eSuPfdN5D9vOiYwoNFV/5YcVgZthk3YV20WJpQWUXhtlCx2D9LcQgh
V92YB3kWzqLaadD42R9J4AH2SiGCIVBW4oLno6+2+BEeE+PoKfUvyanMACDJn+u5
1j7PRm1Yo4E1AI3QO5/DYcBeaWFJ5mwjj0t3Ox2ICkhoUMHiT4ayUfJNCD/unEJj
oi+mpMy/poip8bBRT7uoubYf8FHNz0itAGJY8THaFekgFixV3ZjyROUf5xKDeCpn
6pR5nanovPj1Tujk3A6jA2VLckW4k4u6dH6XYE06C7XcnDjNxBL1WnOgbT77FmRA
JDtYYqnfMhDROlTpcaNpCTr8zfHT3s8GSOJY7WeWBjGV6oM2o92N7U3h7V1a1VP2
HgcoxInN1jgGfRj4UxcfG5YU1jypraH48orPUISUD1Dein5Vp8Fxwe8Xic683ael
DSuD5cd54ZCd1fxVmBiXsrs9aTSTDoEqTZF3PoRoNS69kuopWbk=
=bCeB
-----END PGP SIGNATURE-----

--nextPart2860183.0W94i3AjuZ--



