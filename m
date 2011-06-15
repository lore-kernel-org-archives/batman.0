Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 15 Jun 2011 23:38:57 +0200
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
	<1307307664-19910-3-git-send-email-ordex@autistici.org>
	<20110605215052.GW4071@lunn.ch>
In-Reply-To: <20110605215052.GW4071@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106152338.58217.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: implement AP-isolation
	on the sender side
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

On Sunday, June 05, 2011 11:50:52 PM Andrew Lunn wrote:
> Hi Antonio
> 
> > +static bool _is_ap_isolated(struct tt_local_entry *tt_local_entry,
> > +			    struct tt_global_entry *tt_global_entry)
> 
> The general pattern i've seen in linux code is that a function _foobar
> is a helper for a function foobar. I don't see an is_ap_isolated()
> here. So i would just call it is_ap_isolated.

I agree - I also wondered about where to find is_ap_isolated() when I saw 
_is_ap_isolated().

Regards,
Marek
