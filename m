Return-Path: <ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Date: Sun, 28 Jul 2013 22:17:57 +0200
From: Antonio Quartulli <ordex@autistici.org>
In-Reply-To: <1374888285-20775-2-git-send-email-linus.luessing@web.de>
References: <1374888285-20775-1-git-send-email-linus.luessing@web.de>
 <1374888285-20775-2-git-send-email-linus.luessing@web.de>
Message-ID: <cec8de3ff4ea6c6853536d1b32dc7352@autistici.org>
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
To: b.a.t.m.a.n@lists.open-mesh.org

Il 27.07.2013 03:24 Linus Lüssing ha scritto:
> batadv_send_skb_prepare_unicast(_4addr) might reallocate the skb's
> data. If it does then our ethhdr pointer is not valid anymore in
> batadv_send_skb_unicast(), resulting in a kernel paging error.
> 
> This patch fixes this issue by storing the few bytes we are interested
> in on the stack before modifying the skb.

Good fix! thanks!


However, I think it would be nice to send another patch aiming master 
which could polish this situation a bit better: e.g. by calling 
skb_reset_mac_header() in the batadv_send_skb_prepare_unicast_* 
functions and then get the Ethernet header with eth_hdr() right after 
having changed the skb.

> 
> Signed-off-by: Linus Lüssing <linus.luessing@web.de>

Acked-by: Antonio Quartulli <ordex@autistici.org>

-- 
Antonio Quartulli
