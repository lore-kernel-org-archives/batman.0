Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 26 Aug 2009 10:01:27 +0200
References: <20090826064151.GE21827@ma.tech.ascom.ch>
In-Reply-To: <20090826064151.GE21827@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8180517.fLQqLYXfbt";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200908261001.31814.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] List policy for none subscribers
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

--nextPart8180517.fLQqLYXfbt
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> As a side issue, i'm not sure batman-adv is the right name for
> mainline. In the context of the batman project, it makes sense, but
> from the perspective of mainline, this is the first version of batman,
> and maybe we cannot justify the advanced.
It is the name of the protocol and it doesn't make sense to have two comple=
te=20
different B.A.T.M.A.N. things with the exact name hanging around. One in th=
e=20
mainline kernel and one in here for layer 3 stuff. I have also personally a=
=20
problem with the algorithm and the layer 3 protocol having the same name - =
but=20
with completely different version numbering scheme.

To the wiki stuff. The policy was long time correct if I remember it correc=
t=20
(send my first stuff without being subscribed). Maybe it was accidentally=20
changed when the administrator upgraded the mailing list/mail stuff.

What make me a little curious is what that change would mean for the=20
development model. Ok, they would have to work with a git clone and have to=
=20
send merge requests/patches to upstream - but what about internal packet=20
versions. The current version is 7 and have it to support older version in =
the=20
(very probably) situation that the packet format is changed again?

> Should /proc/net/batman-adv/interface be replaced with an IOCTL interface
> similar to brctl?
How to design the kernel<->userspace interface that it doesn't end like=20
wireless-tools?

> The code is however sparse clean and checkpatch only complains about a
> few lines being longer than 80 characters. Most of these are printk
> like statements.
I found also some other things and also told that Marek - but I think that =
not=20
everything was included in the patch I send some weeks ago. Maybe it was on=
ly=20
to break printk statements to fit in 80 chars per line, but I am not sure=20
right now.
I am relativ sure that checkpatch didn't liked the initialization of variab=
les=20
on stack with NULL... which I don't agree. But I haven't checked the kernel=
=20
coding style documents yet.

And as my position as random guy I want to thank you for contacting Greg G-K

Just my two cents,
	Sven

--nextPart8180517.fLQqLYXfbt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKlOvYAAoJEF2HCgfBJntG3rIQAJ3aLUrzhQGBRmGqjMDzxMcL
Q+56EdIELaWwR/e3QInjiFBk9JERxS8sgsAtzZmn54LpU41EJWPeMZYJDNbStM/B
AJdOrA8uM3DzImBC83TcjybRD6dlODGFNhMlH682ZtZELCTDKqF3VMTVOL3lDRIY
OV+NGRqpoIY6KSdShyYy9WmhEe+Ua0UbpTwC5Lu6DwDqcawWP5zB5kZOK7ITKvo1
+KJ246ofRkUywhrxm97gEVCWJ9JGyX4Wi+YJEc4RGna1FO7QpzerhNVRfpzchAfG
v4JtkULhg0zCNX+SoL1Y1Lc+oveBVZSDBtDNPi/c6ZsWj0uJXFv0MlWgIMF0rL+T
ZrZClw6eXlpNba4cwcco/Eipi4PuRM1BiaPLD0eI9utd+JgH134b1YEWcV5AVU+H
9V/KF95xzWEibzWtfO0JkD4hDAZgmDB+uo/Ijaue/a49acSHuEFvpwQpIpyJbAo7
hv8RYo2fRM83MotpxU+zH48hL0YX7LBGdhzRgAKWNbqOF3EN0hBPCs/WFmrkEgbA
xunTJQKzQitU2i55wnRXLjivzfOr4I77eIW9Ial0jr06RdI07lGezCxFDIAXJ1Nj
Fv7514IRuoQCciZ4qsuilW/j+I6H34K0+PRdvpE8hntCie03qCP06bTbd9pbCG2f
gxFMUwfNP3HobWDQmGSw
=Ot8q
-----END PGP SIGNATURE-----

--nextPart8180517.fLQqLYXfbt--
