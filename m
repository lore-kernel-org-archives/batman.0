Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 23:05:52 +0800
Message-ID: <3841474.g7RERK39Gk@voltaire>
In-Reply-To: <2c0e66fe07809e4069df34cbeba51583ad943c7a.1451317025.git.geliangtang@163.com>
References: <2c0e66fe07809e4069df34cbeba51583ad943c7a.1451317025.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8108075.Rt1QnjnYaG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: use to_delayed_work
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
Cc: netdev@vger.kernel.org, Antonio Quartulli <a@unstable.cc>, linux-kernel@vger.kernel.org, Geliang Tang <geliangtang@163.com>, "David S. Miller" <davem@davemloft.net>

--nextPart8108075.Rt1QnjnYaG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, December 28, 2015 23:43:37 Geliang Tang wrote:
> Use to_delayed_work() instead of open-coding it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 2 +-
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  net/batman-adv/network-coding.c        | 2 +-
>  net/batman-adv/originator.c            | 2 +-
>  net/batman-adv/send.c                  | 4 ++--
>  net/batman-adv/translation-table.c     | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

Applied in the batman tree (revision ecc6f9a).

Thanks,
Marek

--nextPart8108075.Rt1QnjnYaG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+UhQAAoJEFNVTo/uthzAkqEIAIqggaBrRvMqvhUwF/hEoUsN
tTh+wjHLusDAUGN6l6uiejFChg5uLmjUgzm6uEmCRAEnO+gDuFUGNaBQ5oML2Ioi
kohnli6XL7uUTPOAtEwmQnO9YrEOfYHBKHBJQ1+DB/btXhwXPAw/QWrZLnBU4px1
h2GzIMQzzY9SUOBaWkMZ1sb1bQ07VeMGf5NAFhu0EMMR1Ox7515xhjjzAlzGBuiV
H8Mkrm/uAq6fClJM0feIpAT0OVJ/a7ikjwDiLt6zfUgU1B0Os2VCE3BbL5oJXrlm
D2v0V3sY6lXN9BDxXGZyHkmEmHRkLqp65dFt9wOrEmKZ2xRtc4MinyqE2+PNXsA=
=uFYZ
-----END PGP SIGNATURE-----

--nextPart8108075.Rt1QnjnYaG--

