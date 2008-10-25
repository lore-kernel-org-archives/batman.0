Message-ID: <d5bba6ce0810251340w25e0d17awe3cea427b0512be9@mail.gmail.com>
Date: Sat, 25 Oct 2008 18:40:17 -0200
From: "Julio Cesar Puigpinos" <jcpuigpinos@gmail.com>
In-Reply-To: <d5bba6ce0810251333r67247a0cpaf164be0e33b0f38@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d5bba6ce0810251333r67247a0cpaf164be0e33b0f38@mail.gmail.com>
Subject: [B.A.T.M.A.N.] Re: BMX problem in r1138 with client node and tun
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
To: b.a.t.m.a.n@open-mesh.net

2008/10/25 Julio Cesar Puigpinos :
> Hi
>
> I'm having a problem with bmxd-r1138, bat0 is not created in client node.
> The gateway is started with: -o 2000 -g 5000 ath2. The client is
> started with: -o 2000 -r 1 ath2
>
> Using this parameters and OpenWRT Kamikaze r13037 in the nodes:

Sorry, a typo. it's bmxd-r1069, not bmxd-r1062 :)

The right table is this:

    client                 gw                     Works?
 bmxd-r1069        bmxd-r1069             YES
 bmxd-r1138        bmxd-r1069             YES
 bmxd-r1138        bmxd-r1138             NO
 bmxd-r1069        bmxd-r1138             NO


> [...]

        Saludos, Julio

-- 
www.lugro-mesh.org.ar/        Wireless Mesh Networks Group
www.lugro.org.ar                         GNU/Linux User Group Rosario, Argentina
Slackware rulez :P             www.slackware.org
NO A LA MATRICULA!!!: http://noalamatricula.wordpress.com/
