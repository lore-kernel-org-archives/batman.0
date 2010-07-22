Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 22 Jul 2010 23:46:26 +0200
References: <1279664722-27500-1-git-send-email-sven.eckelmann@gmx.de>
	<20100722213007.GA26362@kroah.com>
In-Reply-To: <20100722213007.GA26362@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart18822848.xiPRdgmlGx";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007222346.28234.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (5)
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
To: Greg KH <greg@kroah.com>
Cc: b.a.t.m.a.n@lists.open-mesh.net

--nextPart18822848.xiPRdgmlGx
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greg KH wrote:
[...]
> > I can also provide a patch on top of linux-next instead of
> > staging-next-2.6 if you would prefer it in this situation. I will call
> > it
> > "[PATCH-next 1/3] Staging: batman-adv: Don't increment stats of foreign
> > device"
> >=20
> > I hope that it doesn't create more confusion as necessary. :)
>=20
> I just applied the 3 patches, I shouldn't need to apply the other one on
> top of -next, right?

No, it was just in case that some merges happened before you apply them (an=
d=20
you would get the same situation as it is currently in linux-next).

I hope that the person who must resolve the merge conflict between staging-
next and net-next does the right thing... but I am sure that everything wil=
l=20
work fine (it is relative trivial).

thanks,
	Sven

--nextPart18822848.xiPRdgmlGx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMSLwzAAoJEF2HCgfBJntGnw4QAJ4AjZZvDZNciGeKkxM26PhI
5JW73OiFfeStIhrWYEeYOVircaqpHAtmlZYVd3+SqDrYtOkWJLiwHjvdPDoVsrOy
QDe4CUQjFXLGhnhjSUW1hoG4prMoyWRQNC1NzyzNPMswV/L8YcuORacwk0/mu5F3
zbRLjGF5B4YNVdtZLqTbjKfXcpnR3LkrFZH9GYQeoWj3aUxfg419fcTLD2W5VgPj
iFQm238JGM0UNtRNi41DH4IdpIQCuGnDQrfElri4Kp6uymNjJ8UB4qMp1+GNHwwm
tRm+26Z+TZ0Dn30BAhBOt45oxWWvz0zXpQSWekf1bsGf/0FglzxSCStIh80AGq97
ud6KRvmF7lJ4LuSBDYDPFDsyHAzberL5fDMo3pDKj4UDrVd19nCdqstlL88WYP3J
tKhDOGBWtRA12ROowLOunwB4hUUtPhcrnZ9MPpKm4Ib6zNGIMm0gF6pInTeSn39N
lC7W2x4XG6VXMUl0/PP72ghEOldfjLR2vgLfyNl7Uh0jbql6iKKVe5NnoeT37Rp8
9qPRUV3y1itIXX9lvcRLM/6c4LJOCCcxKIx5qwcYFkrpOpUx6vxkNk1DxnnHJV35
Q47ob86uznYEUE3e8IDHX1Le7j0iGVTnNnv9E4kINKtAZJq9qK4Bl9zXRGAK4YtJ
+QjYmfmFGNtp9G1QqpY3
=xm6r
-----END PGP SIGNATURE-----

--nextPart18822848.xiPRdgmlGx--
