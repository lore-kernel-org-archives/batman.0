Return-Path: <hrogge@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <006301ca60f7$991ca3a0$f90a8282@sharlyn>
References: <871vkbzd6s.fsf@trurl.pps.jussieu.fr>
	<006301ca60f7$991ca3a0$f90a8282@sharlyn>
Date: Mon, 9 Nov 2009 10:07:27 +0100
Message-ID: <87eacd830911090107k394e7f8fm5c6b28d20f2f3e0d@mail.gmail.com>
From: Henning Rogge <hrogge@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [Babel-users] A peer-reviewed assessment of OLSR,
	BATMAN and 	Babel
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "Dr. Mehran Abolhasan" <mehrana@uow.edu.au>
Cc: olsr-users@lists.olsr.org, b.a.t.m.a.n@lists.open-mesh.net, Brett Hegelstein <brett.hagelstein@gmail.com>, justin.lipman@gmail.com, Chun-Ping Wang <jerryw@uow.edu.au>, Juliusz Chroboczek <jch@pps.jussieu.fr>, babel-users@lists.alioth.debian.org, Brett Hagelstein <bretth@uow.edu.au>

On Mon, Nov 9, 2009 at 05:46, Dr. Mehran Abolhasan <mehrana@uow.edu.au> wro=
te:
> Hi All,
>
> Many Thanks for all your comments. Just a couple of point of clarificatio=
n.
>
> 1. The aim of this paper was to study all the protocols in their default
> settings. We did not
> switch off ETX with olsr (note we used the olsr version from olsr.org). I=
n
> fact the link quality metric was left to 2 by default. We are well aware
> that ETX provide more stable routes than hop count.
The problem is that the "RFC" mode of olsr.org is not well tested, the
MPR algorithm is broken in 0.5.6 and RFC conform OLSR networks do not
work in practice for non-trivial networks. I'm surprised that you got
results this good.

> 2. In terms of looking at performance using different parameters, we will=
 be
> doing this in our future studies.
> Also, note that the conference papers were limited to 4 pages only.
If you plan to start your tests, feel free to contact the olsr mailing
lists for some suggestions for parameters. ;)

> 3. In terms of overheads, given that this was a small scale indoor test-b=
ed,
> we believed the amount of overhead introduced into the network is not
> signficant enough to adversely affect the network. So we did not look int=
o
> overheads for this paper, however we would do this for larger test-beds.
>
> 4. We previously ran OLSR using various different outdoor and indoor
> test-beds and at the time we were doing the experimentations BATMAN and
> BABEL were more stable.
Noone surprised (without ETX).

Henning Rogge

--=20
"Wo k=E4men wir hin, wenn alle sagten, wo k=E4mem wir hin, und niemand
ginge, um einmal zu schauen, wohin man k=E4me, wenn man ginge." (Kurt
Marti)
