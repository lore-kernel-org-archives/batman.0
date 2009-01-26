From: "SoukoussMan - FrancoFON CEO" <soukoussman@francofon.fr>
References: <497CE6F6.7090504@francofon.fr>	<200901260711.12511.lindner_marek@yahoo.de>	<497D7F55.9040104@francofon.fr>
	<200901261808.22139.lindner_marek@yahoo.de>
In-Reply-To: <200901261808.22139.lindner_marek@yahoo.de>
Date: Mon, 26 Jan 2009 12:25:32 +0100
Message-ID: <003401c97fa8$cd3c1570$67b44050$@fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: fr
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

Hi,

When batmand is launch and show this :
root@Fonera:~# /usr/bin/batmand -g 1mbit/1024 -o 2000 -d 3 ath2
Interface activated: ath2
Using interface ath2 with address 5.0.0.1 and broadcast address
5.255.255.255
B.A.T.M.A.N. 0.3.1 rv1203 (compatibility version 5)
Warning - batgat kernel modul interface (/dev/batgat) not usable: No =
such
file or directory
This may decrease the performance of batman!
debug level: 3
originator interval: 2000
gateway class: 39 -> propagating: 1024KBit/1024KBit
Adding route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)

I do this command :=20
root@Fonera:~# ip route ls table 254
192.168.182.0/24 dev tun0  proto kernel  scope link  src 192.168.182.1=20
192.168.18.0/24 dev eth0.1  proto kernel  scope link  src 192.168.18.3=20
192.168.10.0/24 dev br-lan  proto kernel  scope link  src 192.168.10.1=20
5.0.0.0/8 dev ath2  proto kernel  scope link  src 5.0.0.1=20
default via 192.168.18.1 dev eth0.1=20
root@Fonera:~#

The route isn't present in the table 254.


Cordialement,

--=20
FrancoFON CEO and Founder
SoukoussMan@FrancoFON.fr
Communaut=E9 des foneros francophones - www.francofon.fr

-----Message d'origine-----
De=A0: b.a.t.m.a.n-bounces@open-mesh.net
[mailto:b.a.t.m.a.n-bounces@open-mesh.net] De la part de Marek Lindner
Envoy=E9=A0: lundi 26 janvier 2009 11:08
=C0=A0: The list for a Better Approach To Mobile Ad-hoc Networking
Objet=A0: Re: [B.A.T.M.A.N.] problem with batman test


Hi,

> Adding route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)
> ^CDeleting route to 169.254.0.0/16 via 0.0.0.0 (table 254 - gate0)
> Error - can't delete route to 169.254.0.0/16 via 0.0.0.0 (table 254): =
No
> such process
> Deleting all BATMAN routes
> Interface deactivated: ath2
>
> The route isn't add when batmand is launch.

I just ran the same command as you and it works as expected. Why are you =
so=20
sure that the route is not added ? Batman would throw an error message=20
(similar to the delete error). But it does not happen. May be something =
else

deletes the route ?
Could you check whether the command "logread" reveals more clues ?

Regards,
Marek

_______________________________________________
B.A.T.M.A.N mailing list
B.A.T.M.A.N@open-mesh.net
https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n

