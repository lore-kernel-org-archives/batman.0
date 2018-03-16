Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 16 Mar 2018 21:24:32 +0100
Message-ID: <4626296.strlS8ikrF@sven-edge>
In-Reply-To: <c09f296ac6e85467147096e656d12ddf05713216.1521196151.git.mschiffer@universe-factory.net>
References: <b512c268fbe9f9d61eadc579457d6b825fcf3638.1521196151.git.mschiffer@universe-factory.net>
 <c09f296ac6e85467147096e656d12ddf05713216.1521196151.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1639984.4Es2WcuOp0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 3/3] batman-adv: do not modify
 batadv packet header before pulling it
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

--nextPart1639984.4Es2WcuOp0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 16. M=E4rz 2018 11:29:11 CET Matthias Schiffer wrote:
> +       skb_push_rcsum(skb, hdr_size);

This function is only available since Linux 4.7. Compat code support must=20
be added to avoid build problems with oler kernels. An example can be
found in=20
https://git.open-mesh.org/batman-adv.git/commit/9f2b23430dec8caceedf996eb8e=
c75d3f8674144

Kind regards,
	Sven
--nextPart1639984.4Es2WcuOp0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqsKAAACgkQXYcKB8Em
e0bb/w//T/nJLIHAE5lZdTJGE0i/rP7dpE+Cx/Ds+T5MvHB8FP8+B2RwJuTEBwKB
Z/9ie9k+p0s+dYazPX7N3oFPK7wmZUmFT2sCcPx2gXVnYWZ0Z/+99zT/F73U1tTM
NrtIDAneDu9PQupQHhVUUdbTzvppXwzZYJtNaI1tug9kxt9ZIxQiQHsMSKl/dpFK
AVNuYIlZhJt9xXHkINrD/qckCI3g5nvX0rTxVhYYufOq/n+Um45CtHXyM7wM5I9h
7O6BTDCl4U4ZG8X4nRGIl4OIvlN+7Oxplg8P48gHgTDBB7RfSmYcPrBpY99WO1jK
jJhWsnwkzDoM1HvxC33j04oeRdAhgByWsJ6FnLOjTnwXzxvXo1I5YcGBagd8cjH+
dy33AhxjbMwgkn4bwLFhU0EZFeZLxkWbG3U3zllOuR/LQ5wAfqoE95reBKKF/xiG
GolkiHPq2YMcH/AwPGwVGwcmD25Pd+h5qXHeU8FzfpXhJS0vMAubPU4IDPFphWSF
BW4zEQc2ymo4KXR5rywCpaVXJToikJ0LoAzTWt4mzghH9esxWAG3KF02wbCAgIss
QS++IVmcXCaqGf/u2Qt4vEidjYm0br4FLtHlr5PVHkMpd2oJ1lr75qsytdy37BIM
s7aeT9CMNaqj3/sdSrt5IPIXThUbPKnJ8I8Eh6QtX0HDe0ZZyaQ=
=pKWP
-----END PGP SIGNATURE-----

--nextPart1639984.4Es2WcuOp0--

