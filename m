Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 May 2016 16:43:14 +0800
Message-ID: <4856686.pSXAZedqgS@voltaire>
In-Reply-To: <1463564330-11178-1-git-send-email-sven.eckelmann@open-mesh.com>
References: <4816418.hDXNbSuFUQ@bentobox>
 <1463564330-11178-1-git-send-email-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1597449.ghYzb6F8Yg";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v11 1/2] batman-adv: return netdev status
	in the TX path
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart1597449.ghYzb6F8Yg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, May 18, 2016 11:38:48 Sven Eckelmann wrote:
> From: Antonio Quartulli <antonio.quartulli@open-mesh.com>
> 
> Return the proper netdev TX status along the TX path so that the tp_meter
> can understand when the queue is full and should stop sending packets.
> 
> Signed-off-by: Antonio Quartulli <antonio.quartulli@open-mesh.com>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
> v11:
>  * no changes
> v10:
>  * no changes
> v9:
>  * rebase on top of current master+"batman-adv: Include main.h in all
> files"+ "batman-adv: Keep includes ordered by filename"
> v8:
>  * rebase on top of current master
> ---
>  net/batman-adv/fragmentation.c | 41
> +++++++++++++++++++++++++---------------- net/batman-adv/fragmentation.h
> |  6 +++---
>  net/batman-adv/main.c          |  4 +++-
>  net/batman-adv/routing.c       | 23 ++++++++++++++---------
>  net/batman-adv/send.c          | 25 +++++++++++++------------
>  5 files changed, 58 insertions(+), 41 deletions(-)

Applied in revision 53b6614.

Thanks,
Marek

--nextPart1597449.ghYzb6F8Yg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXPs4iAAoJEFNVTo/uthzA4nQIAL2EDxSGjN9VXwpaJ+/Ap7dH
e15KLFfHvZnIZzH5WPeKTdGA6nPzMgWi7Q4CZMwbOfcX2CtuRSWtyZaag6D/KMvW
vH+J3iR6AYVP49FB30PcMEFBsJpLpjVdTLy8jpI0HoAfhvKP/pApZuXhX3bibGZE
tC0Yig8q1eXiZwzfqopaRcP6uTvJlr4PbBcUga7VGeA9MtG4k603k8qQkoDBWWa5
D1Qec70FWlXBabAdrmzpwO2GvxAYTN+W1t0IKJS5HKzrIYurlKHmb0RwIh7fwYE5
JnZB9iMS5Zo99SjHe0jk6CqrNI9hC4tdCsbLDrtGTddus/uNahghJIckLX2v+Us=
=X/7g
-----END PGP SIGNATURE-----

--nextPart1597449.ghYzb6F8Yg--

