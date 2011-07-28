Return-Path: <sven@narfation.org>
Date: Thu, 28 Jul 2011 14:06:01 +0200
From: Sven Eckelmann <sven@narfation.org>
Message-ID: <20110728120601.GA22245@sven-atom.home.narfation.org>
References: <CA+qXHzNUGtLUpFqOmvKge05wLYyyoCpkTJG4HKwkd+Zzv81hYQ@mail.gmail.com>
	<2942004.kRGEbDgGH5@sven-laptop.home.narfation.org>
	<CA+qXHzN2x3CL7aH7T-OJKEE0tfs7kgOVoqtUpNZJyecrywRJWg@mail.gmail.com>
	<8523816.3y33SjpCxy@sven-laptop.home.narfation.org>
	<CA+qXHzOAVeGYcnqjz_=goW2Yzc+oJ5y1GpAYDcH8EeGZssL=wA@mail.gmail.com>
	<20110721102000.GA9313@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20110721102000.GA9313@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] Filtering BATMAN-ADV packet
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


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2011 at 12:20:00PM +0200, Andrew Lunn wrote:
[...]
> You might want to consider using a network simulator/emulator. Use a
> number of user mode linux nodes, or qemu nodes, connected together
> using a virtual network. You can control the packets losses, paths
> etc, much easier and dynamically.
>=20
> Take a look at this page for an example:
>=20
> http://www.open-mesh.org/wiki/open-mesh/Emulation


Yes, this is an extreme good reminder. It cannot be used for performance=20
analysis, but is quite good to test routing in extreme weird situation.

Only a small hint: Try to use qemu-kvm instead of qemu and enable KSM [1] w=
hen=20
not enough memory is available to hold all virtual machines in memory.

Kind regards,
        Sven

[1] http://www.linux-kvm.com/content/using-ksm-kernel-samepage-merging-kvm

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJOMVCoAAoJEF2HCgfBJntGWWAP/jIFMKFE0tradKACFzRBfydv
7L3CW1FkjATdxCg6sJbsSVES8QC+fGa64by0kFcHIg3e9omRcCkUo4ikV/XYQOEs
OrU79uNw2L1qQt9gW/Y6wQvSdVvIiZfpg81ni3pcW1BGhrUh6H9D8HEaI7DxPcMM
07rB+uyjhJSbrxkUJJow4PmCAtPeJJPv7MS6GSA//EmDz5IAqph1YRy+DfMfzMqF
5MdTo32pz81qumxW9gfwV55CaajUdyY9utFJ2LDLQP/qDXAv39rKA4qeM89BAOCV
wCZhLtALY10DI1sUE9PuL8LoRERTKE8SmuF0nFCIZIeNLPJYA0a4T5Zb+Hg7HgA2
j0UBzWcf5QM2JOey+yi6LPHn7c7biuBMEe5Ni/FPfB80XxaxA6tJihtTQ7FJdWJF
OZqz4/F+10TCAiywCosF5ilc13QQHBT55GFqLsMRvTh38nY0YQ68uZ3bQ/aYMDdD
c222UtjfZ/3LO8WeWwZ3h8R4bSdUuk/v/OmwU1REA9b62u8aOSP2ygTsToWJqjfi
ucsg0pZ7iSS8Im6v25v+uj0VqqYlMmUAmcTQUNTgab2oSqGM2sqzylLSuMsRBXIT
JZUQFnaRjesUQN6u2espoLiXAkRXVxtueu4f+0QyhQZ/SiKQq3NSXacFclOfVz/g
twCLfCVHW//bUbFp+9W0
=Xbgj
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
