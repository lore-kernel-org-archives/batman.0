Return-Path: <jerryw@uow.edu.au>
From: Chun-Ping Wang <jerryw@uow.edu.au>
Date: Tue, 10 Nov 2009 00:00:24 +1100
Message-ID: <BD0FE81CE135624188025441BB9CB99138F599F20A@EXCMS01.ad.uow.edu.au>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [Babel-users] A peer-reviewed assessment of OLSR,
 BATMAN and Babel
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
To: Henning Rogge <hrogge@googlemail.com>, Mehran Abolhasan <mehrana@uow.edu.au>
Cc: "olsr-users@lists.olsr.org" <olsr-users@lists.olsr.org>, "b.a.t.m.a.n@lists.open-mesh.net" <b.a.t.m.a.n@lists.open-mesh.net>, Brett Hegelstein <brett.hagelstein@gmail.com>, "justin.lipman@gmail.com" <justin.lipman@gmail.com>, Juliusz Chroboczek <jch@pps.jussieu.fr>, Brett, "babel-users@lists.alioth.debian.org" <babel-users@lists.alioth.debian.org>, Hagelstein <bretth@uow.edu.au>

Hi all,=20

Many thanks for all your feedbacks.  It will definately help us to improve =
our work.
However, I think there is quite a bit of confusions at very beginning.  So =
I would=20
like to make some clarifications for this paper.

As it has been mentioned earlier, this paper was to study all the protocols=
 in
their default setting.  In term of "default setting" for OLSR, we used orig=
inal=20
config file shipped in olsr v0.5.5.  As far as I know, this config file is =
based on=20
the LQ mode of OLSR  (i.e. olsrd.conf.default.lq ).  So, correct me if I am=
 wrong,=20
we have been using OLSR with ETX to begin with. We only modified the HELLO =
and
TC interval to improve static node performance. The results shown in our pa=
per is=20
actually the performance of OLSR with ETX. =20

You may also aware the protocols that we used are already out-dated.  This =
is because=20
this work was done back in 2008.  We are more than happy to undergo another=
 study=20
with more recent protocols.

Regards,=20
Jerry









________________________________________
From: Henning Rogge [hrogge@googlemail.com]
Sent: Monday, November 09, 2009 8:07 PM
To: Mehran Abolhasan
Cc: Juliusz Chroboczek; babel-users@lists.alioth.debian.org; olsr-users@lis=
ts.olsr.org; b.a.t.m.a.n@lists.open-mesh.net; Brett Hagelstein; justin.lipm=
an@gmail.com; Brett Hegelstein; Chun-Ping Wang
Subject: Re: [Babel-users] A peer-reviewed assessment of OLSR, BATMAN and  =
     Babel

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

--
"Wo k=E4men wir hin, wenn alle sagten, wo k=E4mem wir hin, und niemand
ginge, um einmal zu schauen, wohin man k=E4me, wenn man ginge." (Kurt
Marti)
