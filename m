Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 Jun 2011 12:11:07 +0200
References: <1304975758-9412-1-git-send-email-ordex@autistici.org>
	<1307787958-25414-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1307787958-25414-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106121211.08023.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 3/3] batman-adv: improved gateway
	tq-based selection
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

On Saturday, June 11, 2011 12:25:58 PM Marek Lindner wrote:
> From: Antonio Quartulli <ordex@autistici.org>
> 
> If a client issues a DHCPREQUEST for renewal, the packet is dropped
> if the old destination (the old gateway for the client) TQ is smaller
> than the current best gateway TQ less GW_THRESHOLD

Applied in revision 17852fa.

Thanks,
Marek
