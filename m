Return-Path: <francesco.cappuccio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200910211200.24602.sven.eckelmann@gmx.de>
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com> 
	<20091021070510.GK23663@lunn.ch>
	<45f642440910210035t5e5b8589kc676459a1470bbdb@mail.gmail.com> 
	<200910211200.24602.sven.eckelmann@gmx.de>
From: Francesco <francesco.cappuccio@gmail.com>
Date: Wed, 21 Oct 2009 14:11:36 +0200
Message-ID: <45f642440910210511r6c3960easa2101bb07aa72323@mail.gmail.com>
Content-Type: multipart/alternative; boundary=00163628453e8d0516047670e28d
Subject: Re: [B.A.T.M.A.N.] basic B.A.T.M.A.N-adv setup
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--00163628453e8d0516047670e28d
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

Add the wlan0 interface to /proc/net/batman-adv/interfaces when wlan0 is up
actually seems to solve the problem.

Thanks.


On Wed, Oct 21, 2009 at 12:00 PM, Sven Eckelmann <sven.eckelmann@gmx.de>wrote:

> Francesco wrote:
> > Hi Andrew,
> > it (obviously) worked, i got the trunk, make and make install batctl
> after
> > batman-adv.
> >
> > Weird that:
> > $batctl o
> > BATMAN disabled - primary interface not active
> >
> > I just run this script:
> >
> > insmod /home/francesco/trunk/batman-adv-kernelland/batman-adv.ko
> > ifconfig wlan0 down
> > iwconfig wlan0 mode ad-hoc essid BATMAN_NET
> > echo wlan0 > /proc/net/batman-adv/interfaces
> > ifconfig wlan0 up
> > ifconfig bat0 192.168.1.1 up
> >
> > What is wrong?
>
> I think that you found a bug in batman-adv. Please add the wlan0 interface
> to
> /proc/net/batman-adv/interfaces when wlan0 is up.
>
> Best regards,
>         Sven
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>


-- 
Francesco Cappuccio

--00163628453e8d0516047670e28d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>Add the wlan0 interface to
/proc/net/batman-adv/interfaces when wlan0 is up actually seems to solve th=
e problem.<br><br>Thanks.<br>
<br><br><div class=3D"gmail_quote">On Wed, Oct 21, 2009 at 12:00 PM, Sven E=
ckelmann <span dir=3D"ltr">&lt;<a href=3D"mailto:sven.eckelmann@gmx.de">sve=
n.eckelmann@gmx.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">

<div class=3D"im">Francesco wrote:<br>
&gt; Hi Andrew,<br>
&gt; it (obviously) worked, i got the trunk, make and make install batctl a=
fter<br>
&gt; batman-adv.<br>
&gt;<br>
&gt; Weird that:<br>
&gt; $batctl o<br>
&gt; BATMAN disabled - primary interface not active<br>
&gt;<br>
&gt; I just run this script:<br>
&gt;<br>
&gt; insmod /home/francesco/trunk/batman-adv-kernelland/batman-adv.ko<br>
&gt; ifconfig wlan0 down<br>
&gt; iwconfig wlan0 mode ad-hoc essid BATMAN_NET<br>
&gt; echo wlan0 &gt; /proc/net/batman-adv/interfaces<br>
&gt; ifconfig wlan0 up<br>
&gt; ifconfig bat0 192.168.1.1 up<br>
&gt;<br>
&gt; What is wrong?<br>
<br>
</div>I think that you found a bug in batman-adv. Please add the wlan0 inte=
rface to<br>
/proc/net/batman-adv/interfaces when wlan0 is up.<br>
<br>
Best regards,<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0Sven<br>
</font><br>_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net">B.A.T.M.A.N@lists.open-m=
esh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br>Francesco Cappuccio=
<br><br>

--00163628453e8d0516047670e28d--
