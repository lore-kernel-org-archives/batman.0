Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Feb 2016 07:41:38 +0800
Message-ID: <33875999.jBEq8r4P9a@voltaire>
In-Reply-To: <1456178194-29307-2-git-send-email-sven@narfation.org>
References: <1456178194-29307-1-git-send-email-sven@narfation.org>
 <1456178194-29307-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2231850.TIoZFGypsE";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Split
	batadv_iv_ogm_orig_del_if function
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

--nextPart2231850.TIoZFGypsE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 22, 2016 22:56:34 Sven Eckelmann wrote:
> batadv_iv_ogm_orig_del_if handles two different buffers bcast_own and
> bcast_own_sum which should be resized. The error handling two for
> allocating these buffers causes the complexity of this function. This can
> be avoided completely when the function is split into a main function
> handling the locking, freeing and call of the subfunctions.
> 
> The subfunction can then independently handle the resize of the buffers.
> This also allows to easily reuse the old buffer (which always is larger) in
> case a smaller buffer could not be allocated without increasing the code
> complexity.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c | 131
> ++++++++++++++++++++++++++++---------------- 1 file changed, 84
> insertions(+), 47 deletions(-)

Applied in revision 1c5fc73.

Thanks,
Marek

--nextPart2231850.TIoZFGypsE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAABCAAGBQJW0jQyAAoJEFNVTo/uthzA6/4H+PPzRAjHTmUxXYgaldv5mtxO
u9xeIgJ33NZdjNwPYgyc8sUUte9SFnBk8nSGvPvpBpDYIYJxsV1JeHIBwGobNG+x
258qFfkUsJZmz+sgdRcJ2OmrCrfb0PnLlwadrrlO/Sa2qKV8pu5ftnv6gsRUnPZ4
gZh+oQ0xa3qXREJIYcA4l9b4klDvSkPqvOXp7j07QIPrTDgAZAQUG4UfkIAQXATw
232ctaHMBNFNpf5OC8kGDTgAr67P+klhqtvnT+hp+seB0qC3YavPrkp4y2FDaQt+
51bEVrduFZB7ZwB3DK0PLhqZE9yAq751JeUxzr6tuWVlqhM2n/EcHcUdc+DIYw==
=tAtl
-----END PGP SIGNATURE-----

--nextPart2231850.TIoZFGypsE--

