Return-Path: <antonio@meshcoding.com>
Message-ID: <52FB6F75.6070802@meshcoding.com>
Date: Wed, 12 Feb 2014 13:56:21 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-16-git-send-email-antonio@meshcoding.com>
 <20140212091215.GI30814@lunn.ch> <52FB6525.7090001@open-mesh.com>
 <52FB6F04.3000404@openwrt.org>
In-Reply-To: <52FB6F04.3000404@openwrt.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cNJNFlHC9B2VC7P7kurpE1CBSK3uDp1i2"
Subject: Re: [B.A.T.M.A.N.] [RFC 15/23] batman-adv: ELP - send unicast ELP
 packets for throughput sampling
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
To: b.a.t.m.a.n@lists.open-mesh.org, Felix Fietkau <nbd@openwrt.org>, Andrew Lunn <andrew@lunn.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cNJNFlHC9B2VC7P7kurpE1CBSK3uDp1i2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 13:54, Felix Fietkau wrote:
> On 2014-02-12 13:12, Antonio Quartulli wrote:
>> On 12/02/14 10:12, Andrew Lunn wrote:
>>> On Tue, Feb 11, 2014 at 01:48:15PM +0100, Antonio Quartulli wrote:
>>>> From: Antonio Quartulli <antonio@open-mesh.com>
>>>>
>>>> In case of a unused link, the throughput estimation will
>>>> get stuck to the last sampled value and therefore the
>>>> reported metric will becomes obsolete.
>>>>
>>>> Send unicast ELP packets to each neighbor to trigger throughput
>>>> sampling on unused links.
>>>
>>> Humm, i can understand the need for this, but i really think the rate=

>>> control code should be sending the probes, not batman. What do the
>>> wifi people say about this? Have they tried submitting patches to
>>> them?
>>
>> I am CC'ing Felix so that he can give his opinion.
>> But last time I checked Minstrel I realised that it uses data packets =
to
>> probe rates (there is not a specific probing packet), meaning that if
>> there is no data packet to send, then no probing is performed.
> Correct. Minstrel never sends dedicated probing packets. Changing
> minstrel to send active probing packets to serve the needs of batman
> would be a very bad idea, because pretty much all regular users do not
> have any need for extra probing.
>=20
>> Sending this ELP packets (when there is no unicast traffic) is a way t=
o
>> trigger this mechanism in Minstrel.
> Right. If I remember correctly, if you send less than 1 packet per 100
> ms, then all packets should end up being probing packets. If that
> doesn't work, we can change minstrel's probing pattern to allow things
> like batman to get a desirable amount of rate control probing simply by=

> sending unicast packets.

This is what I am trying to achieve here: if no unicast packets have
been sent for the last 100ms (at least) then send N probing packets in a
row (with N =3D 2 at the moment - it is a define in main.h).


Thanks Felix!

Cheers,


--=20
Antonio Quartulli


--cNJNFlHC9B2VC7P7kurpE1CBSK3uDp1i2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+294AAoJEEKTMo6mOh1V37MP/1ova8ptYdkEKwH+9vj8swAI
MLR4ksqqITLx0q1mG4mxrwOMBbGq0tZELC3pbOQBShzUDMcE5BcqGLjxSdZMJAoD
0Dh14R5NVwI6cMWi8dR+EgB8m/tZSAEA2gm4Z+OkTF84BUM3a7E4btOpcjF8cDKE
8+X/x0EImxQJmqt1c/mNTYLkCRavRI4ZH4ELTZ0XTyQPgcf7RXJIbO77Be/ryuaz
MA7i7UEIgMg6JfYHIlhUtF60NLCnI3uTec6t7bNygZ9qhZxOWoRsdyRFur9YrQ2o
VfE3W/iw1qajrX4xNoRmKJeShChdFz+NAAvblOSc3AitWBx/JsigYV1d/eiEGqqa
i489eXHTQqCdRZ5yyyO10CokkY/Pj75xzbw6jNvWK86YvQSugF0YKdZtW824rWou
5Hbw2eTANqFutD3GdsDMXLoTvMMiebHS2hQ2RMsTEDi46gIaeaGrIF+FY0jC44Md
7vM2aKyWVooKhxkbALiwTyrWJRCvI6fwvIgYZpngJ9AQFp7nT3gkdDDVxaywU6CN
646qpn+AhD0Wd2WBXAK88K1v0B7jxNOCb3hMRlUyrUCNQoEC8oyasY8HeQ5HwfBn
A6Pt22HPLdfhqcLP2mcX4IeAxvzhW9IeXbrJe19OJWQv7gdCGzD81JS8jGr953r1
1PJBeMk2ol+WYFp4y7YP
=G+Ru
-----END PGP SIGNATURE-----

--cNJNFlHC9B2VC7P7kurpE1CBSK3uDp1i2--
