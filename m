Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 19 Oct 2012 18:48:36 +0800
References: <1350640310-8968-1-git-send-email-sven@narfation.org>
In-Reply-To: <1350640310-8968-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201210191848.37014.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Simplify crc for skb with
	skb_prepare_seq_read
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On Friday, October 19, 2012 17:51:50 Sven Eckelmann wrote:
> a7fe30736a46d203b74e9fb2df3fb4e1d94222bc ("batman-adv: Add function to
> calculate crc32c for the skb payload") introduced a function that walked
> through the three different socket buffer classes to compute the crc32 for
> an skb. This function is affected by many changes to the sk_buff structure
> in future. This can be avoided by using the sequential read functions to
> access blocks transparently.
>=20
> Reported-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> Reported-by: Marek Lindner <lindner_marek@yahoo.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  compat.h |   35 -----------------------------------
>  main.c   |   31 +++++++++++++------------------
>  main.h   |    2 +-
>  3 files changed, 14 insertions(+), 54 deletions(-)

Applied in revision 3c26295.

Thanks,
Marek
