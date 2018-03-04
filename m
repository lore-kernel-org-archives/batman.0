Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Mar 2018 14:36:40 +0100
Message-ID: <4734050.hZAXbvf8iE@sven-edge>
In-Reply-To: <20180227081016.13122-2-linus.luessing@c0d3.blue>
References: <20180227081016.13122-1-linus.luessing@c0d3.blue>
 <20180227081016.13122-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4070646.146XcdYU5e";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: add multicast flags
 netlink support
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

--nextPart4070646.146XcdYU5e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 27. Februar 2018 09:10:16 CET Linus L=FCssing wrote:
> +       if (nla_put_u8(msg, BATADV_ATTR_MCAST_FLAGS, flags) ||
> +           nla_put_u8(msg, BATADV_ATTR_MCAST_FLAGS_PRIV, flags_priv))
> +               return -EMSGSIZE;

Are you sure that 8 flags are enough for the future? Not that you are endin=
g=20
up with a 9th flag and don't know where to put it.

Kind regards,
	Sven
--nextPart4070646.146XcdYU5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqb9mgACgkQXYcKB8Em
e0aNHg//aabn8e52PkjDpEVm694/opqHFjQkdx2V/PRbu29Ij5O0Ze7lHSsLXNmc
Z9ybmk+U8pir/rQMw2c3HWLetsYTKfYmAcPqVLqL7Zh3v4cYrQ7sQtlZuZCrdoEt
js+IDavB7c3ibk3iBwuq6NA2JPVDYTWEbGW8Eg9T3IA9h4yygGCMHYS1hEREgt4g
axv5LVnwUcfM5RiiA5eWiRezFDDU8xDYjaKzmb7rwzI6/1HOs0zoFEBz0Aa0LIRC
efHt+50ADGHRh0e7dtAg0MldBfsRz5o33Ei7k+UWIMGdK5CAPzmaEHh6djHaJoE5
rrJ3N9hZ0JU4WIyd0KYhulNI5VL/XcOpRG8R/AO4fJslx5h8TGwl6PC5wNCOc1Hn
bpw2Mx4rZBdm6QFyp/NnPwaYHwHTtN8r72GUihNINzTuii6VPVR5Xul9sS87K/Fa
4WiDzpGSfSLB6+Wtqg671IGWNudi3bQ11LiCrQ+dDfU+np1WVW+5F+28ehSmdO+C
flXXL76yJhgaH76Pf0LA1BVg8pt9CUtVF7be4dqowVcctX/igg639JfP+a+1ph/I
q8UZm3vy1k6uJ0LDZrOnj561mtWjfUE5rStuCay99vZ3o6QSVN79omlFub+MXwMR
I0+HI6CFlX/X8zrPZtC/nD8kPN+estKnf95Qxpkkru8+eYIYtgU=
=7p79
-----END PGP SIGNATURE-----

--nextPart4070646.146XcdYU5e--

