MIME-Version: 1.0
In-Reply-To: <20090522110826.GA26812@pandem0nium>
References: <1242937180.14711.14.camel@turing.asconix.lan>
	<20090522110826.GA26812@pandem0nium>
Date: Fri, 22 May 2009 19:51:20 +0200
Message-ID: <8502079e0905221051s197a3d21n30658bb952b56463@mail.gmail.com>
From: Christoph Pilka <christoph.pilka@googlemail.com>
Content-Type: multipart/alternative; boundary=000e0cd250487951c8046a83e8ba
Subject: Re: [B.A.T.M.A.N.] VIS server for batman-adv-kernelland
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
To: B.A.T.M.A.N@open-mesh.net

--000e0cd250487951c8046a83e8ba
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Simon,

many thanks for all the infos and hints. The base install seems to work
properly. I'll take a look at s3d this weekend cause I'm very interested in
getting it running at ethernet frame level. By the way, the JSON output
seems to be really nice feature but the code is only available for level3
batman ?

Greets.
Chris <=B0(((><

2009/5/22 Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

> Hello Christoph,
>
> On Thu, May 21, 2009 at 10:19:40PM +0200, Christoph Pilka wrote:
> > Hi folks,
> >
> > my goal is to visualize batman-adv-kernelland network topology. 'echo
> > "server" > /proc/net/batman-adv/vis' activates vis server on the mesh
> > node directly, right?
>
> Yes, that's right.
> > Do the other nodes find the vis server
> > autmagically?
>
> Yup, they do.
>
> > What happens, if I wanna use more than one vis server?
>
> The running vis servers synchronize each other. You can set up multiple
> vis servers inside your mesh (this is different from L3 batman).
>
> > And
> > the last and most important question: is it possible to run a vis serve=
r
> > outside the mesh running layer 2 batman-adv?
>
> That's not possible. They only run within the batman-adv module, and you
> can only access the data locally on the node. One thing you can do is
> building a script with ssh, e.g.
>
> ssh <yournode> 'cat /proc/net/batman-adv/vis'
>
> which would give you the topology even on a remote node.
> What you can also do is building a vis server similar to the L3 one
> on the node by using netcat and a small shellscript which prints out
> /proc/net/batman-adv/vis in a loop.
>
>
> > The layer 3 vis runs fine
> > but I have no clue how to get the visualization running on batman-adv
> > nodes. How to tell the vis server on the mesh nodes to output their dat=
a
> > to a dot-draw server (s3d) ? Lot of questions ;-)
>
> if you build a vis server with netcat and a shellscript this will be
> possible.
> Please note however that you might need to patch the s3d visualization
> program
> (olsrs3d or meshs3d) as it expects IP addresses, not MAC addresses. This =
is
> not
> hard to do ....
>
> >
> > For the German readers: I am documenting all the stuff on
> > http://debian.asconix.com/batman-advanced-openwrt-howto but I think, th=
e
> > way I'm describing in the vis chapter is the way to get vis running in
> > layer3 batman, isn't it?
> >
>
> Right, your description references to the layer 3 vis server. Layer 2 is
> a little bit different ...
> > Greets,
> > Chris
> >
> > --
> > "Privacy in residential applications is a desirable marketing
> > option." (ETSI EN 300 175-7 Ch. A6)
> >
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkoWh6oACgkQrzg/fFk7axazzwCdEj0eeCi+lI10Fjo3IXevv78Q
> PWYAn01bptuXhZX+bo6rXE5Sm1n8N3jt
> =3DouCT
> -----END PGP SIGNATURE-----
>
>


--=20
"Privacy in residential applications is a desirable marketing option." (ETS=
I
EN 300 175-7 Ch. A6)

--000e0cd250487951c8046a83e8ba
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Simon,<br><br>many thanks for all the infos and hints. The base insta=
ll seems to work properly. I&#39;ll take a look at s3d this weekend cause I=
&#39;m very interested in getting it running at ethernet frame level. By th=
e way, the JSON output seems to be really nice feature but the code is only=
 available for level3 batman ?<br>
<br>Greets.<br>Chris &lt;=B0(((&gt;&lt;<br><br><div class=3D"gmail_quote">2=
009/5/22 Simon Wunderlich <span dir=3D"ltr">&lt;<a href=3D"mailto:simon.wun=
derlich@s2003.tu-chemnitz.de">simon.wunderlich@s2003.tu-chemnitz.de</a>&gt;=
</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hello Christoph,<=
br>
<div class=3D"im"><br>
On Thu, May 21, 2009 at 10:19:40PM +0200, Christoph Pilka wrote:<br>
&gt; Hi folks,<br>
&gt;<br>
&gt; my goal is to visualize batman-adv-kernelland network topology. &#39;e=
cho<br>
&gt; &quot;server&quot; &gt; /proc/net/batman-adv/vis&#39; activates vis se=
rver on the mesh<br>
&gt; node directly, right?<br>
<br>
</div>Yes, that&#39;s right.<br>
<div class=3D"im">&gt; Do the other nodes find the vis server<br>
&gt; autmagically?<br>
<br>
</div>Yup, they do.<br>
<div class=3D"im"><br>
&gt; What happens, if I wanna use more than one vis server?<br>
<br>
</div>The running vis servers synchronize each other. You can set up multip=
le<br>
vis servers inside your mesh (this is different from L3 batman).<br>
<div class=3D"im"><br>
&gt; And<br>
&gt; the last and most important question: is it possible to run a vis serv=
er<br>
&gt; outside the mesh running layer 2 batman-adv?<br>
<br>
</div>That&#39;s not possible. They only run within the batman-adv module, =
and you<br>
can only access the data locally on the node. One thing you can do is<br>
building a script with ssh, e.g.<br>
<br>
ssh &lt;yournode&gt; &#39;cat /proc/net/batman-adv/vis&#39;<br>
<br>
which would give you the topology even on a remote node.<br>
What you can also do is building a vis server similar to the L3 one<br>
on the node by using netcat and a small shellscript which prints out<br>
/proc/net/batman-adv/vis in a loop.<br>
<div class=3D"im"><br>
<br>
&gt; The layer 3 vis runs fine<br>
&gt; but I have no clue how to get the visualization running on batman-adv<=
br>
&gt; nodes. How to tell the vis server on the mesh nodes to output their da=
ta<br>
&gt; to a dot-draw server (s3d) ? Lot of questions ;-)<br>
<br>
</div>if you build a vis server with netcat and a shellscript this will be =
possible.<br>
Please note however that you might need to patch the s3d visualization prog=
ram<br>
(olsrs3d or meshs3d) as it expects IP addresses, not MAC addresses. This is=
 not<br>
hard to do ....<br>
<div class=3D"im"><br>
&gt;<br>
&gt; For the German readers: I am documenting all the stuff on<br>
&gt; <a href=3D"http://debian.asconix.com/batman-advanced-openwrt-howto" ta=
rget=3D"_blank">http://debian.asconix.com/batman-advanced-openwrt-howto</a>=
 but I think, the<br>
&gt; way I&#39;m describing in the vis chapter is the way to get vis runnin=
g in<br>
&gt; layer3 batman, isn&#39;t it?<br>
&gt;<br>
<br>
</div>Right, your description references to the layer 3 vis server. Layer 2=
 is<br>
a little bit different ...<br>
<div class=3D"im">&gt; Greets,<br>
&gt; Chris<br>
&gt;<br>
&gt; --<br>
&gt; &quot;Privacy in residential applications is a desirable marketing<br>
&gt; option.&quot; (ETSI EN 300 175-7 Ch. A6)<br>
&gt;<br>
</div>&gt; _______________________________________________<br>
&gt; B.A.T.M.A.N mailing list<br>
&gt; <a href=3D"mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net=
</a><br>
&gt; <a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=
=3D"_blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
&gt;<br>
<br>-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.9 (GNU/Linux)<br>
<br>
iEYEARECAAYFAkoWh6oACgkQrzg/fFk7axazzwCdEj0eeCi+lI10Fjo3IXevv78Q<br>
PWYAn01bptuXhZX+bo6rXE5Sm1n8N3jt<br>
=3DouCT<br>
-----END PGP SIGNATURE-----<br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br>&quot;Privacy in re=
sidential applications is a desirable marketing option.&quot; (ETSI EN 300 =
175-7 Ch. A6)<br><br>

--000e0cd250487951c8046a83e8ba--
