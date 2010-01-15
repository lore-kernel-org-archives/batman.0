Return-Path: <ecforusers@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20100114200359.GB24649@lunn.ch>
References: <5522db2e1001140540p7af82ba9gd52b375d54a2441d@mail.gmail.com>
	<20100114200359.GB24649@lunn.ch>
Date: Thu, 14 Jan 2010 21:32:46 -0500
Message-ID: <5522db2e1001141832q5b98ffa4o1d12f8ecfa0bcc08@mail.gmail.com>
From: ecfu <ecforusers@gmail.com>
Content-Type: multipart/alternative; boundary=0016e64603eaa822d9047d2ad1f0
Subject: Re: [B.A.T.M.A.N.] network down timeout
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

--0016e64603eaa822d9047d2ad1f0
Content-Type: text/plain; charset=ISO-8859-1

Is there something special about this number?

If I need a faster response say 1 minute or even 30 seconds, is that a bad
idea?



On Thu, Jan 14, 2010 at 3:03 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Jan 14, 2010 at 08:40:25AM -0500, ecfu wrote:
> > Is there a configuration setting for batman-adv to timeout on a
> connection?
> >  i.e. if I lose a node in my network, I noticed it took a long time for
> that
> > node to leave the originators list.  What is this based on or in other
> words
> > when does batman-adv declare the lost originator gone?
>
> An originator is purged when it has not been heard from in
>
> #define PURGE_TIMEOUT 200000      /* purge originators after time in ms if
> no
>                                   * valid packet comes in.
>
> is 200s = 3.3 minutes.
>
>   Andrew
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.org
> https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n
>

--0016e64603eaa822d9047d2ad1f0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Is there something special about this number? =A0<div><br></div><div>If I n=
eed a faster response say 1 minute or even 30 seconds, is that a bad idea?<=
/div><div><br></div><div><br><br><div class=3D"gmail_quote">On Thu, Jan 14,=
 2010 at 3:03 PM, Andrew Lunn <span dir=3D"ltr">&lt;<a href=3D"mailto:andre=
w@lunn.ch">andrew@lunn.ch</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">On Thu, J=
an 14, 2010 at 08:40:25AM -0500, ecfu wrote:<br>
&gt; Is there a configuration setting for batman-adv to timeout on a connec=
tion?<br>
&gt; =A0i.e. if I lose a node in my network, I noticed it took a long time =
for that<br>
&gt; node to leave the originators list. =A0What is this based on or in oth=
er words<br>
&gt; when does batman-adv declare the lost originator gone?<br>
<br>
</div></div>An originator is purged when it has not been heard from in<br>
<br>
#define PURGE_TIMEOUT 200000 =A0 =A0 =A0/* purge originators after time in =
ms if no<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * vali=
d packet comes in.<br>
<br>
is 200s =3D 3.3 minutes.<br>
<br>
 =A0 Andrew<br>
_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.org">B.A.T.M.A.N@lists.open-m=
esh.org</a><br>
<a href=3D"https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n</a><br>
</blockquote></div><br></div>

--0016e64603eaa822d9047d2ad1f0--
