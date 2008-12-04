Date: Thu, 4 Dec 2008 12:35:58 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv-kernelland: Fix memory
	corruption bug
Message-ID: <20081204113558.GA14932@pandem0nium>
References: <DFF8A357-1AF1-4F11-BE89-46DD131FA7FF@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <DFF8A357-1AF1-4F11-BE89-46DD131FA7FF@gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Scott,

thank you very much for the fix! Can you confirm if this bug is related
to https://dev.open-mesh.net/batman/ticket/86 ?
This bug has very likely been caused by a memory corruption, but i
couldn=C2=B4t find where. (i have not experienced any kernel panics by this
however ...).

Thanks, best regards
	Simon

On Thu, Dec 04, 2008 at 02:14:27PM +1300, Scott Raynel wrote:
> Hi there,
>=20
> I've been spending some time tracking down a bug that's been causing =20
> memory corruption followed by random kernel panics. Thanks to the =20
> kernel's slab memory debugger I tracked it down to a kfree in send.c =20
> that was freeing a block of memory that had been written to past the =20
> end of its allocation.
>=20
> Turned out to be a simple typo, which I've fixed in the following =20
> patch. When resizing the packet_buff struct in batman_if, the new =20
> length was being updated but the old length was being used for the =20
> kmalloc(), causing something later to think it had more memory =20
> allocated to write to, hence writing past the end of the allocation.
>=20
> Signed-off-by: Scott Raynel <scottraynel@gmail.com>
>=20
> Index: send.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- send.c	(revision 1105)
> +++ send.c	(working copy)
> @@ -159,7 +159,7 @@
>  	if ((hna_local_changed) && (batman_if->if_num =3D=3D 0)) {
>=20
>  		new_len =3D sizeof(struct batman_packet) + (num_hna *=20
>  		ETH_ALEN);
> -		new_buf =3D kmalloc(batman_if->pack_buff_len, GFP_ATOMIC);
> +		new_buf =3D kmalloc(new_len, GFP_ATOMIC);
>=20
>  		/* keep old buffer if kmalloc should fail */
>  		if (new_buf) {
>=20
>=20
> Cheers,
>=20
> --
> Scott Raynel
> WAND Network Research Group
> Department of Computer Science
> University of Waikato
> New Zealand
>=20
>=20
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJN8Cerzg/fFk7axYRAhnJAKC0v9ILXxucnLDYztTOkr18WvFGqQCeLOdO
P4p9VSCl9AwnOkFzSWha4fY=
=LaVQ
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
