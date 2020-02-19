Return-Path: <srn@coolheads.com>
Reply-To: srn@coolheads.com
Subject: Re: can't find logged information
References: <24aa48bb-8f52-78be-28df-98ec2e2a054b@coolheads.com>
 <1851274.gzzsXW5Q3G@prime>
 <a687012a-8857-22f3-0623-d82bad19e7bc@coolheads.com>
 <2230258.gT3E0N9OL2@prime>
From: Steve Newcomb <srn@coolheads.com>
Message-ID: <e8843ba8-f0b4-728f-eebd-5ca55ac2828b@coolheads.com>
Date: Wed, 19 Feb 2020 10:00:35 -0500
MIME-Version: 1.0
In-Reply-To: <2230258.gT3E0N9OL2@prime>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

I'm very grateful for your very helpful attention to my bizarre problem,=20
Simon.

Two days ago, my efforts to instrument the nodes had the weird=20
side-effect of making the problem go away.=A0 So now I have no problem;=20
only the mystery remains, and I have little hope of resolving it.

For the record, below are some details that seem relevant, at least to me.



On 2/19/20 4:50 AM, Simon Wunderlich wrote:
>
>> -----------------------------------------------------------------------
>>
>> When nodes become unreachable, they do so only partially.  Consider this
>> weirdness I encountered two days ago:  Given nodes a, b, c, d, from the
>> perspective of a, d has disappeared; in other words, "a# batctl ping d"
>> doesn't work.  But I ssh'd from a to b, then from b to c, then from c to
>> d, all successfully.  And "a# batctl ping d" still wasn't working, even
>> though I was talking to d through that chain of ssh pipes.  Any ideas on
>> what that might mean?  (When I reboot a -- the gateway -- everything
>> always works again, usually for many hours, but never as long as a whole
>> day.)
> Hmm, that's strange indeed. Did you have good connection between all those
> devices? There is a certain "horizon", e.g. if you have many weak links i=
n a
> daisy chain the the OGMs are dropped before they are reaching the end of =
the
> path.
>
> Did you see node D in the originator table of node A?
As discussed below, when I added instrumentation, the problem=20
disappeared.=A0 (*insert muffled scream here*)
>
>> ----------------------------------------------------------------------
>>
>> Do I have a problem because the two meshes, and everything connected to
>> them, all share the same LAN?  I note "received a claim frame from
>> another group" in the above log excerpt.  (I don't know what that means,
>> but I'm guessing that the two meshes are getting each other's
>> maintenance traffic.)  Should the two meshes be separate subnets?
> It's possible and perfectly fine if you have two meshes connected to the =
same
> LAN like this:
>
> https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-=
Testcases#Two-meshes-connected-by-one-LAN
>
> Just make sure that the meshes are properly disconnected and not rejoin f=
rom
> time to time (e.g. by having different SSIDs)
I think I had missed this page.=A0 Thanks for pointing it out.
>
>> In a similar vein: Should each node be running its own subnet?
>>
>> ----------------------------------------------------------------------
>>
>> Should I try changing all nodes over to BATMAN_V, rebooting them all,
>> and hoping they re-establish contact?  (It would be massively
>> inconvenient to have to reset them all physically.)
> No, BATMAN V will not magically fix this.
Then I won't switch to BATMAN_V.=A0 "If it ain't broke, don't fix it."
>
>> ----------------------------------------------------------------------
>>
>> Should I try turning off bridge loop avoidance?
> bridge loop avoidance should be on as soon as you have any two nodes conn=
ected
> to the same LAN and mesh at one time.
Then I guess I don't need BLA.=A0 I'm tempted to turn it off just to avoid =

the overhead, because only the gateways have wired access to the LAN,=20
and all other nodes have only their respective meshes.
>
> I think we should work on your a - b - c - d chain and find out why a can=
't
> talk to d. That seems like the most obvious symptom.
I would do that if it were still broken!

Here's what I did, in some detail: rosepark dot us hash Feb182020



