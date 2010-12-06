Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201012061720.26228.lindner_marek@yahoo.de>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<20101202120210.GB13912@ritirata.org>
	<AANLkTi=isvXpB+HK22nLEwAa9ErmRDwhtXFRPJPCO_C3@mail.gmail.com>
	<201012061720.26228.lindner_marek@yahoo.de>
Date: Mon, 6 Dec 2010 18:06:54 +0100
Message-ID: <AANLkTinhV_bVKuH8i=DxXoEAAy6BxD+21kGC4osjfrLk@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] BATMAN routing
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

Hi all,

2010/12/6 Marek Lindner <lindner_marek@yahoo.de>:
>
> Hi,
>
>> But in my opinion the main cause of performance deficiency is the
>> route flap problem documented in some research paper. This is a common
>> problem, especially in dense network.
>
> would you mind explaining in a few words why you think rapid route changes are
> a performance problem or name the paper you are referring to ?

The paper I refer is "Routing Stability in Static Wireless Mesh Networks"
Krishna Ramachandran, Irfan Sheriff, Elizabeth Belding, Kevin Almeroth
University of California, Santa Barbara

The rapid route change is an advantage in case of variable and
unstable wireless link, but can become a problem in case of multiple
available "good" links. In my opinion, in this case useless route
change happens, maybe for a temporary throughput improvement, so it is
important to protect current good route from route flapping.

>> As soon as I have some written material I will send it to the mailing
>> list hoping to receive some suggestion or critiques.
>>
>> PS. I'm also working on a theoretical analysis on routing overhead in
>> term of network utilization. Soon I will post some results.
>
> Great! Looking forward to your results.
>
> Cheers,
> Marek
>

I hope I've been clear.

Bye!

--
Daniele Furlan
