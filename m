Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 19 Jun 2013 23:20:40 +0800
References: <1371233050-7938-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1371233050-7938-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201306192320.40627.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: (style) fix for switched
	vid-ifiindex parameter order
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

On Saturday, June 15, 2013 02:04:09 Linus L=C3=BCssing wrote:
> batadv_tt_local_add() first takes the vid and then the interface index
> parameter. One of these calls had the order switched.
>=20
> However in this case it is not a functional, but just a style fix
> because at the moment BATADV_NO_FLAGS is equal to BATADV_NULL_IFINDEX.
>=20
> Introduced by 580d7919f19e4f73ccd79e82a532af2bdc638042
> ("batman-adv: add the VLAN ID attribute to the TT entry")
>=20
> Acked-by: Antonio Quartulli <ordex@autistici.org>
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
> v2: Added "Introduced by..." to commit message
>=20
>  main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision cc14598.

Thanks,
Marek
