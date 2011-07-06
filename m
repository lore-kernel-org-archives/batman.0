Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJA-1Lg=T_xkp4vdopQ2fscQgSnB9pLiThTBcmf=y_HocYKm=w@mail.gmail.com>
References: <CAJA-1Lg=T_xkp4vdopQ2fscQgSnB9pLiThTBcmf=y_HocYKm=w@mail.gmail.com>
Date: Wed, 6 Jul 2011 10:58:38 +0200
Message-ID: <CAG7VhQRdp3jLMKFotkzGMUVDr75-iWvA=oj6qKT8a+awfLkbMQ@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] make batctl 2011.1.0
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

I think the warnings are not a big problem.

If you run batctl what is the error message reported?

2011/7/6 Max Ip <ipmax2011@googlemail.com>:
> Hi all,
>
> I downloaded the batctl package 2011.1.0 from the batman website. I
> installed it using command make all.
>
> It generates the following two warnings:
>
> functions.c: In function =91read_file=92:
> functions.c:153:9: warning: ignoring return value of =91system=92,
> declared with attribute warn_unused_result
>
> and
>
> bisect.c: In function =91bisect=92:
> bisect.c:197:9: warning: =91j=92 may be used uninitialized in this functi=
on
>
> I just ignored the warnings. But, I wasn't able to run the batctl
> command neither could I see the manual page for batctl.
>
> I couldn't figure out what exactly could be the issue though I have
> been going through the codes and the makefile.
>
> Do anyone of you have an idea if my way of installation is correct?
>
> Thanking you.
>
> Max
>



--=20
Daniele Furlan
