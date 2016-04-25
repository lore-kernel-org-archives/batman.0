Return-Path: <a@unstable.cc>
Date: Mon, 25 Apr 2016 21:39:50 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160425133950.GH3381@prodigo>
References: <1461590722-2095-1-git-send-email-dvlasenk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9iyR+p8Z2cn535Lj"
Content-Disposition: inline
In-Reply-To: <1461590722-2095-1-git-send-email-dvlasenk@redhat.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Deinline
 batadv_orig_hash_find, save 9024 bytes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>


--9iyR+p8Z2cn535Lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2016 at 03:25:22PM +0200, Denys Vlasenko wrote:
> This function compiles to 473 bytes of machine code.
> 21 callsites.
>=20
>     text     data      bss       dec     hex filename
> 95903266 20860288 35991552 152755106 91adba2 vmlinux_before
> 95894242 20860288 35991552 152746082 91ab862 vmlinux

Hi Danys,

thanks for your patch. This function is used in a several performance criti=
cal
code paths (i.e. packet forwarding).

Are we sure we are not losing in performance here?

Cheers,

--=20
Antonio Quartulli

--9iyR+p8Z2cn535Lj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXHh4mAAoJEJ4aZjxxc6bKLJoP/jHg8GN+Ws4YjyxStL+LshJH
RAL0qpVkaaecVB0KrkNfeAM7lYU3AhXT6t2dQFZF9vUVi6U8maFx/VJf+FDvQkFM
sGGwhNJPOcb/CAfw+Re4qLOow5SKzuh0SuCrIrxx9NQjMmM9dTpgRuuCG2+rJQuv
IFWC20eWS+jwXxw/tq9AGrYJTw/T1ccrh69FKAWWQNSv28vS9fY8uakjAFd689ot
JQ3XZjnqjV8zFHB5SlnUBmRnOOreoU6MhGy2OIMTBPRy5REc1eLbhF+eIV6zFKY5
bYRPT1LHt1mBEAJMMIcEnMRII2K+/q30rpwzZDWNZw1N4iPxlPVaYHi6OkpR6ggY
+ShBJ/j3WWsJtd0hb+zOpBFq5Lt52UVr0zn6c9wBq5GXqK3zjm1kGuQK4e5SHjMu
s+lg9+V8futJqEmt8ewNxfz4U8KnZz6KK/m+aBKCOwXle+iORtpnuWcvitaUVGRD
R2uRZbXz6pLACJ5MFGS9iixOLbyi+AHYBfDyG1nqC74959ybCz0EUFRXVwRingwv
ilvm8BpG2nWOFpxvDG9sNBIVq0FmWluQ5TFNUkLCPyJJ/Xqm+hiGWvRbVCSNVInw
vnGQi/PFV6+JTrLaBl03aj/lNWWMyoliNFYxAFGweGrHhI4+5qYl8245/vNbp+63
R2tyJ+ZyQR3NW6/GGxxd
=cT3k
-----END PGP SIGNATURE-----

--9iyR+p8Z2cn535Lj--
