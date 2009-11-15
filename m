Return-Path: <jch@pps.jussieu.fr>
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
References: <200911082144.49637.lindner_marek@yahoo.de>
	<591bc9930911090043mf62cd17tac8033d316002a18@mail.gmail.com>
	<200911092239.01984.lindner_marek@yahoo.de>
Date: Sun, 15 Nov 2009 18:21:27 +0100
In-Reply-To: <200911092239.01984.lindner_marek@yahoo.de> (Marek Lindner's
	message of "Mon, 9 Nov 2009 22:39:01 +0800")
Message-ID: <874oovvh48.fsf@trurl.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 released
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
To: b.a.t.m.a.n@lists.open-mesh.net

>> I have a feature request -- has there been any consideration to getting
>> batman-adv to fragment ethernet frames, so as to get a 1500 byte MTU
>> batman-adv network running on top of a 1500 byte MTU ethernet network? 

> it comes with a severe performance penalty.

Fragmentation over multiple hops is harmful, as explained in detail in

   Kent and Mogul, Fragmentation Considered Harmful, 1995.

On the other hand, in the presence of hop-to-hop ARQ, hop-to-hop
fragmentation/reassembly is a good thing, especially in wireless
networks.  The difference with the above is that when doing hop-to-hop
fragmentation and ARQ, you only need to resend the lost fragments, not
the whole packet.  And since loss probability is proportional to the
fragment size, this is a net gain.

Of course, this has to be balanced with the overhead of sending multiple
frames, which can be pretty high if you contend for the link at every frame.

In short, there's good reason why 802.11 includes link-layer fragmentation.

> Imagine a payload packet comes in (1500 bytes), batman-adv adds its stuff (24 
> bytes) and then we make 2 packets out of it: one 1500 Bytes and one 24 Bytes

Obviously, it's better to send two 750-byte packets.

                                        Juliusz
