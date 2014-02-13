Return-Path: <antonio@meshcoding.com>
Message-ID: <52FC9605.5050205@meshcoding.com>
Date: Thu, 13 Feb 2014 10:53:09 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-13-git-send-email-antonio@meshcoding.com>
 <20140212084022.GE30814@lunn.ch> <52FB6701.5000406@meshcoding.com>
 <20140213093650.GA7193@lunn.ch>
In-Reply-To: <20140213093650.GA7193@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lJb97kA5ni6N9U3alkHxKXPxlrVh2e1Xw"
Subject: Re: [B.A.T.M.A.N.] [RFC 12/23] batman-adv: add base throughput
	attribute
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Andrew Lunn <andrew@lunn.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lJb97kA5ni6N9U3alkHxKXPxlrVh2e1Xw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/02/14 10:36, Andrew Lunn wrote:
>>>> +/**
>>>> + * BATADV_DEFAULT_BASE_THROUGHPUT - default value used as throughpu=
t for
>>>> + * hard_ifaces for which it is not possible to measure/estimate the=
 real one.
>>>> + * Value is expressed in Mbps/10
>>>
>>> Mbps/10 is a rather odd unit. How about just Kbps?
>>
>> This is the unit used in cfg/mac80211 because most of the rates are
>> either in the form of XX.0Mbps of XX.YMbps (so just one decimal number=

>> needs to be saved).
>> Moreover I thought that having an higher precision is not very useful
>> because the routing decision cannot be taken on such a fine grained va=
lue.
>> Actually the originator table prints the metric in Mbps (XX.YMbps).
>=20
> It is not precision which i think is important, it is having a unit a
> user expects. Networking people work in Kbps, or MBps. If it is
> printed in the originator table as XX.YMBps, then i think this sysfs
> file also needs to be XX.YMBps. That does however make your parsing
> more complex, since it is no longer an int. I suppose there is the use
> case of an ADSL link, with bandwidth of say 2Mbps down, 256Kbps up,
> and then you do need the decimal point in XX.YMBps.

I just checked what we do in the "improved GW bandwidth advertisement"
introduced not so much time ago:

- we store the bandwidth value in Mbps/10
- we print it in the form XX.YMbps
+ but we allow the user to specify the unit when entering the value in
the sysfs interface: "xxxMbps" or "yyyKbps".

This way the user can pick the favourite unit, but of course the value
is truncated (in the case of Kbps) to fit the internal representation.

What do you think about this approach?
I also think we have to keep the two consistent with each other (it
would allow me to re-use the same parsing function).


Cheers,


--=20
Antonio Quartulli


--lJb97kA5ni6N9U3alkHxKXPxlrVh2e1Xw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS/JYIAAoJEEKTMo6mOh1Vw5kP/1AoRZ1ga+sXGEMRTpsa7XXS
yxb6rReYE07S+nAPDGxYWWpFSHS4uQ39EUXhvqQz7GTOhMI8QDGXFBtzCz2PNjDM
v2/hQU16lERNPU2oxGfBleCtIAervjVvzTr6hl8e/oARdI7gcP7wyLQB+A5VFV4u
eQZwlHrfcSYMZ4grwqjNkHIp5bLgHDiC0qW7McF9SiAUkfuLDCc9W75931L/I1ei
6FNRww2jLa2zAg2RhuBNSSWjNFdbfRA48zuwc2i11EgTFcQTMj/ZRga1AEyDNtfU
CukTr7Og1l9yzrcZXC5E9RY0EOFwY1DYTOjkXWC/GSIGaQzSwarbE09gijFrqYJA
hrqe7IXnC4BOWlOfw5hKJOh67ZsCr38wfn3cbxYMQjQa9Hzi3yHetn6LqcjYaJq8
OIAoi2jyx9RaJ74KcXqNztETHEGdnYRcvOP7lK2mFz+mzSAOPJmCfsSIwAsCsPML
tgd1N+AAPepFXrTpMgu/RtUevbt545YA6+AkJyqcE+kX4uoSGrs2ZqVmo0H3YV9Q
X04E8XPn/Qwl5PA/ro0q3MCxtL18ZOjRbTNmd28PytAxgOXCAUUgNYFC/owuCAgR
s5aTMu5N8bX4Sid3f/1xpDQhiDB9l6UexrgkhaRYF8fSCMwSUCpAlnR85TUwTMRN
IrPrshCgkmeV4TNkA9Ry
=00nF
-----END PGP SIGNATURE-----

--lJb97kA5ni6N9U3alkHxKXPxlrVh2e1Xw--
