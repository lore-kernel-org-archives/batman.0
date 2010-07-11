Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 11 Jul 2010 16:37:19 +0200
References: <20100707193047.422ac235@rechenknecht>
In-Reply-To: <20100707193047.422ac235@rechenknecht>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201007111637.19762.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman adv unicast fragmentation (version 5)
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

On Wednesday, July 07, 2010 19:30:47 Andreas Langer wrote:
> i changed a few things as noted. In fragmentation.c search_frag_packet, i
> reduced the goto labels to one and a packet with the same seqno will
> continue to be replaced. The rest was implemented as indicated.

Since there were no more objections I applied your patch in revision 1736 & 
1737 with the little modification suggested by Sven.

Thanks,
Marek
