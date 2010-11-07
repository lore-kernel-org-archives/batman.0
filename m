Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 7 Nov 2010 17:03:29 +0100
References: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
	<1289148361-16019-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1289148361-16019-4-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1841284.70SZr2ZjzB";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201011071703.36509.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Add sequence number and
	duplicate checks for unicasts
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
Cc: Linus, =?iso-8859-1?q?L=FCssing?= <linus.luessing@ascom.ch>

--nextPart1841284.70SZr2ZjzB
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday 07 November 2010 17:46:01 Linus L=FCssing wrote:
>  /* this file is included by batctl which needs these defines */
> -#define COMPAT_VERSION 12
> +#define COMPAT_VERSION 13\

Please increase that to 14. 13 is already used in linux 2.6.37(-rc1)

Best regards,
	Sven

--nextPart1841284.70SZr2ZjzB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJM1s3SAAoJEF2HCgfBJntGUmYP/i5bhngqgclF8aFQ6PYE7nqG
0iDOf0Gx4keOUSmIQIIwUd8Nqo/wlXemVoWMRxLiENtP9Kzh/j+GuU/7QmSu8opp
TG7pwdLRg4g5gMmKTRV3ItrMNOe1NVet0Vv2BqIkima7p9BPcYz0S5/GqiVQa3mE
dxIlNMxUPE5a3AKS60RbVtT0QkTTURABEfmIskZIKgdj0/Qi58Zuhcxamx67TGvD
2s032DNitJJY5byf035xdsf9XzUUJfoTBt72lK8gpXBaD3NdcYhRGziA5NiR6eYR
t8aGyTv/WqN1ccjOHWg2s6s0FfzNS2joLzPcD8v9imP00Jpp47i1AvJxaufT+vul
PCpvBg/iTLmDesFY7S+8elGPmr77PSx4CCqQvhPzKe2OsDmZq5uP4vTifouDOj8N
xvNYumwQ5VdgbGRVn3i7k0NVCYxhUphxK80KrGEuiShddLXt8/kjkcyY8zvrNBf0
NK+OFA1jWFdC+L9if3Qc/k8CEoLGKyFH8GnQQtQq55j8SWrK+Ws0HXrh3LhW4J5b
Ry4uRYbQe7Of5d8X3LjWZ8z9o5/rZ4W5VPo2bZN3SUcpJOg3SRBaT/Oq7e5sMaKH
E930hpom//Vb5BNU7gqPbvrXhw5qJXo/rac4jJNvotaux15H0tsOHqXMfB4C1J8q
NSxwmaUH0xfDliwGvbfC
=7jcX
-----END PGP SIGNATURE-----

--nextPart1841284.70SZr2ZjzB--
