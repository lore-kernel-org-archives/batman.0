Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20110415083243.GA18748@ritirata.org>
References: <BANLkTik_+b9cNK0safmy76+gfjDB2MNDjg@mail.gmail.com>
	<20110415083243.GA18748@ritirata.org>
Date: Fri, 15 Apr 2011 13:03:26 +0200
Message-ID: <BANLkTimfZSDojvdNzDHS-LjWLrOepggBRw@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Batman-adv hna balancing
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

>So, even with a mac conflict handling
>procedure, I think that this situation would be a bit tricky to be
>managed.

I think batman shouldn't handle mac duplication as conflict but simply
act as the two nodes see the same clients, like olsrd do when multiple
nodes announces the same hna

2011/4/15 Antonio Quartulli <ordex@autistici.org>:
> Hi Gioacchino,
>
> On ven, apr 15, 2011 at 10:07:13 +0200, Gioacchino Mazzurco wrote:
>> Hi!
>>
>> I am installing batman-adv on nodes on our mesh networks in Pisa, but
>> i have a question
>>
>> Here you can see our topology, there is two nodes at moment they are
>> connected to the same switch and should see same hnas but they are
>> announced mostly by one of the two
>> http://eigenlab.org/batman-adv_status.php
>>
>> If i turn off the cc:c8 node the hna pass to the other nodes but when
>> i turn it on all hna pass on it
>>
>> Why this? Is not better to balance hna announcing?
>>
>> Very thanks!
>
>
> What you are observing is part of a more general problem that we are
> already taking into account: What to do if two nodes detect to be
> connected to the same client (same MAC address). It is not a simple
> problem and we are trying to figure out which could be a good solution.
> (Ideas are welcome :D)
>
> With the actual implementation, if I am not wrong, the last received OGM
> that carries the client MAC address wins. Because there is not a real
> mac conflicting handling procedure.
>
> Moreover, in your case, you have a switch in between, so I can imagine
> that the traffic is redirected to one or to the other node on the switch
> basis depending on the packet destination. So, even with a mac conflict handling
> procedure, I think that this situation would be a bit tricky to be
> managed.
>
> I hope I've been clear in what wanted to say. :)
>
> bye
>
> --
> Antonio Quartulli
>
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara
>
