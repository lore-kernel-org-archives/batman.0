Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Jul 2016 16:53:14 +0800
Message-ID: <7771733.X2rgy4yZyd@voltaire>
In-Reply-To: <1467545508-7333-3-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1601259.AODRKxi1EV";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 02/16] batman-adv: Suppress debugfs
	entries for netns's
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

--nextPart1601259.AODRKxi1EV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:34 Sven Eckelmann wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Debugfs is not netns aware. It thus has problems when the same
> interface name exists in multiple network name spaces.
> 
> Work around this by not creating entries for interfaces in name spaces
> other than the default name space. This means meshes in network
> namespaces cannot be managed via debugfs, but there will soon be a
> netlink interface which is netns aware.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/debugfs.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Applied in revision 242d600.

Thanks,
Marek

--nextPart1601259.AODRKxi1EV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXiKR6AAoJEFNVTo/uthzAExsH+gI6gm7xCaqzIuGP3uYv07jt
ViGVk3jouSJ2H8vU3uYl6yvHdKHoXDMHxvmiS6J0gb6JEfekmRmYWlDn10/yMbz9
aazM4kCNvGLnYo3t4glGh5Nxnp4TIDxG/RqkrmSwIOfFFWYUZTDkFxdVvx6d76yw
gtq9tAovf84kJUN3z3jbtrCUk/YevX2RPS/tZwznx+Biga4jwLCXW1vICSjArIVU
7ekVi0n30Ysr68XugvRIWtTmlU3UALoQfxQb4nGZDggDXkUSx/tnLnvJ5RTg9MjM
hzaAylLjf+oXfmKn5COLadllzx9BN5RiP/79Nk1tQepFLOG1MeeHgfp/qPPj86g=
=cRon
-----END PGP SIGNATURE-----

--nextPart1601259.AODRKxi1EV--

