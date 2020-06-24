Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: batadv gw_mode client 0?
Date: Wed, 24 Jun 2020 23:12:18 +0200
Message-ID: <3573996.TXEB8fxZsQ@sven-edge>
In-Reply-To: <FE41926B-5684-45D8-B9AE-17D46DA1C8C7@xecoenergy.com>
References: <927533E5-C265-44BF-B271-1A7A9A084447@xecoenergy.com> <2094569.NUmnuQNPM9@sven-edge> <FE41926B-5684-45D8-B9AE-17D46DA1C8C7@xecoenergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3048125.H8yJaoMOXz"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Rob Cowart <rob.cowart@xecoenergy.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart3048125.H8yJaoMOXz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 24 June 2020 22:37:29 CEST Rob Cowart wrote:
> Are there any docs that talk about what B.A.T.M.A.N. V vs B.A.T.M.A.N. IV is good for?  The decision to upgrade was made before I got here, I'm not sure anyone understood that IV would still be supported/expected to be used.

There is a summary page about B.A.T.M.A.N. V [1] which you should read first. 
And you should definitely not use B.A.T.M.A.N. V when the "throughput based 
metric" is not able to retrieve any meaningful values for your link partners
and you are not able to give the routing protocol anything useful to work with.

And B.A.T.M.A.N. IV is still the default and cannot be compiled out. And the
configuration option for B.A.T.M.A.N. V still has following sentence at the 
end:

	  B.A.T.M.A.N. V is currently considered experimental and not
	  compatible to B.A.T.M.A.N. IV networks.

So while it is definitely less experimental than some years ago, it tends to 
still have problems to get useful throughput information from the drivers of 
the lower device(s).

But both protocol versions have their Pros and Cons - but with your current 
setup (with your current drivers), I have have big doubts that B.A.T.M.A.N. V 
has any benefits for you. But I could be wrong.

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/BATMAN_V
--nextPart3048125.H8yJaoMOXz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl7zwbIACgkQXYcKB8Em
e0apmBAA1xybBWMNr1jAZpJ/++vPGBEU41Qk974+RN7Sm7zFrERrpAMV4SUB5NUN
KmwjVOUyYbWLTAtIpkCl2GzIN9GWybgZbouLbyMGVuLpQHTWarOcpgRQqAxzJVF+
iAUvyHdBi1QhXJPwiR6KRVn11CzvSr0b/xP6Rt7np1gzayM2g+t8HqqG9SO9muhk
9YU4ME0Da/de5/EkohBvD3rNHjPgBvHej+5X4k5XM+fXVF/f1+P4hTV13MtQ1hEB
Ogd3rp6Sz5i2E88fZq7wOvUbXiikmmaRGilou4P8UrkT3UVPLFMthjNg30GjnCvs
dVoIK/IiXtwZrNc4z55Fdszn9sQdbIwRIab1Ovpz6jgpQGL29/ytfRHpkRdySsR6
LnSO4l4bG3gl/XshrWLSFS1e8r1BZsLc12AOKP6vvNWNunXWkQvhxXiw0+QxhNT9
vV+GCF/FBrBzFmeJtxO6W6qQiyHtVsXrSDnaHNMFoHMteNSIphKhPYqqsOI1jXvi
rOTJjRyf0DrrW52TyQa+sp+Pq9f43ubBZX3Vpa8tCXo2uGJ8Mr5xxjY9vVhmz7Tn
NtL/l6rbTAWLCPezsTHOCtV4P6ZAUjULzbWBPb3y1dW4ixI/Jm0tihzaK0KVAkHX
5X9hwfdoE0MEBR4X9f3g+VOemIU+ZUcqwZj4IxdX/n/BNTMFmf4=
=AWN9
-----END PGP SIGNATURE-----

--nextPart3048125.H8yJaoMOXz--


