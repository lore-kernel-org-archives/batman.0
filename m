From: Marek Lindner <lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Disposition: inline
Date: Sat, 29 Sep 2007 00:27:50 +0200
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Message-Id: <200709290027.50827.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] 0.3 beta released
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


Hi,

the 0.2 branch has proven to be quite stable and robust but with many rough 
edges. We used this fundament to work on annoyances and improvements all 
over the code to make the upcoming release a worthy successor.

We are very proud to announce that B.A.T.M.A.N. has an official port assigned 
by the IANA now. It is 4305 and already in the code. You can see it for 
yourself: http://www.iana.org/assignments/port-numbers 
Pay attention to the fact that all ports used by B.A.T.M.A.N. are changing: 
4305 for OGMs, 4306 for the tunneling and 4307 for the vis server. Adjust 
your firewall settings if required.

Another big step forward is our new experimental routing code - we call it 
B.A.T.M.A.N. IV. It takes asymmetric routing into account. Currently we have 
several ideas competing for the final inclusion into the release. Feel free 
to join our testing team.
If you use the stable branch you will find the TQ (Transmit Quality) algorithm 
enabled. Each node observes its neighbor nodes and measures the link quality 
and adds this information to all (re)broadcasted packets. The clients 
choose the route with the best tq value. Use debug level 1 to get the tq 
information.

Also, we heavily worked to improve the overall performance of our buitin 
tunneling. Therefore we created mod_batgat -  a linux kernel module which will 
do the job from within the kernel land. It still needs some love and to be 
backported to 2.4 but it certainly will be finished for the release.

The whole gateway management received a lot attention. We have new gateway 
classes which support down- and upload rates. Just specify your speeds and 
B.A.T.M.A.N. will guess the appropriate gateway class. The routing classes 
have been reworked as well. The user can choose between fast, stable or 
fast-switching connection. The B.A.T.M.A.N. internet client can detect broken 
gateways (blackholes) to avoid them. All internet related options can be 
changed during runtime. Disabling the own gateway, change the preferred 
gateway or routing class is possible without restarting the daemon.

We also improved the quality of our documentation and thanks to the hard work 
of Wesley we have a man page with a compete overview about all options 
accompanied by a usage example section.

Our vis server was a bit hidden in the past but it steadily made progress and 
is now a stable powerful application. It can handle multiple interfaces, HNA 
and is small enough to run on embedded devices. We will provide precompiled 
packages for it from now on. Therefore we release its first beta version. In 
order to avoid confusion in the future the vis server will get the same 
version numer as the compatible batman release. That makes it 0.3 beta as 
well.


The B.A.T.M.A.N. dev team

