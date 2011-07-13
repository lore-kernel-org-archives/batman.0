Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20110712000020.GA31975@netfeed>
References: <CAOaDhSS0-EP6bPM+2kho3h9u8aGJXsP0QmaqFMAhHa_4Y=MA4Q@mail.gmail.com>
	<CAKeC-QH0D5R2dvXJ-KEoBPCc=rmYadCzmMW1kAeBxuur+okzrw@mail.gmail.com>
	<CAOaDhSTMPWNi+Cbv8jqumA3S1Bkpetcqqmh-SMUROOe+LUFEbg@mail.gmail.com>
	<1640517.S3sb13Hzrx@sven-desktop.home.narfation.org>
	<20110712000020.GA31975@netfeed>
Date: Thu, 14 Jul 2011 01:51:13 +0200
Message-ID: <CAOaDhSSBoxZQHnc7kJ+d967sViR1q0isasYQY4kgibw-s7zjBA@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batctl vd dot buggy
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
To: =?ISO-8859-1?Q?Linus_L=FCssing?= <linus.luessing@web.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

I have not tested that deeply but some people told me that their
computer (HNA) is missing on the graf...

2011/7/12 Linus L=FCssing <linus.luessing@web.de>:
> On Wed, Jul 06, 2011 at 12:27:28AM +0200, Sven Eckelmann wrote:
>> On Tuesday 05 July 2011 23:29:07 Gioacchino Mazzurco wrote:
>> > Good job, but what we are trying to fix is the topology visualization
>> > we need that at moment
>>
>> Just looked with one eye at the stuff and it seems that the data which c=
omes
>> from the kernel module is not what you expect. For example 00:15:6d:fc:7=
2:0b
>> isn't marked as primary or secondary.
>
> We don't mark secondary interfaces explicitly in the raw output, a
> raw row output of a primary interface contains all the
> information, both that it is a primary interface and also
> optionally which other secondary interfaces belong to it.
>
> Gioacchino:
> Are the interfaces 00:15:6d:fc:72:0b, 06:15:6d:7c:09:d8 and
> 06:15:6d:fc:71:ce primary or secondary ones?
> (a primary one is the one listed in the first line of 'batctl o',
> the MainIf)
>
> And those are actually the specific ones where no
> subgraph-dot-thingy has been added and no box was drawn and where
> the error lies, right? Or are there more issues we missed so far
> (like links, HNA entries or interfaces missing completely in the list and=
/or
> graph for instance)?
>
>>
>> It looks like one vis_if_list
>>
>> So you can't use the module from 2.6.38 and expect that we fix it with b=
atctl.
>> And the correct people to ask here are:
>> =A0* Simon Wunderlich (author of the vis stuff)
>> =A0* Linus Luessing (the person which added the subgraph stuff)
>> =A0* Andrew Lunn (he introduced the format "vis raw" which is used in vi=
s_data)
>>
>> I don't want to touch it because it may explode in my hand. But you can =
also
>> try whether you are lucky and check vis_seq_print_text. It is currently =
overly
>> complex without any reason. It could easily use seq_file and don't do th=
e
>> precalculation (which was necessary in /sys).... I forgot the topic.
>>
>> Kind regards,
>> =A0 =A0 =A0 Sven
>
