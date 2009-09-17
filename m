Return-Path: <gus.lindberg@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AACE951F705644649DB6ABC24CFBCF29@youillmlpt3>
References: <AACE951F705644649DB6ABC24CFBCF29@youillmlpt3>
Date: Thu, 17 Sep 2009 15:15:48 -0300
Message-ID: <8c906fa50909171115v2b296844h69c5f93eea99403c@mail.gmail.com>
From: Gustavo Lindberg <gus.lindberg@gmail.com>
Content-Type: multipart/alternative; boundary=000e0cd6b4da42ef420473ca01fe
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

--000e0cd6b4da42ef420473ca01fe
Content-Type: text/plain; charset=ISO-8859-1

2009/9/16 Lick A Prize <lick.prize@gmail.com>

>  In the ROBIN address allocation described here
> http://robin-mesh.wik.is/Documentation/Router_Configuring/Advanced_Configuration/Robin_IP_SpaceI'm curious how collisions are avoided.
>
> If you generate IP 5.dd:ee:ff from aa:bb:cc:dd:ee:ff won't you get a
> collision if you other devices with MACs ending in dd:ee:ff like
> aa:aa:cc:dd:ee:ff, aa:aa:aa:dd:ee:ff, and so on.
>

What is the occurrence probability of "r"  MAC-Adress twon agree on their
last two bytes?

This is similar to the birthday paradox: At a meeting of r> 2 people which
is the number of people needed for the probability that two men have same
birthday sould be 99%? The solution is in many books and that can view at:

http://en.wikipedia.org/wiki/Birthday_problem

Then, At a meeting of 60 people there is the 99% probability  of the least
two men have a  birthday the same day. So,, Similarly to the case of
MAC-Adress is:

P(r)=1-65536!/(65536^r * (65536-r)!)

where *! is factorial operator, and "r" is the Mac-Adress.

Well if the calculations are not mistake, we obtain r = 13,107 MAC-Adress
minimun in the same site then 99% probability two matches in his last two
bytes.

Now a new MAC entering, which is the probability that given "n"
MAC-Adress,,, all with two last byte differents this new MAC  matches with
any MAC-Adress in its last two bytes? Well this is:

P(n)=1-(65535/65536)^n  then when n=13107 is  P(13107)=0.18 or 18%. That is
MAC-paradox...



>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>

--000e0cd6b4da42ef420473ca01fe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2009/9/16 Lick A Prize <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:lick.prize@gmail.com">lick.prize@gmail.com</a>&gt;</=
span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">




<div style=3D"padding-left: 10px; padding-right: 10px; padding-top: 15px;" =
name=3D"Compose message area">
<div><font size=3D"2" face=3D"Arial">In the ROBIN address allocation descri=
bed here <a title=3D"http://robin-mesh.wik.is/Documentation/Router_Configur=
ing/Advanced_Configuration/Robin_IP_Space
CTRL + Click to follow link" href=3D"http://robin-mesh.wik.is/Documentation=
/Router_Configuring/Advanced_Configuration/Robin_IP_Space" target=3D"_blank=
">http://robin-mesh.wik.is/Documentation/Router_Configuring/Advanced_Config=
uration/Robin_IP_Space</a>=20
I&#39;m curious how collisions are avoided.</font></div>
<div>=A0</div>
<div><font size=3D"2" face=3D"Arial">If you generate IP 5.dd:ee:ff from=20
aa:bb:cc:dd:ee:ff won&#39;t you get a collision if you other devices with M=
ACs=20
ending in dd:ee:ff like aa:aa:cc:dd:ee:ff, aa:aa:aa:dd:ee:ff, and so=20
on.</font></div></div></blockquote><div><br>What is the occurrence probabil=
ity of &quot;r&quot; =A0MAC-Adress twon agree on their last two bytes?<br>
<br>
This is similar to the birthday paradox: At a meeting of r&gt; 2 people
which is the number of people needed for the probability that two men
have same birthday sould be 99%? The solution is in many books and that
can view at:<br>
<br>
<a href=3D"http://en.wikipedia.org/wiki/Birthday_problem" target=3D"_blank"=
>http://en.wikipedia.org/wiki/Birthday_problem</a><br>
<br>
Then, At a meeting of 60 people there is the 99% probability =A0of the
least two men have a =A0birthday the same day. So,, Similarly to the case
of MAC-Adress is:<br>
<br>
P(r)=3D1-65536!/(65536^r * (65536-r)!)<br>
<br>
where *! is factorial operator, and &quot;r&quot; is the Mac-Adress.<br>
<br>
Well if the calculations are not mistake, we obtain r =3D 13,107
MAC-Adress minimun in the same site then 99% probability two matches in
his last two bytes.<br>
<br>
Now a new MAC entering, which is the probability that given &quot;n&quot;
MAC-Adress,,, all with two last byte differents this new MAC =A0matches
with any MAC-Adress in its last two bytes? Well this is:<br>
<br>
P(n)=3D1-(65535/65536)^n =A0then when n=3D13107 is =A0P(13107)=3D0.18 or 18=
%. That is MAC-paradox...<br>
<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px so=
lid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net">B.A.T.M.A.N@lists.open-m=
esh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
<br></blockquote></div><br>

--000e0cd6b4da42ef420473ca01fe--
