Message-ID: <20080105214740.n00x2uza0coowssk@webmail.ddmesh.de>
Date: Sat, 05 Jan 2008 21:47:40 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
Subject: Re: [B.A.T.M.A.N.] Memory leak
References: <20080104105751.q5lswookggc040gk@webmail.ddmesh.de>
	<200801042124.18425.axel@open-mesh.net>
In-Reply-To: <200801042124.18425.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

I have checked the problem a little more. Beside the "top" command on debian
can show the same as the "top" does on WRTs. If you press 'H' the threads are
also shown. Perhaps the implementation of the "top" or "ps" show the  
threads too.

There are four batmand threads running. After a while one thread is  
terminated for about 100 seconds (25 x 4 seconds) and a new thread is  
created after
this time. At this time the memory needs is increased. It seams that  
at each thread-kill-restart 16 Kbytes are wasted. The virtual assinged  
memory increases
and also the %-Value used.

Below you will see the values (memory and pid) delivered by "top" for one
incrementation.
Hope it gives you a hint.
Why is the thread killed and created? There is no client conntected to any
router. rdate is restarted periodically and the laptop is telling that it has
an internet connection (configured through batmand arguments, which is  
wanted).
Note that the laptop does not have a connection to internet. It just pretends
it has one.


MEM: 1180   8%
PIDS:1 -> 893 -> 894 -> 895
                      -> 2673

Pid 2673 terminates
MEM: 1180   8%
....
100 seconds
....
MEM: 1180   8%
Pid 3751 is created
MEM: 1196   9%
1 -> 893 -> 894 -> 895
                 -> 3751
MEM: 1196   9%


Bye
  Stephan



