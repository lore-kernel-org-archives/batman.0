Message-ID: <BLU122-W22ECF92C81BC9F2EB9400AF6A30@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_6217caba-5a2e-4a35-9b3b-fc1913cae789_"
From: Dennis Bartsch <dennis_bartsch@hotmail.com>
Subject: RE: [B.A.T.M.A.N.] strange default routes
Date: Mon, 15 Oct 2007 18:03:53 +0100
In-Reply-To: <6792.85.41.146.90.1192460098.squirrel@krisma.oltrelinux.com>
References: <BLU122-W10D014E29FA86CA3739C9AF6A30@phx.gbl>
	<200710151614.36704.onelektra@gmx.net> 
	<6792.85.41.146.90.1192460098.squirrel@krisma.oltrelinux.com>
MIME-Version: 1.0
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

--_6217caba-5a2e-4a35-9b3b-fc1913cae789_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

hey,

the problem semms to be found and very much trivial. the recent openWRT-rel=
ease (or especially the ixp4xx-port ?!) as well as the rather old slackware=
10.2 comes _without_ policy-routing compiled into the kernel. figure this o=
ut ... an OS for embedded routers comes without advanced routing capabiliti=
es ... nothing i've expected. nevertheless batman should detect this and gi=
ve a hint rather than trying to write to non-existent routing-tables.=20

i report back later and tell whether the problems are gone ...

greets,
dennis bartsch (... who should study linux-policy-routing before trying to =
soft-migrate olsr-to-batman)


> Date: Mon, 15 Oct 2007 16:54:58 +0200
> Subject: Re: [B.A.T.M.A.N.] strange default routes
> From: a.anselmi@oltrelinux.com
> To: b.a.t.m.a.n@open-mesh.net
>=20
> ciao Elektra
>=20
> need some hunters ? :)
>=20
> we are strongly testing batmand 0.3-beta since its alpha revisions:
> actually rv674 seems the best working one. Today rv719 is now in
> testing...
> We appreciate very much your work
>=20
> -- Antonio
>=20
> > I'm sorry to say that 0.3beta is not usable at the moment. We are in th=
e
> > status of bug-hunting.
> >
> > cu elektra
> >
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >
>=20
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

_________________________________________________________________
Freunde treffen. Jetzt den Windows Live=99 Messenger downloaden!
http://get.live.com/messenger/overview=

--_6217caba-5a2e-4a35-9b3b-fc1913cae789_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'><div style=3D"text-align: left;">hey,<br><br>the =
problem semms to be found and very much trivial. the recent openWRT-release=
 (or especially the ixp4xx-port ?!) as well as the rather old slackware10.2=
 comes _without_ policy-routing compiled into the kernel. figure this out .=
.. an OS for embedded routers comes without advanced routing capabilities .=
.. nothing i've expected. nevertheless batman should detect this and give a=
 hint rather than trying to write to non-existent routing-tables. <br><br>i=
 report back later and tell whether the problems are gone ...<br><br>greets=
,<br>dennis bartsch (... who should study linux-policy-routing before tryin=
g to soft-migrate olsr-to-batman)<br><br></div><br><hr id=3D"stopSpelling">=
&gt; Date: Mon, 15 Oct 2007 16:54:58 +0200<br>&gt; Subject: Re: [B.A.T.M.A.=
N.] strange default routes<br>&gt; From: a.anselmi@oltrelinux.com<br>&gt; T=
o: b.a.t.m.a.n@open-mesh.net<br>&gt; <br>&gt; ciao Elektra<br>&gt; <br>&gt;=
 need some hunters ? :)<br>&gt; <br>&gt; we are strongly testing batmand 0.=
3-beta since its alpha revisions:<br>&gt; actually rv674 seems the best wor=
king one. Today rv719 is now in<br>&gt; testing...<br>&gt; We appreciate ve=
ry much your work<br>&gt; <br>&gt; -- Antonio<br>&gt; <br>&gt; &gt; I'm sor=
ry to say that 0.3beta is not usable at the moment. We are in the<br>&gt; &=
gt; status of bug-hunting.<br>&gt; &gt;<br>&gt; &gt; cu elektra<br>&gt; &gt=
;<br>&gt; &gt; _______________________________________________<br>&gt; &gt;=
 B.A.T.M.A.N mailing list<br>&gt; &gt; B.A.T.M.A.N@open-mesh.net<br>&gt; &g=
t; https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n<br>&gt; &gt;<br>&gt; =
<br>&gt; <br>&gt; _______________________________________________<br>&gt; B=
.A.T.M.A.N mailing list<br>&gt; B.A.T.M.A.N@open-mesh.net<br>&gt; https://l=
ist.open-mesh.net/mm/listinfo/b.a.t.m.a.n<br><br /><hr />Machen Sie Ihre E-=
Mail-Kontakte zu Messenger-Freunden! <a href=3D'http://redirect.gimas.net/?=
cat=3Dhmtl&n=3DM1007AI&d=3Dhttp://messenger.live.de/ersteschritte_adressimp=
ort.html' target=3D'_new'>Einfacher Adressimport!</a></body>
</html>=

--_6217caba-5a2e-4a35-9b3b-fc1913cae789_--
