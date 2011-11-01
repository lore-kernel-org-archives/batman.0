Return-Path: <ordex@autistici.org>
Date: Tue, 1 Nov 2011 10:14:34 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111101091433.GC20215@ritirata.org>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
	<1319964962-5092-5-git-send-email-ordex@autistici.org>
	<20111031001004.GE10726@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20111031001004.GE10726@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: Distributed ARP Table -
 add ARP parsing functions
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

On Mon, Oct 31, 2011 at 01:10:04AM +0100, Simon Wunderlich wrote:
> This patch is not checkpatch.pl --strict clean
> 
> On Sun, Oct 30, 2011 at 09:56:00AM +0100, Antonio Quartulli wrote:
> > +	if (unlikely(!pskb_may_pull(skb, ETH_HLEN + arp_hdr_len(skb->dev) + 8 + 12)))
> > +		goto out;
> 
> use ETH_ALEN * 2 + 4 * 2 instead to show where theses numbers come from.

Actually this is a mistake, because I have recently seen that arp_hdr_len()
already includes those supplementary bytes.

> > +	bat_dbg(DBG_ARP, bat_priv, "ARP message of type %d recognised "
> > +		"[%pM-%pI4 %pM-%pI4]\n", type, ARP_HW_SRC(skb),
> > +		&ARP_IP_SRC(skb), ARP_HW_DST(skb), &ARP_IP_DST(skb));
> 
> Would you mind printing the type as string? something like REQUEST or REPLY instead of 1 and 2 ...

Oky


Thanks, 

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
