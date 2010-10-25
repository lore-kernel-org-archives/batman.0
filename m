Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 25 Oct 2010 14:48:57 +0200
References: <AANLkTi=MbTkJiD-=7LcWdzMdqcJeqaBkX2G6O3oeUDZ8@mail.gmail.com>
In-Reply-To: <AANLkTi=MbTkJiD-=7LcWdzMdqcJeqaBkX2G6O3oeUDZ8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201010251448.57946.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv multi-hop route
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Linus =?utf-8?q?L=C3=BCssing?= <linus.luessing@web.de>

On Monday 25 October 2010 06:03:01 Xianghua Xiao wrote:
> I'm trying to test how much bandwidth is left after multi-hops using
> dual-radio as the backbone(interface alternating), I have a few nodes
> and want to force them cascaded, is there a way to set up 'static hop
> route' somehow so the nodes will not take a short-cut, the nodes are
> all close-by.
> 
> Basically I want to have A->B->C->D->E and avoid A->E or something alike.

You could remove the external antennas (if any) to reduce the signal strength. 
That is much easier than a software solution. Alternatively you can use 
ebtables to block unwanted OGMs. Linus might be of help here.

Regards,
Marek
