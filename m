Message-ID: <d5bba6ce0811040637r2c7c267ap3ab1de99d91a06c6@mail.gmail.com>
Date: Tue, 4 Nov 2008 12:37:13 -0200
From: "Julio Cesar Puigpinos" <jcpuigpinos@gmail.com>
Subject: Re: [B.A.T.M.A.N.] BMX problem in r1138 with client node and tun
In-Reply-To: <200811041044.29172.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d5bba6ce0810251333r67247a0cpaf164be0e33b0f38@mail.gmail.com>
	<200810292133.58495.axel@open-mesh.net>
	<d5bba6ce0811031526y6073839eibd9b8c486b9178e6@mail.gmail.com>
	<200811041044.29172.axel@open-mesh.net>
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

2008/11/4 Axel Neumann :
> Hi,

Hi

> On Dienstag 04 November 2008, Julio Cesar Puigpinos wrote:
> [...]
>> Well, after several (and painfull :) ) tests we could determinate 2
>> scenarios: 1) BMX started like this "bmxd -o 2000 -g 5000 ath2", it didn't
>
> THANX a lot for your painfull testing! That was the tip. I was not aware that
> forking to backgound after launching a new thread is so problematic. And
> because i forgot that my initscripts on the foneras always added -d3 and
>>/dev/zero & to the commandline the problem never appeared. Should be fixed
> with rv1148.

YW, it was worth.

I've tested r1148 and is working :)

This saturday we're gonna test it deeply with Nightwing.

> best regards,
> axel

                    Saludos, Julio

-- 
www.lugro-mesh.org.ar/        Wireless Mesh Networks Group
www.lugro.org.ar                         GNU/Linux User Group Rosario, Argentina
Slackware rulez :P             www.slackware.org
NO A LA MATRICULA!!!: http://noalamatricula.wordpress.com/
