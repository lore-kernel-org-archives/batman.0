Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 20 Mar 2018 08:11:25 +0100
Message-ID: <6449718.Qs0OEB85sk@bentobox>
In-Reply-To: <20180320011924.28287-1-linus.luessing@c0d3.blue>
References: <20180320011924.28287-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1855822.0v87oRv3Ra";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: netlink: fix resetting
 mcast_flags_priv to unsupported state
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1855822.0v87oRv3Ra
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. M=E4rz 2018 02:19:24 CET Linus L=FCssing wrote:
> This fixes a copy & paste error detected by Coverity.
>=20
> Fixes: b56061058113 ("batctl: add netlink dump function for multicast fla=
gs table")
> Reported-by: scan-admin@coverity.com
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied as 15f6d90 [1].

Thanks,
	Sven

[1] https://git.open-mesh.org/batctl.git/commit/15f6d908fe3d152fc7a4c682231=
d13fbf1b8751e
--nextPart1855822.0v87oRv3Ra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqwtB0ACgkQXYcKB8Em
e0YOVw//f2GAyJYTt/rKhZ9EWLlqnXAupO+ePGLSWWkeIgRMI13mYolqmqoyj5h+
LSKDuyB3Xd9x1GeVhx2mTLHpOYS6l/2yHv9BuYrXlr/c7S4fZaVggIWmBHounXVz
RxQqy24bsmn331qDczhb5qR200MyufVBKZROt3p4iy6zpgopi2FnRFZhCw3cfqCV
+Nobo2fMkI4vgI+7kd04kkVBov1Van6wWR2A0Y9dfroOInbdZ4wFSkeZgZYogRUa
8LPVP+CJfGS88T/P0SSHaWDBwXaK8CeJ6F4hKo58ReQniPnckwmFHEUq31Hp9jFz
nH/oqOt4zM7UtA+gOvykCuKWAJr3AASGCIY5M8kmKd5q3uwc6GYBiEX2PVowkofl
dmO9ba9eSScw6m2aKIPCtSIdxEcgmPyxAUdNIzjqmy11twPMnxA3KZTSv7Slnqbu
dDJAaTM5ZjhZdS1rHX6KjJJTU0psGtsk8l3KPEA8TDUgxVOWWZgwCLu+3ZAGtN+m
icB9Z3iap34zSFtPB8WXc6pQ8NOjDP/7BTR+Xc7W/UeNv9IwO/FhHz0aSLGVxk6+
+cn2vUEchdbFoOtfdoVjIfbCqsmpfCUvHK1HOFaiOGIJCdJs0M0r/vwqcA0mjcoj
mo7xwqUVfs7I2QjTYvu3j/bOmHREImR4PzOipTRvQ4q6YZ/2CbY=
=qkf6
-----END PGP SIGNATURE-----

--nextPart1855822.0v87oRv3Ra--

