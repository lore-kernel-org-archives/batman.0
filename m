Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1735926.sqdKcyb43X@voltaire>
References: <CAL4ejvQpfAQUUupvDpAx3xek3QggQc_Gi81ucm=EERo+aBwFdQ@mail.gmail.com>
 <1616942.MvSMDqlREL@voltaire>
 <CAL4ejvQDGtSx_NH3SmvmFAOwFvfWbP0ArQ-+b74PCm4dNwimFA@mail.gmail.com>
 <1735926.sqdKcyb43X@voltaire>
Date: Tue, 18 Aug 2015 18:54:28 -0700
Message-ID: <CAKLmikMS_sw6Nb4orxvW8wcpxoytC1h8BBXsNe7F5-ryiyrKoQ@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Why we switched to Babel
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Marc Juul <juul@labitat.dk>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Jenny Ryan <tunabananas@gmail.com>, Jernej Kos <jernej@kos.mx>

Hi!

Wouldn't the MAC issue be addressed if the mesh network would be a mix
of L2/L3 network? L2 to cover community spaces and allow roaming in
there, but then across such segments, there would be a L3 routing?

So one would for example be able to follow you inside Omni, but not
across the whole network.


Mitar

On Mon, Aug 17, 2015 at 1:57 AM, Marek Lindner
<mareklindner@neomailbox.ch> wrote:
> On Saturday, August 15, 2015 07:05:17 Marc Juul wrote:
>> > I am afraid by telling your mesh users that you switched to an IP based
>> > mesh protocol you lure them into a false sense of 'non-traceability'. It
>> > kind of feels like a debate we had almost a decade ago when WiFi came to
>> > the masses. People had the feeling to use WiFi they had to learn what this
>> > cumbersome SSL thing is. Because WiFi is insecure as the waves leave your
>> > home and the neighbors can eavesdrop on you .. Countless hours had to be
>> > invested into educating our mesh users that SSL always is a good thing.
>> >
>> > Personally, I rotate my MAC address on a daily basis. That works not only
>> > with
>> > batman-adv but everywhere. Obviously, that won't help you against the
>> > countless ad networks, Google, Facebook, etc, etc
>>
>> I hear you.
>>
>> The biggest danger I feel is that associating to one of our access points
>> once with your phone would then allow anyone, even a technically
>> semi-literate stalker, to track you and find out where you live and work
>> using something we built. My fear would be that someone could use this data
>> to put up a public web app where any idiot can put in a MAC address and
>> instantly get a nice map of movement activity.
>
> I think we are at a point in our discussion where we just repeat what was
> already said. batman-adv certainly can be improved to provide better anonymity
> by default. Even with such a mechanism in place people can be tracked in your
> network (with IP mesh routing or without). Tracking without connecting to your
> network is even easier than that.
>
> Therefore, I favor education over a technology arms race. The latter you won't
> be able to win as you eventually will have to battle people's desire for the
> 'least effort route'.
>
>
>> Hopefully these tracking services you mention are not quite so easy to
>> access and use for something like this by an unlicensed individual (but
>> maybe they are?) though even if others are making these types of services
>> available, I'd rather not make it easy for them to use our network for their
>> nefarious purposes.
>
> These systems are built for absolutely non-technical users. For those who
> prefer videos over boring texts:
> https://www.youtube.com/watch?v=hCGiGaRp7-U
>
> I recommend to pay close attention to the section they call 'loyal customers'
> (around 1:30min into the video). Note that this was just the first search
> result that came up. There are many more.
>
> Cheers,
> Marek



-- 
http://mitar.tnode.com/
https://twitter.com/mitar_m
