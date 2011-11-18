Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <25416217.yBclFAKIz7@sven-laptop.home.narfation.org>
References: <CAG7VhQTrx1nvuH2ZXRbenSuwAqE7RyW=r9WoWrH+ubs6+aP56g@mail.gmail.com>
	<25416217.yBclFAKIz7@sven-laptop.home.narfation.org>
Date: Fri, 18 Nov 2011 15:43:46 +0100
Message-ID: <CAG7VhQRric4kzJnZFg5bKRKQUYRNPAOLuO4-haaYiwOExz152Q@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/5] Loop-freness for B.A.T.M.A.N.
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

2011/11/17 Sven Eckelmann <sven@narfation.org>:
> On Thursday 17 November 2011 16:15:42 Daniele Furlan wrote:
>> This series of patches introduce a correction in tq metric and forwardin=
g
>> =A0rules of ogm packets.
>>
>> =A0In the current configuration routing loops scenario can emerge due to=
 some
>> =A0conceptual errors such the global tq window and the forwarding of ogm
>> coming from sub-optimal paths substituting ogm tq with the average of
>> current router. An example scenario has been realized also in simulation
>> using qemu.
>
> Interesting statement but maybe it would also be interesting for others t=
o
> provide examples and explanations.
>
This argument will be a section of my master thesis. As soon as I have
some more material I will forward it to the community together with the scr=
ipt
used for testing with qemu.

>> =A0Can be demonstrated as already done for DSDV[1], that is a protocol v=
ery
>> =A0similar to batman, that a proper forwarding policy together with a st=
rict
>> =A0control on metric monotonicity (as suggested in [2]) are sufficient t=
o
>> =A0guarantee loop-freeness for the protocol.
>>
>> =A0I apologize in advance if the source style is not the best possible,
>> =A0but I hope that the ideas will applied after a phase of code revision=
.
>
> Please read and understand
> =A0http://www.open-mesh.org/wiki/open-mesh/Contribute#Submitting-patches
>
> I refer here to checking of your patches using simple static analyzers an=
d the
> documentation part.
>
> Also things like
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* update last originator seqno received fr=
om this neighbour */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((set_mark) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (batman_ogm_packet->seqno >=
 tmp_neigh_node->last_seqno))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_neigh_node->last_seqno =
=3D batman_ogm_packet->seqno;
> +
>
> are simply wrong. Have you thought about overflow of sequence numbers (hi=
nt:
> seq_before/after)? Ok, forget about the code and look at the rest.
>
I perfectly know that the code I provided is a mess.
But it works and would solve the problems of loops and convergency, and
this can be verified by anybody before concentrating on coding technicality=
.

> You don't give any hints about implications of your changes in the commit
> messages (no, something like "everything will be better because I say it"
> doesn't count).
>
As already said I will provide soom formal proofs of NON loop-freeness of
current BATMAN implementation together with a proposal of changes
that guarantees FORMALLY loop-freeness.

> Take for example the stuff prepared by Simon. He gathered information, ta=
lked
> to the people and prepared documentation. I can now use this stuff to dis=
cuss
> with him at a higher level than with the stuff you provided. And his stuf=
f is
> only a "small" optional feature, but your patches changes things in the p=
ath
> selection and information propagation code.
>
My modifications are not as drastic as you are saying. They simply remove
formally wrong mechanisms such global TQ window and the forwarding of ogm
not coming from the actual router.

> Maybe you should contact everyone (marec, d0tslash, ordex, ...) on IRC an=
d
> talk about the actual concepts (and also their concepts... ttvn
> *hinthinthint*) and prepare actual documentation based on that.
>
As soon as I have some more material I will expose my concept clearly,
meanwhile if someone want to test my patch is free to do that.

> Kind regards,
> =A0 =A0 =A0 =A0Sven

Thanks for your comments!
Regards.

          Daniele Furlan
