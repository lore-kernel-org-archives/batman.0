Return-Path: <francesco.cappuccio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <200910202222.36928.sven.eckelmann@gmx.de>
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com> 
	<200910201917.12629.sven.eckelmann@gmx.de>
	<45f642440910201259j63a37a7bi58ea8b97a094a82f@mail.gmail.com> 
	<200910202222.36928.sven.eckelmann@gmx.de>
From: Francesco <francesco.cappuccio@gmail.com>
Date: Wed, 21 Oct 2009 08:54:02 +0200
Message-ID: <45f642440910202354r1224c4f5i99e6f126c09c82c1@mail.gmail.com>
Content-Type: multipart/alternative; boundary=0016362836a2d7947d04766c723c
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

--0016362836a2d7947d04766c723c
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

HI all,
I've now downloaded and $make latest batman-adv trunk from
$svn co
http://downloads.open-mesh.net/svn/batman/trunk/batman-adv-kernelland/
I have issues with batctl trunk:
$svn co http://downloads.open-mesh.net/svn/batman/trunk/batctl/

Download is ok but when i fire
$ make

root@francesco-desktop:/home/francesco/batctl# make
make -j 1 batctl
make[1]: Entering directory `/home/francesco/batctl'
    CC main.o
In file included from main.c:34:
tcpdump.h:23:25: error: list-batman.h: No such file or directory
In file included from main.c:34:
tcpdump.h:33: error: field =91list=92 has incomplete type
In file included from main.c:35:
bisect.h:30: error: field =91event_list=92 has incomplete type
bisect.h:31: error: field =91rt_table_list=92 has incomplete type
bisect.h:36: error: field =91list=92 has incomplete type
bisect.h:47: error: field =91list=92 has incomplete type
bisect.h:65: error: field =91list=92 has incomplete type
make[1]: *** [main.o] Error 1
make[1]: Leaving directory `/home/francesco/batctl'
make: *** [all] Error 2


I suppose there was no need to uninstall old batctl i did compiled..or not?

Thanks.

--=20
Francesco Cappuccio

--0016362836a2d7947d04766c723c
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

HI all,<br>I&#39;ve now downloaded and $make latest batman-adv trunk from<b=
r>$svn co <a href=3D"http://downloads.open-mesh.net/svn/batman/trunk/batman=
-adv-kernelland/">http://downloads.open-mesh.net/svn/batman/trunk/batman-ad=
v-kernelland/</a> <br>

I have issues with batctl trunk:<br>$svn co <a href=3D"http://downloads.ope=
n-mesh.net/svn/batman/trunk/batctl/">http://downloads.open-mesh.net/svn/bat=
man/trunk/batctl/</a><br><br>Download is ok but when i fire<br>$ make<br>

<br>root@francesco-desktop:/home/francesco/batctl# make<br>make -j 1 batctl=
<br>make[1]: Entering directory `/home/francesco/batctl&#39;<br>=A0=A0=A0 C=
C main.o<br>In file included from main.c:34:<br>tcpdump.h:23:25: error: lis=
t-batman.h: No such file or directory<br>

In file included from main.c:34:<br>tcpdump.h:33: error: field =91list=92 h=
as incomplete type<br>In file included from main.c:35:<br>bisect.h:30: erro=
r: field =91event_list=92 has incomplete type<br>bisect.h:31: error: field =
=91rt_table_list=92 has incomplete type<br>

bisect.h:36: error: field =91list=92 has incomplete type<br>bisect.h:47: er=
ror: field =91list=92 has incomplete type<br>bisect.h:65: error: field =91l=
ist=92 has incomplete type<br>make[1]: *** [main.o] Error 1<br>make[1]: Lea=
ving directory `/home/francesco/batctl&#39;<br>

make: *** [all] Error 2<br><br><br>I suppose there was no need to uninstall=
 old batctl i did compiled..or not?<br><br>Thanks.<br clear=3D"all"><br>-- =
<br>Francesco Cappuccio<br><br>

--0016362836a2d7947d04766c723c--
