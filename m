Return-Path: <linus.luessing@web.de>
Date: Wed, 26 May 2010 01:56:18 +0200 (CEST)
From: =?ISO-8859-15?Q?Linus_L=FCssing?= <linus.luessing@web.de>
Message-ID: <1590021460.2964981.1274831778112.JavaMail.fmail@mwmweb020>
References: <20100517072041.GA23674@ritirata.org>
	<1274232349-10414-1-git-send-email-linus.luessing@web.de>
	<20100521082127.GA7802@ritirata.org>
	<175836929.848340.1274437048158.JavaMail.fmail@mwmweb020>,
	<20100521183148.GA17533@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20100521183148.GA17533@ritirata.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Adding netfilter-bridge hooks
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

>Hi Linus,
>=09I thought that the dead node should be pushed away after a
>while, not 3 minutes. So that was my mistake...indeed everything was worki=
ng correctly!
>
>I tried it again five minutes ago, and everything went as I expected!
>
>Thanks very much!

Great! You're welcome :). Feel free to share any interesting tests and resu=
lts with this=20
manual, explicit filtering capabilities.

>P.S. batctl td was not so usefull since I have to point it to wlan0..and
>obviously I can see all the packets there.
Usually I my self am using "batctl td" in conjunction with grep. For instan=
ce I'm having an interface which is nearly only
having batman-adv traffic. I'm also usuallly not deactivating IPv6 so I get=
 some annoying extra packets in batctl td -
but I can easily get rid of this with " batctl td | grep -v "Warning" ". '-=
v' is pretty handy to throw out undesired lines from
the output.

Cheers, Linus

>
>--=20
>Antonio Quartulli
>
>Ognuno di noi, da solo, non vale nulla=20
>Ernesto "Che" Guevara
___________________________________________________________
NEU: WEB.DE DSL f=C3=BCr 19,99 EUR/mtl. und ohne Mindest-Laufzeit!
http://produkte.web.de/go/02/
