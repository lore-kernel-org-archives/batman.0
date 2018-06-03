Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 Jun 2018 14:49:58 +0200
Message-ID: <3015974.TFUEeMtuLR@sven-edge>
In-Reply-To: <20180601153845.26561-1-sven@narfation.org>
References: <20180601153845.26561-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1713228.3ZhcznCuGQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Drop support for Linux < 3.16
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

--nextPart1713228.3ZhcznCuGQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 1. Juni 2018 17:38:45 CEST Sven Eckelmann wrote:
> The Linux Kernel 3.2 reached its end of life [1] after over 6 years.
> Instead it is recommended to use at least kernel 3.16 which is also already
> over 3 years old. All older kernels (v3.2 - v3.15) should therefore be
> dropped to reduce the support overhead.
> 
> [1] https://lkml.kernel.org/r/a3d2d2b2c3559217eb8315d25df0c5883f922066.camel@decadent.org.uk
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

Applied as 7ab78d556b34 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/7ab78d556b343b592aa80f4d84b2dfd14019f2d8
--nextPart1713228.3ZhcznCuGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsT4/YACgkQXYcKB8Em
e0asug/+NmY9RWvNoJmOjRMaRgby8jtWJ0KdYt/F4tI5rUCX0QmUo1dsoZOJTVAH
Z9qh1BjEjSFD1gsZCPAoNlIY54EJdcJJri1BEBge6VrXSNbkRGBlhl+qHriAgoP/
L3bz0YRYQvy37VOVZY4AN0puQT1FIirADj86NRmRgY0AOE2AAobNP2L2WdBH/7gf
IqUld6uDTieNddzajZjuwHy2/elM+6xfPgXQG4I9lNN6oyq173Q4gbsbS6QCbe0p
imcAvC1ck6hi5D5EVCYRhyeqv8hA5HaeSDR/u1YbUUyLMOcu3T1GKGEPYnNP4ER7
pCmfBbvRba2H3lNP7Cb4ssWnWAUr1pkm4JhHT7iVgm5jPK099a2IAMNMiYRLye5g
KLBbXsJQlKIUE6Rq71BJYyGUiUM08nafnvuo7whT4rFeC9yrFg4YMYK67SDlBrqp
KcKTfUIQkkypfQSewK2q1UhYU+nd4uUnIofvtc+hM3B1PQ/ZU5C33ur2fHrEsk4J
y86CbmKMekKJEC88iZx6lpM1J2tJWb/XqGyieG9fTChLpDaQlz07TSgBYDdb1qkk
nK+nJmmIPaUomCmd1CUenj7SF+C6DmOZdQ0k3L8W+k30wJL/s3siz2UchxRx+Ohm
B1Xo1R3sSzOLOZw8fbsDkCB3m+74NkB2UFQoZUg0WLIqF2vvs8o=
=MwNZ
-----END PGP SIGNATURE-----

--nextPart1713228.3ZhcznCuGQ--



