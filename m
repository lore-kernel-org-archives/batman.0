Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 4 Mar 2012 16:17:57 +0800
References: <1330587321-12177-1-git-send-email-lindner_marek@yahoo.de>
	<1330587321-12177-3-git-send-email-lindner_marek@yahoo.de>
	<20120303175953.GA15413@pandem0nium>
In-Reply-To: <20120303175953.GA15413@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201203041617.57848.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: register batman ogm
	receive function during protocol init
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

On Sunday, March 04, 2012 01:59:53 Simon Wunderlich wrote:
> On Thu, Mar 01, 2012 at 03:35:18PM +0800, Marek Lindner wrote:
> > -static void bat_iv_ogm_receive(struct hard_iface *if_incoming,
> > -			       struct sk_buff *skb)
> > +static void _bat_iv_ogm_receive(struct sk_buff *skb,
> > +				struct hard_iface *if_incoming)
> 
> <rant>
> Personally, I don't like underscore functions. They are usually created
> because of a lack of creativity, but are later called from different
> places, do different jobs and in the end everyone is confused. :) Is it
> possibble to change the name, e.g. to bat_iv_ogm_handle()?
> </rant>

Hmm.., I kind of agree. I'll think about another solution.  :-)


> We should somewhere add a check whether the hard_iface is actually assigned
> to a mesh using the BATMAN IV algorithm. When more algorithms are added,
> we only want the assigned protocol to be handled, others should be
> ignored.

You are right - we need a check but not necessarily in this patch. We lived 
without such a check for quite while. This patch is not introducing a loophole 
that did not exist before. I'll send a separate patch.

Thanks for the comments!

Cheers,
Marek
