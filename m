Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 15:49:57 +0800
Message-ID: <2592152.smDXvm4ZLG@voltaire>
In-Reply-To: <1467545508-7333-11-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-11-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2127254.Z7DQvBh46G";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 10/16] batman-adv: netlink: add
	gateway table queries
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

--nextPart2127254.Z7DQvBh46G
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:42 Sven Eckelmann wrote:
> Add BATADV_CMD_GET_GATEWAYS commands, using handlers bat_gw_dump in
> batadv_algo_ops. Will always return -EOPNOTSUPP for now, as no
> implementations exist yet.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  include/uapi/linux/batman_adv.h |  8 ++++++
>  net/batman-adv/gateway_client.c | 59
> +++++++++++++++++++++++++++++++++++++++++ net/batman-adv/gateway_client.h
> |  2 ++
>  net/batman-adv/netlink.c        | 10 +++++++
>  net/batman-adv/types.h          |  3 +++
>  5 files changed, 82 insertions(+)

Applied in revision 117a3bf.

Thanks,
Marek

--nextPart2127254.Z7DQvBh46G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjdulAAoJEFNVTo/uthzA8iIIAIoVdLW0XuFPmLxyymqlG8Sd
FyyIaNpAOziVFyzv/MmJNedjeQNhfw4jrdsNObv2gXzTR/e383IqgN8RKjCd07b5
C09+XMXDDnKMxG04dkrH5kTxLrxox5GC6yGH8gx5zXpwXS0aDMUNh1qs1AZzA6Ev
HB7FxqP518nfyeovMMJnE+WNWfT/1LyFkDdE1fdbSSDY9Hvqq3TdYAULYMMSHHCh
BN7kM623F1n9y8Rk2amJfWmD4Z2sA2O++jPVzNp3I2iWzvhO5JArII7+e8l4e4Ys
M1NL/HUNHVbBzdTTf+OzR0hsgDOljNmNmw+1DPHHW6ch/JbBaldq9kq+qy+gUKw=
=fdak
-----END PGP SIGNATURE-----

--nextPart2127254.Z7DQvBh46G--

