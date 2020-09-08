Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Running multiple batman-adv namespaces on the same broadcast domain
Date: Tue, 08 Sep 2020 13:28:36 +0200
Message-ID: <17582207.Wjj8Q8S2kB@ripper>
In-Reply-To: <CADJ1cUTq=Bpj9SQdS5Y6aXKcPR9XqkxKn_Sj5sRMmN1R=qX_2g@mail.gmail.com>
References: <CADJ1cUTq=Bpj9SQdS5Y6aXKcPR9XqkxKn_Sj5sRMmN1R=qX_2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart26226944.1ARZ2byAtU"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Alessandro Bolletta <abolletta@netter.io>

 
--nextPart26226944.1ARZ2byAtU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 8 September 2020 13:23:32 CEST Alessandro Bolletta wrote:
> i'm trying to reproduce a PoC where i'm running multiple batman-adv
> instances(eg. bat0, bat1, batX) on the same broadcast domain.
[...]
> Is this kind of scenario supported?

No, you need something which implements separation of top of ethernet to avoid 
that bat0/bat1/.../batX see each other. E.g. VLAN, VXLAN, ...

Kind regards,
	Sven
--nextPart26226944.1ARZ2byAtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl9XauQACgkQXYcKB8Em
e0YNxhAApu6US6Ma5JjrP/tfSIwruPY/AHPI4/j3LGUaLvO1cQZjtf0D93RxYmV2
2vI+r0oV1YFcHA0s4xcrDWMg2JME1an8ypE2cGt0IFv07PKZ5jSgQqxe6t6ysWya
TaOnPGPD7u/Ly08mLFJQ4f7aBeHm4DckoIoJnQVb8x8TvBXis4p3LlKI/DEJJ3GU
WE57G4Z/opwJDI4+9mqX4yKqbwVBNfE+Y2VtuStmDnvITwVqBx1B2PvgWtsbEo5t
g6bwwStJONoyqkYoq1dPln4+8y4xf7QcIZWmJ6xBubq3Tzt/wsELfyMQs0QvUdJJ
3n/oxrmbYEBHTDprEn7zZkuNS+kzS57W+bvzjUtzjQIAJ1vs2D0D5E2M1YVtCkYX
o8hnAI9nUQTUNrB9x9C1YYQyautgD3qzuEmMN5BspOSOO03xV64Kdk1D3L8xSPM0
yl3yndM+LA9HrURjJ4kGQQCN/DdIEvlY1oH1uPAL0zVewLVAgJgyxlPRW22QuHhL
IaXgLVaUgdfOuQS1ziUOPUbZl7sgtY0G1yQcVaBuQu4VieOL2IBP88Zp0gxlEnd5
RXOgftKEXPKqLT0ksPP/eZuDxHAkEwCb3CGyaQaCU8DCcsgbR+O3MDnvKpYlsRqt
rHNZsSmEoA/b01238qZH69aR+r6adcex2BNFQVYQazMna33SqmI=
=sr9s
-----END PGP SIGNATURE-----

--nextPart26226944.1ARZ2byAtU--


