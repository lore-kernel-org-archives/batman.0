Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 27 May 2010 23:30:15 +0800
References: <20100527162350.75bef379@rechenknecht>
	<20100527150700.GA29869@lunn.ch>
In-Reply-To: <20100527150700.GA29869@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201005272330.15388.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Layer 2 fragmentation
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

On Thursday 27 May 2010 23:07:00 Andrew Lunn wrote:
> I don't quite understand the problem. If you have implemented
> fragmentation, you will naturally increase the MTU on bat0 so that it
> is the standard for Ethernet. So this statement will not trigger.

AFAIK batman-adv determines the minimal MTU automatically, so that you can't 
simply increase the mtu on bat0. But you are right - if the fragmentation is 
enabled batman-adv could allow higher mtu values.

Cheers,
Marek
