From: david johnson <david.lloyd.johnson@gmail.com>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 29 Oct 2008 23:49:30 -0700
Message-Id: <1225349370.13082.53.camel@desiree>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman - how does "fast internet connection"
	connection work
Reply-To: david.lloyd.johnson@gmail.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: b.a.t.m.a.n@open-mesh.net

Hi

First an introduction - I am a David Johnson - I've been working on mesh
protocols for a few years now and I've built a 49 node wireless grid to
benchmark mesh protocols in South Africa:
http://wirelessafrica.meraka.org.za/wiki/index.php/49-node_Indoor_Mesh

Elektra and I did some experiments with batman (do I have to use the
dots @#!!!) and olsr at the beginning of the year and we wrote a paper
showing how batman outperforms olsr on CPU usage and better throughput
due to less flapping. The results were very impressive!

I'm now in the USA starting a PhD in mesh and I've decided to work on
batman in one of my networking projects. We have this idea to try and
improve gateway location performance by measuring real throughput at the
gateway and then allowing nodes to optimally pick gateways that will
give them the best throughput to the Internet but in a fair manner - ie.
one user musn't disadvantage another.

I would like to understand how the ﻿"fast internet connection" gateway
location node works
batmand -r 1 [interface]?:

It says it considers link quality and advertised gateway class - what
formula does it used to combine these two together so that it compare
others against each other.

Thanks and look forward to becoming part of the discussion

David

