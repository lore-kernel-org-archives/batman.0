Return-Path: <ordex@autistici.org>
Date: Fri, 17 May 2013 09:09:45 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130517070945.GK3350@ritirata.org>
References: <1368389397-1518-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6CiRFyVmOOJ3DkBX"
Content-Disposition: inline
In-Reply-To: <1368389397-1518-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: use __constant_htons when
 possible
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


--6CiRFyVmOOJ3DkBX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2013 at 10:09:57PM +0200, Antonio Quartulli wrote:
> When comparing a network ordered value with a constant, it
> is better to convert the constant at compile time by means
> of __constant_htons() instead of converting the value at
> runtime using ntohs().
>=20
> This refactoring may slightly improve the code performance.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---

I just found another occurrence that needs the __constant version of this
function. I'll send v3.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--6CiRFyVmOOJ3DkBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRlde5AAoJEADl0hg6qKeOG7UP/0KBXfB70L6tUjcQVHg6mIMI
syipPM+WdOSj04KKGqxkwpZ26s0OpDcIqgtwOwrEpYz5Qmed4L2qn1rN39tkF/1x
HoWLNbwHDVmIWZVqPXqc0kfufQ32RJ9m6NeNF4X5cQLFiIKmBtPBNiUeM+Bi/b23
/IsmUcRpzAWZEywWIM2e7ImpurdHSamsUBv/4lMzVHR+mhJNA7v8YKDhTUqTXkvX
q+uAzAwLREBZbKPuukD6lUScIgIbkelvozSh1HS+gt3Vy9K4NtY7W4C/UwxBct4G
js7xRZXjGn8G2+tByeKlt5CJybDIXpAc3i/Pkdoy96zzjkINkIokzT3I/FZ9pcbf
+/PPvDjrMfKXv3f6NKelJ8CuI1qYYjoonp0tmPNc2K24QFfMMwwp0xcpwei9CheW
QUldDqkqxHimQnEqnV0ysioL6bKIZNnSPMoPdBEulawQpm+sVTohMpCfsY1UzW/g
M92ZmS12y2gIcMmJEXukN2ifC8CLm+SK4NAVcT77fYsJ7vsjF+uj9Y7Tv3j0mBpk
+SigZfhTJPJ9T04mzGgO9XMga2dAmxVb0LQ9UYFqOr62UP6TdKzNVzCXyrYjXoVP
cQbXVxRDPFGoaUY/aEtEaCW6w1AwoYN9Qze6enu40VGiLXKhxz2hZkN9g1IHs/Ju
NiIxdnc84ub9GNNDF5yv
=Yfla
-----END PGP SIGNATURE-----

--6CiRFyVmOOJ3DkBX--
