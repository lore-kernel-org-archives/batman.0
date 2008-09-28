Message-ID: <48DFDA1A.4000503@ddmesh.de>
Date: Sun, 28 Sep 2008 21:25:14 +0200
From: Freifunk <freifunk@ddmesh.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] batman-exp hang on 95% CPU load
References: <e11ab4a352cc7f56557957a5d5eed927.squirrel@wm.ddmesh.de>
	<200809272153.07235.axel@open-mesh.net>
In-Reply-To: <200809272153.07235.axel@open-mesh.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Axel,

> but I dont remember which PID caused the trouble. Do you have an idea for how 
> long the daemon was running without any interruption ? 
I can not say how long batman was running, but I think about two days. But an other
router that are using the same firmware are running since weeks.

> 
> The PID which referenced the hanging thread seems to be the debug thread. 
> Perhaps the problem was related to the bug which Sven Eckelmann identified 
> recently. Revision 1123 for bmx has no dedicated thread for debugging 
> anymore. So if this was the problem it should be fixed now.
I will try it. but I think that I can not give a "it is working now" because the hanging
batmand issue happend only once.

bye
  Stephan

