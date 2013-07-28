Return-Path: <ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Date: Sun, 28 Jul 2013 22:14:23 +0200
From: Antonio Quartulli <ordex@autistici.org>
In-Reply-To: <1374888285-20775-1-git-send-email-linus.luessing@web.de>
References: <1374888285-20775-1-git-send-email-linus.luessing@web.de>
Message-ID: <6b7819a6334d21a1a7bd0657ac78bd97@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH next 1/2] batman-adv: check return type
 of unicast packet preparations
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
> data.

In next these functions are named a bit differently. I think this can be 
fixed while merging the patch.

> And if it tries to do so then this can potentially fail.
> 
> We shouldn't continue working on this skb in such a case.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@web.de>

Acked-by: Antonio Quartulli <ordex@autistici.org>


-- 
Antonio Quartulli
