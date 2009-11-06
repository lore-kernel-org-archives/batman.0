Return-Path: <aaron@lo-res.org>
Content-Type: text/plain; charset=iso-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v1076)
From: "L. Aaron Kaplan" <aaron@lo-res.org>
In-Reply-To: <4AF3094F.3000705@gmail.com>
Date: Fri, 6 Nov 2009 11:17:27 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECFA725C-F3CD-4B24-B22C-F247B8A1FEE6@lo-res.org>
References: <4AF21525.3080008@gmail.com> <20091105024904.GA29859@Linus-Debian>
	<4AF3094F.3000705@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Any results from BattleMesh 2009?
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


(disclaimer: I was not at this WBM but at the previous one - but I =20
think some things can be generalized, so I dare to give some answers =20
here. Others who were there might want to add )

On Nov 5, 2009, at 6:20 PM, Gus Wirth wrote:

> On 11/04/2009 06:49 PM, Linus L=FCssing wrote:
> [snip]
>> PS: Just out of curiosity and also because the reports are in
>> progress right now, what kind of results are you expecting?
>
> Things I'm curious about:
>
> How was the mesh configured?
>
> What tools did you use to test the mesh?
>
> How does the mesh react to the addition of a node? How long does it =20=

> take a new node to integrate itself into the mesh?

Many of the protocols tested at the WBM tests so far can be tuned to =20
different timing parameter. So, in theory you can make them pretty =20
"fast" (but you have more communication overhead). There is AFAIK no =20
agreed upon standard setting of comparable timing and config parameters.

BATMAN per see seems to have a theoretical limitation that Juliusz =20
found out: exponential time for convergence in the presence of loss. =20
This result was obtained thru reasoning and logic, not thru tests.

>
> How does the mesh react to the removal of a node? How long does it =20
> take the mesh to react to the node removal?
>
see above

> How does the mesh handle interference? Did you have anything to =20
> generate interference for testing?
>
interference is a layer 2 issue. Unfortunately at the last WBM in =20
Paris, I wish I had a spectrum analyzer to actually compare the =20
testbed with the "interference surrounding" it was embedded within.

> What tools were used to visualize the mesh? Any images available?
>

> Results of throughput testing for one hop, two hop, etc.
>
> What was the CPU load on the mesh nodes while relaying traffic? What =20=

> were the nodes?
>
> I'll probably have more questions later.

In Paris, it was *very* hard to get comparable results at all. However =20=

it made sense to discuss and improve the respective implementations =20
however  :)


a.

