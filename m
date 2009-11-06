Return-Path: <zoobab@gmail.com>
MIME-Version: 1.0
Sender: zoobab@gmail.com
In-Reply-To: <ECFA725C-F3CD-4B24-B22C-F247B8A1FEE6@lo-res.org>
References: <4AF21525.3080008@gmail.com> <20091105024904.GA29859@Linus-Debian>
	<4AF3094F.3000705@gmail.com>
	<ECFA725C-F3CD-4B24-B22C-F247B8A1FEE6@lo-res.org>
Date: Fri, 6 Nov 2009 15:35:04 +0100
Message-ID: <560c7c9a0911060635r19fbf346qe354942299e8018f@mail.gmail.com>
From: Benjamin Henrion <bh@udev.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

On Fri, Nov 6, 2009 at 11:17 AM, L. Aaron Kaplan <aaron@lo-res.org> wrote:
>
> (disclaimer: I was not at this WBM but at the previous one - but I think
> some things can be generalized, so I dare to give some answers here. Othe=
rs
> who were there might want to add )
>
> On Nov 5, 2009, at 6:20 PM, Gus Wirth wrote:
>
>> On 11/04/2009 06:49 PM, Linus L=FCssing wrote:
>> [snip]
>>>
>>> PS: Just out of curiosity and also because the reports are in
>>> progress right now, what kind of results are you expecting?
>>
>> Things I'm curious about:
>>
>> How was the mesh configured?
>>
>> What tools did you use to test the mesh?
>>
>> How does the mesh react to the addition of a node? How long does it take=
 a
>> new node to integrate itself into the mesh?
>
> Many of the protocols tested at the WBM tests so far can be tuned to
> different timing parameter. So, in theory you can make them pretty "fast"
> (but you have more communication overhead). There is AFAIK no agreed upon
> standard setting of comparable timing and config parameters.
>
> BATMAN per see seems to have a theoretical limitation that Juliusz found
> out: exponential time for convergence in the presence of loss. This resul=
t
> was obtained thru reasoning and logic, not thru tests.
>
>>
>> How does the mesh react to the removal of a node? How long does it take
>> the mesh to react to the node removal?
>>
> see above
>
>> How does the mesh handle interference? Did you have anything to generate
>> interference for testing?
>>
> interference is a layer 2 issue. Unfortunately at the last WBM in Paris, =
I
> wish I had a spectrum analyzer to actually compare the testbed with the
> "interference surrounding" it was embedded within.

Next Battle Mesh should be organised in a 2.4Ghz-free zone (ie a
remote area with no wifi in the surroundings).

And I also think the foneras are not the right platforms to use, since
they only ouput 1.5Mo/sec in ad-hoc mode in static routing
configuration.

--
Benjamin Henrion <bhenrion at ffii.org>
FFII Brussels - +32-484-566109 - +32-2-4148403
"In July 2005, after several failed attempts to legalise software
patents in Europe, the patent establishment changed its strategy.
Instead of explicitly seeking to sanction the patentability of
software, they are now seeking to create a central European patent
court, which would establish and enforce patentability rules in their
favor, without any possibility of correction by competing courts or
democratically elected legislators."
