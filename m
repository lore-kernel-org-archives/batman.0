Return-Path: <antonio@meshcoding.com>
Message-ID: <53998BF3.4040300@meshcoding.com>
Date: Thu, 12 Jun 2014 13:16:03 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <538314FE.9020808@mindeye.net> <2316167.xuFsC4suZi@diderot>
In-Reply-To: <2316167.xuFsC4suZi@diderot>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eOQtBmP6pSbqQSqbFJU7fd8X6m6DLEmaA"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Init and use batman
 interface with correc netns.
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eOQtBmP6pSbqQSqbFJU7fd8X6m6DLEmaA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/06/14 11:48, Marek Lindner wrote:
> On Monday 26 May 2014 12:18:38 Daniel Ehlers wrote:
>> Enables us to use batman-adv inside of network namespaces.
>> Unfortunately it does not enable us to use multiple batX interfaces
>> in different namespaces. This limitation results from using
>> debugfs and its unawareness of namespaces.
>>
>> Signed-off-by: Daniel Ehlers <danielehlers@mindeye.net>
>> ---
>>  hard-interface.c    | 10 ++++++----
>>  hard-interface.h    |  2 +-
>>  soft-interface.c    |  8 ++++++--
>>  soft-interface.h    |  2 +-
>>  sysfs.c             |  4 +++-
>>  translation-table.c |  4 +++-
>>  6 files changed, 20 insertions(+), 10 deletions(-)
>=20
> Would you mind re-sending both patches while cc'ing the netdev list and=
=20
> specifically asking for reviews from the namespace people ? None of us =
has any=20
> experience with netns. As such a meaningful review is difficult for us.=

>=20
> Furthermore, your commit message should be more explicit about what the=
 patch=20
> is trying to fix / improve. Things like 'issue #179' are too vague to b=
e=20
> understandable by everyone.
>=20

Please specify "RFC" instead of "PATCH" in the subject when sending it
to netdev, this way nobody thinks that it was sent for a direct
inclusion (net-next is closed now, so somebody might not be happy).

Cheers,

--=20
Antonio Quartulli


--eOQtBmP6pSbqQSqbFJU7fd8X6m6DLEmaA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTmYv7AAoJEJgn97Bh2u9eZV8QAKArW2rCBBwEqndm4NApzhsz
ERPBzuvLtMo4eb7jdWOGvC/IYanqgbGdRAu+ICL0WvrvYOFVDHsSX/kixBqwMTk2
6DTHQkD2F0a+5V843Xnn/6uQ5NalhMX4/2ZMN4Mtnm1kUr5lxKzJspC2EwD6686V
UQUUnQclEQnaJYHvYWRxfi3adMKMkI/JAHCZUAoxFZnRwpJLVi0KCMIRoiXhq77E
xkaSAj88/OPud5sOspEQe+ONcKnZaL/c6ec/kpLM8hk5yDMz1udi9CjmuM9BT+PT
7uhdXDs3AzDThQ+3fSkwTU5Pw/EzAdRXUKV0EBu3JID7SejK4I1RSpIWloVaI2ZN
ki2Pl6wOF2ORGkjSyMEWRcxEklP1inOv+5TZR6Seb050z2gSbF9t0LFmocjFJ/Bl
d29Wyear+1xVqgArHvoTNXeLgELdIm/t9jtMmUzVj6nn7skeMfWVskj8SaCKDPe7
m64keTWeM6Im3GFRvoEEIxP0eSVEPN8QTxrs7uoBjodJiEnTEKNvl1uyHkBonq6i
UxKJ+65RuclKthAOfTOwKQSinUpgdvG7lfTYBc1FrW2XOjTIQ4XvXDz+QQHpgun5
5bBkr7YxKR2YLVTLiwLYyiL+cnnv7S4/7otZkTI/pXQiaQbw9pL35HdcaTSgXMNH
xgD4Z3a6MiCf4+373BcI
=D0f9
-----END PGP SIGNATURE-----

--eOQtBmP6pSbqQSqbFJU7fd8X6m6DLEmaA--
