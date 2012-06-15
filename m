Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 16 Jun 2012 03:09:42 +0800
References: <1339705288-4175-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1339705288-4175-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206160309.43218.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix skb->data assignment
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Friday, June 15, 2012 04:21:28 Antonio Quartulli wrote:
> skb_linearize(skb) possibly rearranges the skb internal data and then
> changes the skb->data pointer value. For this reason any other pointer in
> the code that was assigned skb->data before invoking skb_linearise(skb)
> must be re-assigned.
> 
> In the current tt_query message handling code this is not done and
> therefore, in case of skb linearization, the pointer used to handle the
> packet header ends up in pointing to poisoned memory. The packet is then
> dropped but the translation-table mechanism is corrupted.
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> 
> *** this patch is an important fix and it is for maint ***

Next time you send a patch for maint, please be sure the patch is actually 
based on maint. Your patch does not even apply on top of maint ...

Applied in revision c7d05ee.

Thanks,
Marek
