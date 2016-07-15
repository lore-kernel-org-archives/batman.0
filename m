Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Jul 2016 16:38:55 +0800
Message-ID: <2409001.5OBQ1FXe5O@voltaire>
In-Reply-To: <1467236757-6273-1-git-send-email-sven@narfation.org>
References: <1467236695-6180-1-git-send-email-sven@narfation.org>
 <1467236757-6273-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1624238.xLo0a14mto";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix consistency of
	update route messages
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

--nextPart1624238.xLo0a14mto
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, June 29, 2016 23:45:57 Sven Eckelmann wrote:
> The debug messages of _batadv_update_route were printed before the actual
> route change is done. At this point it is not really known which
> curr_router will be replaced. Thus the messages could print the wrong
> operation.
> 
> Printing the debug messages after the operation was done avoids this
> problem.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/routing.c | 43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)

Applied in revision 728cf51.

Thanks,
Marek

--nextPart1624238.xLo0a14mto
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXiKEfAAoJEFNVTo/uthzARK8H/0h0j/Hd/KP549nmHMoRKV/G
VCQjEtfZb5aGjbr3+IgZJ3K9Mf+v9S+1CGIvXOOaDq78c0OShOn5sKuYjFxXjJl5
wXeWS0l9Q9mg0ViapWGinjewytOwI6q63TpDCMEmwDGlzFEHWnzgoEr588W/4QtY
n6WteF0dky6EAA5XXoxdpuPgdTCToWpZQgwhl2Ul3AK5SArr+B0Tt6MEJV66ebcg
M57FcWyMiNMu2uusR3F7RnCyDStTw2ucuz/PTatVXkgmMisjR/fDW9c7ceGDoE68
RREd9gWr6gZJp1/NpoVy/Mi2mUqkDiubgWvxrCULO8IJj0pFljfGvCjByMkwsQs=
=EPHu
-----END PGP SIGNATURE-----

--nextPart1624238.xLo0a14mto--

