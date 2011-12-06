Return-Path: <marko.panger@agblab.com>
Message-ID: <4EDDE473.5020008@agblab.com>
Date: Tue, 06 Dec 2011 10:46:27 +0100
From: Marko Panger - AGB Lab <marko.panger@agblab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] TT inconsistency problem (again)
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

Hi,

I'm evaluating the possibility to use batman in our next product 
(measurement equipment) and I'm facing problems in using batman.
I have five nodes installed around and I experience black-outs in 
connection among nodes. The resoult is I can't ping a certain node anymore.

Here is the output from 'batctl o' and the subsequent ping to a node 
which has good link quality (TQ):

[root@gtam00119 ~]# batctl o
[B.A.T.M.A.N. adv 2011.4.0, MainIF/MAC: ra0/48:5d:60:b8:a2:f6 (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
48:5d:60:b8:a2:b7    0.974s   (202) 48:5d:60:b8:a3:0e [       ra0]: 
48:5d:60:b8:a2:d2 (  0) 48:5d:60:b8:a3:0e (202)
48:5d:60:b8:a3:0e    0.439s   (249) 48:5d:60:b8:a3:0e [       ra0]: 
48:5d:60:b8:a2:d2 (231) 48:5d:60:b8:a3:0e (249)
48:5d:60:b8:a2:d2    0.749s   (250) 48:5d:60:b8:a2:d2 [       ra0]: 
48:5d:60:b8:a3:0e (235) 48:5d:60:b8:a2:d2 (250)
48:5d:60:b8:a2:ff    0.156s   (209) 48:5d:60:b8:a3:0e [       ra0]: 
48:5d:60:b8:a2:d2 (  0) 48:5d:60:b8:a3:0e (209)

[root@gtam00119 ~]# batctl ping 48:5d:60:b8:a3:0e
PING 48:5d:60:b8:a3:0e (48:5d:60:b8:a3:0e) 20(48) bytes of data
Reply from host 48:5d:60:b8:a3:0e timed out
Reply from host 48:5d:60:b8:a3:0e timed out
Reply from host 48:5d:60:b8:a3:0e timed out
Reply from host 48:5d:60:b8:a3:0e timed out

And this is the output from 'batctl ll tt routes' from he node that is 
being pinged (see above):

[     63665] Sending TT_REQUEST to 48:5d:60:b8:a2:b7 via 
48:5d:60:b8:a2:ff [.]
[     63665] TT inconsistency for 48:5d:60:b8:a2:ff. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 0 crc: 19133 last_crc: 0 
num_changes: 0)
[     63666] TT inconsistency for 48:5d:60:b8:a2:b7. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 0 crc: 22851 last_crc: 0 
num_changes: 0)
[     63666] TT inconsistency for 48:5d:60:b8:a2:ff. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 0 crc: 19133 last_crc: 0 
num_changes: 0)
[     63666] Sending TT_REQUEST to 48:5d:60:b8:a2:ff via 
48:5d:60:b8:a2:ff [.]
[     63667] TT inconsistency for 48:5d:60:b8:a2:b7. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 0 crc: 22851 last_crc: 0 
num_changes: 0)
[     63667] TT inconsistency for 48:5d:60:b8:a2:ff. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 0 crc: 19133 last_crc: 0 
num_changes: 0)
[     63668] TT inconsistency for 48:5d:60:b8:a2:b7. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 0 crc: 22851 last_crc: 0 
num_changes: 0)
[     63668] TT inconsistency for 48:5d:60:b8:a2:ff. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 0 crc: 19133 last_crc: 0 
num_changes: 0)
[     63669] TT inconsistency for 48:5d:60:b8:a2:b7. Need to retrieve 
the correct information (ttvn: 1 last_ttvn: 0 crc: 22851 last_crc: 0 
num_changes: 0)

This situation was triggered by the following procedure:
1) from node (last two octets) 'a2:f6' the 'a3:0e' node was pinged
2) in the middle a ssh connection from the node 'a2:f6' was made to the 
node 'a3:0e'.
3) so far so good
4) the node 'a3:0e' was rebooted by issuing the 'reboot' command in the 
console
5) after this the connection is lost and the above logs were produced

I'm using the version 2011.4.0 on all nodes:
[root@gtam00119 ~]# batctl -v
batctl 2011.4.0 [batman-adv: 2011.4.0]

Any help is highly appreciated. I might be doing something wrong, but 
seems a stability problem.

Marko

