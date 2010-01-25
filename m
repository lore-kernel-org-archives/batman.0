Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 25 Jan 2010 16:21:11 +0800
References: <20100123174616.GA4795@Sellars> <20100124204212.GA4350@Sellars>
	<20100125064747.GS24649@lunn.ch>
In-Reply-To: <20100125064747.GS24649@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001251621.12033.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] bat_events: page allocation failure (batman-adv
	maint)
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

On Monday 25 January 2010 14:47:47 Andrew Lunn wrote:
> Staging: batman-adv: Fix skbuff leak in VIS code.
> 
> The vis code takes a copy of the data inside the skbuf if it is
>  interesting  for us, so we always need to release the skbuf.

Applied in rev 1564.

Thanks,
Marek
