Date: Mon, 29 Jan 2007 18:45:39 +0100 (MET)
From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] -p ... crashes
References: <001601c743c1$16212ad0$0105a8c0@bluebox>
In-Reply-To: <001601c743c1$16212ad0$0105a8c0@bluebox>
MIME-Version: 1.0
Content-Type: text/plain;  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701291838.17909.lindner_marek@yahoo.de>
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


Hi,


> i've seen this behavior bevor, but couln't reproduce it until now:
> This happens reproduceble ~30-60sec. after start.
> Until this point routes are written.
> No output. No purging of written routes.

could you send a core dump and your binary ?

How to create a core dump:
Connect to your device (via ssh) and type:
ulimit -c 20000
Afterwards start batmand with a debug level > 0, e.g.:
batmand -d 3 -p <gateway> -r 2 eth1:bat br0:bat
Wait until it crashed and you will find a file named "core" in your current 
directory which represents the state of batman in the moment when it crashed.

Regards,
Marek
