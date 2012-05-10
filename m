Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 11 May 2012 04:19:56 +0800
References: <4FA54C09.6000303@universe-factory.net>
	<4FAA970F.7080901@hundeboll.net>
	<4FAC1B52.7050804@universe-factory.net>
In-Reply-To: <4FAC1B52.7050804@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205110419.56441.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: fix visualization output
	without neighbors on the primary interface
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

On Friday, May 11, 2012 03:47:30 Matthias Schiffer wrote:
> 1st, implementations [1-3] aren't very configurable, and [4], an
> implementation by Intel, is hard to configure and *huge* (stripped
> binary ~400KB). Most of the implementations don't support announcing
> IPv6 addresses (I'm not sure which anymore), although that isn't really
> an important feature for me, as I'd use it mostly to announce hostnames
> for the MAC addresses, but I consider software that only supports IPv4
> as deprecated. Also, most of these projects seem to be dead for years.
> 
> 2nd, I think without batman-adv specific extensions LLDP isn't very
> useful, as the LLDP daemon only cares about the bat0/bridge MAC
> addresses, and not the hardif MAC addresses which are visible in the
> vis. The softif MAC addresses are shown in the vis as TT records, of
> course, but as one can't really discern between the adresses of the node
> itself and those of other clients on the bridge, it's rather useless in
> my opinion.

I understand all reason except for the last one. What are you trying to 
achieve that you need to auto-discover all batman-adv interfaces ? Are you 
trying to replace vis ? 
As far as I understood Martin was trying to point you to a protocol which 
broadcasts arbitrary data on layer2 (similar to mDNS on layer3).

Regards,
Marek
