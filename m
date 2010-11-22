Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 11:28:59 +0100
References: <1290383767-32602-1-git-send-email-sven.eckelmann@gmx.de>
	<201011220206.30172.lindner_marek@yahoo.de>
In-Reply-To: <201011220206.30172.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13585583.vLnXWrG05j";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201011221129.06220.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv for 2.6.38 (1)
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: greg@kroah.com, b.a.t.m.a.n@lists.open-mesh.org

--nextPart13585583.vLnXWrG05j
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Monday 22 November 2010 02:06:29 Marek Lindner wrote:
> >       Staging: batman-adv: ensure that eth_type_trans gets linear memory
> >       Staging: batman-adv: Don't remove interface with spinlock held
>=20
> Wouldn't it be better to push these too into .37 as they prevent the kern=
el
> from "oopsing" ? Or are we way to late for this ?

This is correct, but I have to look which previous versions might be also=20
affected... and what should I today when I've would have done everything=20
yesterday ;)

=46or example "ensure that eth_type_trans gets linear memory" may be a cand=
idate=20
for 2.6.36.x. It needs some merging due to other patches in that area.

I will prepare these patches and send it as reply for this mail.

Best regards,
	Sven

--nextPart13585583.vLnXWrG05j
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJM6kXtAAoJEF2HCgfBJntGAnkP/1Og9AH+jotPFV9W3x9Dz19s
BYB3aoM5T0NPJJ+9aiK1pj8wHASbOexXRoygQN7uGssuS5l/KSrUREeoBIdg1c78
O+JTpDNJbFII5lQsfr5DjLUSYsL6ZfXjZ8eEAtTdpy8XfW6VS29QjIX3Aa+NuUIN
Fpr0iCjaLjaCpKxdh4pznKJ5nizcQfynJzZ2BiAJ68KBYq4r3q0t4wHq9q/Fh+WI
2Z13MFf81mfa14H7mDf+JK5gV12SH76Gyv8zko+3AaKycWU1/eGSU/FEqKS1dghf
+521aGbVHvf3eS3silvaI9dAyFGpYT2u6fSG0++XXDTreYBnwli3CY6tLGODoJHb
pFZE6qh3qmW0INcYK12lHdQKciN+c0HlBOG2A3gj6/cVWVzYV+6f6WJeJZ28kh2i
iGEwJjhaQ+VLAdaMP8hLsyIGycqmBG/i+JHySRt8nN0cGjYciI17aGVVNm1sU7XQ
RmHp7cRzfpLxuw7lMXfIS1EIK9u3vbizwYh5A47unEvUwmzG1WdkFAXAH7EP7drW
EjtI4XNwYvMYu9S3FEf4b+fG3mMbzBd2fHpJsbY/YmeLCEZTgwW41KSr7G0tQJkN
Xsv1bp6HZ11UcwOFjZLARGkORXiODtgO2fPH86aD39fHb0Z03S1wMvniLAoMkTWu
lLckoWTJOT/oHkZmaO5r
=7V+c
-----END PGP SIGNATURE-----

--nextPart13585583.vLnXWrG05j--
