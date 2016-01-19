Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jan 2016 23:08:51 +0800
Message-ID: <1494821.Z9zhdATZLZ@voltaire>
In-Reply-To: <1452933619-6712-1-git-send-email-mareklindner@neomailbox.ch>
References: <8047297.0qIFjkW2bL@voltaire>
 <1452933619-6712-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3950236.npuUjNyxr5";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 01/12] batman-adv: Add hard_iface
	specific sysfs wrapper macros for UINT
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

--nextPart3950236.npuUjNyxr5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 16:40:08 Marek Lindner wrote:
> From: Linus Luessing <linus.luessing@web.de>
> 
> This allows us to easily add a sysfs parameter for an
> unsigned int later, which is not for a batman mesh interface
> (e.g. bat0), but for a common interface instead. It allows
> reading and writing an atomic_t in hard_iface (instead of
> bat_priv compared to the mesh variant).
> 
> Developed by Linus during a 6 months trainee study period in
> Ascom (Switzerland) AG.
> 
> Signed-off-by: Linus Luessing <linus.luessing@web.de>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> [antonio@open-mesh.com: rename functions and move macros]
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  net/batman-adv/sysfs.c | 49
> +++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 49
> insertions(+)

Applied in revision ec46535.

Thanks,
Marek

--nextPart3950236.npuUjNyxr5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWnlGDAAoJEFNVTo/uthzA0lMIAKL1lVp9/+sZRB42lJ+Gp8hr
/jWWKmBevNdfJ3Ew3Lkg7DJxrxKumpE8t+lnDq7YQH5CeafYn4hYQtVAs3cv2Eoy
3WH5yihZvoqdml5Cqz30QuSl9dS5nKwGHDwZ/27FTz4aJuUDwNNPT3cF4prZsUSb
+lI3SvBnayGg9b7BHsJwZuNi1uUfKLGwtLt4HrMXmysfT5s9iX76RPjrJUD8lssK
tkTKu6gNEDCxzEFecoxBf0AMnLz6PnFPD5sa2IvnbbdLtUnH4r9w9jfxXlvwNW8E
RfidYSl5bzEdqShmfnxGtk9C52WyfkyfXXvkHx4j5/CMRQXeMlCTrFx7W81ZwmE=
=eEIB
-----END PGP SIGNATURE-----

--nextPart3950236.npuUjNyxr5--

