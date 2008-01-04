Message-ID: <20080104105751.q5lswookggc040gk@webmail.ddmesh.de>
Date: Fri, 04 Jan 2008 10:57:51 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Memory leak
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
To: "Open-Mesh, Mailinglist" <b.a.t.m.a.n@open-mesh.net>

Hello,

I have a problem where batman (rev871 and rev908) consumes more and  
more memory
until the router has no memory.
I  have added the output of the "top" command and the command line  
arguments of my setup.

(WRT 10-1).....wlan.......(wrt 10-2) =======tinc vpn=====(laptop debian 0-1)
kernel 2.4.32              kernel 2.4.32                  kernel 2.6


I have seen that one batman thread changes the PID where the other  
stay the same.
Below you will find the "top" output for batmand when it was started and after
about one hour.
The batmand running on kernal 2.6 does not increment its memory needs.
Perhaps there are some allocation of memory that is not freed because of the
arguments of the batmand.
There is no special traffic on those nodes, they just are connected.

Any Ideas?
Regards
  Stephan

linux 2.6. (0-1)
/usr/bin/batmand -g 1024/200 -a 104.61.0.0/16 -a 141.56.20.5/32 -s  
10.12.0.1 --no-unreachable-rule
--no-throw-rules --no-prio-rules --resist-blocked-send wifi tbb /t 1 /i /A
wifi is a unused bridge
1 batmand
   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  6612 root      15   0 19136  684  532 S  0.3  0.1   0:27.85 batmand

####################################################################

linux 2.4.32 (wrt GL 10-2)
/sbin/batmand -s 10.12.0.1 -a 10.12.10.16/28 -r 2 --t 63  
--no-unreachable-rule --no-throw-rules --no-prio-rules
  --resist-blocked-send eth1 tbb /t 1 /i /A

3 batmands
   PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND
   847   846 root     S     1196   4%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.16/28 -r 2 --t 63 --no-unreachable-rule
  3937   847 root     S     1196   4%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.16/28 -r 2 --t 63 --no-unreachable-rule
   848   847 root     S     1196   4%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.16/28 -r 2 --t 63 --no-unreachable-rule
----------
   848   847 root     S     2076   7%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.16/28 -r 2 --t 63 --no-unreachable-rule
   847   846 root     S     2076   7%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.16/28 -r 2 --t 63 --no-unreachable-rule
22570   847 root     S     2076   7%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.16/28 -r 2 --t 63 --no-unreachable-rule


####################################################################

linux 2.4.32 (wrt GL 10-1)
/sbin/batmand -s 10.12.0.1 -a 10.12.10.0/28 -r 2 --t 63  
--no-unreachable-rule --no-throw-rules --no-prio-rules  
--resist-blocked-send eth1

4 batmands
   PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND
   837     1 root     S     1292   9%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.0/28 -r 2 --t 63 --no-unreachable-rule -
   838   837 root     S     1292   9%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.0/28 -r 2 --t 63 --no-unreachable-rule -
11854   838 root     S     1292   9%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.0/28 -r 2 --t 63 --no-unreachable-rule -
   839   838 root     S     1292   9%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.0/28 -r 2 --t 63 --no-unreachable-rule -
---------
   837     1 root     S     2172  15%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.0/28 -r 2 --t 63 --no-unreachable-rule -
   838   837 root     S     2172  15%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.0/28 -r 2 --t 63 --no-unreachable-rule -
30544   838 root     S     2172  15%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.0/28 -r 2 --t 63 --no-unreachable-rule -
   839   838 root     S     2172  15%   0% /sbin/batmand -s 10.12.0.1  
-a 10.12.10.0/28 -r 2 --t 63 --no-unreachable-rule -


