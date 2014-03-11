Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 11 Mar 2014 18:43:40 +0800
Message-ID: <1664196.Jt0tteyZgd@diderot>
In-Reply-To: <1393798682-7703-2-git-send-email-linus.luessing@web.de>
References: <1393798682-7703-1-git-send-email-linus.luessing@web.de>
 <1393798682-7703-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2411238.LW8NTg6f00";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/3] batctl: fix wrong header lines
	number for local translation table
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


--nextPart2411238.LW8NTg6f00
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 02 March 2014 23:18:00 Linus L=FCssing wrote:
> A commit in batman-adv has added a second header line to the local
> translation table output.
>=20
> Introduced by 59cb0861498776c62bd17584c31f34477fa301a0
> ("batman-adv: improve local translation table output")
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  debug.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 795b0ba.

Thanks,
Marek

--nextPart2411238.LW8NTg6f00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTHujgAAoJEFNVTo/uthzA5kEH+weuhu8lTiVNZ/szKKqP8Wqn
3EgXDHQJc7AiXKK+/wpkhjTMQsgh6GIOtOv/XNRv8dREKh/19LUuwsWM69iMBZYb
RmW/kEdXbGvIFc0knJ2j4F8nPCLewpkCkJf+tNRoSlCAdD0XIflWUplhHTj7o/ah
E6NFzbA7ioc48sMtmy3IoQJ1sPPZ5zUPG6oApfkcghLYV17anpyJugAcinzVMzH1
4qhnbkrod0Sp3FWeNe/oqLSWM+7ktdcp88D0Zj6UwfE5i2wrxe+/C3z0krrGQUTW
c34rmlha6BnzxosqlpHNM93lSCAsVSB+DumPhbg8TbNZfkZl2Gu9kqeTTbqVTbo=
=t5hy
-----END PGP SIGNATURE-----

--nextPart2411238.LW8NTg6f00--

