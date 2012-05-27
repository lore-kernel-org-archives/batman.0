Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 27 May 2012 11:42:33 +0200
Message-ID: <4906132.My1k7u0VYv@sven-desktop.home.narfation.org>
In-Reply-To: <201205270350.30491.lindner_marek@yahoo.de>
References: <CAFevQmPp152mUiJfjm-476=ASnCZEh0UQbhvjKAyeaxHwJ=Tow@mail.gmail.com>
	<201205270350.30491.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2919900.af89oQl0uL";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] hotplug.d
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2919900.af89oQl0uL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday 27 May 2012 03:50:30 Marek Lindner wrote:
> Filippo,
> 
> > there is an error in /etc/hotplug.d/net/99-batman-adv at line 9.
> > 
> > The function that be called is bat_config and not config_bat
> > 
> > Could someone fix it in latest batman-adv stable release?
> 
> could you please be more precise which package you are talking about ? I
> wasn't able to find the line you are referring to anywhere.

https://dev.openwrt.org/browser/branches/packages_10.03.2/net/batman-adv/files/etc/hotplug.d/net/99-batman-adv

and 

https://dev.openwrt.org/browser/branches/packages_10.03.2/net/batman-adv/files/lib/batman-adv/config.sh

Kind regards,
	Sven
--nextPart2919900.af89oQl0uL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJPwfcJAAoJEF2HCgfBJntG+6cP/ixPEqCkxxz0KJmcud0JcJWx
Iblold7Y4D2AjYC8FMn1TXI7EZ1F58U2N0BnXRqjkBrv8zOWzPiLK/Tjnef8qN6x
Bcf8va1qVDUv7DXUO6WiTHFL6PTKcLd/+X0aO/KYJT4zJ5Kc5bt5EVM+jSHdEszl
MhyejXtqvrmLs9cDczBsXugX+o9tmoc8qiM0cuoHGJlBG3JgdxHbOwoGxhHjPjCx
m++OUzre4XCiv10nmNe35qcubToEX0keVntbwAETCI7CPHbQccpDBsAEu34+IEdl
fdSrzYHeI5lWGWPIl0jhpk1To9oszr17JCbCTcR6McSN1uxrFyL/baBqZrGBXeJi
oeUd51oH2Dz8+FlwO+unsSiTVwTQ3OshJMQTnUpnqLmmCQKLsPQV+k5lw/lAT4st
+qcFfyB6q8vzPfI+KJubO82ibmcrzWHG4JSUpbdhAxMHqFcwY3vvCL2CuHlGOlAP
ENG9YzI/AnVjRsHmBpvkXp13jcQGqVxQ5MEgPWN7xYm9tsxLNIOZ6tIAlpOrsfe4
WSqndN14zLPQyeQkkE29J/rFbG70nLKIl21HcZoY7C5lE9yoEiNoCfZ+nwuryOEA
WwD1n2vqSpF3WEW0j/ghg3BslfJbrCxB1wkhFB2WEBVf8XY/3yLlbZRn+GOktqpg
SRKLGWekPxSRxkWIlwRL
=g1yz
-----END PGP SIGNATURE-----

--nextPart2919900.af89oQl0uL--

