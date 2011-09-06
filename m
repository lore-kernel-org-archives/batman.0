Return-Path: <tracer@robotech.de>
Message-ID: <4E65E286.7080600@robotech.de>
Date: Tue, 06 Sep 2011 11:06:14 +0200
From: Tobias <tracer@robotech.de>
MIME-Version: 1.0
References: <4E5D69E3.30403@robotech.de> <20110901213531.GE840@ritirata.org>
	<4E600B22.7090100@robotech.de>
	<201109051006.13844.lindner_marek@yahoo.de>
In-Reply-To: <201109051006.13844.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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

Am 05.09.2011 10:06, schrieb Marek Lindner:
>
> I have tried to reproduce your issue but was unsuccessful. Could you help
> narrowing down the cause by providing some more information ?
> For instance:
> * What is the simpliest setup that can provoke the issue ? Does it also happen
> if you only involve 2 nodes ? Or 3 / 4 / 5 ? Does the problem go away if you
> reduce the number of interfaces on each node ?
> * You provided some logs showing additions / deletions of a non-existing mac
> address and you said this would go away after a while. What do the logs say
> when the problem is about to disappear ?
> * Are the nodes that often exhibit this flakiness far apart or direct
> neighbors ? What does the topology look like ? Again, the simplier the setup
> the better.
>
> Regards,
> Marek

Hello Marek,

i needed to get this working so i switched to 2011.2 last weekend and 
the problems are gone.

So it seems it's a bug introduced in 2011.3.

The network on which i had the problems is live and in use, so i can't 
make any further tests on it right now.

I have some similar devices as spare parts. I'll try to set them up and 
reproduce the problems - but that can take a while.

What i can tell you is:
- every node has only one wlan-network on which batman runs and only the 
node itself uses the bat0 interface - no bridging, no routing
- at the end, most of the time only the directly connected nodes were 
reachable via a normal ping - the "hopping" was not working
- i had the *feeling* that the problems got bigger the more nodes we added
- also i *think* the problems began when we mixed Fonera- and 
TP-Link-devices (sightly different architecture i think)
- the log was always spammed with messages - because of the tiny devices 
i use it's not easy to save the log and inspect it when the connection 
is working again - which can take an hour...

Thank you for your help. I'm sorry, that i can't provide you more infos 
to track down the bug.

Tobias
