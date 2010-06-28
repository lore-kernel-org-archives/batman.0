Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 28 Jun 2010 14:34:19 +0200
References: <20100627172416.62e7554d@rechenknecht>
	<201006271815.37040.sven.eckelmann@gmx.de>
In-Reply-To: <201006271815.37040.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3518860.YxKET7FyLt";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006281434.20396.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] PATCH fragmentation of unicast packets
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

--nextPart3518860.YxKET7FyLt
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> And can you try to add [] around PATCH in the summary line and remove the
> regards... stuff from the commits message? Otherwise it will be part of
> the commit message and the patch we send to the kernel folks.

Ah, forgot something. Could you also change the subject to include which pa=
rts=20
it touches ("batctl: ", "batman-adv: "). So the subject line should look=20
something like:

 * [PATCH] batman-adv: Implement fragmentation of unicast packets
 * [PATCH] batctl: Add fragmentation handling

And why does your patch change the packet format and doesn't increase the=20
COMPAT_VERSION to 12 (11 is currently used in maint)? Maybe there are other=
=20
changes coming which are merged at the same time... I am just being curious=
=2E=20
:)

thanks,
	Sven

--nextPart3518860.YxKET7FyLt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMKJbMAAoJEF2HCgfBJntG5dgP/3EpNcXf1G/jEuroo7RpX+B4
+DXZg46W+8b6y0sjCjdChUtpnnM/I2S6S+j/UfTAIZ/9X3QjrUQCrXC2KQaKJ7gE
h5gbEQk3QXne/SU7d+ZopRI9xPJHdDBHe2uGdrnNzMM9PwwkRWwJEZr/njByJDvS
yjYdcO/EgKDNN7m691+fVl8IOIjuZTwSrR8bs3yjYRpK3PcwSTCNHJp/1xeXA+rv
iYFLe5MARuhYQoFsaOYLjDh+Xj4z4xkAQ7Dg5VByUUuWBXkI4GttuSCfkeq4FJZ5
E7iiJuWZ5AFhVe6k2+8DaUlXervyf7f00vp0AAItiDXzcPGDICr70maEtHe0jBW/
XIAu/f2nx6RWrsOmd4en08hHIwqHYYtH54OtQhs2fnLc4TvcUpyYJMZF9EYA2KW1
iLGIiWNWei+Ju0mbpg0oxlQzvwPBNH0mWNx4Yaovm38hYtRV+6SVRI+lqy/5L3im
CQXlqmXecQkfujvEJn1VeWrEh0X+fXYjLSaZld6coq7AxnYDSl0oX+bNrhIkDL3v
LFONFY4pTR8+/3AEV2zUeGwoIRFI68pjWjJXLFT1vvOW8O0SPb8yYjwcrTf2xCA+
OMovoLjFdv1SEnacXHcuDS/cA8vqXJbKXfyp2fELLhJ9Pbpg/0QeZe9X8MqEU9er
qMphivyqWY8qqHmiseIJ
=4iUe
-----END PGP SIGNATURE-----

--nextPart3518860.YxKET7FyLt--
