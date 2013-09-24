Return-Path: <antonio@meshcoding.com>
Date: Tue, 24 Sep 2013 15:46:50 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130924134650.GP3911@neomailbox.net>
References: <1380030033-11533-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="51uid+Ur/3ko9cBW"
Content-Disposition: inline
In-Reply-To: <1380030033-11533-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: introduce 'no_rebroadcast'
 option
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


--51uid+Ur/3ko9cBW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2013 at 03:40:33PM +0200, Linus L=C3=BCssing wrote:
>=20
> Using this option wrongly will break your mesh network, use this option
> wisely and at your own risk!

Exactly for this reason (As we discussed on IRC) I think this mechanism sho=
uld be
reasoned a bit more. As I told you, it would be nice to have a self-activat=
ing
mechanism which is able to switch it on or off when really needed.

The common network administrator will probably not have enough knowledge to
understand when this is useful or when this is breaking things.


Moreover, with this patch you are adding a userspace API that we won't be a=
ble
to remove anymore (!) and since the feature needs some more time before bei=
ng
mature I'd rather to suggest to avoid this.


Cheers,

--=20
Antonio Quartulli

--51uid+Ur/3ko9cBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSQZfKAAoJEADl0hg6qKeOZIcP/1XNjccWfOvMuKy7u0YSEHjC
mGuA7PbM4hQ3gdY4l6UaCbC7hyKrwu64In9IRwS05HUxMysid1okMv8q0MU23pFt
mmUJ6+OEVxuqgBI/68dtPpQYeYira9ClVemqwajkkueY7MEastLzskLIP+oZslET
8awe4xyFUX9VdHLwwe9qyEvsk0fFbcRQpgExlNdTm7kz6AiHycy3GmqmWXWUzWZC
alavlrVjhlKTmYNg2DN9dStPsbUPyhcUBmo9kXOnF2epRr/G2p59/ZaChtUF5vgM
Rxw39eTW7S0/Ltb7EWmqSmcdws3dxLVMV7Vg7wBGQX6Msn8mDPJNI5XpjAhQGPdq
//MZCtaMyRE6+vJvkRcvgzmJNujUWOys+9l8CGxXl69ys2dE4Dj9tC3TrpliBdIq
cXSNRTqWxDoXypP8JepUNgVZZLDRAXUc8z0QR+u/WGtePDelhO7bUAX7H4icQeY7
bwyDvw9CetjbQIfG7FzzZhBp/U63ND9Ou4jGJcWDGXVB49neIlHqmsK0uUGiu7UJ
MjhdQCNaiVNjZksvfrIWsEw9sUTF+S2tkIZFsXmvO4Wu5kkgCwwWuK3rxUTneMRD
3iaRbbE4IrkXAKc2r3RjoPQ81Moy6+zF5PgSXb2KzuQnJGHy69/d54N/sxFSL1kO
IvA8lrcDR45ubrAYqyvj
=HqeD
-----END PGP SIGNATURE-----

--51uid+Ur/3ko9cBW--
