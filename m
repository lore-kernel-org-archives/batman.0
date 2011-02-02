Return-Path: <linus.luessing@web.de>
Date: Wed, 2 Feb 2011 21:43:18 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110202204318.GA20603@Sellars>
References: <1296352379-1546-2-git-send-email-sven@narfation.org>
	<1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
	<201102022049.18069.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201102022049.18069.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] Re: batman-adv: Correct rcu refcounting
 for gw_node
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

On Wed, Feb 02, 2011 at 08:49:17PM +0100, Marek Lindner wrote:
> On Wednesday 02 February 2011 18:37:18 Linus Lüssing wrote:
> > So after some more discussions with Marek and Sven, it looks like we
> > have to use the rcu protected macros rcu_dereference() and
> > rcu_assign_pointer() for the bat_priv->curr_gw and curr_gw->orig_node.
> > 
> > Changes here also include moving the kref_get() from unicast_send_skb()
> > into gw_get_selected(). The orig_node could have been freed already at
> > the time the kref_get() was called in unicast_send_skb().
> 
> I'd suggest you make a standalone patch because the patches address different 
> problems.
> 
> Thanks,
> Marek
> 

Oki doki, will do that (wasn't ment to be a clean patch yet anyway
- I wanted to know first if the usage of
rcu_dereference/rcu_assign_pointer() was going in the right
direction).

Cheers, Linus
