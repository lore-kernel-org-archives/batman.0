Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2] batman-adv: bcast: queue per interface, if needed
Date: Fri, 14 May 2021 10:28:53 +0200
Message-ID: <3148825.KiqjeL1upR@sven-desktop>
In-Reply-To: <20210427184527.9889-1-linus.luessing@c0d3.blue>
References: <20210427184527.9889-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3550591.GgTu1SRWts"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart3550591.GgTu1SRWts
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v2] batman-adv: bcast: queue per interface, if needed
Date: Fri, 14 May 2021 10:28:53 +0200
Message-ID: <3148825.KiqjeL1upR@sven-desktop>
In-Reply-To: <20210427184527.9889-1-linus.luessing@c0d3.blue>
References: <20210427184527.9889-1-linus.luessing@c0d3.blue>

On Tuesday, 27 April 2021 20:45:27 CEST Linus L=FCssing wrote:
> - * The skb is not consumed, so the caller should make sure that the
> - * skb is freed.
> + * This call clones the given skb, hence the caller needs to take into
> + * account that the data segment of the original skb might not be
> + * modifiable anymore.

But none of your callers is now taking care of it because you've removed al=
l=20
skb_copy's. All you do is to clone the control data and give it to the=20
underlying layers. And they may write freely to the data. Thus breaking=20
parallel (and under some circumstances sequential) running code which opera=
tes=20
on the skbs.

The review was stopped after noticing this problem.

Kind regards,
	Sven
--nextPart3550591.GgTu1SRWts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCeNMUACgkQXYcKB8Em
e0b0ZQ//e0aQXKF8xuHnOfSECYU1MEMmXLhCkurOMTW+Cvcr6T67fmRPciBPZR5t
UhzXC2bill3oWSQPyDcoIz9fgd3GYoIn+/4TwekU9euyLfYZ2+Fe8C0ZtgXRSjL1
lDySZgvp5qaTmXYM738/9Jd249+Hgav7WqbR9cMKQCDMZ4WO3kThTUQyw5REnWsv
eRRahLbIOrGl6XiBanu4TDCFxm3m0ZSBXnhk1xqx45iQWQOduoVDu1huEhPFznxM
rv7PVzeVzveP9gHSNNHB7s1U84toeJtCG1rQc8JClpRcMNnrcnAZy7aWJHyLkNm3
rd0wbMDk1/RUYaHsjQao+SCUpMcFbJ2f3yLc/z8SrriOG0cSF2eMydMoQ5U+ej4o
yhuL4iotcD7j7EuvLiGJw5wOppp1LPcvr5VNZZEgZOSAQLcQXzGnrJKz3YLbKFCO
X5S5tq2sBH2GoEMuSsZwm94pTQg3F6upS3Da7NVSR01G48+gBZe08QbyCyuQM7aw
oE9vpFiLuf0fQeFKTMimZ742+WttDkyDTxTESX4Y95XAheiOwHdQMlN481nZknaa
vno++fkIpSGPMS5s8/wAaSQW/i3OuTViiwdDm14WOmn9SU2NTOAtHnKojwges8v1
acG3P7IHboLFiMrTMAuSGZ3LoTV/NSjpT24bE9P0aC63kIgD+jU=
=OczW
-----END PGP SIGNATURE-----

--nextPart3550591.GgTu1SRWts--


