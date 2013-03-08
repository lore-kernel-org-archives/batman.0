Return-Path: <mschiffer@universe-factory.net>
Message-ID: <513A5D27.7020506@universe-factory.net>
Date: Fri, 08 Mar 2013 22:50:31 +0100
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <1362764336-1591-1-git-send-email-linus.luessing@web.de>
 <201303090328.38621.lindner_marek@yahoo.de>
 <513A3F2A.8090601@universe-factory.net>
 <201303090406.42605.lindner_marek@yahoo.de>
In-Reply-To: <201303090406.42605.lindner_marek@yahoo.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2EMLHFXMMCSKBQPTDJHHP"
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
------enig2EMLHFXMMCSKBQPTDJHHP
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 03/08/2013 09:06 PM, Marek Lindner wrote:
> On Saturday, March 09, 2013 03:42:34 Matthias Schiffer wrote:
>>> In general, I like the idea but the approach isn't the best. Can't we=

>>> automate these settings instead of adding hundreds of little knobs
>>> nobody will understand ? Why not detecting wifi interfaces as such an=
d
>>> configure the broadcast value accordingly ? The same goes for etherne=
t /
>>> vpns ?
>>
>> While is makes sense to find some sensible defaults for such values, i=
n
>> my opinion everything should be as configurable as possible. I don't
>> think it would be a problem to have some dozens knobs more if a normal=

>> user almost never has to touch them. On the other hand, for testing,
>> debugging and development purposes, it can save a lot of time not havi=
ng
>> to recompile the kernel for such changes all the time.
>=20
> Knobs only used for debugging and development should never go into sysf=
s. User=20
> space APIs are created for life time. Once it is there and we submit it=
 to the=20
> kernel the API has to stay and has to be supported forever.

You have a point there... While I still think making the broadcast count
adjustable makes sense, I'd also be happy to get a patch accepted that
just sets the broadcast count depending on the interface type.

My current plan is:

* WLAN devices: 3 broadcasts
* Everything else: 1 broadcast

Any additional types that should be considered?

>=20
>=20
>> Also, for VPN connections, automatic detection of the link type isn't
>> generally possible, as we'd have to know which medium the VPN is going=

>> over...
>=20
> You are running batman-adv over VPN links on top of wifi interfaces ?
Not yet, but extrapolating from the setups I've already done, it's
probably just a matter of time until I am ;)

Matthias

>=20
> Cheers,
> Marek
>=20



------enig2EMLHFXMMCSKBQPTDJHHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE6XScACgkQq3qIxbiQM9hyUwCdFzapbQDQyRiO1lti8fYAf48p
iA8AoKBzhWmRySZDEhME/jiEvUEu3z00
=jRUm
-----END PGP SIGNATURE-----

------enig2EMLHFXMMCSKBQPTDJHHP--
