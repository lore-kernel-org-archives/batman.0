Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 23 Jun 2010 09:47:59 +0200
References: <201006101303.45771.sven.eckelmann@gmx.de>
	<20100622230258.GD18495@suse.de>
In-Reply-To: <20100622230258.GD18495@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11509737.uCquxjz6nD";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006230948.01188.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv: Migration from staging to net
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
To: Greg KH <gregkh@suse.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart11509737.uCquxjz6nD
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greg KH wrote:
[...]
> If everything is now moved into debugfs, and everything in sysfs is only
> "one-value-per-file" then I don't really have an objection.
>=20
> I would say let the networking developers start reviewing it.

Thanks for the response.

Can please also make some comments about the last part of the mail (regardi=
ng=20
the merge process):

Sven Eckelmann wrote:
> To the merge process itself. We should prepare a patch which adds
> everything in net/batman-adv/ (and Documentation/ABI/testing/,
> MAINTAINERS) and then send it to netdev@vger.kernel.org/David S. Miller.
> After it was merged we just send you a patch which removes
> drivers/staging/batman-adv. Is that correct (just searched for an example
> and only found benet[1, 2])?

thanks,
	Sven

--nextPart11509737.uCquxjz6nD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMIbwwAAoJEF2HCgfBJntGJQoP/RSSiWTLEazzimzV79lX3L6o
qzZn8f88Uw2mbVRU3uddz9bFrX/Kwc0EA9eB5M6bnVQvBVcx9MqhvDrm0G8GwrBA
VJi/GMG9u3uX72+Z1EHhoE3bFbBQzzhHA6ThmxHoILMZdnpSX5OPmtknkB9ShMVv
2PJin44jQ6QhoFhgDJdoNIHvHSSx6UF0t22qngfeR6As8KEieHC2Ml4wEzFdwAgr
z6OYvmE8o8KZQVYoWYYLiZ6taTP5OPV/+LZs+eNMZRl42IfQK7l+6FDRaKkg6gsb
ZyZ6Z4UyEBa1d7XjNJOxuYw4M+UQYEdsKY9DUg9eMbTvzSkbMzohrP8924cdVyrW
x2ic6uY4fuY/khSuDX/R+zRn+fiOdnoIAofPX+JCcwZzDRiEjy/uRQ33sdzCkt6Z
mH2KhifwOY3khHJsoql6/gtOs0ZPqCPK5rChMQ5R8RBhvCNGFYCzoqhF6r0w8Iic
A1FuVNMwViTWfYoNc1dEk9T3l8F0ulyIKqz+FVPivJtOSMtx7KixdNo1Q3dRLOTc
vSirO/ch+jvVpSw6/TIdVB42xIamKDttj+iIsZ+a5W2AP3Gw7Y1wPeMr3mbj1nYY
+67HJf4NUhlC92yrT+5vd4YIUTBHIILDu3Rk32dxO/W3mIYHMk8TEJvySQWbkzTc
eFoAnSb9SBHfumomo1oH
=dxAK
-----END PGP SIGNATURE-----

--nextPart11509737.uCquxjz6nD--
