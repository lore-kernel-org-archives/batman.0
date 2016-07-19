Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:08:07 +0800
Message-ID: <2088001.MVd1Uj5BSu@voltaire>
In-Reply-To: <1468597173-25378-2-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1879882.tIKdok8QXC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 02/18] batman-adv: Place kref_get for
	orig_ifinfo near use
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>

--nextPart1879882.tIKdok8QXC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:17 Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type
> 
>  net/batman-adv/originator.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision 180df6d.

Thanks,
Marek

--nextPart1879882.tIKdok8QXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjd/oAAoJEFNVTo/uthzAn/IIAL60uJnp3KbLRSlPdPLxIbf9
858rdcI38nCZQuf9HEARmd7aN6wYthTxK4elckhhMihrS5WR0ztDGCsTP6WVur8i
4Pi2EUVz5BM7rZD8xtbLxumduZO/jTxUD/yA/vHVDO88qDguDvcGPjg6d4PlvPjf
U58LQohq9uggigt98kemvLJeRaHuKUrqbUIB3p6ROlHrdg7mnp0W/KVgfDlaOXx8
zB/ejkD0YgMm/SxFG3rTa20XvY/WT1tWQeWkfuuBE4fwKZ6rv1/9vwfkvWZtkXfL
koUXGsWkCdrPf1E2voe2bl1JmVQIAv1DxIIzI1aUpljXu0beQBQF+9LzHInyUq8=
=CufO
-----END PGP SIGNATURE-----

--nextPart1879882.tIKdok8QXC--

