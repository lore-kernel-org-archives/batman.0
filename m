Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Mar 2012 17:47:17 +0300
References: <CAHD-aqKv+7SDGC-07Or+xOZKiJATPmOy876SnDawJp_Zs0GZvg@mail.gmail.com>
In-Reply-To: <CAHD-aqKv+7SDGC-07Or+xOZKiJATPmOy876SnDawJp_Zs0GZvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201203261747.17373.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BW degradation on p2p links?
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


Hi,

> i'm participating in the development of a wireless mesh network in
> Delta de Tigre, near Buenos Aires, Argentina.
> Landscape is absolutely flat, with dense forest 15-20mts tall. Nodes
> are being installed along the river, 50 - 150mts apart, with clear LOS
> at ground level.
> I collaborated with Nico Echaniz last month, bulding another community
> network in Cordoba, and given the success, I decided to start one more
> here. I'm also really thankful with Elektra, for recommending the
> tl-m3220 to Nico!
> We chose batman over olsr, in part because of avahi stuff, but also to
> have a real-world implementation and thus collaborate in testing /
> debugging :) So far, there are  only 4 working nodes, but luckily I'm
> already facing unexpected behaviour.
> 
> I'm sorry for the long email, it's mostly terminal logs.
> In short, iperf between two neighbouring nodes reports >20mbps, yet
> running the same iperf between nodes separated by one hop reports
> inexplicably low <5mbps.
>
> [..]
>
> Any ideas, thoughts, pointers? Any additional info needed?

welcome on the list!
I admit not having dived into all the details of your mail - the bigger part 
of the batman team is sitting in Athens at the moment (see battlemesh.org). 
The best next step is to find out whether this performance issue is a batman-
adv or a wifi driver problem. May I suggest you remove batman-adv and repeat 
the same test using static routing ? If you still see the problem it is the 
wifi that is not working otherwise we have to fix batman-adv.

Regards,
Marek

