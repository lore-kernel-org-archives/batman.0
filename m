Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201106071001.59176.lindner_marek@yahoo.de>
References: <1307400355-11624-1-git-send-email-daniele.furlan@gmail.com>
	<201106071001.59176.lindner_marek@yahoo.de>
Date: Tue, 7 Jun 2011 10:23:58 +0200
Message-ID: <BANLkTinO=5LO+Ctss=a05i1Pr-zFsyKEzA@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark as received also old
	rebroadcast
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

2011/6/7 Marek Lindner <lindner_marek@yahoo.de>:
> On Tuesday, June 07, 2011 12:45:55 AM Daniele Furlan wrote:
>> This patch avoid local TQ drop in case of heavy load. In this case,
>> rebroadcast can be delayed more than orig_interval causing the receiver
>> to incorrectly drop old packets without marking them as received.
>
> Do mind you explaining in more detail what led you to make this change and in
> which scenarios it improves the situation (please give a concrete example) ?
>

When a node is saturated, obviously tends to delay packet send. This
delay is applied
also to batman management frame.
It frequently happens that ogm rebroadcast of neighbour are delayed
more than orig_interval
causing the receiver to discard old packets. This is reflect to the local TQ
that decrease quickly.

I verified this behaviour with wireshark that highlight that in many
case batman management
frame are sent with a great delay.

Running some test with netperf (but also using ping -f the result did
not change), it happens
that TQ towards all node in the network drops to values near 0. This
beahaviuor lead to "random" route
change that are not correlated with the quality of the link.
I verified that this patch solve this problem.

I hope I was clear.

> Thanks,
> Marek
>



-- 
Daniele Furlan
