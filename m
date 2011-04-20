Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 20 Apr 2011 09:09:46 +0200
References: <1303282479-17392-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1303282479-17392-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2433516.8S3uOVxihB";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201104200909.48651.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Move definition of
	atomic_dec_not_zero() into main.h
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

--nextPart2433516.8S3uOVxihB
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wednesday 20 April 2011 08:54:39 Antonio Quartulli wrote:
> atomic_dec_not_zero() is very usefull and it is currently defined
> multiple times. So it is possible to move it in main.h

I would prefer "useful" and a "Signed-off-by:" line.

For the rest of the patch:

Acked-by: Sven Eckelmann <sven@narfation.org>

--nextPart2433516.8S3uOVxihB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNroa6AAoJEF2HCgfBJntGLIgQAIPWTj+YrHdTSWw0lF23/2iD
QUl01XEPkUOF+TaTaGwjgLnIVU3ysjKjYuFPmNfHvIHsIPCr0Ekkg5qZi4Q+ezOF
ITmxXsWombaJA40qRNEVhcsXdhoeLjEpqbAqWNlnaZhqcGntff+yx20x+zWHxRoH
kHXZnZLpENUQmef3ZXR0jBs4iZLOi99zwMhxpEBmMDwV50MOcOUW9eOI8QkMAWz8
fq9KfGQ5c2aMJLQYvb8rxQ9RsS/0O1hbBeVXdcbVxOGnkvgcic3QlbfjGJpT5cei
+ia6LwZ+HmpLgIoNl0r5dhV58wi8/mCapG8kxc4DK0dEtVEq/Rc2LCRZQSFufiIq
VRuhBObFiF0/OicgJJEM/B+e8Ksoa/e5KTC2pzT/DGu5Runa2tgnGxu/L/pcqWJ4
sKp1PjcjGxVI15vp+dHsaIerA6nwIFiHV9kSBMnHYqVcs6uxWP2gb0T91DbJkM9Y
lI0GWHdDBX2fI+mcMe5wiLc6uig2AyB54LkmB9h1X0y/hkIP374cKSKWVAikpgah
k7Sw8y9FXFdp3d2syQGgzv8pF7zfmhLkq9ViF6n6/xTGZZV2kplIHygjmNhl4S0X
KeL7O+pYuC1Ya+Uj98rbpjCtigvK+0CHqEqPBvRT/YFg8mY8cCfvpnLMiwj0xtiX
oZSPqOz8de8/upZoZ4TO
=ROXY
-----END PGP SIGNATURE-----

--nextPart2433516.8S3uOVxihB--
