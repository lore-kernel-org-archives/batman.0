Return-Path: <outbackdingo@gmail.com>
MIME-Version: 1.0
In-Reply-To: <SNT107-W364D4E251434A47E75E6C7A60A0@phx.gbl>
References: <200908051533.26117.lindner_marek@yahoo.de>
	<200908051931.10324.lindner_marek@yahoo.de>
	<SNT107-W263AEF87A1D0726A92E172A60D0@phx.gbl>
	<200908051953.56292.lindner_marek@yahoo.de>
	<SNT107-W49473D7262E3265C059DBCA60D0@phx.gbl>
	<5635aa0d0908050939me70c61cpbf633d90175bc5b9@mail.gmail.com>
	<SNT107-W364D4E251434A47E75E6C7A60A0@phx.gbl>
Date: Thu, 6 Aug 2009 10:07:10 -0400
Message-ID: <5635aa0d0908060707l73bf0412i9068a102b025ae80@mail.gmail.com>
From: Outback Dingo <outbackdingo@gmail.com>
Content-Type: multipart/alternative; boundary=0016361648d1c00915047079a223
Subject: Re: [B.A.T.M.A.N.] Routing help?
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

--0016361648d1c00915047079a223
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

well im not quite sure why you want to go 802.11S othere then adhoc with
batman,according to some docs S has a limitation on nodes/hops, unless its
been overcome. just go brcm2.4 on 8.09.1 and you can move forward

On 8/6/09, nick farrow <nickthefarrow@hotmail.com> wrote:
>
>  Hi Thanks for that,
>
> I originally wanted the 2.6 kernel for 802.11s, but then found build issues
> with 2.4 in K8.09 and it all got messy. So back to the trusted k7.09 with
> batman to the rescue. This thread I kicked off on the openwrt forum would
> seem to confirm no native brcm support in k8.09
> https://forum.openwrt.org/viewtopic.php?id=20620
>
> nick
>
> ------------------------------
> Date: Wed, 5 Aug 2009 12:39:34 -0400
> From: outbackdingo@gmail.com
> To: b.a.t.m.a.n@lists.open-mesh.net
> Subject: Re: [B.A.T.M.A.N.] Routing help?
>
> thats based on a 2.6 kernel build, OpenWRT still supports this board on 2.4
> kernel
> under 8.09 or 8.09.1, your so legacy is kinda funny. im sure you can find a
> 8.09.1 build for that unit
>
> On 8/5/09, *nick farrow* <nickthefarrow@hotmail.com> wrote:
>
> Hi Marek,
>
> Thanks for the update.
>
> I'm using 7.09 as last time I looked there was no support for the broadcom
> 802.11 in 8.09.
>
> nick
>
> > From: lindner_marek@yahoo.de
> > To: b.a.t.m.a.n@lists.open-mesh.net
> > Date: Wed, 5 Aug 2009 19:53:56 +0800
> > Subject: Re: [B.A.T.M.A.N.] Routing help?
> >
> > On Wednesday 05 August 2009 19:35:48 nick farrow wrote:
> > > Thanks very much - so advance sounds like the solution, I'll try this.
> Does
> > > the whole bridge work be default with this install or is there some
> special
> > > configuration?
> >
> > For your setup I suggest you kill the bridge between ethernet and wifi
> since
> > batman-adv will create a new brdige interface you should work with: bat0
> You
> > should bridge your ethernet with that device and the rest should work as
> you
> > want to have it.
> >
> >
> > > My ipkg does list batman adv but its an alpha, is this the still the
> best
> > > current version to use?
> >
> > You are using an old version of OpenWRT (7.09). There are updated batman
> > packages in 8.09.
> >
> > Regards,
> > Marek
> >
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@lists.open-mesh.net
> > https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
> ------------------------------
> Celebrate a decade of Messenger with free winks, emoticons, display pics,
> and more. Get Them Now <http://clk.atdmt.com/UKM/go/157562755/direct/01/>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>
>
> ------------------------------
> Windows Live Messenger: Thanks for 10 great years-enjoy free winks and
> emoticons. Get Them Now <http://clk.atdmt.com/UKM/go/157562755/direct/01/>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>

--0016361648d1c00915047079a223
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

well im not quite sure why you want to go 802.11S othere then adhoc with ba=
tman,according to some docs S has a limitation on nodes/hops, unless its be=
en overcome. just go brcm2.4 on 8.09.1 and you can move forward<br><br><div=
>
<span class=3D"gmail_quote">On 8/6/09, <b class=3D"gmail_sendername">nick f=
arrow</b> &lt;<a href=3D"mailto:nickthefarrow@hotmail.com">nickthefarrow@ho=
tmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">




<div>
Hi Thanks for that,<br>
=A0<br>
I originally wanted=A0the 2.6 kernel for 802.11s, but then found build issu=
es with 2.4=A0in K8.09 and it all got messy. So back to the trusted=A0k7.09=
 with batman to the rescue. This thread I kicked off on the openwrt forum w=
ould seem to confirm no=A0native=A0brcm support in k8.09 <a href=3D"https:/=
/forum.openwrt.org/viewtopic.php?id=3D20620" target=3D"_blank" onclick=3D"r=
eturn top.js.OpenExtLink(window,event,this)">https://forum.openwrt.org/view=
topic.php?id=3D20620</a><br>

=A0<br>
nick<br>=A0<br>
<hr>
Date: Wed, 5 Aug 2009 12:39:34 -0400<br>From: <a href=3D"mailto:outbackding=
o@gmail.com" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,=
event,this)">outbackdingo@gmail.com</a><span class=3D"q"><br>To: <a href=3D=
"mailto:b.a.t.m.a.n@lists.open-mesh.net" target=3D"_blank" onclick=3D"retur=
n top.js.OpenExtLink(window,event,this)">b.a.t.m.a.n@lists.open-mesh.net</a=
><br>
</span><div><span class=3D"e" id=3D"q_122eee0acc235d54_2">Subject: Re: [B.A=
.T.M.A.N.] Routing help?<br><br>thats based on a 2.6 kernel build, OpenWRT =
still supports this board on 2.4 kernel<br>under 8.09 or 8.09.1, your so le=
gacy is kinda funny. im sure you can find a 8.09.1 build for that unit<br>
<br>
<div><span>On 8/5/09, <b>nick farrow</b> &lt;<a href=3D"mailto:nickthefarro=
w@hotmail.com" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(windo=
w,event,this)">nickthefarrow@hotmail.com</a>&gt; wrote:</span>
<blockquote style=3D"padding-left: 1ex;">
<div>Hi Marek,<br><br>Thanks for the update.<br><br>I&#39;m using 7.09 as l=
ast time I looked there was no support for the broadcom 802.11 in 8.09.<spa=
n><br><br>nick<br><br>&gt; From: <a href=3D"mailto:lindner_marek@yahoo.de" =
target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">=
lindner_marek@yahoo.de</a><br>
&gt; To: <a href=3D"mailto:b.a.t.m.a.n@lists.open-mesh.net" target=3D"_blan=
k" onclick=3D"return top.js.OpenExtLink(window,event,this)">b.a.t.m.a.n@lis=
ts.open-mesh.net</a><br></span>&gt; Date: Wed, 5 Aug 2009 19:53:56 +0800<br=
>&gt; Subject: Re: [B.A.T.M.A.N.] Routing help?
<div><span><br>&gt; <br>&gt; On Wednesday 05 August 2009 19:35:48 nick farr=
ow wrote:<br>&gt; &gt; Thanks very much - so advance sounds like the soluti=
on, I&#39;ll try this. Does<br>&gt; &gt; the whole bridge work be default w=
ith this install or is there some special<br>
&gt; &gt; configuration?<br>&gt; <br>&gt; For your setup I suggest you kill=
 the bridge between ethernet and wifi since <br>&gt; batman-adv will create=
 a new brdige interface you should work with: bat0 You <br>&gt; should brid=
ge your ethernet with that device and the rest should work as you <br>
&gt; want to have it.<br>&gt; <br>&gt; <br>&gt; &gt; My ipkg does list batm=
an adv but its an alpha, is this the still the best<br>&gt; &gt; current ve=
rsion to use?<br>&gt; <br>&gt; You are using an old version of OpenWRT (7.0=
9). There are updated batman <br>
&gt; packages in 8.09.<br>&gt; <br>&gt; Regards,<br>&gt; Marek<br>&gt; <br>=
&gt; _______________________________________________<br>&gt; B.A.T.M.A.N ma=
iling list<br>&gt; <a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net" targe=
t=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">B.A.T=
.M.A.N@lists.open-mesh.net</a><br>
&gt; <a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=
=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">https:=
//lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br><br></span></div>
<hr>
Celebrate a decade of Messenger with free winks, emoticons, display pics, a=
nd more. <a href=3D"http://clk.atdmt.com/UKM/go/157562755/direct/01/" targe=
t=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">Get T=
hem Now</a></div>
<br>_______________________________________________<br>B.A.T.M.A.N mailing =
list<br><a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net" target=3D"_blank=
" onclick=3D"return top.js.OpenExtLink(window,event,this)">B.A.T.M.A.N@list=
s.open-mesh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">https://lis=
ts.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br><br></blockquote></div><br>=
<br>
</span></div><hr>Windows Live Messenger: Thanks for 10 great years-enjoy fr=
ee winks and emoticons. <a href=3D"http://clk.atdmt.com/UKM/go/157562755/di=
rect/01/" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,eve=
nt,this)">Get Them Now</a></div>

<br>_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"mailto:=
B.A.T.M.A.N@lists.open-mesh.net">B.A.T.M.A.N@lists.open-mesh.net</a><br>
<a onclick=3D"return top.js.OpenExtLink(window,event,this)" href=3D"https:/=
/lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_blank">https://lis=
ts.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
<br></blockquote></div><br>

--0016361648d1c00915047079a223--
