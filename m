Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 7 Jan 2010 22:14:30 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100107211430.GA5373@pandem0nium>
References: <200912181714.58212.lindner_marek@yahoo.de>
	<DE721D43-8031-4174-8357-DE4A475A7898@dd19.de>
	<201001072123.32104.lindner_marek@yahoo.de>
	<914B198A-C2DA-4222-9306-B81CFFE88284@dd19.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <914B198A-C2DA-4222-9306-B81CFFE88284@dd19.de>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. V outlook
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

we probably did not make this very clear in the document, but we will=20
focus our work on batman-adv (layer 2) and will keep the batmand (layer 3)
as it is for now. As a consequence, some ideas for BATMAN V are layer 2=20
exclusive (mesh bonding, incoming interface based routing).

On Thu, Jan 07, 2010 at 05:10:39PM +0100, Alex Morlang wrote:
>
> Am 07.01.2010 um 14:23 schrieb Marek Lindner:
>
>> On Thursday 07 January 2010 15:44:36 Alex Morlang wrote:
>>> are you considering attaching metrics to HNA?
>>
>> That is not necessary as each non-batman host is connected to a batman=
=20
>> host
>> which has a metric. Therefore the implementation just needs to support=
=20
>> the HNA
>> metric. The batman daemon does so since quite a long time. It is on =20
>> the
>> feature list for batman-adv 0.3 but does not require any protocol =20
>> changes
>> unless I miss your point.
>
> maybe you do, as you might have costs between the connected network and=
=20
> the connecting batman node.
>
> when you have more then one batman node connecting a network to the =20
> mesh, this costs should be relevant.
>
That might be true, however in batman-adv we are dynamically adding and
removing MAC addresses. IMHO, it would not make so much sense to
add custom metrics to each mac address. If you need to connect subnets,
it might be feasible to use something like BGP and extract batman metrics
out of the module.

>>
>>
>>> How about ipv6?
>>
>> I can't follow you here. The length of the protocol identifier (IPv4
>> address/IPv6 address/mac address/random number) is not relevant for =20
>> the
>> routing protocol.
>>
>
> ok, i thought you were talking about an implementation, so i asked about=
=20
> support for this addresstype.
>
> so am i right in thinking the next batman will be protocol independent?
>

Even now, batman-adv is independent. We don't have an IPv6 verson of BATMAN
layer 3 however.

best regards,
	Simon

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktGTrYACgkQrzg/fFk7axZz7ACg89kTwSGH1aSdFaHAcMhqdnbx
x00AoMa72pVJavwJWzs+BqRcA9JrThWS
=c5xw
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
