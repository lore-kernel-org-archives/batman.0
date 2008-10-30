Message-ID: <49098068.80606@lo-res.org>
Date: Thu, 30 Oct 2008 10:37:44 +0100
From: aaron <aaron@lo-res.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] batman - how does "fast internet
	connection"	connection work
References: <1225349370.13082.53.camel@desiree>
In-Reply-To: <1225349370.13082.53.camel@desiree>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: david.lloyd.johnson@gmail.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

david johnson wrote:
> Hi
>
> First an introduction - I am a David Johnson - I've been working on mesh
> protocols for a few years now and I've built a 49 node wireless grid to
> benchmark mesh protocols in South Africa:
> http://wirelessafrica.meraka.org.za/wiki/index.php/49-node_Indoor_Mesh
>
> Elektra and I did some experiments with batman (do I have to use the
> dots @#!!!) and olsr at the beginning of the year and we wrote a paper
> showing how batman outperforms olsr on CPU usage and better throughput
> due to less flapping. The results were very impressive!
>   

Well, it is interesting that you note that.
I read the PDF. One thing that struck me was that the settings for OLSR
were such that OLSR used *full flooding*. (MPR 7 etc)
That is *exactly* NOT what it is meant to do!
So I must object to the objectivity of the study.
Basically the study was comparing an elephant and a wale
Well.. both are great ideas :) But ... they do live in different terrain
and under different assumptions :)))

got me?


> I'm now in the USA starting a PhD in mesh and I've decided to work on
> batman in one of my networking projects. We have this idea to try and
>   
great!
> improve gateway location performance by measuring real throughput at the
> gateway and then allowing nodes to optimally pick gateways that will
> give them the best throughput to the Internet but in a fair manner - ie.
> one user musn't disadvantage another.
>
> I would like to understand how the ﻿"fast internet connection" gateway
> location node works
> batmand -r 1 [interface]?:
>
> It says it considers link quality and advertised gateway class - what
> formula does it used to combine these two together so that it compare
> others against each other.
>
> Thanks and look forward to becoming part of the discussion
>
> David
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>   

