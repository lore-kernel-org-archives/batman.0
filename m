Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180527220816.GB13283@otheros>
References: <CAA_JP8XmfiYWFe71iavwSRT40MkaXcrz=k-cvvQQxD-7JLRb-Q@mail.gmail.com>
 <20180527220816.GB13283@otheros>
From: dan <dandenson@gmail.com>
Date: Sun, 27 May 2018 20:12:32 -0600
Message-ID: <CAA_JP8UVRhjxPSmx801+a7hq+nEbq0n7M9Lrdgc7r-10WmN=5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] where is batman-adv on multicast? specifically
 IPTV
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I'm not brave enough to test :)  I'm still evaluating batman-adv for
this deployment model and haven't even setup real hardware to test
yet.  I think that I can live with a separate VLAN and PIM multicast
routing if need be plus I'd probably be running whichever batman-adv
version is in-kernel on ubuntu so that upgrades are more seamless so I
would imagine quite a long time until these patches make it in.

On Sun, May 27, 2018 at 4:08 PM, Linus L=C3=BCssing <linus.luessing@c0d3.bl=
ue> wrote:
> Hi Dan,
>
> On Sat, May 26, 2018 at 07:43:03PM -0600, dan wrote:
> [...]
>> I see that if there is just one listener, then it basically becomes a
>> unicast stream.  But what if I have multiple sites (lets say 10) and
>> at 2 sites there are 1 listener each.
>>
>> does this mean that all 10 sites will get the broadcast? or that just
>> the 2 sites that have listeners will get the broadcast?
>
> Currently, if 2 (or more) batman-adv nodes have 1 listener each (for
> the same multicast group) then the packet will be flooded. Meaning all
> nodes in the mesh will receive it.
>
> I currently have two more patches for batman-adv open for further
> testing to allow not just multicast-to-unicast conversion to a
> single destination, but a multicast-to-multi-unicast conversion, too.
> They are currently burried in here:
>
> https://github.com/freifunk-gluon/gluon/pull/1357
>
> If you are interested and brave enough to try them then let me
> know how that goes for you :-).
>
> Regards, Linus
