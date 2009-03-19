Sender: erminia.loreto@java-system.com
From: "Marco Tozzini" <lists@java-system.com>
Date: Thu, 19 Mar 2009 13:55:48 +0100
Message-id: <49c240d4.2c9.6a79.136927888@webmaildh6.aruba.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [B.A.T.M.A.N.] Problem with B.A.T.M.A.N. 0.3.1 rv1206
	(compatibility version 5)
Reply-To: lists@java-system.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

----- Original Message Follows -----
From: Max <rey.web.mail@gmail.com>

> Good afternoon to everybody!
> 
> I have to deal with 2 big problems occurred when I run
> batmand 0.3.1 rv 1206 in meshboxs equipped with OpenWrt
> Kamikaze 8.09 I detect the following problems:
> 1) B.A.T.M.A.N. daemon only works whether launched in
> debug mode. I'm sure about this because I'm monitoring the
> network with a packet sniffer

...

> 
> Best regards,
> Massimo Reineri
> 

Hi Massimo,

Please don't blame me for this, but ...
did you start batman this way:
batman -d 1 ath0
I my case batman remain in foreground and if you send ^C it
stops

I used
batmand ath0
and then
batman -c -d 1
to see what happens to daemon in background

Ciao
Marco



