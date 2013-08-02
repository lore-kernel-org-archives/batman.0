Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 2 Aug 2013 12:05:28 +0800
References: <1374888285-20775-1-git-send-email-linus.luessing@web.de>
 <1374888285-20775-2-git-send-email-linus.luessing@web.de>
 <cec8de3ff4ea6c6853536d1b32dc7352@autistici.org>
In-Reply-To: <cec8de3ff4ea6c6853536d1b32dc7352@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201308021205.28767.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next 2/2] batman-adv: fix potential
	kernel paging error for unicast transmissions
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Monday, July 29, 2013 04:17:57 Antonio Quartulli wrote:
> Il 27.07.2013 03:24 Linus L=C3=BCssing ha scritto:
> > batadv_send_skb_prepare_unicast(_4addr) might reallocate the skb's
> > data. If it does then our ethhdr pointer is not valid anymore in
> > batadv_send_skb_unicast(), resulting in a kernel paging error.
> >=20
> > This patch fixes this issue by storing the few bytes we are interested
> > in on the stack before modifying the skb.
>=20
> Good fix! thanks!
>=20
>=20
> However, I think it would be nice to send another patch aiming master
> which could polish this situation a bit better: e.g. by calling
> skb_reset_mac_header() in the batadv_send_skb_prepare_unicast_*
> functions and then get the Ethernet header with eth_hdr() right after
> having changed the skb.

I like that approach because it seems cleaner that way. Is there a reason n=
ot=20
do it right away ?

Cheers,
Marek
