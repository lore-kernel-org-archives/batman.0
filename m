Return-Path: <linus.luessing@web.de>
MIME-Version: 1.0
Message-ID: <trinity-27069899-f60c-4931-9e7b-7b5c426148dc-1362863034733@3capp-webde-bs30>
From: =?UTF-8?Q?=22Linus_L=C3=BCssing=22?= <linus.luessing@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 9 Mar 2013 22:03:54 +0100 (CET)
In-Reply-To: <201303090328.38621.lindner_marek@yahoo.de>
References: <1362764336-1591-1-git-send-email-linus.luessing@web.de>
 <1362764336-1591-2-git-send-email-linus.luessing@web.de>,
 <201303090328.38621.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: make number of
 broadcasts configurable per hardif
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
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>



> Gesendet: Freitag, 08. M=C3=A4rz 2013 um 20:28 Uhr
> Von: "Marek Lindne=
r" <lindner_marek@yahoo.de>
> An: "The list for a Better Approach To Mobile=
 Ad-hoc Networking" <b.a.t.m.a.n@lists.open-mesh.org>
> Betreff: Re: [B.A.T=
.M.A.N.] [PATCH 2/2] batman-adv: make number of broadcasts configurable per=
 hardif
>
> On Saturday, March 09, 2013 01:38:56 Linus L=C3=BCssing wrote:
=
> > From: Matthias Schiffer <mschiffer@universe-factory.net>
> >
> > In het=
erogenous networks, setting the number of broadcasts to differing
> > value=
s on different interfaces can be beneficial.
> >
> > E.g., on wireless inte=
rfaces with high packet loss a higher number of
> > broadcasts may be neces=
sary, whereas on low-bandwidth interfaces with
> > relatively high reliabli=
ly (such as VPN links over slow internet lines)
> > sending only a single p=
acket makes more sense to preserve bandwidth.
>
> In general, I like the id=
ea but the approach isn't the best. Can't we automate
> these settings inst=
ead of adding hundreds of little knobs nobody will
> understand ? Why not d=
etecting wifi interfaces as such and configure the
> broadcast value accord=
ingly ? The same goes for ethernet / vpns ?

I like the idea of automating =
things, especially if the automated mechanism isn't too complex and therefo=
re I like the idea of Matthias latest patch. And it helps us just as well f=
or our setup.

Nevertheless I'm still wondering, whether a manually configu=
rable number of broadcast might be of general interest, not only for debugg=
ing and not only for obscure scenarios.

Two things I could think of: A sce=
nario where people might use a higher multicast rate, where maybe a slightl=
y higher rebroadcast number might become necessary. Or for wifi longshots, =
which could have a very changing, whether dependant link quality (while gen=
eralizing a dynamic number of broadcast isn't that easy, it's very easy to =
write a script to check the current link-quality (or even the local whether=
 station :) ) towards the target which adjusts the number of rebroadcasts f=
rom this upper level.)

What do the others think? Or are such scenarios sti=
ll too obscure to justify the addition of such a sysctl parameters? Has any=
one on this ML maybe had a setup where s/he thought such a sysctl parameter=
 could be useful?

Cheers, Linus

>
> Cheers,
> Marek
>
