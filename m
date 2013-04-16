Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 17 Apr 2013 00:59:02 +0800
References: <1366125995-18034-1-git-send-email-lindner_marek@yahoo.de>
 <1366125995-18034-7-git-send-email-lindner_marek@yahoo.de>
 <20130416164001.GC20819@ritirata.org>
In-Reply-To: <20130416164001.GC20819@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304170059.02745.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/7] batman-adv: tvlv - convert tt query
	packet to use tvlv unicast packets
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

On Wednesday, April 17, 2013 00:40:01 Antonio Quartulli wrote:
> On Tue, Apr 16, 2013 at 11:26:34PM +0800, Marek Lindner wrote:
> > Instead of generating TT specific packets the TVLV unicast API is used
> > to send translation table data.
> >
> > 
> >
> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> 
> [...]
> 
> > -
> > -     if (batadv_send_skb_to_orig(skb, dst_orig_node, NULL))
> > -             ret = 0;
> > +     batadv_tvlv_unicast_send(bat_priv, primary_if->net_dev->dev_addr,
> > +                              dst_orig_node->orig, BATADV_TVLV_TT, 1,
> > +                              (unsigned char *)tvlv_tt_data,
> 
>                                  ^^^^^^^^^^^^^^^^^
> You should remove this cast since the function expects a void *

Thanks for the hint! I fixed the function calls and pushed the patches into my 
repository[1]. Feel free to pull from there.

Cheers,
Marek

[1] http://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/marek/tvlv
