Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 28 Apr 2011 18:14:33 +0200
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1303940106-1457-3-git-send-email-ordex@autistici.org>
	<20110428161031.GB4240@lunn.ch>
In-Reply-To: <20110428161031.GB4240@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1776613.EVJ1TOIzOk";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201104281814.36331.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: improved client
	announcement mechanism
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

--nextPart1776613.EVJ1TOIzOk
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Thursday 28 April 2011 18:10:31 Andrew Lunn wrote:
[..]
> > Moreover:
> > - COMPAT_VERSION has been increased to 14
> > - batman-adv now depends on module "crc16" for tt crc computation

[..]

> Shouldn't this dependency be listed in the Kconfig file? I think you
> need to add
>=20
> select CRC16
>=20
> See for example ./drivers/w1/slaves/Kconfig.

Yes, but this patch is against the external module.

Kind regards,
	Sven

--nextPart1776613.EVJ1TOIzOk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNuZJqAAoJEF2HCgfBJntGP8YQAJn2/v3qAcxRkwPdpONlK3Bh
6MrEBUlUY/0I7s8V89aAVd/Z7p03SW8eYBSdBdUmj8CHT9u7T4leHdc2hgTGB2Bg
/O4ESTurm93OM8KAccowswKmfDMZQLRqFFN1ASW8J+siR8aDnV1+bWyta4GnM1pn
daKfhpogn9xOSREZFpvciaHviNdR036hBrauwrK0o8u0zfhN29L2D5j5lAj/SsdB
JGIf/mFBBo5zrAJLrqlr91gNgpiWo3iWJSPnN5BE4Asv5O46wwxv+WIWY2mUxR2e
7T/7fpbMNonBFBXdzM4UpR0gdNsEhe9TXWylAZhVYB9tl1OoU9qsYJYcomQ4TtE8
FO5AsN/8y7xGltei9Gaput7DlqjH13vI3fy/dZSDHdWNshJXhib+bJvqfKr3KZzp
qCuhD/Jp6EHKDIfuFL+atVSJ0fv2OZ9nMAEKbO0ZFQQB9YzGv0jK1Tqqb/4cyGQR
azTeuWEMkFQNiazELI04TYW4gJDQBSA1ctMvm1vFslDtBOpXKrGgX809BQqcOv/Y
b1aeew44Azqz4LdIAJBbk8AjtX5iJuNsH45AiFlxGIEBRzu5wKMRwy12hh4TLT/l
4+PNFD365kGimlh54wkhksJnieH+mMQvgsX0A/cjubUULtuSTqptzpLa09vNBT3V
vxM+D041jl4kHf6pSmb2
=xgrR
-----END PGP SIGNATURE-----

--nextPart1776613.EVJ1TOIzOk--
