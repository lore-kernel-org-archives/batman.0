Return-Path: <gus.lindberg@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4AB28C2D.7060600@tiwoc.de>
References: <AACE951F705644649DB6ABC24CFBCF29@youillmlpt3>
	<8c906fa50909171115v2b296844h69c5f93eea99403c@mail.gmail.com>
	<4AB28C2D.7060600@tiwoc.de>
Date: Thu, 17 Sep 2009 17:14:01 -0300
Message-ID: <8c906fa50909171314lb275b23vf87bd2852e3bd244@mail.gmail.com>
From: Gustavo Lindberg <gus.lindberg@gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd29fc40fe1b80473cba8f9
Subject: Re: [B.A.T.M.A.N.] IP from MAC
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

--000e0cd29fc40fe1b80473cba8f9
Content-Type: text/plain; charset=ISO-8859-1

2009/9/17 Daniel Seither <post@tiwoc.de>

> Gustavo Lindberg wrote:
> > Then, At a meeting of 60 people there is the 99% probability  of the
> least
> > two men have a  birthday the same day. So,, Similarly to the case of
> > MAC-Adress is:
> >
> > P(r)=1-65536!/(65536^r * (65536-r)!)
>
> Robin uses 3 bytes of the MAC address to choose the IP address of the
> mesh interface, not only 2 bytes = 65536 possibilities. This leads to
> 2^24 = 16777216 different addresses.
>

All IP addresses are derived by device's MAC address, if MAC is
aa:bb:cc:dd:ee:ff then ath0 IP (mesh iface) will be 5.dd:ee:ff while ath1 IP
and ath2 IP will be 101.ee:ff:1 and 102.ee:ff:1 (obviously in decimal
format).

--000e0cd29fc40fe1b80473cba8f9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2009/9/17 Daniel Seither <span dir=3D"lt=
r">&lt;<a href=3D"mailto:post@tiwoc.de">post@tiwoc.de</a>&gt;</span><br><bl=
ockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204=
, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">Gustavo Lindberg wrote:<br>
&gt; Then, At a meeting of 60 people there is the 99% probability =A0of the=
 least<br>
&gt; two men have a =A0birthday the same day. So,, Similarly to the case of=
<br>
&gt; MAC-Adress is:<br>
&gt;<br>
&gt; P(r)=3D1-65536!/(65536^r * (65536-r)!)<br>
<br>
</div>Robin uses 3 bytes of the MAC address to choose the IP address of the=
<br>
mesh interface, not only 2 bytes =3D 65536 possibilities. This leads to<br>
2^24 =3D 16777216 different addresses.<br>
</blockquote></div><br>All IP addresses are derived by device&#39;s MAC add=
ress, if MAC is aa:bb:cc:dd:ee:ff then ath0 IP (mesh iface) will be
5.dd:ee:ff while ath1 IP and ath2 IP will be 101.ee:ff:1 and 102.ee:ff:1 (o=
bviously in decimal format).<br><br><br><br><br><br>

--000e0cd29fc40fe1b80473cba8f9--
