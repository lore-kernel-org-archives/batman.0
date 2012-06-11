Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 Jun 2012 07:45:36 +0200
Message-ID: <2563899.9QQv9Pr4OL@sven-desktop.home.narfation.org>
In-Reply-To: <20120610232259.GA23542@ritirata.org>
References: <CAHD-aqK3yvVCDi9wucx4nX5jM4OjxbjbUFz3QHG+KzzuoMhz7Q@mail.gmail.com>
	<20120610232259.GA23542@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1817796.eErIM7r0Fy";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batman-adv gw_mode and ipv6 router advertisements
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1817796.eErIM7r0Fy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 11 June 2012 01:23:00 Antonio Quartulli wrote:
> > Are there any plans of implementing in batman-adv something analog to
> > the mangling done on DHCPv4 packets, to RA packets as well? (the
> > mechanism would be the inverse: instead of unicasting queries and
> > replies, propagate to clients only 1 RA packet out of all incoming;
> > decide which one to propagate based on gw_mode current logic)
> 
> someone proposed the idea on the bugtraq, but no plans about implementation
> have been seen so far..

Just for completeness: http://www.open-mesh.org/issues/159

Kind regards,
	Sven
--nextPart1817796.eErIM7r0Fy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJP1YYAAAoJEF2HCgfBJntGtocP/1n56ibHswd4DBqjCELlW+18
UG1MonP+ZYD1XHiF/jFjgEN2dJ3mhsKPB08jdqoF4qtODpewBeRMHYiIy7aTV6bo
dOxIwG1ddWGZTJ6+BSklW2xHIbV3S3vB8fWZ0Kub48K6lQS6ksesaUaUTvsjLCQq
Nozmi9AnaiTEMAusrIYOSu49vByGYwCR+cSO5UFrPpvbq/EEvgBcu5FQGJvO60qN
ltyn2oFpk7cZifyPHSJ7Pu1ofoYmq0q1nUJsTX7c4CWtycl1MA6MnMOoWSi4Td4v
r3B1zplHG68LvHijV8k2otaIPwMp5elCa+JxFtL58dUfK2eeQBDExnILFz2T5jdX
/2XPCcVud4FIuy2g7c1hXSUX8Wgcb3oDFO8ac/lz2RIoi092gzTg7dqeWrgq8leA
tVpZjTbnVNIuDL9KqxdrM3gKtZa2PBr6Vy3RXYSqmbsq5/S/SopPWUkYray1iV13
F41FbSQ2eLGnQT3QRR/YFPg7YyctrTx7ENnmtfsR/WhvfCbiJQUdAinaesvUbisH
K3tyskEMxnqJ/OkAiyKdqPhULv+aqm5C5Dzu+fVeYQ3HzFf+f6sQURscu3QAmwJl
HQy6845vY7BRpNGy/7AaUJ1NVZpVPH3u+kZEJGErb16kMgR49OJwssx2N8P5nNPB
NeHgjSf+rN5+ZNTy+nz8
=0ynq
-----END PGP SIGNATURE-----

--nextPart1817796.eErIM7r0Fy--

