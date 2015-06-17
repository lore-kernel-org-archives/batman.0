Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 17 Jun 2015 18:38:53 +0800
Message-ID: <239090680.adTWjqp5ZN@voltaire>
In-Reply-To: <1434467426-4281-4-git-send-email-linus.luessing@c0d3.blue>
References: <1434467426-4281-1-git-send-email-linus.luessing@c0d3.blue>
 <1434467426-4281-4-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15262129.OJOzI8n3NB";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 maint 3/5] batman-adv: Make TT
	capability changes atomic
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


--nextPart15262129.OJOzI8n3NB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, June 16, 2015 17:10:24 Linus L=FCssing wrote:
> Bitwise OR/AND assignments in C aren't guaranteed to be atomic. One
> OGM handler might undo the set/clear of a specific bit from another
> handler run in between.
>=20
> Fix this by using the atomic set_bit()/clear_bit() functions.
>=20
> Fixes: 5d2121af6d31 ("batman-adv: introduce capability initialization=

> bitfield") Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  translation-table.c |    4 ++--
>  types.h             |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied in revision a51fa16.

Thanks,
Marek

--nextPart15262129.OJOzI8n3NB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVgU49AAoJEFNVTo/uthzAAY8H/iA4wIdqlH1IX79eML9C12Kh
rJWSrWjwj9jzrciJkqh15wS3cV4kigH9rQtaPDyhTz5JOwxXbpb0SfFx3TO8M6ww
Bl3SHW2s6HTWCvu9uD/yUenEVZJy7X0+VxZIjUZ5Ycv4yBxjMfh94ApgOMHr0S4D
OWhvvKuNGmRilgcckPq9+LFvZmR4xduQJbpB24g3fFRDrjRJOzaPF9T5nKN4ShLk
CIT039QAlxswNZ6rKKgIQbE74/1hrpR+MKfKwbQ+jnjpCkD552MzUCe6XUaRjEsd
rhQwEMEV8aQsfJ/6kK8u0QIg3i1OL7CsJziui5IRfjcWRONU7By32QjiJ9/73ts=
=RBcI
-----END PGP SIGNATURE-----

--nextPart15262129.OJOzI8n3NB--

