Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 16 Jun 2011 12:12:53 +0200
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
	<201106152328.29223.lindner_marek@yahoo.de>
	<20110615224355.GA15320@ritirata.org>
In-Reply-To: <20110615224355.GA15320@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106161212.54542.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: detect clients connected
	through a 802.11 device
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

On Thursday, June 16, 2011 12:43:55 AM Antonio Quartulli wrote:
> > > -	tt_local_add(soft_iface, soft_iface->dev_addr);
> > > +	tt_local_add(soft_iface, soft_iface->dev_addr, NULL_IFINDEX);
> > 
> > Are you sure 0 is not a valid index for any interface ?
> 
> Yes. You can also check the function dev_new_index() at
> http://lxr.linux.no/linux+v2.6.39/net/core/dev.c#L5080
> indexes start from 1 :)

Ok.


> > How about adding a set of flags (TT_CLIENT_ROAM / TT_CLIENT_WIFI / etc)
> > instead of adding more and more bool arguments ? In several places the
> > code converts one to the other which does not seem necessary.
> 
> You mean simply passing a int value which is combination of the used
> flags? mught be a good idea, even for further changes.

Yes, that is what I had in mind.


Regards,
Marek
