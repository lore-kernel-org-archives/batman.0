Return-Path: <ylonen@gmx.net>
Content-Type: multipart/mixed; boundary="========GMX294631263912711800448"
Date: Tue, 19 Jan 2010 15:51:51 +0100
From: =?iso-8859-1?Q?=22Juha_Yl=F6nen=22?= <ylonen@gmx.net>
In-Reply-To: <201001192007.38210.lindner_marek@yahoo.de>
Message-ID: <20100119145151.294630@gmx.net>
MIME-Version: 1.0
References: <20100118112706.91160@gmx.net>
	<201001182138.32432.lindner_marek@yahoo.de>	<20100119074334.275290@gmx.net>
	<201001192007.38210.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--========GMX294631263912711800448
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


-------- Original-Nachricht --------
> Datum: Tue, 19 Jan 2010 20:07:38 +0800
> Von: Marek Lindner <lindner_marek@yahoo.de>
>
> It confirmed what we saw in the other logs: This device (the laptop?) does
> not 
> see the packets from the other side, therefore the protocol correctly
> assumes  
> a dead link. There might be 2 reasons: either the wifi layer does not
> really 
> work or batman-adv drops the packets without any further warning. 
> You can try the latest trunk and/or run batctl/wireshark on the laptop to 
> deep-inspect the packets. Feel free to share the logs with us.

I got the latest trunk up and running, some changes were required to get it to crosscompile for ARM (and 2.6.24 kernel). Same behaviour as before, device log shows a lot of activity, but laptop batman doesn't seem to be doing much anything. I tried the wireshark and got a log ok (which shows a lot of multicast traffic from the device until I disabled the service) but I'm at loss to decipher possible batman packages. What should they look like in wireshark? I only noticed couple of IPX packages from device to (broadcast?) but nothing else. I attached the log file, is anyone able to say if there are batman packages included?

-Juha
-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.5 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/chbrowser

--========GMX294631263912711800448
Content-Type: application/octet-stream; name="ARM-adhoc-batman"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ARM-adhoc-batman"


--========GMX294631263912711800448--
