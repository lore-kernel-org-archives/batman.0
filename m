Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Aug 2013 19:12:54 +0800
References: <1375813275-19292-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1375813275-19292-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201308071912.54321.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 next] batman-adv: fix potential kernel
	paging errors for unicast transmissions
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

On Wednesday, August 07, 2013 02:21:15 Linus L=C3=BCssing wrote:
> There are several functions which might reallocate skb data. Currently
> some places keep reusing their old ethhdr pointer regardless of whether
> they became invalid after such a reallocation or not. This potentially
> leads to kernel paging errors.
>=20
> This patch fixes these by refetching the ethdr pointer after the
> potential reallocations.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
> v4:
> * Reassign new ethhdr correctly in batadv_unicast_generic_send_skb()
>=20
> v3:
> * Remove the change from 'Returns' to 'Return
> * Avoid using eth_hdr(skb), using (struct ethhdr *)skb->data instead
> * Added fix for batadv_gw_is_dhcp_target() too
>=20
>  bridge_loop_avoidance.c |    2 ++
>  gateway_client.c        |   12 +++++++++++-
>  gateway_client.h        |    3 +--
>  soft-interface.c        |    8 +++++++-
>  unicast.c               |   12 ++++++++++--
>  5 files changed, 31 insertions(+), 6 deletions(-)

Applied in revision c98c3e5.

Thanks,
Marek
