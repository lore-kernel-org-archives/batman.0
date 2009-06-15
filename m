MIME-Version: 1.0
In-Reply-To: <5161afcd0906151503kb1945d5x665050c2d7eaea7a@mail.gmail.com>
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
	<200906130408.45362.lindner_marek@yahoo.de>
	<5161afcd0906121327m603d4c4ftc02458f30d39ff9c@mail.gmail.com>
	<200906130538.06620.lindner_marek@yahoo.de>
	<5161afcd0906121452p7fd294daha8915c906d7bb00e@mail.gmail.com>
	<5161afcd0906151503kb1945d5x665050c2d7eaea7a@mail.gmail.com>
Date: Mon, 15 Jun 2009 18:10:36 -0400
Message-ID: <5635aa0d0906151510i22f26826tc6980847b4f7ada9@mail.gmail.com>
From: Outback Dingo <outbackdingo@gmail.com>
Content-Type: multipart/alternative; boundary=0015175caee6e42bb8046c6a531f
Subject: Re: [B.A.T.M.A.N.] batman advanced in openwrt
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--0015175caee6e42bb8046c6a531f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

change the version in the batman-adv packages Makefile, and rebuild should
be all you need

On 6/15/09, Jacob Marble <jacobmarble@gmail.com> wrote:
>
> On Fri, Jun 12, 2009 at 3:52 PM, Jacob Marble<jacobmarble@gmail.com>
> wrote:
> > On Fri, Jun 12, 2009 at 3:38 PM, Marek Lindner<lindner_marek@yahoo.de>
> wrote:
> >> On Saturday 13 June 2009 04:27:44 Jacob Marble wrote:
> >>> > This message indicates that this nodes already has one interface
> which is
> >>> > not activate. Could you post "cat /proc/net/batman-adv/interfaces"
> after
> >>> > you get this result ?
> >>>
> >>> "echo 'ath0' > interfaces"
> >>> "cat interfaces"
> >>> ath0
> >>>
> >>> [     97532] Adding interface: ath0
> >>> [     97532] Can't activate module: the primary interface is not active
> >>> [     97534] Adding route towards: 00:15:6d:a7:6a:14 (via
> >>> 00:15:6d:a7:6a:14) [     97534] Creating new global hna entry:
> >>> 00:ff:cf:5c:68:e0 (via 00:15:6d:a7:6a:14)
> >>
> >> It looks like a bug that I fixed in revision 1254. What version are you
> using ?
> >>
> >
> > 1176 (from OpenWrt repositories).  I'll get the latest svn.
> >
>
>
> Alright, I have OpenWrt SVN compiling, which has revision 1289.
> However, I would like to compile the batman-advanced code from the
> batman SVN repository instead.  I have tried copying the
> batman-advanced directory to [the openwrt sdk]/package/ and then run
> make, and this doesn't work.  I have tried compiling the
> batman-advanced code by simply "make
> KERNELPATH=~/OpenWrt-SDK-atheros-for-Linux-i686/" and that didn't
> work.  I have tried several paths for KERNELPATH, but I think I need
> the other cross-compile tools to be available as well...
>
> Can someone give me a quick-and-dirty "Howto compile for OpenWrt"?
> Afterwards, I could put together a nice README.openwrt for the SVN
> repository.
>
> TIA,
>
> Jake
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

--0015175caee6e42bb8046c6a531f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

change the version in the batman-adv packages Makefile, and rebuild should =
be all you need<br><br><div><span class=3D"gmail_quote">On 6/15/09, <b clas=
s=3D"gmail_sendername">Jacob Marble</b> &lt;<a href=3D"mailto:jacobmarble@g=
mail.com">jacobmarble@gmail.com</a>&gt; wrote:</span><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, Jun 12, 2009 at 3:52 PM, Jacob Marble&lt;<a href=3D"mailto:jacobmar=
ble@gmail.com">jacobmarble@gmail.com</a>&gt; wrote:<br> &gt; On Fri, Jun 12=
, 2009 at 3:38 PM, Marek Lindner&lt;<a href=3D"mailto:lindner_marek@yahoo.d=
e">lindner_marek@yahoo.de</a>&gt; wrote:<br>
 &gt;&gt; On Saturday 13 June 2009 04:27:44 Jacob Marble wrote:<br> &gt;&gt=
;&gt; &gt; This message indicates that this nodes already has one interface=
 which is<br> &gt;&gt;&gt; &gt; not activate. Could you post &quot;cat /pro=
c/net/batman-adv/interfaces&quot; after<br>
 &gt;&gt;&gt; &gt; you get this result ?<br> &gt;&gt;&gt;<br> &gt;&gt;&gt; =
&quot;echo &#39;ath0&#39; &gt; interfaces&quot;<br> &gt;&gt;&gt; &quot;cat =
interfaces&quot;<br> &gt;&gt;&gt; ath0<br> &gt;&gt;&gt;<br> &gt;&gt;&gt; [=
=A0=A0=A0=A0 97532] Adding interface: ath0<br>
 &gt;&gt;&gt; [=A0=A0=A0=A0 97532] Can&#39;t activate module: the primary i=
nterface is not active<br> &gt;&gt;&gt; [=A0=A0=A0=A0 97534] Adding route t=
owards: 00:15:6d:a7:6a:14 (via<br> &gt;&gt;&gt; 00:15:6d:a7:6a:14) [=A0=A0=
=A0=A0 97534] Creating new global hna entry:<br>
 &gt;&gt;&gt; 00:ff:cf:5c:68:e0 (via 00:15:6d:a7:6a:14)<br> &gt;&gt;<br> &g=
t;&gt; It looks like a bug that I fixed in revision 1254. What version are =
you using ?<br> &gt;&gt;<br> &gt;<br> &gt; 1176 (from OpenWrt repositories)=
.=A0=A0I&#39;ll get the latest svn.<br>
 &gt;<br> <br> <br>Alright, I have OpenWrt SVN compiling, which has revisio=
n 1289.<br> However, I would like to compile the batman-advanced code from =
the<br> batman SVN repository instead.=A0=A0I have tried copying the<br> ba=
tman-advanced directory to [the openwrt sdk]/package/ and then run<br>
 make, and this doesn&#39;t work.=A0=A0I have tried compiling the<br> batma=
n-advanced code by simply &quot;make<br> KERNELPATH=3D~/OpenWrt-SDK-atheros=
-for-Linux-i686/&quot; and that didn&#39;t<br> work.=A0=A0I have tried seve=
ral paths for KERNELPATH, but I think I need<br>
 the other cross-compile tools to be available as well...<br> <br> Can some=
one give me a quick-and-dirty &quot;Howto compile for OpenWrt&quot;?<br> Af=
terwards, I could put together a nice README.openwrt for the SVN<br> reposi=
tory.<br>
 <br> TIA,<br> <br> Jake<br> <br>__________________________________________=
_____<br> B.A.T.M.A.N mailing list<br> <a href=3D"mailto:B.A.T.M.A.N@open-m=
esh.net">B.A.T.M.A.N@open-mesh.net</a><br> <a href=3D"https://lists.open-me=
sh.net/mm/listinfo/b.a.t.m.a.n">https://lists.open-mesh.net/mm/listinfo/b.a=
.t.m.a.n</a><br>
 </blockquote></div><br>

--0015175caee6e42bb8046c6a531f--
