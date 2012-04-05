Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 5 Apr 2012 23:19:01 +0300
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-5-git-send-email-lindner_marek@yahoo.de>
	<20120324203945.GI5662@lunn.ch>
In-Reply-To: <20120324203945.GI5662@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204052319.01961.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 5/5] batman-adv: ELP - add configurable
	minimum ELP packet length (def: 300B)
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

On Saturday, March 24, 2012 22:39:45 Andrew Lunn wrote:
> > +	if (skb->len < min_len) {
> > +		memset(elp_neigh_entry, 0, min_len - skb->len);
> > +		skb_put(skb, min_len - skb->len);
> > +	}
> > +
> 
> I don't know the skbuf code too well, maybe you know it better than
> me.
> 
> Is this memset needed? The skb is a copy of the template ELP packet
> created then the soft interface is created. So if the contents of the
> template is set to 0, should we be able to skip this zeroing here?

skb_copy() does not initialize the skb with zeros as far as I can tell. 
bat_v_elp_iface_enable() only writes zeros into the ELP header 
(BATMAN_ELP_HLEN), so zeroing the rest of the skb seems correct. 
We could zero the entire skb in bat_v_elp_iface_enable() to save the memset.

Regards,
Marek
