From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batman-exp hang on 95% CPU load
Date: Sat, 27 Sep 2008 21:53:06 +0200
References: <e11ab4a352cc7f56557957a5d5eed927.squirrel@wm.ddmesh.de>
In-Reply-To: <e11ab4a352cc7f56557957a5d5eed927.squirrel@wm.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809272153.07235.axel@open-mesh.net>
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

Hi Stephan,


On Mittwoch 24 September 2008, Stephan Enderlein (Freifunk Dresden) wrote:
> Hi,
>
> I currently use batman-experimental rev 1105. Yesterday
> a node was not reachable. The "top" showed me that batmand
> was running with almost 100% load.
>
...
> Do you have already seen this?
No, not recently. I've seen something similar (see:
https://list.open-mesh.net/pipermail/b.a.t.m.a.n/2008-January/000550.html )
but I dont remember which PID caused the trouble. Do you have an idea for how 
long the daemon was running without any interruption ? 

The PID which referenced the hanging thread seems to be the debug thread. 
Perhaps the problem was related to the bug which Sven Eckelmann identified 
recently. Revision 1123 for bmx has no dedicated thread for debugging 
anymore. So if this was the problem it should be fixed now.

greetings
/axel
