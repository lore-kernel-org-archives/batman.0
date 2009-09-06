Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Sun, 6 Sep 2009 14:37:08 +0200
References: <4AA34865.9000203@rsm-freilassing.de>
	<200909061250.40558.onelektra@gmx.net>
	<4AA39E02.7030201@rsm-freilassing.de>
In-Reply-To: <4AA39E02.7030201@rsm-freilassing.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200909061437.08881.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Hi Michael!


> Announcing 0.0.0.0/0 can really be a problem, but why does BATMAN tunnel
> the internet-traffic through gate0?

Because we want to have the means to select the gateway from the gateway 
client, rather than ending up somewhere random with our outgoing Internet 
traffic. With default route entries in every mesh node all a gateway client node 
can determine is its next link-local hop on the path towards one of the 
gateways. Hence every node on your path will make its own selection for the 
default gateway, so it is not possible to select the gateway from the mesh 
gateway client. 

Cheers,
Elektra

