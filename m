From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Sync hash implementation of batgat and
	batman-adv
Date: Thu, 25 Sep 2008 23:42:34 +0200
References: <20080925191508.GA8854@sven-desktop.lazhur.ath.cx>
In-Reply-To: <20080925191508.GA8854@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7069706.BlJ46xlnNp";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200809252342.38150.sven.eckelmann@gmx.de>
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

--nextPart7069706.BlJ46xlnNp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 25 September 2008 21:15:08 Sven Eckelmann wrote:
> The compare functions had a different interpretation of its return value
> and kmalloc can sleep inside batgat because we are running in user context
> of kernel.

This patch can ignored if not wanted. It is just a copy of batman-adv-
kernelland/batman-core/hash.c to batman/linux/modules/hash.c so they have=20
nearly the same implementations. The only difference should now that the on=
e=20
in batman-adv-kernelland uses GFP_ATOMIC in kmallocs and the one in batgat=
=20
uses GFP_KERNEL. Most changes are coding style changes and a different=20
interpretation of the return value of the compare functions.

Sven

Current differences:
diff batman/linux/modules/hash.c batman-adv-kernelland/batman-core/hash.c  =
                                                                           =
                    =20
24,25c24
< #include <linux/string.h>     /* strlen, strstr, strncmp ... */
< #include <linux/slab.h>
=2D--
> #include "main.h"
80c79
<               iter =3D kmalloc(sizeof(struct hash_it_t), GFP_KERNEL);
=2D--
>               iter =3D kmalloc(sizeof(struct hash_it_t), GFP_ATOMIC);
148c147
<       hash =3D kmalloc(sizeof(struct hashtable_t) , GFP_KERNEL);
=2D--
>       hash =3D kmalloc(sizeof(struct hashtable_t) , GFP_ATOMIC);
154c153
<       hash->table =3D kmalloc(sizeof(struct element_t *) * size, GFP_KERN=
EL);
=2D--
>       hash->table =3D kmalloc(sizeof(struct element_t *) * size, GFP_ATOM=
IC);
187c186
<       bucket =3D kmalloc(sizeof(struct element_t),GFP_KERNEL);
=2D--
>       bucket =3D kmalloc(sizeof(struct element_t),GFP_ATOMIC);

--nextPart7069706.BlJ46xlnNp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjcBcsACgkQqQGwKVlMoDs9TwCaAvL2SHvQ4Nc8oyYL5ldKwRnJ
DPEAoNrPJPc7h9G783Vq6XIXDWGEWz5p
=H23l
-----END PGP SIGNATURE-----

--nextPart7069706.BlJ46xlnNp--
