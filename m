Return-Path: <francesco.cappuccio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20091021070510.GK23663@lunn.ch>
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com> 
	<200910201917.12629.sven.eckelmann@gmx.de>
	<45f642440910201259j63a37a7bi58ea8b97a094a82f@mail.gmail.com> 
	<200910202222.36928.sven.eckelmann@gmx.de>
	<45f642440910202354r1224c4f5i99e6f126c09c82c1@mail.gmail.com> 
	<20091021070510.GK23663@lunn.ch>
From: Francesco <francesco.cappuccio@gmail.com>
Date: Wed, 21 Oct 2009 09:35:23 +0200
Message-ID: <45f642440910210035t5e5b8589kc676459a1470bbdb@mail.gmail.com>
Content-Type: multipart/alternative; boundary=0016e640d408c0127c04766d063b
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

--0016e640d408c0127c04766d063b
Content-Type: text/plain; charset=ISO-8859-1

Hi Andrew,
it (obviously) worked, i got the trunk, make and make install batctl after
batman-adv.

Weird that:
$batctl o
BATMAN disabled - primary interface not active

I just run this script:

insmod /home/francesco/trunk/batman-adv-kernelland/batman-adv.ko
ifconfig wlan0 down
iwconfig wlan0 mode ad-hoc essid BATMAN_NET
echo wlan0 > /proc/net/batman-adv/interfaces
ifconfig wlan0 up
ifconfig bat0 192.168.1.1 up

What is wrong?

I did the same in two mesh nodes with the same result..


On Wed, Oct 21, 2009 at 9:05 AM, Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Oct 21, 2009 at 08:54:02AM +0200, Francesco wrote:
> > HI all,
> > I've now downloaded and $make latest batman-adv trunk from
> > $svn co
> > http://downloads.open-mesh.net/svn/batman/trunk/batman-adv-kernelland/
> > I have issues with batctl trunk:
> > $svn co http://downloads.open-mesh.net/svn/batman/trunk/batctl/
>
> This unfortunately, does not work. The batctl sources has symbolic
> links into the batman directory for the files hash.c, list-batman.c,
> hash.h list-batman.h.
>
> Check out the complete trunk and then you will have everything you
> need.
>
>        Andrew
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>



-- 
Francesco Cappuccio

--0016e640d408c0127c04766d063b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andrew, <br>it (obviously) worked, i got the trunk, make and make instal=
l batctl after batman-adv.<br><br>Weird that: <br>$batctl o<br>BATMAN disab=
led - primary interface not active <br><br>I just run this script:<br><br>

insmod /home/francesco/trunk/batman-adv-kernelland/batman-adv.ko<br>ifconfi=
g wlan0 down<br>iwconfig wlan0 mode ad-hoc essid BATMAN_NET<br>echo wlan0 &=
gt; /proc/net/batman-adv/interfaces<br>ifconfig wlan0 up<br>ifconfig bat0 1=
92.168.1.1 up<br>

<br>What is wrong?<br><br>I did the same in two mesh nodes with the same re=
sult..<br><br><br><div class=3D"gmail_quote">On Wed, Oct 21, 2009 at 9:05 A=
M, Andrew Lunn <span dir=3D"ltr">&lt;<a href=3D"mailto:andrew@lunn.ch">andr=
ew@lunn.ch</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Wed, Oct 21, 2009 at 08:54:02AM +0200, Francesco wrote:<br>
&gt; HI all,<br>
&gt; I&#39;ve now downloaded and $make latest batman-adv trunk from<br>
&gt; $svn co<br>
&gt; <a href=3D"http://downloads.open-mesh.net/svn/batman/trunk/batman-adv-=
kernelland/" target=3D"_blank">http://downloads.open-mesh.net/svn/batman/tr=
unk/batman-adv-kernelland/</a><br>
&gt; I have issues with batctl trunk:<br>
&gt; $svn co <a href=3D"http://downloads.open-mesh.net/svn/batman/trunk/bat=
ctl/" target=3D"_blank">http://downloads.open-mesh.net/svn/batman/trunk/bat=
ctl/</a><br>
<br>
</div>This unfortunately, does not work. The batctl sources has symbolic<br=
>
links into the batman directory for the files hash.c, list-batman.c,<br>
hash.h list-batman.h.<br>
<br>
Check out the complete trunk and then you will have everything you<br>
need.<br>
<font color=3D"#888888"><br>
 =A0 =A0 =A0 =A0Andrew<br>
</font><div><div></div><div class=3D"h5">__________________________________=
_____________<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net">B.A.T.M.A.N@lists.open-m=
esh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Francesco C=
appuccio<br><br>

--0016e640d408c0127c04766d063b--
