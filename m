Return-Path: <a@unstable.cc>
Date: Tue, 10 May 2016 22:57:05 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160510145705.GB22414@prodigo.lan>
References: <1462890719-2146-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <1462890719-2146-1-git-send-email-mareklindner@neomailbox.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: init ELP tweaking options
 only once
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 10, 2016 at 10:31:59PM +0800, Marek Lindner wrote:
> The ELP interval and throughput override interface settings are initializ=
ed
> with default settings on every time an interface is added to a mesh.
> This patch prevents this behavior by moving the configuration init to the
> interface detection routine which runs only once per interface.
>=20
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Acked-by: Antonio Quartulli <a@unstable.cc>

--=20
Antonio Quartulli

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMfbBAAoJEJ4aZjxxc6bKpBsQAL493bk7XUn9jLpXamWq41PG
xPg4IoFWlaUBKUydqR0lA31LBHd1Gg4hU/1iPlP+/ClYq2A+gRlfEtyKrLusZfu6
zL2FMuZT0PCJXf3b3CPzHL202D5inoRE2j0FVY581M+WvZpMv6YSSjFuOE8ir4Tw
7XG/aEVVuXqfM4PaD7E3Ojmy2f9nMQKketCr+GjwVmSvf8rDFF8SzMzS1Mfj9+wM
6XY6M6OSdIq1JBQxlsFBXAPzdIA/3qO/g2D6BxBQ0n6PlwWytAqjr0Ofpc+yePna
cU9wgrMJAuwccYSBxdbk+Ge5z8fnBtTU2kd858BpGFiti79XwWZvURk94PUSCoYG
+u2Sk6NW3nP3sXyo098Szi/x6BnXAmLaZhcXc5O2xRmYiV2HW/DW4LdyjT6JLSzD
T6HeL39z4zwiLI5blhbbsnXTQTq97OIUtlzEXVcbm3c5Hu+aK/Vi8M3g9pZhO1fW
C7dRUWGE6XkR5zOee6HdVmX6/2yxUIgNH+TH+2u5+C3NECKxiwsTnQyUFlrfha61
CJAT/yfx0JEVbCOSfIzzouTU8SNAxgPmCwcu3MV3eG2YxRtvub9XH//l+4cbTvp2
I9in6q0xfe74Mzw7b0RtLXDoUM2O+LpD/Hv87ZVFSUhdUS14I7Qo5mwc1IKkBJ+j
RiN++2uCeSmaX8YxHnU2
=bhOq
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
