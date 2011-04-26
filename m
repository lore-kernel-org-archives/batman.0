Return-Path: <gollab@interia.pl>
Message-ID: <4DB7320A.3070907@interia.pl>
Date: Tue, 26 Apr 2011 22:58:50 +0200
From: =?UTF-8?B?S3J6eXNpZWsgR2/FgsSZYmlld3NraQ==?= <gollab@interia.pl>
MIME-Version: 1.0
References: <4DB720B8.2040309@interia.pl>
In-Reply-To: <4DB720B8.2040309@interia.pl>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Batmand - ping 169.254.0.0 from client is not
 working.
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

I have to correct my previous email, unfortunately I made a mistake.

 > I have noticed that when I stop my firewall I will have Internet on 
computer PC (on the gateway) and batmand is not working properly. After 
my firewall was > started, batmand works properly but I can`t use the 
Intenet then. I have solved it by changing rule forward from REJECT to 
ACCEPT (on router gateway and on > the router client) in firewall 
settings. My firewall is working at the moment and I can start batmand 
and it works properly. I can browse websites in my
 > internet browser and ping hosts. Ping from the PC connected to router 
client works too.

Of course situation is opposite. When I start firewall batmand won`t 
work properly and I have access to Internet. When I stop firewall 
batmand will work properly but I can`t access to Internet (I think about 
PC connected to routers). I think there are rules to forward packets 
between LAN and WAN.

Is there any possibility to change posts in archive?

Cheers,
Krzysiek.

---------------------------------------------
Ksiegowa radzi: Jak załozyc firme w 15 minut?
http://linkint.pl/f2968

