Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 26 Sep 2010 22:25:36 +0200
References: <201009262057.36382.lindner_marek@yahoo.de>
	<1285527477-10340-1-git-send-email-lindner_marek@yahoo.de>
	<201009261516.21774.lew.pitcher@digitalfreehold.ca>
In-Reply-To: <201009261516.21774.lew.pitcher@digitalfreehold.ca>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201009262225.38357.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv: softif lan loop avoidance
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

On Sunday 26 September 2010 21:16:16 Lew Pitcher wrote:
> you are trying to prevent OGMs from perpetually circulating around. 
> Wouldn't "wifi1" be able to recognize it's own OGMs? If so, then why
> wouldn't  it just drop them, rather than passing them along to the next
> node?
> 
> If each wifi dropped it's own OGMs, then OGMs would only "circulate" once 
> through the loop, and be discarded when they arrive back at their
> originating  node.

Maybe my mail was not clear enough that this problem exists because the 
payload traffic loops, not the batman-adv protocol traffic. As you correctly 
pointed out the OGMs are filtered and dropped if necessary.

By the way, this is not a problem unique to batman-adv. Ethernet loops are a 
common problem in bridged / switched environments. Feel free to search for 
"bridge loop" or "ethernet loop" to find some interesting examples.  

Regards,
Marek
