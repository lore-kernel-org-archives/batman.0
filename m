Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 10 Jul 2010 01:07:56 +0200
References: <1277504905-27672-1-git-send-email-sven.eckelmann@gmx.de>
	<201007061736.14006.sven.eckelmann@gmx.de>
	<20100706161737.GA16045@kroah.com>
In-Reply-To: <20100706161737.GA16045@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1518133.ufRQTmAym7";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007100107.57451.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (3)
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
Cc: Greg KH <greg@kroah.com>

--nextPart1518133.ufRQTmAym7
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greg KH wrote:
> > No, I didn't want to say that you are too slow. It is just hard to know
> > how fast somebody can process something and if he has enough free time.
> > If you would say that the weather is to good to do computer related work
> > until 2.6.35 then it would be fine too. :)
>=20
> The weather is pretty nice here, finally, maybe I should take a few
> weeks off :)
>=20
> Don't worry about pinging me if I haven't responded to a patch, it
> doesn't bother me at all.  In rare cases, I do miss them, so it can't
> hurt if you haven't gotten a response from me in a week.

Ok. Thanks a lot that you applied the patches so fast - even when the weath=
er=20
is so nice. :)

I have a small question about the topic "how to reduce the workload for you=
".=20
We send the patch which should integrate batman-adv into net/ around two we=
eks=20
ago to David S. Miller and the netdev@vger mailing list [1]. Some hours lat=
er=20
Hagen Paul Pfeifer responded with some questions and different ideas - whic=
h=20
we (batman developers and Henning Rogge from olsr) either answered and/or=20
started to discuss them.

The problem is that the discussion stopped quite fast... actually there was=
=20
only one mail from the netdev guys. This is quite irritating to me and the=
=20
question arose whether we did something terrible wrong when we send the pat=
ch.

Maybe you could give us a small hint how to proceed further. If we should=20
wait, poke around or maybe submit it in a completely different way. It is n=
ot=20
about "getting it into net right away", but we would really like to get som=
e=20
responses so we can work on it to make it better.

batman-adv works quite well for us - but that doesn't mean that it is good =
in=20
context of the current kernel development. And who should know it better th=
an=20
the netdev guys.

thanks for the mentoring,
	Sven

[1] http://kerneltrap.org/mailarchive/linux-netdev/2010/6/28/6280066/thread

--nextPart1518133.ufRQTmAym7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMN6vMAAoJEF2HCgfBJntGXZ8QAL6z8sMupswLEpYFECC5PmHo
zC38qGB2HydihHODZoSvCcdJcE00qe1b/hzGnVBA5S3NhJAX8uyEEjc8Pn9oc4xg
DvCZyPRTwVbRILHt8pBlkgLuZQjCnPdrSmxc0qR49G/VP23KnNjo7AqN65QGnpIN
qF2OvFzpH6rlbtWkng1cq18F0i4EOZMFZckW6Zm+0a001I2cYRJpOYDpE65rGEgz
VF6riAxOJxWSpl9HbYjj1jIEq+bs2lOSEY92Td6K0uQ020hnayp5oe+QX7Oq3iMD
TNDQBLEucvSoEc/4Ul6YzudFnmGRlaX+5u695+e/gDvxSFT4W9hXz+730pJgTEt7
k7ROL4B7982JGMN/O3maO7yA/lvhevQ/62D/QVKMCdQQ6f0Xr5xW0USGUIhMYcOb
vOIh0bD6FpVmVKU9wd06cCLnXvTptqVCkF1OoGYD18VFlb8gvRjvTT3BgPwwI/mn
RXLZO5XGP8xIgpq7g/M1e65CbIduYX3DlQoj/bOunyUspYn7BQmwJFcqq50e2Nmu
DV33Blg9yB8job/3E2JaKkj3gN/k5Jss5ZIzI8I7H9dHzd5WE2GwtVLJAb58di+5
NS64Ka+hOPgObsDrupO0PjkFNtdkGjVob/un5IhZYoXdmhoOZjD6S5+5zLx9JxDT
mWXBSBALPq7zzQbb2ZMO
=2P2M
-----END PGP SIGNATURE-----

--nextPart1518133.ufRQTmAym7--
