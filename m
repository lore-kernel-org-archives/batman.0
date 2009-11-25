Return-Path: <francesco.cappuccio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200910292104.13536.lindner_marek@yahoo.de>
References: <45f642440910260327u6eb01bc3nf468cc092fa8700@mail.gmail.com> 
	<200910292104.13536.lindner_marek@yahoo.de>
From: Francesco <francesco.cappuccio@gmail.com>
Date: Wed, 25 Nov 2009 11:26:58 +0100
Message-ID: <45f642440911250226s1ea87735ja8639d433ba7c942@mail.gmail.com>
Content-Type: multipart/alternative; boundary=001636164063cb836104792f8081
Subject: Re: [B.A.T.M.A.N.] batman-adv metric and next-hop choice
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

--001636164063cb836104792f8081
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I was just looking for a name: the name of the metric (is that ETX?) that is
used in batman-adv.
Actually i did not find any useful info in old messages on the list.

Thanks.

On Thu, Oct 29, 2009 at 2:04 PM, Marek Lindner <lindner_marek@yahoo.de>wrote:

>
> Hi,
>
> > I am experimenting some path hopping in my tests using batman-adv.
> > Was wondering if and where metric information are shared among batman
> nodes
> > (again, with batman-adv) as I did not find any useful infos sniffing
> >  packets with wireshark patched.
> >
> > The command batctl l shows (with log level 8)
> > But no info about actual metric when a route is changed.
>
> I'm not entirely sure what you expect to find or what is missing. If you
> want
> to understand the batman protocol you might want to start with some of our
> recorded talks. If you want to use wireshark to analyze the traffic be sure
> to
> have the batman dissectors installed (or use batctl td). If you want
> routing
> debug information from the module use debug level 12 (batman [4] + routes
> [8]).
>
> Hope that helps,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>



-- 
Francesco Cappuccio

--001636164063cb836104792f8081
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I was just looking for a name: the name of the metric (is that E=
TX?) that is used in batman-adv.<br>Actually i did not find any useful info=
 in old messages on the list.<br><br>Thanks.<br><br><div class=3D"gmail_quo=
te">

On Thu, Oct 29, 2009 at 2:04 PM, Marek Lindner <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:lindner_marek@yahoo.de">lindner_marek@yahoo.de</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br>
Hi,<br>
<div class=3D"im"><br>
&gt; I am experimenting some path hopping in my tests using batman-adv.<br>
&gt; Was wondering if and where metric information are shared among batman =
nodes<br>
&gt; (again, with batman-adv) as I did not find any useful infos sniffing<b=
r>
&gt; =A0packets with wireshark patched.<br>
&gt;<br>
&gt; The command batctl l shows (with log level 8)<br>
</div><div class=3D"im">&gt; But no info about actual metric when a route i=
s changed.<br>
<br>
</div>I&#39;m not entirely sure what you expect to find or what is missing.=
 If you want<br>
to understand the batman protocol you might want to start with some of our<=
br>
recorded talks. If you want to use wireshark to analyze the traffic be sure=
 to<br>
have the batman dissectors installed (or use batctl td). If you want routin=
g<br>
debug information from the module use debug level 12 (batman [4] + routes<b=
r>
[8]).<br>
<br>
Hope that helps,<br>
Marek<br>
_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net">B.A.T.M.A.N@lists.open-m=
esh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Francesco Cappuccio<br>=
<br>

--001636164063cb836104792f8081--
