Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Feb 2017 08:56:44 +0100
Message-ID: <2164005.BaM7rbROku@bentobox>
In-Reply-To: <DB5PR09MB0391C18D43FB524CC828F191B35A0@DB5PR09MB0391.eurprd09.prod.outlook.com>
References: <DB5PR09MB0391C18D43FB524CC828F191B35A0@DB5PR09MB0391.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1577754.dcWfnuF4NX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Distributing Data using BATMAN-Multicast
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, "shantanoo_desai@hotmail.com" <shantanoo_desai@hotmail.com>

--nextPart1577754.dcWfnuF4NX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 16. Februar 2017 12:35:32 CET Shantanoo Desai wrote:
> I have developed a Multicast based Data Distribution protocol
[...]
> I would like to compare how quick can data be disseminated in a Batman 
> enabled Mesh network versus the protocol that I have developed

You've already lost me here. You say that your protocol is a "data
distribution protocol" which is using multicast ("Multicast based"). But the
L2 multicast feature [1] of batman-adv is an optimization which tried to
reduce the amount of broadcasts on the underlying layer (for example wifi)
while still allow interested multicast listeners to receive the data. So you
could say that it "implements" L2 multicast in a slightly different way than
in older batman-adv versions (which was just using broadcasts on the
underlying layer).

So your description sounds to me like these things are two different things
for two different tasks. Basically two different layers in the stack. Can you
clarify this?

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Multicast-optimizations
--nextPart1577754.dcWfnuF4NX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlimrLwACgkQXYcKB8Em
e0ZTYg/8DPxAYOpYAkVjI5Eo89d8hGgrmMU9lJCL4sR55rEbP3m4i7V3vyAaEaT5
UpsVJcw9Kuvg53YZ6CuaAer2pq2+yIeUZ7iopZ/wec08BO6uws4NkdGIq/FLV2H9
02NkLAQI2QsZiHWiAa85dDrfpFhXXN+fHDjJWRlh2uK5d0dDzohVSfIY/MJP95yl
OUylpw8FC0JvbQXq6CXjtxXeuFx+zLfW5n+090vYcsmw4wh7lL+6G5DPc10yH+lo
BrZCpWXIhZzBMjQ6g8EVvh1fJNHDFCw2qTlj5zTJJ1zOW3jipYNRp+P8HdcIjhqU
mI3ighAscSQ5b/K4OTQsm583ALQLoOMa7O2NSub0zUVMZ+MajSlhiuV5hg6jbh0X
FMBd8ZT2fEYwY5PSAfXSE4w8lHi4VzrDNHppGaXrB0ZTjp5nrUi0QZc/4q1YzONi
BUTdDqCR8PbcqZEtHvfv1oo8i0xfAQS+xqATLa9w8LGCliNuq7luoWVeRq3BipPk
S6Da+czz6CfHSG1EzWuleGCiLLUZjRCG9gp3D8fXjve1rfQasbpU8rDeuDZbA6EG
h6PNCxMwppTWmuQfsc9gej43JzzK0q3QXQd/Moa8mQOk+LZnlnWcUalJBVYFinfH
ho8j99ipREw4eK33HJ/jbt+onqrq780/DlbBkqyTLRpakqxsCIU=
=wQFq
-----END PGP SIGNATURE-----

--nextPart1577754.dcWfnuF4NX--

