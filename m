Return-Path: <ordex@autistici.org>
Date: Thu, 13 Dec 2012 19:04:17 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121213180417.GE23890@ritirata.org>
References: <1355263044-13131-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EXKGNeO8l0xGFBjy"
Content-Disposition: inline
In-Reply-To: <1355263044-13131-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: postpone OGM preparation to
	sending time
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2012 at 10:57:24PM +0100, Antonio Quartulli wrote:
[...]

>  /* when do we schedule a ogm packet to be sent */
>  static unsigned long batadv_iv_ogm_fwd_send_time(void)
>  {
> -	return jiffies + msecs_to_jiffies(random32() % (BATADV_JITTER / 2));
> +	return jiffies + BATADV_MAX_AGGREGATION_MS +
> +	       msecs_to_jiffies(random32() % (BATADV_JITTER / 2));
>  }

I just realise that I cannot add BATADV_MAX_AGGREGATION_MS here directly be=
cause
this function is used to compute the forwarding time of OGMs the node recei=
ved
and that it has to rebroadcast.
I'll fix this and post a patch.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--EXKGNeO8l0xGFBjy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQyhihAAoJEADl0hg6qKeOqiQQAKHFBtMb0X0wCk8sfKy/49Ty
SHBGs9BZTAjkNGK06erMgcTrt3DJFjHc7x0c03g5FFB2ZzwWjIBVGYJkwfpN57b/
GJWDSY6j6fXzXe8zL8rLMdp0R0ll6fQKlGU/2ZLcBf40K+5mDj1/Sz2j5gnl5srr
bcazvsyrtI/+ooFCF/FpzcNni6ZRgbddM09bstyULIxOFlWppmhN08WQnQbPpeVH
U+u10ZFFmFn1OyduaG0xqjWdHsGRUCz8uchCECgbofa9/p2Nl7pjkpGtwuaoXH0L
y0/xCDLMmiY9AlhT3AVji2DXHgTIj0Ogrn8hATDnC9udW8TfRyNbg5WzQRsbOi+X
ZCyxcgn71OG3vbiHpVngSaPu83Qfa8Xwg3j6x++VC1zvrzEvAExUemY7qjUROjEX
65aQiH1pQNkzojZYJZFhtJDD8xvHrCSV8WnKdWcallsDez1bWPAYNAfwkhAo1xET
tCXeRmrqGUI3ISCOylb5h4AjYIMVmuh5/btaS6RZx3V9OgqYWpl+A4d+n/ScS7Js
STHf5aP6162zve2/K4YcNUzgwM/i9intThNm7A+hNIdCYH/R6LKqyvCFkI8u+T2B
rn4W+hibV64kgFLZuGR6njU15G+bvtw9PkSDfQRADcdE4aQLT+VtPEa7uNHU0dat
zTD2ZLhTtxl+xnLj3fG8
=Ae2+
-----END PGP SIGNATURE-----

--EXKGNeO8l0xGFBjy--
