Return-Path: <markbirss@gmail.com>
MIME-Version: 1.0
References: <CADg1mwL07UQqmUctQexAFCgFMrXBiF=rB1EdRqb3agveSEkckQ@mail.gmail.com>
 <1986026.lAXmxmQttu@sven-edge> <CADg1mwLTTq-wjxvPvkTBb2J9qtSs_+BxhNsSW0DGTeo6QiWXbA@mail.gmail.com>
 <12351834.0eS7jaRIYG@bentobox>
In-Reply-To: <12351834.0eS7jaRIYG@bentobox>
From: Mark Birss <markbirss@gmail.com>
Date: Thu, 25 Jun 2020 13:56:18 +0200
Message-ID: <CADg1mwLt_cw7frwgYC6hyjQ4wO35UA0GNLw=MERAgUjNvM4SjQ@mail.gmail.com>
Subject: Re: BATMAN-adv Debug options
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
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Sorry about the reply not including the mailing address, i  made error
clicking wrong reply icon

> As for originator and neighbours this can also be checked by batctl or1
> proc file system.

No i meant /sys/kernel/debug as I run recent Batman adv 2020-1

Thank you for pointing out the correct wiki links, I could not find them

I will create another topic for some other questions,

Thank you


On Thu, Jun 25, 2020 at 1:44 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> [please never contact me privately about batman-adv without a really good
>  reason. Cc at least the mailing list]
>
> On Thursday, 25 June 2020 13:12:34 CEST Mark Birss wrote:
> > "Is the lower layer working or did the lower layer break? Can be
> > tested easily with multicast/broadcast and unicast pings on the lower
> > device."
> >
> > How to do this ?
>
> ping/ping6.
>
> * unicast: just ping as normal the lower device (not bat0) IPv4 address or
>   (link local) IPv6 address
> * multicast: just send from both sides an multicast ping. For example
>   ff02::1%wlan0 and check if the remote (not your own device) responds with a
>   unicast reply
>
> > As for originator and neighbours this can also be checked by batctl or
> > proc file system.
>
> proc? If you have batman-adv entries in proc then you should definitely
> upgrade. This was removed in 2010.
>
> Should this have been a question about where to find the originators and
> neighbors table? And you can see this via "batctl meshif bat0 originators"
> and "batctl meshif bat0 neighbors". The "meshif bat0" has to replaced with
> "-m bat0" on older batctl versions.
>
> > Another question is there a breakdown of the meaning of the messages for
> >
> > $ cat /sys/kernel/debug/batman_adv/bat0/log
> >
> > The additional debug output is by default disabled. It can be enabled
> > during run time. Following log_levels are defined:
>
> No idea what you want here. The help text already says what each message type
> is about. If you don't know what a specific feature is then please check the
> wiki [1].
>
> > and what is the Flags here
> >
> > root@LiMe-a376eb:~# batctl tl
> > [B.A.T.M.A.N. adv 2020.1-openwrt-2, MainIF/MAC:
> > dummy0/aa:84:86:a3:76:eb (bat0/72:8b:cf:a4:00:77 BATMAN_IV), TTVN: 4]
> > Client             VID Flags    Last seen (CRC       )
> > 72:8b:cf:a4:00:77   -1 [.P....]   0.000   (0x1c349131)
> > 50:3e:aa:06:6f:4d   -1 [......]   0.280   (0x1c349131)
> > 72:8b:cf:a4:00:77    0 [.P....]   0.000   (0x9243e316)
> > cc:2d:e0:47:b3:56   -1 [......]   0.980   (0x1c349131)
> > 72:8b:cf:a4:00:77    1 [.P....]   0.000   (0xdb7f9e31)
>
> The flags here are
>
> * 'R' BATADV_TT_CLIENT_ROAM
> * 'N' BATADV_TT_CLIENT_NEW
> * 'X' BATADV_TT_CLIENT_PENDING
> * 'W' BATADV_TT_CLIENT_WIFI
> * 'I' BATADV_TT_CLIENT_ISOLA
> * 'P' BATADV_TT_CLIENT_NOPURGE
>
> And they are documented in the wiki [2]
>
> Kind regards,
>         Sven
>
> [1] https://www.open-mesh.org/projects/batman-adv/wiki/Protocol_information
> [2] https://www.open-mesh.org/projects/batman-adv/wiki/TT-Flags
