Message-ID: <a934d3f30708241122h4031e67di927d5523caaf5db1@mail.gmail.com>
Date: Fri, 24 Aug 2007 23:52:19 +0530
From: "Vinay Menon" <vinaymenon@gmail.com>
Subject: Re: [B.A.T.M.A.N.] robin
In-Reply-To: <46faed20708241035n595ebaas4e45df35c3dfdff5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_25934_18608391.1187979739451"
References: <38331.85.41.146.90.1187693478.squirrel@krisma.oltrelinux.com>
	<46CF07B9.8060903@bb.banban.jp>
	<46faed20708241035n595ebaas4e45df35c3dfdff5@mail.gmail.com>
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

------=_Part_25934_18608391.1187979739451
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I tried ROBIN on the Meraki nodes i have,must say it really looks promising.
Truly 0-config without the need of a central server this is plug-n play :)

I was wondering why dont you use the same essid as ROBIN instead of the
ROBIN_mac/ip.
This would make a mesh repeater network and would completely emulate meraki.

Thanks and
Regards,
Vinay

On 8/24/07, Steven Leeman <steven@leeman.be> wrote:
>
> Ive allready got a  5Node fonera robin mesh and 8others are waiting to
> be installed; first a vis-server;and the most recent updates
>
> 2007/8/24, Lemonde <zukky@bb.banban.jp>:
> > Hi, all. Hi, Antonio.
> >
> > I've made up two ROBIN nodes on LaFoneras.
> > They works quite well.
> >
> > ---node.A as gateway---
> > root@OpenWrt:~# /sbin/brn -h
> > usage /sbin/brn
> >  -a : shows batmand -d 1
> >  -b : shows neighbors
> >  -d : shows non-direct neighbors
> >  -g : shows: OGs using NBs with non-direct GWs
> >  -v : shows all
> >  -l : loop every 2 seconds
> >  -h : shows help
> >
> > root@OpenWrt:~# /sbin/brn -v
> > All Originators:
> > 6.16.66.32           6.16.66.32 (128):      6.16.66.32 (128)
> > NBs:
> > 6.16.66.32           6.16.66.32 (128):      6.16.66.32 (128)
> > NBs with non-direct GWs:
> > OGs using NBs with non-direct GWs:
> > root@OpenWrt:~#
> > -------------------------
> >
> > ---node.B as node------
> > root@OpenWrt:~# /sbin/brn -v
> > All Originators:
> > 6.16.62.172         6.16.62.172 (126):     6.16.62.172 (126)
> > NBs:
> > 6.16.62.172         6.16.62.172 (126):     6.16.62.172 (126)
> > NBs with non-direct GWs:
> > OGs using NBs with non-direct GWs:
> > root@OpenWrt:~#
> > -------------------------
> >
> > ROBIN is so 0-config that I can't understand how it woks. :-)
> >
> > regards,
> >
> > zukky
> >
> > P.S.
> > Antonio, your documents are so nice.
> >
> >
> > > Hi,
> > >
> > > I'm using BATMAN routing algorithm on an kamikaze based firwmare,
> > > realizing ROBIN (Routing Batman Inside) MESH: a 0-config, QoS capable
> mesh
> > > software which targets Atheros AP51 devices such as Meraki Mini or
> Fonera.
> > >
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>



-- 
Vinay Menon

------=_Part_25934_18608391.1187979739451
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I tried ROBIN on the Meraki nodes i have,must say it really looks promising.<br>Truly 0-config without the need of a central server <span style="font-weight: bold;">this is plug-n play</span> <span style="font-weight: bold;">


:)</span><br><br>I was wondering why dont you use the same essid as ROBIN instead of the ROBIN_mac/ip.<br>This would make a mesh repeater network and would completely emulate meraki.<br><br>Thanks and <br>Regards,<br>Vinay
<br><br><div><span class="gmail_quote">On 8/24/07, <b class="gmail_sendername">Steven Leeman</b> &lt;<a href="mailto:steven@leeman.be">steven@leeman.be</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Ive allready got a&nbsp;&nbsp;5Node fonera robin mesh and 8others are waiting to<br>be installed; first a vis-server;and the most recent updates<br><br>2007/8/24, Lemonde &lt;<a href="mailto:zukky@bb.banban.jp">zukky@bb.banban.jp</a>
&gt;:<br>&gt; Hi, all. Hi, Antonio.<br>&gt;<br>&gt; I&#39;ve made up two ROBIN nodes on LaFoneras.<br>&gt; They works quite well.<br>&gt;<br>&gt; ---node.A as gateway---<br>&gt; root@OpenWrt:~# /sbin/brn -h<br>&gt; usage /sbin/brn
<br>&gt;&nbsp;&nbsp;-a : shows batmand -d 1<br>&gt;&nbsp;&nbsp;-b : shows neighbors<br>&gt;&nbsp;&nbsp;-d : shows non-direct neighbors<br>&gt;&nbsp;&nbsp;-g : shows: OGs using NBs with non-direct GWs<br>&gt;&nbsp;&nbsp;-v : shows all<br>&gt;&nbsp;&nbsp;-l : loop every 2 seconds<br>
&gt;&nbsp;&nbsp;-h : shows help<br>&gt;<br>&gt; root@OpenWrt:~# /sbin/brn -v<br>&gt; All Originators:<br>&gt; <a href="http://6.16.66.32">6.16.66.32</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://6.16.66.32">6.16.66.32</a> (128):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://6.16.66.32">
6.16.66.32</a> (128)<br>&gt; NBs:<br>&gt; <a href="http://6.16.66.32">6.16.66.32</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://6.16.66.32">6.16.66.32</a> (128):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://6.16.66.32">6.16.66.32</a> (128)<br>&gt; NBs with non-direct GWs:
<br>&gt; OGs using NBs with non-direct GWs:<br>&gt; root@OpenWrt:~#<br>&gt; -------------------------<br>&gt;<br>&gt; ---node.B as node------<br>&gt; root@OpenWrt:~# /sbin/brn -v<br>&gt; All Originators:<br>&gt; <a href="http://6.16.62.172">
6.16.62.172</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://6.16.62.172">6.16.62.172</a> (126):&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://6.16.62.172">6.16.62.172</a> (126)<br>&gt; NBs:<br>&gt; <a href="http://6.16.62.172">6.16.62.172</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://6.16.62.172">
6.16.62.172</a> (126):&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://6.16.62.172">6.16.62.172</a> (126)<br>&gt; NBs with non-direct GWs:<br>&gt; OGs using NBs with non-direct GWs:<br>&gt; root@OpenWrt:~#<br>&gt; -------------------------<br>&gt;<br>
&gt; ROBIN is so 0-config that I can&#39;t understand how it woks. :-)<br>&gt;<br>&gt; regards,<br>&gt;<br>&gt; zukky<br>&gt;<br>&gt; P.S.<br>&gt; Antonio, your documents are so nice.<br>&gt;<br>&gt;<br>&gt; &gt; Hi,<br>&gt; &gt;
<br>&gt; &gt; I&#39;m using BATMAN routing algorithm on an kamikaze based firwmare,<br>&gt; &gt; realizing ROBIN (Routing Batman Inside) MESH: a 0-config, QoS capable mesh<br>&gt; &gt; software which targets Atheros AP51 devices such as Meraki Mini or Fonera.
<br>&gt; &gt;<br>&gt; _______________________________________________<br>&gt; B.A.T.M.A.N mailing list<br>&gt; <a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>&gt; <a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n">
https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>&gt;<br>_______________________________________________<br>B.A.T.M.A.N mailing list<br><a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br></blockquote></div><br><br clear="all"><br>-- <br>Vinay Menon

------=_Part_25934_18608391.1187979739451--
