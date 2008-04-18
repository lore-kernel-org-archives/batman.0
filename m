MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Message-id: <C3F5B343-E97B-4745-8007-01C66906860E@philippeapril.com>
From: Philippe April <isf_lists@philippeapril.com>
In-reply-to: <48902.85.41.146.90.1208503463.squirrel@krisma.oltrelinux.com>
Subject: Re: [B.A.T.M.A.N.] Node keeps switching back and forth
Date: Fri, 18 Apr 2008 09:46:09 -0400
References: <7BE4D55B-B938-45A8-BCF4-923632152CFC@philippeapril.com>
	<854CEDF6-8307-4BB8-AFD0-EAC208163FE3@gmail.com>
	<B0598FDC-F54D-4D67-BEE2-670F6BD8A064@philippeapril.com>
	<200804181448.44510.lindner_marek@yahoo.de>
	<48902.85.41.146.90.1208503463.squirrel@krisma.oltrelinux.com>
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

Sorry if this sentence sounded so bad... I obviously meant unusable in  
this situation where I couldn't make it work properly, I know there's  
a LOT of people who use it without any problem! There must be  
something in the air...

2 La Fonera, 2 Accton (from open-mesh.com). I had issues with antenna  
diversity at first, reflashed them all to c484 which got upgraded to  
beta-1.1.

Is there an image to flash straight to beta-1.1 and make sure I'm not  
missing upgrades in between or something weird like that?

I won't discuss this anymore on this list here and move the thread to  
the ROBIN forums, as it's no longer related to BATMAN which seems to  
work great except some firewall issues I'm having related to packets  
tagged as "INVALID".

Thanks to everyone for the great explanations... It'd be great to have  
the Wireless Community Weekend's ROBIN test filmed and put on the net,  
as I won't be able to be part of it :)

On 18-Apr-08, at 3:24 AM, a.anselmi@oltrelinux.com wrote:

> Hi,
>
>> I tried the RO.B.IN firmware on 4 nodes and the symptoms are the  
>> same,
>> it's basically unusable.
>
> Can you tell me your hardware and what version are you using?
> Surely there are some problems in your configurations or hardware:  
> many
> peoples run flawlessy robin beta-1.1.
>
> Greetings,
> Antonio
>
>
>
> Marek Lindner disse:
>>
>> Hi,
>>
>>> I tried the RO.B.IN firmware on 4 nodes and the symptoms are the  
>>> same,
>>> it's basically unusable.
>>
>> when did you try this ? I helped them to fix some of these  
>> problems, so I
>> know
>> it should be quite stable now.
>>
>>
>>> Does anybody have a great success story to tell me with this  
>>> hardware
>>> (FON/Accton with Atheros) and mesh networks? B.A.T.M.A.N seems to be
>>> the only thing stable in my setup after all :)
>>
>> There are a bunch of thing you should pay attention to. the last item
>> which
>> made Robin much more stable was:
>>
>> iwconfig ath0 rate 5.5M
>>
>> Try this.
>>
>> Greetings,
>> Marek
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

