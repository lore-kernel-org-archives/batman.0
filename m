Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 09 Nov 2014 12:46:53 +0800
Message-ID: <35392227.73ozm9CNQu@diderot>
In-Reply-To: <1414646620-6022-1-git-send-email-linus.luessing@c0d3.blue>
References: <1414646620-6022-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1805418.gVuijTWUMB";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix delayed foreign
	originator recognition
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


--nextPart1805418.gVuijTWUMB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday 30 October 2014 06:23:40 Linus L=C3=BCssing wrote:
> Currently it can happen that the reception of an OGM from a new
> originator is not being accepted. More precisely it can happen that
> an originator struct gets allocated and initialized
> (batadv_orig_node_new()), even the TQ gets calculated and set correct=
ly
> (batadv_iv_ogm_calc_tq()) but still the periodic orig_node purging
> thread will decide to delete it if it has a chance to jump between
> these two function calls.
>=20
> This is because batadv_orig_node_new() initializes the last_seen valu=
e
> to zero and its caller (batadv_iv_ogm_orig_get()) makes it visible to=

> other threads by adding it to the hash table already.
> batadv_iv_ogm_calc_tq() will set the last_seen variable to the correc=
t,
> current time a few lines later but if the purging thread jumps in bet=
ween
> that it will think that the orig_node timed out and will wrongly
> schedule it for deletion already.
>=20
> If the purging interval is the same as the originator interval (which=
 is
> the default:=E2=80=AF1 second), then this game can continue for sever=
al rounds
> until the random OGM jitter added enough difference between these
> two (in tests, two to about four rounds seemed common).
>=20
> Fixing this by initializing the last_seen variable of an orig_node
> to the current time before adding it to the hash table.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  originator.c |    1 +
>  1 file changed, 1 insertion(+)

You're definitely contending for this year's highest code to commit mes=
sage=20
ratio. Kudos to you for this well documented fix!

Applied in revision  8a2ad52.

Thanks,
Marek

--nextPart1805418.gVuijTWUMB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUXvG9AAoJEFNVTo/uthzAW1oH/26qsizqnPXIyNVx+S7xZUno
MR8uf6o6myhsfH1exgFlO0xZUySHXj9fKQpD+zWHxUTv1Jf/XfKV8Xsa6zIDJctd
o4/0XaQkX4ZwGnozHarlF3HDGOG8AylwPqo3VwAtMHym8OTfdOx4iR9vqI+llNHO
KkVvxbyTqoRcJpY8EGqTQZKL8F1lb37olRUdC2I3/BgIEG1ZFpz/vD/H4451Teb3
s0hEl+fi94UYbdhu4ITMfx/4R716xkYIoPaHj8lM83WxDvI1lHyY93Rt4JHT+7Gl
9oyavaEySWPeFetF3ce7utQJ95IrE7RTmEAZPwc+y48TejMLRWGHEiw7ILay77s=
=b1l2
-----END PGP SIGNATURE-----

--nextPart1805418.gVuijTWUMB--

