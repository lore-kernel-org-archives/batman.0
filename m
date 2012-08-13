Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Aug 2012 11:07:49 +0200
Message-ID: <1618575.5XC116L4jJ@bentobox>
In-Reply-To: <3089530.tcqQjiXxMe@sven-desktop.home.narfation.org>
References: <1344514526-30256-1-git-send-email-montik@autistici.org>
 <1344514526-30256-2-git-send-email-montik@autistici.org>
 <3089530.tcqQjiXxMe@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2125323.OJyPsT1Qpl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [RFC 1/3] batman-adv: bandwidth meter
	implementation
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


--nextPart2125323.OJyPsT1Qpl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 12 August 2012 14:20:57 Sven Eckelmann wrote:
[...]
> Sry, disapproved.

And just because I just saw it in your git branch:

> --- a/Makefile
> +++ b/Makefile
> @@ -22,7 +22,7 @@
>  # B.A.T.M.A.N. debugging:
>  export CONFIG_BATMAN_ADV_DEBUG=n
>  # B.A.T.M.A.N. bridge loop avoidance:
> -export CONFIG_BATMAN_ADV_BLA=y
> +export CONFIG_BATMAN_ADV_BLA=n
>  
>  PWD:=$(shell pwd)
>  KERNELPATH ?= /lib/modules/$(shell uname -r)/build

This is also not acceptable.

Kind regards,
	Sven

--nextPart2125323.OJyPsT1Qpl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQKMPlAAoJEF2HCgfBJntG93gP/1akuHpg4dvSnB57Umo/zW9R
xy6a1QwbiQSQiXAMrOdtk3ONZ2rgGQDelDQMttSHv4SmOTmxZqhUjcvMMLNeimfW
dL26DKMhZQiLU0kAizZAp07koJ5cmXb+1VHm2O5x6YsJOIpTeyTtrhjaUexQezfT
ANsb0rpnCYWqdswBNpJCdvZ7nuhtTbBMLUqhIf17vdzFl58Oe2eNn3DYgBLbAR7+
Rm54v3vvv5Uho8sNsYMT/rLKxlGUr2NYej6JCPCL13bcfq2MwUL0Ww/rw/IrPZXg
+pTbJ3iraniEHIGmxpVLbZH0QrM13Cz6UU5GYLdV+dEBZrcM4CUY7qv7qljNBSrf
pu6kDRgGOTPQlNoejjrhtNc8yWfPWb13yLg5BwgMkfBVnI4oqKW57ckUq1mKq5Ms
/uUWopxqOz8GcTWFsXq6lNEY/L7CUa8LLe3dyArxjK5CyjDZL7TkLmNSJhjdYkDO
7XS9p2thgorfFa19Z/UcMKyRH6+Bo3RuVTSEDl2TCV4hcnO1N8Wy6yqpM8KoaSJG
ebrArRe4PXjFCvyLQluHt+Co5T5jsnsaTAFqBRc2+RVVnhuOsqEfpOqIvMg+goQE
1QKBKgLinuA/mMxBeLmF+P200VcVFcVL1p7hlhRr7C6aAyj54FWaMywIWwuKD7K4
5alw3h3IYKI8pOenervm
=PKk3
-----END PGP SIGNATURE-----

--nextPart2125323.OJyPsT1Qpl--

