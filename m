Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 5 Dec 2011 04:00:48 +0800
References: <201111290028.01655.lindner_marek@yahoo.de>
	<1322497717-21268-2-git-send-email-lindner_marek@yahoo.de>
	<20111129152318.GA8417@pandem0nium>
In-Reply-To: <20111129152318.GA8417@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112050400.48933.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: convert batman iv
	algorithm to use dynamic infrastructure
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


Hi,

> Generally, we should have a few lines per function in types.h to
> describe what each function is doing - we don't need that for a RFC patch,
> but that would be useful for the final version.

ok, I will do that.


> > +	void (*bat_ogm_init)(struct hard_iface *hard_iface);
> > +	void (*bat_ogm_init_primary)(struct hard_iface *hard_iface);
> > +	void (*bat_ogm_update_mac)(struct hard_iface *hard_iface);
> > +	void (*bat_ogm_schedule)(struct hard_iface *hard_iface,
> > +				 int tt_num_changes);
> 
> can't we put tt_num_changes somewhere bat_priv?

tt_num_changes holds the number of changed TT entries since the last OGM. 
Obviously that changes all the time. Are you suggesting we store this value in 
bat_priv instead of a local variable ? 


> > +	void (*bat_ogm_emit)(struct forw_packet *forw_packet);
> > +	void (*bat_ogm_receive)(const struct ethhdr *ethhdr,
> > +				unsigned char *packet_buff, int packet_len,
> > +				struct hard_iface *if_incoming);
> 
> you can just pass the SKB instead of ethhdr, packet_buff, and packet_len
> -> they are derived from the skb anyway.
> 
> Then, you have can do the API with always a hard_iface as the first
> parameter. ;)

I will send a separate patch for this API change in a minute as it is not 
really a part of the dynamic routing algo patchset.

Thanks for all the feedback!

Cheers,
Marek
