Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Running multiple batman-adv namespaces on the same broadcast domain
Date: Wed, 09 Sep 2020 10:30:19 +0200
Message-ID: <34120415.8pMx1AJBNe@ripper>
In-Reply-To: <CADJ1cUSNtDrR-C-L7MHXF3JohbkmBbQBsFzBvBxE2WntUd9Yqw@mail.gmail.com>
References: <CADJ1cUTq=Bpj9SQdS5Y6aXKcPR9XqkxKn_Sj5sRMmN1R=qX_2g@mail.gmail.com> <17582207.Wjj8Q8S2kB@ripper> <CADJ1cUSNtDrR-C-L7MHXF3JohbkmBbQBsFzBvBxE2WntUd9Yqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3099535.ntOIJHjIdy"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alessandro Bolletta <abolletta@netter.io>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart3099535.ntOIJHjIdy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 9 September 2020 10:20:20 CEST Alessandro Bolletta wrote:
> Just one more info: is there an hard limit for the number of "bat"
> interfaces on the same host?

But yes, running multiple batman-adv interfaces on the same host works fine. I 
am currently using 8 in parallel. The lower/hardif/slave interfaces are using 
VXLAN (to connect some servers in other datacenters), fastd (to connect remote 
"clients") and some other "ethernet" protocol compatible things.

And the hard limit is most likely the number of netdev's the Linux kernel can 
create (id wise and memory wise).

> Moreover, is the multiple batX namespaces a scenario that it is
> supposed to work fine, is it well tested or it still does need some
> love?

I don't like the word "namespaces" here. Because this reverse to a completely
different concept in the linux kernel.

And I don't know what you will end using - so I cannot say if this will work
or is tested.

Kind regards,
	Sven
--nextPart3099535.ntOIJHjIdy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl9YkpsACgkQXYcKB8Em
e0Yo3w//eym45hMOsWqm4uh+q9Ms7QWaFfI92RDOHnUpXVwqCT2daQqNlaE8O8PA
lxc+rYMhAgZRwk9jpovuMkGPtcq3y8ThDnEWnhcoKUGqsjXJZ1wVWnPzUoxv9E0y
fogH2/eI2qV1QATCYCd+s7cVAaDoqzquQhTUabDdwFbJELICwqF2kUCtX+wOe6gz
IUqH9zmeSPBLgxEypg90+sOhrlm9tkcTWiHTEjgdOyE0INeU4ZWd0x3ye03l+F9A
bL+pBXQuOVO1bpLFalvIQCRx6FR90IBcJapcoZQRxZJ7siCcQtYttznbQRKx3oRv
dWXsRIjy0MNNFqVfJV6PuwMas1C7TNKCWWCNiMpjp1QCuraUbY6sKgB0NZBUgIRT
Xijek+x95/7HL0lZWlQhTNMs7+rHtUJB047t81Pq8u9EsgOj6hNxpKZ4nm1Wx9U4
xQpIfXqlIvVniLBsVuhUKj5IN4JVDLf6i6QyoffXXfOG0H2m9pYEEkcSgidZOYFR
+2dn6x8U066Y2XbHmr1MsJGBBt21r2x+KmDhVDGHWk68KsmAGCvueDPLo1Z8irOF
0BfBwwsUJ1jgJIXoeA6igmfusRPmhCMiFqPO92/1LrdH7qt4wVSSRfFN2hrO3nEH
8g6plHwObU25ZU45xyQZVMh/NzeYF4yMLqqv8SDFBnPl55HeA9c=
=UE3D
-----END PGP SIGNATURE-----

--nextPart3099535.ntOIJHjIdy--


