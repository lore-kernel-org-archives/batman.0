Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 20 Oct 2009 12:04:21 +0200
References: <200910061328.04894.holger@layer-acht.org>
In-Reply-To: <200910061328.04894.holger@layer-acht.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1655724.R6vhNg9gDQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910201204.37562.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Debian extra modules
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart1655724.R6vhNg9gDQ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Holger Levsen wrote:
> I've shortened Gregs mail to only have the relevant info for this list :-)
> Full mail is at http://lists.debian.org/debian-kernel/2009/10/msg00236.ht=
ml
There was an announcement some hours ago which explains the (possible)=20
backgrounds further[1]. It looks like the packages which builds binary=20
packages from out-of-the-tree modules gets removed and it is now preferred =
to=20
send the source upstream to staging by the author of the module, patch the=
=20
kernel sources to include the must-have kernel modules or use the dkms[2] t=
o=20
build kernel modules.

I will search for some more information what must be done to support dkms a=
nd=20
send some patches if it looks promising for upstream. There is currently on=
ly=20
one package[3] in Debian which supports it. So lets see if we can add a sec=
ond=20
and third one :)

Best regards,
	Sven

[1] http://lists.debian.org/debian-devel-announce/2009/10/msg00003.html
[2] http://linux.dell.com/projects.shtml#dkms
[3] http://packages.debian.org/squeeze/openafs-modules-dkms

--nextPart1655724.R6vhNg9gDQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJK3YsmAAoJEF2HCgfBJntGAvkP/idbuO29+Jsam3OfwzFSWSo3
4NSajIJ0k3cyVt0gZjgqs8AA2teoLRfU4iEh1Gjg8toTIaACmFongQFSI0RxBxcA
bp4ft3tuguxMlsJTfvkg/Gx0U4KkXW3UD2T3US9wyXXj1e8RggH7LA2cJ5Myvddq
Drfu77Ajb4uJw9Qi0Nvsxc3KXBa/wMym4cocP0CUt2y6RtH4wQVr+xcxDDug8za5
k6jbysta4698I71jwJNOTNjqC9Z4zG234P1NhtAeMNO4s10VMVf4kvOqhViMOPr8
JP3OxpWC6gpExjRMw1FVs5as8jNuYhCPn2uuM8j/vfvoEWMu0USdcPZE2Vr6no4Y
3Cdgx3cStmPytiP02RIxJJWb6vcVcj9v55RmLc2m88NEgSGGh19r8eRINnKKNP8f
OaokogqXJDc1NqqminG3M7rhobuMdJLlSa4+esonOXUx/WPl1So8mQEYWT6Qw+p7
XJURRXKx2grhiTqinM0EeTYjK769HSFlYXldxb64w+4mgAAGjmv/rdpMm5snOuqy
qejYhpzxHrRwRF869AZ1yd54e13ey15kHnO+UtgYUtYLA1cda8JZEnXyKLN8ksXB
muLRV3TyG0XwkY0S4LLQ5Z0ddww5jaz8ZfrNjIwSwFsUuYatYfU3lvw2J2V6tV4+
zKQuQ5apUotp/gpVqhW9
=FcpZ
-----END PGP SIGNATURE-----

--nextPart1655724.R6vhNg9gDQ--
