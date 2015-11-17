Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 Nov 2015 16:49:30 +0800
Message-ID: <8883114.ve0PqyjJvy@voltaire>
In-Reply-To: <1446541544-7647-1-git-send-email-sven@open-mesh.com>
References: <1446541544-7647-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2559074.19iOAuSs7E";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Fix invalid stack access
	in batadv_dat_select_candidates
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
Cc: Sven Eckelmann <sven@open-mesh.com>

--nextPart2559074.19iOAuSs7E
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, November 03, 2015 10:05:44 Sven Eckelmann wrote:
> batadv_dat_select_candidates provides an u32 to batadv_hash_dat but it
> needs a batadv_dat_entry with at least ip and vid filled in.
> 
> Fixes: 3e26722bc9f2 ("batman-adv: make the Distributed ARP Table vlan
> aware") Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
> v2: Send with @open-mesh.com address for correct sponsor attribution
> 
>  net/batman-adv/distributed-arp-table.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied in revision e897e5e.

Thanks,
Marek

--nextPart2559074.19iOAuSs7E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWSuoaAAoJEFNVTo/uthzAB2oIAJKTWOTMemv+BzY1GETrllGY
zvN/TMIQKdare9HVortFVeZWb17jZ3f4i9L59bp+BoSskbmLCz/wOvXfjiMOhfJ6
zZBbRpShKzxxcpS1Uam0baR3osPchcKObr1gkJGp2FTks+yAjiP8HAHH32Zmo7tZ
4REnoi4OVO6aVk4qQOEwqnDz5lHGjmLcVq0XkWkZd8LUmyItAYlKc+1j05Sw9oeO
4+/5PK718yAl19+FDydyRp6L8zhJrgvK1UtCqRtil9YfEik30sIQO/Hii2t+YbZF
2hHqLZVcisgV6q8G00bhMrr3x6WNvG71tkBEvPySpnr87FL9k5WjX+zycfczi1A=
=Y+MW
-----END PGP SIGNATURE-----

--nextPart2559074.19iOAuSs7E--

