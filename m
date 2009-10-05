Return-Path: <a.mailevent@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200910051849.49493.lindner_marek@yahoo.de>
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910051849.49493.lindner_marek@yahoo.de>
Date: Mon, 5 Oct 2009 14:12:20 +0200
Message-ID: <d9bba8670910050512m41441532u5d28c6c2a476d152@mail.gmail.com>
From: a <a.mailevent@gmail.com>
Content-Type: multipart/alternative; boundary=00148531b766840b6404752f06fd
Subject: Re: [B.A.T.M.A.N.] batman-adv and TCP problem
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--00148531b766840b6404752f06fd
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

No,

it is not a MTU problem. TCP packet are small (I'm sending only few
characters) and big packet size (1400 byte) ping works



2009/10/5 Marek Lindner <lindner_marek@yahoo.de>

>
> Hi,
>
> > The IP connectivity is ok and I can ping from B1 to EX and vice versa.
> > I have installed a tcp echo server on the three nodes and it works
> between
> > B1-GW and GW-EX, but I have problem with B1-EX test.
> > B1 correctly receives data from EX, but EX application doesn=92t receiv=
e
> data
> > from B1. I repeated the test without batman and everything works fine.
> > Do you have any suggestion?
>
> could be a MTU problem. Does a big packet size ping work ?
>
> Regards,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

--00148531b766840b6404752f06fd
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

No,<br><br>it is not a MTU problem. TCP packet are small (I&#39;m sending o=
nly few characters) and big packet size (1400 byte) ping works<br><br><br><=
br><div class=3D"gmail_quote">2009/10/5 Marek Lindner <span dir=3D"ltr">&lt=
;<a href=3D"mailto:lindner_marek@yahoo.de">lindner_marek@yahoo.de</a>&gt;</=
span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
Hi,<br>
<div class=3D"im"><br>
&gt; The IP connectivity is ok and I can ping from B1 to EX and vice versa.=
<br>
&gt; I have installed a tcp echo server on the three nodes and it works bet=
ween<br>
&gt; B1-GW and GW-EX, but I have problem with B1-EX test.<br>
&gt; B1 correctly receives data from EX, but EX application doesn=92t recei=
ve data<br>
&gt; from B1. I repeated the test without batman and everything works fine.=
<br>
&gt; Do you have any suggestion?<br>
<br>
</div>could be a MTU problem. Does a big packet size ping work ?<br>
<br>
Regards,<br>
Marek<br>
_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net">B.A.T.M.A.N@lists.open-m=
esh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</blockquote></div><br>

--00148531b766840b6404752f06fd--
