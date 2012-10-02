Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 2 Oct 2012 13:16:40 +0800
References: <1347712461-9031-1-git-send-email-ordex@autistici.org>
 <1349124808-15995-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1349124808-15995-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210021316.40830.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: dirty hack to recompute
	mac_len in the rx path
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

On Tuesday, October 02, 2012 04:53:28 Simon Wunderlich wrote:
> +#define skb_share_check(skb, b) \
> +       skb_share_check(skb, b); \
> +       if (skb) \
> +               skb_reset_mac_len(skb)
> +
> +#endif /* < KERNEL_VERSION(3, 8, 0) */

Has this patch been tested ? Our skb_share_check() call is this:
skb = skb_share_check(skb, GFP_ATOMIC);

Now we replace this function call with 2 function calls and 2 return values ?


Cheers,
Marek
