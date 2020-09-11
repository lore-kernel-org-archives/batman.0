Return-Path: <abolletta@netter.io>
MIME-Version: 1.0
References: <CADJ1cURtCsWdy6rovfgb_XPhbsTc5epCv3yLgRCLcOVjfNSFdw@mail.gmail.com>
 <38142483.hY40ij8To5@ripper> <CADJ1cUQZ2YqFSVj=SNhPcC_sOjy+AkrEr=dQ=8T_0HegFou=Hw@mail.gmail.com>
 <4337705.76P5Ur0oAU@sven-edge>
In-Reply-To: <4337705.76P5Ur0oAU@sven-edge>
From: Alessandro Bolletta <abolletta@netter.io>
Date: Fri, 11 Sep 2020 16:42:52 +0200
Message-ID: <CADJ1cURdGjW=q91qFw8vCBs38pAPnBp9=e5qS1WgzV7w06Onwg@mail.gmail.com>
Subject: Re: Passing VID-aware ethernet frames on plain batX interfaces
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

Hi Sven,

I'm sorry for being not so clear in my statements. You can read my
last "refactored" mail, which is easier to understand:

Should I must only rely to the related 802.1q interface (eg. bat0.1)
or can I receive the whole traffic (untagged and tagged) from the
plain bat0 interface, just listening for the incoming traffic on it?

If the answer is the first choice, is it possible to have an approach
where I can receive coming from bat0 leveraging on a single interface
anyway? Could a linux bridge br0 on the top of bat0 interface make it
possible?

For example, if I connect an openvswitch port, configured as trunk port, to a
linux bridge br0 that enslaves bat0, could I expect to see the whole
traffic inside the batman-adv mesh network (so I mean, both tagged and
untagged traffic) also "flowing" inside the other OvS switch ports
that are attached to that vlans?
Moreover, just out of curiosity, is there also another known way to
get rid of the linux bridge br0 in order to get this done (attaching
the bat0 directly to the OvS switch, for example)?

Il giorno ven 11 set 2020 alle ore 16:02 Sven Eckelmann
<sven@narfation.org> ha scritto:
>
> On Friday, 11 September 2020 15:03:13 CEST Alessandro Bolletta wrote:
> > I see. Ok for transmission purposes, but what if I have to receive a tagged
> > frame?
>
> It should not have been send to the other node when there is no TT entry for
> this mac + VID from the receiver.
>
> > Should I only rely to the 8021q interface (eg. bat0.1) or receive the whole
> > traffic (untagged and tagged) from the plain bat0 interface?
>
> Hm?
>
> > If this is not feasible, is it possible to handle in someway this?
>
> Hm?
>
> > A linux
> > bridge on the top of bat0 interface could make it possible?
>
> No, the bridge must also enable the vlan for this bat0 interface.
>
> See also
> https://www.open-mesh.org/projects/batman-adv/wiki/Faq#BATMAN-Advanced-VLAN-questions
>
> Maybe Antonio wants to add more things to this discussion.
>
> Kind regards,
>         Sven
