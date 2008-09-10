Message-ID: <8c906fa50809101400i4c30cff5geb16998e11d7c607@mail.gmail.com>
Date: Wed, 10 Sep 2008 18:00:59 -0300
From: "Gustavo Lindberg" <gus.lindberg@gmail.com>
Subject: Re: [B.A.T.M.A.N.] BATGAT
In-Reply-To: <20080910193801.GA10777@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8798_6750196.1221080459840"
References: <8c906fa50809100941y79bc2011nd234780ad7b5cd0@mail.gmail.com>
	<20080910193801.GA10777@pandem0nium>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

------=_Part_8798_6750196.1221080459840
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your answer.
I am experimenting very frustrating issues with batgat. Currently i am
testing the last trunk of kamikaze on ubiquity NS2. Batmand dies quietly
with batgat loaded. I will prove the last kamikaze on two NS2 without batgat
and inform the bug  if this error happen again.
Regards.
Gustavo.

2008/9/10 Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

> Hello Gustavo,
>
> batman works fine without the batgat kernel module. The batgat kernel
> module will only accelerate the gateway functionality, but batman can do
> without it. If you don't want it, don't insmod batgat. Batman will detect
> it
> at runtime, no need to recompile.
> The gateway should still work, if it doesn't then you probably found
> a bug.
>
> best regards,
>        Simon
>
> On Wed, Sep 10, 2008 at 01:41:38PM -0300, Gustavo Lindberg wrote:
> > Hi all !
> >
> > How to disable batgat ? It necessary recompiling batmand or is enough to
> > unload batgat module ?
> > I do that and batmand load but the gw never more assign ip trough the
> tunnel
> > iface....
> >
> > TIA
>
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
>
> iD8DBQFIyCIZrzg/fFk7axYRAmBPAJ0VqKfKf2fajACbdC5q8Vcx4OCpdwCg9Urm
> XyHa09aZEEq1ghIW3LceQqM=
> =Adqg
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>

------=_Part_8798_6750196.1221080459840
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Thanks for your answer. <br>I am experimenting very frustrating issues with batgat. Currently i am testing the last trunk of kamikaze on ubiquity NS2. Batmand dies quietly with batgat loaded. I will prove the last kamikaze on two NS2 without batgat and inform the bug&nbsp; if this error happen again.<br>
Regards.<br>Gustavo.<br><br><div class="gmail_quote">2008/9/10 Simon Wunderlich <span dir="ltr">&lt;<a href="mailto:simon.wunderlich@s2003.tu-chemnitz.de">simon.wunderlich@s2003.tu-chemnitz.de</a>&gt;</span><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello Gustavo,<br>
<br>
batman works fine without the batgat kernel module. The batgat kernel<br>
module will only accelerate the gateway functionality, but batman can do<br>
without it. If you don&#39;t want it, don&#39;t insmod batgat. Batman will detect it<br>
at runtime, no need to recompile.<br>
The gateway should still work, if it doesn&#39;t then you probably found<br>
a bug.<br>
<br>
best regards,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;Simon<br>
<div><div></div><div class="Wj3C7c"><br>
On Wed, Sep 10, 2008 at 01:41:38PM -0300, Gustavo Lindberg wrote:<br>
&gt; Hi all !<br>
&gt;<br>
&gt; How to disable batgat ? It necessary recompiling batmand or is enough to<br>
&gt; unload batgat module ?<br>
&gt; I do that and batmand load but the gw never more assign ip trough the tunnel<br>
&gt; iface....<br>
&gt;<br>
&gt; TIA<br>
<br>
</div></div>&gt; _______________________________________________<br>
&gt; B.A.T.M.A.N mailing list<br>
&gt; <a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
&gt; <a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
<br>
<br>-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.6 (GNU/Linux)<br>
<br>
iD8DBQFIyCIZrzg/fFk7axYRAmBPAJ0VqKfKf2fajACbdC5q8Vcx4OCpdwCg9Urm<br>
XyHa09aZEEq1ghIW3LceQqM=<br>
=Adqg<br>
-----END PGP SIGNATURE-----<br>
<br>_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
<br></blockquote></div><br></div>

------=_Part_8798_6750196.1221080459840--
