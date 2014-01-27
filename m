Return-Path: <crockabiscuit@gmail.com>
MIME-Version: 1.0
In-Reply-To: <52E38150.3010903@meshcoding.com>
References: <CAL0=0H2MA7WVq7wkEBsatEOV1S-RevY2KXSHeAEgHsLdtBddRA@mail.gmail.com>
 <20140124164713.7e0fceadfe444297f4fd7350@gmx.net>
 <CAL0=0H2-u+NQhXNiYc=EuZkY9ZsK5dc7o1ka3_tVmoovJbpopA@mail.gmail.com>
 <52E38150.3010903@meshcoding.com>
Date: Mon, 27 Jan 2014 12:58:30 +0900
Message-ID: <CAL0=0H1KZKcAfW=ULgB+n=QCtbTjxkeRZR=QqMUVxjX-3aAZdQ@mail.gmail.com>
From: crocket <crockabiscuit@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Is BATMAN alone enough to create wireless mesh
	networks?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

According to your explanation, batman-adv can't enable my smartphone
to automatically discover nearby smartphones and connect with them.
802.11s, on the other hand, can do it if it's combined with automatic
IP address allocation scheme.

Did I miss something?

On Sat, Jan 25, 2014 at 6:18 PM, Antonio Quartulli
<antonio@meshcoding.com> wrote:
> On 25/01/14 01:29, crocket wrote:
>> So is BATMAN a full-fledged alternative to 802.11s?
>
> No.
>
> 802.11s is implemented at the datalink layer (actually inside the
> mac80211 kernel module) and provides you a way to establish a connection
> with other peers.
>
> With batman-adv you first need to establish the connection with the
> other nodes by means of adhoc or infrastructure mode (or any other kind
> of connection that creates a virtual Ethernet interface).
>
> Therefore when using batman-adv (or batmand or bmx6) you first need to
> establish a datalink layer connection and then you can use the protocol
> on top of it.
>
> In the case of 802.11s the datalink connection is handled by itself
> directly.
>
> I would say that it is a small difference, but then the sentence would be=
:
>
> "{batman-adv + adhoc mode} is an alternative to 802.11s"
>
> batman-adv took this approach because we believe that there is no need
> to re-implement something that we already have (e.g. adhoc mode) and at
> the same time this gives batman-adv more flexibility (it can be used
> also on top of wired Ethernet interfaces).
>
>
> Cheers,
>
>>
>> On Sat, Jan 25, 2014 at 12:47 AM, Elektra <onelektra@gmx.net> wrote:
>>> Hi  =96
>>>
>>> B.A.T.M.A.N. refers to a routing algorithm.
>>>
>>> There are implementations of the routing algorithom at OSI layer 2 (bat=
man-advanced) and layer 3 (batmand, bmx6)
>>>
>>> You can use all 3 variants for Android to build wireless mesh networks =
and people are actually doing so (Serval)
>>>
>>> Integrating batman-advanced into Android requires you to not only have =
root, but also provide a batman-adv kernel module that fits the kernel of t=
he device. This is fine, if someone like Google or Cyanogenmod would enclud=
e batman-adv in their Android builds, which would merely require to enable =
building the module in the kernel build process, as it is shipped with the =
vanilla kernel sources.
>>>
>>> batmand and bmx6 are user space programs that merely alter the routing =
table. Integrating these is easier, since you merely require root permissio=
ns to run them.
>>>
>>> Cheers,
>>> Elektra
>>>
>>>
>>>> I've been searching for wireless mesh network solutions.
>>>> BATMAN showed up in google search results.
>>>>
>>>> I just wonder its role and the future of it, and I want to know if it
>>>> can power wireless mesh networks in android phones.
>>>
>>>
>>> --
>>> Elektra <onelektra@gmx.net>
>>
>
>
> --
> Antonio Quartulli
>
