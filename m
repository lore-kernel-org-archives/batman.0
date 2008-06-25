Message-ID: <0e192879c584de17adb2dbfc872a5004.squirrel@wm.ddmesh.de>
Date: Wed, 25 Jun 2008 11:41:25 +0200 (CEST)
From: freifunk@ddmesh.de
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] using routing script in addtion to batman routing
	rules
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

Hi,

I'm using batmand-experimental rev 1066 and it works fine.
The batmand sets all routes and rules as I have specified by arguments.
But additional I need to run a script to detect any routing changes of the
deamon. It is important that batmand still sets the routes as usual and
also runs the "routing-script" in addition to it. I like to use this for
other purposes.

I have heard that you already have a similar functionality implemented in
different batman branches. But this option will turn off setting the
routes
and rules of batmand.

Can you please add/merge this functionality it to the exp-branch and perhaps
add an option so that the normal route/rule setting is not turned off.
The reason for this is that I like to detect the current gateway changes.

Another questions is, why does the node that offers a gateway not be listed
itself in its batmand -cd2 screen?
It is possible that you add this. The web interface of the router displays
the currently used gateway, but it does not list it if the router self
offers the internet connection. I just grep for the "==>" of the batmand
-cbd2 screen.

Regards
 Stephan







