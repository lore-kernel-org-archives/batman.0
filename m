Message-ID: <c1004cd20806161516y41e09fe8gb3bf2b69f3f0a6ee@mail.gmail.com>
Date: Tue, 17 Jun 2008 00:16:33 +0200
From: "thomas anderson" <eidos85@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Batman doesn't add default route...
In-Reply-To: <200806170149.43572.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8914_13858257.1213654593504"
References: <c1004cd20806160901m70ff21d2y97830fdd128c5f75@mail.gmail.com>
	<200806170149.43572.lindner_marek@yahoo.de>
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

------=_Part_8914_13858257.1213654593504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Maybe have i to active something in the kernel configuration of the fonera
for the policy routing?
right now i'm using this version of openwrt Kamikaze 7.09 kernel compile for
the fonera:
2.6.21.5
Eidos

2008/6/16 Marek Lindner <lindner_marek@yahoo.de>:

> On Tuesday, 17. June 2008 00:01:23 thomas anderson wrote:
> > The problem is that when i start batman on the client pc it doesn't add
> the
> > default route to 192.168.9.1 infact if i add it manually with:
> > route add default gw 192.168.9.1
> > everything goes ok and i can surf on internet but without the manual add
> of
> > the route i can't surf..
> > Can someone help me?
>
> All routing table entries are not shown in the default table (254) but can
> be
> found elsewhere. Please read: http://open-mesh.net/batman/doc/RoutingVodoo
> If your internet connection still does not work, please log debug level 3
> and
> watch out for errors / warnings or post them here.
>
> Greetings,
> Marek
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

------=_Part_8914_13858257.1213654593504
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Maybe have i to active something in the kernel configuration of the fonera for the policy routing?<br>right now i&#39;m using this version of openwrt Kamikaze 7.09 kernel compile for the fonera:<br><a href="http://2.6.21.5">2.6.21.5</a><br>
Eidos<br><br><div class="gmail_quote">2008/6/16 Marek Lindner &lt;<a href="mailto:lindner_marek@yahoo.de">lindner_marek@yahoo.de</a>&gt;:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Tuesday, 17. June 2008 00:01:23 thomas anderson wrote:<br>
&gt; The problem is that when i start batman on the client pc it doesn&#39;t add the<br>
&gt; default route to <a href="http://192.168.9.1" target="_blank">192.168.9.1</a> infact if i add it manually with:<br>
&gt; route add default gw <a href="http://192.168.9.1" target="_blank">192.168.9.1</a><br>
&gt; everything goes ok and i can surf on internet but without the manual add of<br>
&gt; the route i can&#39;t surf..<br>
&gt; Can someone help me?<br>
<br>
</div>All routing table entries are not shown in the default table (254) but can be<br>
found elsewhere. Please read: <a href="http://open-mesh.net/batman/doc/RoutingVodoo" target="_blank">http://open-mesh.net/batman/doc/RoutingVodoo</a><br>
If your internet connection still does not work, please log debug level 3 and<br>
watch out for errors / warnings or post them here.<br>
<br>
Greetings,<br>
Marek<br>
_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</blockquote></div><br>

------=_Part_8914_13858257.1213654593504--
