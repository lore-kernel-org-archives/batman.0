Message-ID: <COL105-W32D1BE3EB52D6D5D3CE8C6F6BB0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_b1fe470d-3f88-4b43-958d-85ca77293c0c_"
From: Dennis Bartsch <dennis_bartsch@hotmail.com>
Date: Thu, 12 Feb 2009 17:14:45 +0100
In-Reply-To: <238a15490902120658h4edb144bvc17db63a5b4a6f0a@mail.gmail.com>
References: <238a15490902111906g23358005v35fd57d8df857154@mail.gmail.com>
	<20090212125347.GA4074@pandem0nium> 
	<238a15490902120658h4edb144bvc17db63a5b4a6f0a@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Using batman L2 on multiple wireless cards
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
To: b.a.t.m.a.n@open-mesh.net

--_b1fe470d-3f88-4b43-958d-85ca77293c0c_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hello List=2C


> however when i check the /proc/net/batman-adv/originators....i see
> that all other nodes are reachable but the interface mentioned is
> ath1....(even those which are actually reachable by ath0)
>=20
> shouldn't some of the boards be reachable by ath0 - as some nodes are
> on a different channel...

if the three interfaces are working in ad-hoc-mode be sure to assign
different BSSIDs to further separate the channels. with a low distance
beween the radios (or even all three readios in one case) the
channel-crosstalk is severe. I have seen cards running on channel 1
even decode some frames from channel 13. thats why a logical
separation is necessary or at least recommended.



regards=2C

dennis bartsch

_________________________________________________________________
http://redirect.gimas.net/?n=3DM0902xFTPFotoalbum
Digitale Fotoalben und Videos ganz einfach selbst erstellen.=

--_b1fe470d-3f88-4b43-958d-85ca77293c0c_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
<br>Hello List=2C<br><br><br>&gt=3B however when i check the /proc/net/batm=
an-adv/originators....i see<br>&gt=3B that all other nodes are reachable bu=
t the interface mentioned is<br>&gt=3B ath1....(even those which are actual=
ly reachable by ath0)<br>&gt=3B <br>&gt=3B shouldn't some of the boards be =
reachable by ath0 - as some nodes are<br>&gt=3B on a different channel...<b=
r>
if the three interfaces are working in ad-hoc-mode be sure to assign
different BSSIDs to further separate the channels. with a low distance
beween the radios (or even all three readios in one case) the
channel-crosstalk is severe. I have seen cards running on channel 1
even decode some frames from channel 13. thats why a logical
separation is necessary or at least recommended.<br>
<br>
regards=2C<br>
dennis bartsch<br><br /><hr />Sicher=2C schnell=2C =FCbersichtlich -  <a hr=
ef=3D'http://redirect.gimas.net/?n=3DM0902IE8beta' target=3D'_new'>der Inte=
rnet Browser vom Marktf=FChrer!</a></body>
</html>=

--_b1fe470d-3f88-4b43-958d-85ca77293c0c_--
