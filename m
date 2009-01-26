From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Jan 2009 07:11:12 +0100
References: <497CE6F6.7090504@francofon.fr>
In-Reply-To: <497CE6F6.7090504@francofon.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901260711.12511.lindner_marek@yahoo.de>
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


Hi,

> How can i debug this problem.
> I've use "-d 4" but i don't have see problem in log.

please use log level 3 to get more information on gateway and routing issues. 
Level 4 is for the routing protocol.


>     root@Fonera:~# /tmp/batmand -o 2000 -g 5000 ath2 -d 4
>     Interface activated: ath2

Note: "-g 5000" is the batman 0.2 syntax for gatewaying. This is not a problem 
because batman tries to guess what it could mean:

>     gateway class: 49 -> propagating: 4MBit/1024KBit

but may lead to wrong values. Use "batmand -H" to see the correct syntax.
I'm pretty sure its unrelated to your current issue.

Regards,
Marek

