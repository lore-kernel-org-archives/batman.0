Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 15 Sep 2011 07:49:27 +0200
Message-ID: <14791148.Lch9XMektA@sven-desktop.home.narfation.org>
In-Reply-To: <c3913757cea624537f48fb88fb60e913.squirrel@clownix.net>
References: <c3913757cea624537f48fb88fb60e913.squirrel@clownix.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2383758.FYzfv1QRN2";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] lxc and batman
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


--nextPart2383758.FYzfv1QRN2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 14 September 2011 18:43:36 clownix@clownix.net wrote:
> Hello,
> I was wondering if the batman code in the kernel make batman not
> compatible with lxc.
> 
> Lxc are the linux containers that permit to have virtual machines with the
> least overhead (native speed) but those machines use the host's kernel.
> If you know openvz, lxc is the same technology.
> 
> It would be nice to be able to have lxc compatible with batman so as to
> test big networks on a single machine.

At least OpenVZ support would mean: one batman-adv instance which provides 
separate interfaces for the different namespaces.

We looked at it and found no useful scenario for the OpenVZ support. And your 
example doesn't seem to make sense for me right now. It would be one batman-
adv instance which is connected to itself... not a big virtual network.

We tend to use something like kvm for big virtual network tests.

Kind regards,
	Sven
--nextPart2383758.FYzfv1QRN2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOcZHnAAoJEF2HCgfBJntGp84QANbXs3dtEvQ4eoR9HQfrU9Wz
3rKOI9YpxZyIXci+kseBRhOsGFBcEH32bA5hl8biOF6HF7h9LL+OYuOzMz5R+JMv
HQxe7OSJ0Pw19aXvSGH9fNlECyKCbNBWXkZBmeJBxx/zgOAHilwah8zV+LbciuBH
89zfNQuPunC7xJZOJC1FFKMoJa5/migcb18QGxqc8FrN8uLhXaj5DpYHYdNgUDLJ
N7sPtOoyjVYHGCK/tgLeUyn11nV6hkIfZLTSW3RNn8hBMzBHo2H07glMMfTmajFL
oOZQnzZ9eFgihV1lnvRfg2GsR53yQxkfv+6RHIrb1vxn2chcuPtT4bKcs2y4AtSZ
RrOx9Rm7KnmfcLIy5vyfdB8UkBQ1Ef+6WnKQdvkHyY6/THsfDj2AOpX409IrePAf
qs/suWIUQkDZaxHRElyNV0MjAIwgQ8DcVCgyxQpXCAfJZvNtr8SiwM9bxzUndyIT
s9xZ7dFqYPteDhAl0J1G1arnXs5qmdyfm1paIiJZJ+uWjZauCH9FgwsyBj7Ou5IH
1d5ZkRdxgkm7UtPfyxrO04n7X8mEXvSXkmyT8nu91oK5fWiNChx5nm54SfH7p3TL
e0Qtbd+/ZNUvpAQeh17queaSsbz8bcYF/vNGqbNK47jnAoMlvU0oM894rmec0n2a
jSiK9r9KwD4Ugo5eccg2
=H7i1
-----END PGP SIGNATURE-----

--nextPart2383758.FYzfv1QRN2--

