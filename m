Return-Path: <linus.luessing@web.de>
Date: Fri, 21 May 2010 12:17:28 +0200 (CEST)
From: =?ISO-8859-15?Q?Linus_L=FCssing?= <linus.luessing@web.de>
Message-ID: <175836929.848340.1274437048158.JavaMail.fmail@mwmweb020>
References: <20100517072041.GA23674@ritirata.org>
	<1274232349-10414-1-git-send-email-linus.luessing@web.de>,
	<20100521082127.GA7802@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20100521082127.GA7802@ritirata.org>
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

>
>I gave a try to this patch, but I see something strange.
>After enabling a simple ebtables rule:
>ebtables -A INPUT -s MAC -j DROP
>and
>ebtables -A FORWARD -s MAC -j DROP (to be sure..)
>
>I saw that batman ping was timing out, while the "originator list" (shown
>with batctl o) is still filled with the other node entry...

Hi Antonio,

thanks for trying the patch! In my case, it worked, I tried it with
ebtables -I INPUT -s MAC -j DROP or
ebtables -I INPUT -p 0x4305 -j DROP
(and the same for -I OUTPUT)

batctl td reported, that it's not receiving any batman packets anymore and =
also
the originator table was empty after a couple of minutes.

Hmm, and also that batping is timing out for you seems to indicate that it =
should work
on your side. Could you check with batctl td too? How long have you been wa=
iting for
the originator table to clear? (dead nodes are not being cleared immediatel=
y in batman,
as they don't harm the routing decisions and we still need the last measure=
ments in case they
might get alive again)

Cheers, Linus
___________________________________________________________
NEU: WEB.DE DSL f=C3=BCr 19,99 EUR/mtl. und ohne Mindest-Laufzeit!
http://produkte.web.de/go/02/
