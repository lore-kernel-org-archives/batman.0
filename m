Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 20 Apr 2013 22:16:24 +0800
References: <1366373804-26785-1-git-send-email-martin@hundeboll.net>
 <1366458879-31677-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1366458879-31677-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201304202216.25126.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5] batman-adv: Move call to
	batadv_nc_skb_forward() from routing.c to send.c
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
Cc: Martin =?utf-8?q?Hundeb=C3=B8ll?= <martin@hundeboll.net>

On Saturday, April 20, 2013 19:54:39 Martin Hundeb=C3=B8ll wrote:
> The call to batadv_nc_skb_forward() fits better in
> batadv_send_skb_to_orig(), as this is where the actual next hop is
> looked up.
>=20
> To let the caller of batadv_send_skb_to_orig() know wether the skb is
> transmitted, buffered or failed, the return value is changed from
> boolean to int.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>=20
> v2: I should make random defines lowercase=20
> v3: Do git add before committing and sending patches :|
> v4: Don't count non-coded packets twice
> v5: Change return value to do correct counting
>=20
>  network-coding.c    |  5 ++---
>  network-coding.h    |  6 ++----
>  routing.c           | 23 +++++++++++++----------
>  send.c              | 27 +++++++++++++++++++--------
>  send.h              |  6 +++---
>  translation-table.c | 12 +++++++-----
>  unicast.c           |  2 +-
>  vis.c               |  7 ++++---
>  8 files changed, 51 insertions(+), 37 deletions(-)

Applied in revision ae72fda.

Thanks,
Marek
