Message-ID: <497D7F55.9040104@francofon.fr>
Date: Mon, 26 Jan 2009 10:16:05 +0100
From: SoukoussMan <soukoussman@francofon.fr>
MIME-Version: 1.0
References: <497CE6F6.7090504@francofon.fr>
	<200901260711.12511.lindner_marek@yahoo.de>
In-Reply-To: <200901260711.12511.lindner_marek@yahoo.de>
Content-Type: multipart/alternative;
	boundary="------------000304090400050908080506"
Subject: Re: [B.A.T.M.A.N.] problem with batman test
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

This is a multi-part message in MIME format.
--------------000304090400050908080506
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

I've make a new test with the right syntax :
root@Fonera:~# /usr/bin/batmand -g 1mbit/1024 -o 2000 -d 3 ath2
Interface activated: ath2
Using interface ath2 with address 5.0.0.1 and broadcast address=20
5.255.255.255
B.A.T.M.A.N. 0.3.1 rv1203 (compatibility version 5)
Warning - batgat kernel modul interface (/dev/batgat) not usable: No=20
such file or directory
This may decrease the performance of batman!
debug level: 3
originator interval: 2000
gateway class: 39 -> propagating: 1024KBit/1024KBit
Adding route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)
^CDeleting route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)
Error - can't delete route to 169.254.0.0/16 via 0.0.0.0 (table 254): No =

such process
Deleting all BATMAN routes
Interface deactivated: ath2

The route isn't add when batmand is launch.

Someone have a idea ?



Marek Lindner a =C3=A9crit :
> Hi,
>
>  =20
>> How can i debug this problem.
>> I've use "-d 4" but i don't have see problem in log.
>>    =20
>
> please use log level 3 to get more information on gateway and routing i=
ssues.=20
> Level 4 is for the routing protocol.
>
>
>  =20
>>     root@Fonera:~# /tmp/batmand -o 2000 -g 5000 ath2 -d 4
>>     Interface activated: ath2
>>    =20
>
> Note: "-g 5000" is the batman 0.2 syntax for gatewaying. This is not a =
problem=20
> because batman tries to guess what it could mean:
>
>  =20
>>     gateway class: 49 -> propagating: 4MBit/1024KBit
>>    =20
>
> but may lead to wrong values. Use "batmand -H" to see the correct synta=
x.
> I'm pretty sure its unrelated to your current issue.
>
> Regards,
> Marek
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>  =20

--=20
-----
FrancoFON CEO and Founder
Pr=C3=A9sident de l'association FrancoFON
Communaut=C3=A9 des foneros francophones - http://www.francofon.fr


--------------000304090400050908080506
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"=
>
</head>
<body bgcolor=3D"#ffffff" text=3D"#333399">
<font size=3D"+1"><font face=3D"Courier New, Courier, monospace">Hi,<br>
<br>
I've make a new test with the right syntax : <br>
root@Fonera:~# /usr/bin/batmand -g 1mbit/1024 -o 2000 -d 3 ath2<br>
Interface activated: ath2<br>
Using interface ath2 with address 5.0.0.1 and broadcast address
5.255.255.255<br>
B.A.T.M.A.N. 0.3.1 rv1203 (compatibility version 5)<br>
Warning - batgat kernel modul interface (/dev/batgat) not usable: No
such file or directory<br>
This may decrease the performance of batman!<br>
debug level: 3<br>
originator interval: 2000<br>
gateway class: 39 -&gt; propagating: 1024KBit/1024KBit<br>
Adding route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)<br>
^CDeleting route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)<br>
Error - can't delete route to 169.254.0.0/16 via 0.0.0.0 (table 254):
No such process<br>
Deleting all BATMAN routes<br>
Interface deactivated: ath2<br>
<br>
The route isn't add when batmand is launch.<br>
<br>
Someone have a idea ?<br>
<br>
<br>
</font></font><br>
Marek Lindner a =C3=A9crit=C2=A0:
<blockquote cite=3D"mid:200901260711.12511.lindner_marek@yahoo.de"
 type=3D"cite">
  <pre wrap=3D"">Hi,

  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">How can i debug this problem.
I've use "-d 4" but i don't have see problem in log.
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
please use log level 3 to get more information on gateway and routing iss=
ues.=20
Level 4 is for the routing protocol.


  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">    root@Fonera:~# /tmp/batmand -o 2000 -g 5000 ath2 -=
d 4
    Interface activated: ath2
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
Note: "-g 5000" is the batman 0.2 syntax for gatewaying. This is not a pr=
oblem=20
because batman tries to guess what it could mean:

  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">    gateway class: 49 -&gt; propagating: 4MBit/1024KBi=
t
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
but may lead to wrong values. Use "batmand -H" to see the correct syntax.=

I'm pretty sure its unrelated to your current issue.

Regards,
Marek

_______________________________________________
B.A.T.M.A.N mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:B.A.T.M.A.N@open-mes=
h.net">B.A.T.M.A.N@open-mesh.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.open-mesh.net/mm=
/listinfo/b.a.t.m.a.n">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.=
n</a>
  </pre>
</blockquote>
<br>
<pre class=3D"moz-signature" cols=3D"72">--=20
-----
FrancoFON CEO and Founder
Pr=C3=A9sident de l'association FrancoFON
Communaut=C3=A9 des foneros francophones - <a class=3D"moz-txt-link-freet=
ext" href=3D"http://www.francofon.fr">http://www.francofon.fr</a>
</pre>
</body>
</html>

--------------000304090400050908080506--
