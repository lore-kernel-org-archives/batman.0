Return-Path: <mschiffer@universe-factory.net>
Message-ID: <513A3F2A.8090601@universe-factory.net>
Date: Fri, 08 Mar 2013 20:42:34 +0100
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <1362764336-1591-1-git-send-email-linus.luessing@web.de>
 <1362764336-1591-2-git-send-email-linus.luessing@web.de>
 <201303090328.38621.lindner_marek@yahoo.de>
In-Reply-To: <201303090328.38621.lindner_marek@yahoo.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DWNVGFWCRCBGMDSCECXE"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: make number of
 broadcasts configurable per hardif
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DWNVGFWCRCBGMDSCECXE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 03/08/2013 08:28 PM, Marek Lindner wrote:
> On Saturday, March 09, 2013 01:38:56 Linus L=FCssing wrote:
>> From: Matthias Schiffer <mschiffer@universe-factory.net>
>>
>> In heterogenous networks, setting the number of broadcasts to differin=
g
>> values on different interfaces can be beneficial.
>>
>> E.g., on wireless interfaces with high packet loss a higher number of
>> broadcasts may be necessary, whereas on low-bandwidth interfaces with
>> relatively high reliablily (such as VPN links over slow internet lines=
)
>> sending only a single packet makes more sense to preserve bandwidth.
>=20
> In general, I like the idea but the approach isn't the best. Can't we a=
utomate=20
> these settings instead of adding hundreds of little knobs nobody will=20
> understand ? Why not detecting wifi interfaces as such and configure th=
e=20
> broadcast value accordingly ? The same goes for ethernet / vpns ?

While is makes sense to find some sensible defaults for such values, in
my opinion everything should be as configurable as possible. I don't
think it would be a problem to have some dozens knobs more if a normal
user almost never has to touch them. On the other hand, for testing,
debugging and development purposes, it can save a lot of time not having
to recompile the kernel for such changes all the time.

Also, for VPN connections, automatic detection of the link type isn't
generally possible, as we'd have to know which medium the VPN is going
over...

Regards,
Matthias

>=20
> Cheers,
> Marek
>=20



------enig2DWNVGFWCRCBGMDSCECXE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE6PysACgkQq3qIxbiQM9iCzwCglDPzS0wzQgX8Ox5m14yGENpq
lwcAn1nA4cHAlBeyv/yoIsnwyNh9f1HF
=ecNQ
-----END PGP SIGNATURE-----

------enig2DWNVGFWCRCBGMDSCECXE--
