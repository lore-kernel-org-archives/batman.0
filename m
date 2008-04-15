MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Message-id: <A46801E6-B4A6-452F-A1DE-C787A4E947D5@philippeapril.com>
From: Philippe April <isf_lists@philippeapril.com>
In-reply-to: <4804FC55.3010407@gmx.net>
Subject: Re: [B.A.T.M.A.N.] Node keeps switching back and forth
Date: Tue, 15 Apr 2008 16:00:46 -0400
References: <7BE4D55B-B938-45A8-BCF4-923632152CFC@philippeapril.com>
	<a934d3f30804150104w4c4c47fp766cce05ae014ae2@mail.gmail.com>
	<018CC2A5-4DD5-421B-AD00-AF9B3CC50D2B@philippeapril.com>
	<200804160202.23971.lindner_marek@yahoo.de>
	<C2223079-2ACE-4EA6-BB82-C9B4A1547149@philippeapril.com>
	<4804FC55.3010407@gmx.net>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

:)

In my case, I'm not having loop problems, I'm just testing my setup to  
see if things are stable, and I was wondering why the path wouldn't  
stay the same.

With your tests with massive traffic streams, can you confirm that  
(for example) a user who's downloading something big (or an  
interactive ssh session) should not see a difference and the flow  
should stay constant, even though the traffic switches to another path  
several times during the session? That'd be great (and I'll test that  
tonight!)

On 15-Apr-08, at 3:04 PM, elektra wrote:

> Hi Philippe -
>
> fast switching of a route is a problem if does cause routing loops.  
> I have verified in a 7x7 physical mesh grid that B.A.T.M.A.N.  
> doesn't loop - ever. And - yes - particularly in my tests where I  
> saturated the grid with several massive traffic  streams that were  
> colliding in the center of the grid, B.A.T.M.A.N. was switching  
> routes quite often (every few seconds).
>
> I see therefore no point in adding hysteresis. If someone can show  
> that there is an issue we can add hysteresis to the protocol.
>
> cu elektra
>
>
>> I tried that but I think it's only for switching from a gateway to  
>> another gateway.
>>
>> My problem is for switching from an intermediate node, to another...
>>
>> For example, imagine a square where there's a node in each corner  
>> at almost equal distance/signal quality (to keep things simple)  
>> with some interference, and only one of them is the gateway, and  
>> the node opposite to the gateway can't reach the gateway directly.
>>
>> That node (opposite to the gateway) has the choice between two  
>> nodes to get to the gateway.
>>
>> In my/this case, it keeps switching from one to the other (since  
>> the quality is almost the same on each). I guess it doesn't help  
>> keeping things reliable for laptop connections behind... Playing  
>> with -r doesn't seem to help because I only have one gateway node.
>>
>> Am I right?
>>
>> On 15-Apr-08, at 2:02 PM, Marek Lindner wrote:
>>
>>>
>>>> As soon as signal from node2 to node1 goes down from let's say  
>>>> 250 to
>>>> 240, if another connection to the gateway's quality is 241, it'll
>>>> switch as soon as it hits 240... Then when quality comes back up to
>>>> 242, it switches back to node1.
>>>>
>>>> I don't think it's very good to switch as soon as the quality is
>>>> higher somewhere else, it should at least "give it a chance" by  
>>>> either
>>>> having a threshold, or switch only if it's been in a more degraded
>>>> state for more than x minutes, etc.
>>>>
>>>> Is there something I can do to influence that? Did I miss a command
>>>> line argument?
>>>
>>> You can use e.g. "-r 20" to switch the gateway as soon as the TQ  
>>> difference is
>>> bigger than 20.
>>>
>>>> From "batmand -H":
>>>
>>> -r routing class (only needed if gateway class = 0)
>>>         default:         0  -> set no default route
>>>         allowed values:  1  -> use fast internet connection  
>>> (gw_flags * TQ)
>>>                          2  -> use stable internet connection (TQ)
>>>                          3  -> use fast-switch internet connection  
>>> (TQ but
>>> switch as soon as a better gateway appears)
>>>
>>>                          XX -> use late-switch internet connection  
>>> (TQ but
>>> switch as soon as a gateway appears which is XX TQ better)
>>>
>>> Greetings,
>>> Marek
>>>
>>> _______________________________________________
>>> B.A.T.M.A.N mailing list
>>> B.A.T.M.A.N@open-mesh.net
>>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

