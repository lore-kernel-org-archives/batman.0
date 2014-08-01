Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 1 Aug 2014 15:00:01 +0200
References: <53DB84A3.8070309@aliyun.com>
In-Reply-To: <53DB84A3.8070309@aliyun.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201408011500.02247.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] How to set up the communication in layer 3 in
	mesh node with batman.adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


> hello, eveyone.I am a b.a.t.m.a.n. beginner.I work on openwrt with
> batman-adv 2012.3.0.
> 
> There are three mesh nodes. Node A  is far from node C. A can't communicate
> with C directly, but it can commuticate with C via node B, which is 
> between A and C. The path is A <--> B <--> C.
> 
> On node A, I can run the command 'batctl ping' to node B and node C
> successfully. I can also 'ping'  the node B, but I can't 'ping' node C. It
> shows that I have set up the commuication with all the nodes in layer 2,
> but I can only communicate with the neighbor in layer 3.
> 
> How can I fix this? Thanks.

Can you ping the node C from node B? What kind of IP addresses have you 
configured? Also, the version you use is pretty old, although this kind of 
basic network should still work ... You can also try "batctl td" to find out 
where the packets get lost.

Cheers,
    Simon
