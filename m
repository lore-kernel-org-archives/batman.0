Return-Path: <ordex@ritirata.org>
Date: Fri, 21 May 2010 20:45:33 +0200
From: Antonio Quartulli <ordex@ritirata.org>
Message-ID: <20100521183148.GA17533@ritirata.org>
References: <20100517072041.GA23674@ritirata.org>
	<1274232349-10414-1-git-send-email-linus.luessing@web.de>
	<20100521082127.GA7802@ritirata.org>
	<175836929.848340.1274437048158.JavaMail.fmail@mwmweb020>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <175836929.848340.1274437048158.JavaMail.fmail@mwmweb020>
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

On ven, mag 21, 2010 at 12:17:28 +0200, Linus L=FCssing wrote:
> >
> >I gave a try to this patch, but I see something strange.
> >After enabling a simple ebtables rule:
> >ebtables -A INPUT -s MAC -j DROP
> >and
> >ebtables -A FORWARD -s MAC -j DROP (to be sure..)
> >
> >I saw that batman ping was timing out, while the "originator list" (shown
> >with batctl o) is still filled with the other node entry...
>=20
> Hi Antonio,
>=20
> thanks for trying the patch! In my case, it worked, I tried it with
> ebtables -I INPUT -s MAC -j DROP or
> ebtables -I INPUT -p 0x4305 -j DROP
> (and the same for -I OUTPUT)
>=20
> batctl td reported, that it's not receiving any batman packets anymore an=
d also
> the originator table was empty after a couple of minutes.
>=20
> Hmm, and also that batping is timing out for you seems to indicate that i=
t should work
> on your side. Could you check with batctl td too? How long have you been =
waiting for
> the originator table to clear? (dead nodes are not being cleared immediat=
ely in batman,
> as they don't harm the routing decisions and we still need the last measu=
rements in case they
> might get alive again)
>=20
> Cheers, Linus

Hi Linus,
	I thought that the dead node should be pushed away after a
while, not 3 minutes. So that was my mistake...indeed everything was workin=
g correctly!

I tried it again five minutes ago, and everything went as I expected!

Thanks very much!

Regards

P.S. batctl td was not so usefull since I have to point it to wlan0..and
obviously I can see all the packets there.

--=20
Antonio Quartulli

Ognuno di noi, da solo, non vale nulla=20
Ernesto "Che" Guevara
