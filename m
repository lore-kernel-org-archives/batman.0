Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 17 Sep 2010 00:27:13 +0200
References: <20100916235908.51ab3bfc@rechenknecht>
In-Reply-To: <20100916235908.51ab3bfc@rechenknecht>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1461605.qi8KMfWOVo";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009170027.16080.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv: unicast fragmentation enhancements
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
Cc: Andy Whitcroft <apw@shadowen.org>

--nextPart1461605.qi8KMfWOVo
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andreas Langer wrote:
> Sven, any idea why checkpatch (0.31)b do this ?
>=20
> ERROR: space prohibited after that '-' (ctx:WxW)
> #10: FILE: batman-adv/routing.c:1146:
> +	    uni_diff =3D sizeof(struct unicast_frag_packet) - hdr_len;

Because... what the heck? Usually it says that you should use consistent=20
spaces around '-'. So better use spaces in patch 1 and 6 and don't remove t=
he=20
space before hdr_len as you did now.

My version from linux-next (today) is 0.30 and doesn't have a problem with=
=20
spaces around those '-' (but with your version of the patches). The=20
checkpatch.pl-testing also don't have the problem.

I would guess that it was a regression in checkpatch.pl. Maybe Andy Whitcro=
ft=20
knows more about it

Best regards,
	Sven

--nextPart1461605.qi8KMfWOVo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMkpnCAAoJEF2HCgfBJntGNCcQAMSbEyaqV28Ko+t02LZFOYHG
38IfVWaCRe23bbI8PH6ShC8WjMTi5MAl8aBYyObUL5rcGFHLc32+MWWmw4nRG5B0
OCSmo0SvvoQiFcMzrtvudktQKDPg8Ac15OL/YF81qPCjXmYLaifW0INqOzHFpwN9
/yAE77Ah2yrVAu331UDd5O+pp3IWg63CInYFplQuLPeUF+JfXo52jLaMK87hQg2g
9v+FOEK52ohHr38QulRG5wUYfp+gYmM0yP0ql+NDVPUii5yY6Bs5idC6RVxKSvxT
OKDIgzhvs2azZjFBlpySFBQ777f5hmFNRGU0xOdtfPN+l+C5bwY5UMLQlwAFEAlQ
IKeLC1x9EkO2E3SohUujwcbhnhX+lZerneJjIBaVferXl2E/jAGtMuXlA0qPNSdd
YtbLeaI8ujDdePiunRdivAXTdwwDiLV3WNuG8EcRhUDCcD+urOAXOdIiKhEP46Ha
b947+80zZMrLahdqlgWHWAmX9V3XAtULcPrrlpQb2HF+MMJ/zQQg3TGnj95U+rbw
EXpF0NUTXG6lyji0uDeVn4LkDeZJIQSYcD6VEzhm1KgqImL90kzhI/J7Ao8T8Z0O
lbfh0xHS/Hrl60hd6tY0jv0QqEMuvxDt0NERbwwJZRUluvek8psxTr3COR0+cU03
juV8p8T2gpSHeRTrJdbH
=74Pe
-----END PGP SIGNATURE-----

--nextPart1461605.qi8KMfWOVo--
