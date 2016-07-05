Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 16:53:27 +0800
Message-ID: <35799247.WFIbEZg2os@voltaire>
In-Reply-To: <1467445934-13951-2-git-send-email-sven@narfation.org>
References: <1467445934-13951-1-git-send-email-sven@narfation.org>
 <1467445934-13951-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2238832.aT5cKSijTL";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: Avoid nullptr
	dereference in dat after vlan_insert_tag
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

--nextPart2238832.aT5cKSijTL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, July 02, 2016 09:52:14 Sven Eckelmann wrote:
> vlan_insert_tag can return NULL on errors. The distributed arp table code
> therefore has to check the return value of vlan_insert_tag for NULL before
> it can safely operate on this pointer.
> 
> Fixes: 53c6c262a581 ("batman-adv: tag locally generated ARP reply if
> needed") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/distributed-arp-table.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied in revision 898382d.

Thanks,
Marek

--nextPart2238832.aT5cKSijTL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe3WHAAoJEFNVTo/uthzAsD0IAK8ra9F0mPyQBnXe5IiWk4z3
nrxyqM+ai+D7BiGLrZlg+IDpe+OFtUMH192akLa1PX2vOPwHu1ZiJJJd9ehw7skc
LNRGdWc9UctmVCHt3nnluUPeviePPW+KDo8dZ/Tm7xJzj6Q/ZSnX0VjFqbv6hALf
5TvJkcGNhJngztnYwCdpNc+be7R8NT18Oz9VHcXtiHSuHOk1/lQBHf9/oC2npZUA
Y9Y3XqAIyKHDrr1AB5WkTaTweXcgtqmSQ9Tb2UnHdKxf5BY5WuiN+Uz7kemOMeGR
uMn9tMd3dROAp3RizzNDgHChFF7tDrpH3jnl0F/RAMr57nzcpc9Xvs4PyE3wFX8=
=6IVd
-----END PGP SIGNATURE-----

--nextPart2238832.aT5cKSijTL--

