Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 23 Mar 2010 06:24:27 +0800
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201003230624.27617.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 0.2.1 released
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
To: b.a.t.m.a.n@lists.open-mesh.net


The B.A.T.M.A.N. team hereby announces the release of the first bugfix milestone 
for the batman-adv 0.2 branch which focuses on stability but also brings 
improvements and small changes. As the kernel module always depends on the 
Linux kernel it was compiled against, it does not make sense to provide 
binaries on our website. As usual, you will find the signed tarballs in our 
download section:
http://downloads.open-mesh.net/batman/releases/batman-adv-0.2.1/
as well as prepackaged binaries in your distribution.


Important changes
----------------

The batman-adv logging facilities underwent structural changes to fully 
integrate into the standard Linux logging mechanisms. Please study the README 
to get further details on how to access the debug logs. In addition, the "vis" 
/proc file has been split up into two files: vis_server and vis_data. The 
vis_server controls the vis server status whereas the vis_data file exports the 
visualization "raw" data which can be easily parsed by user space tools. 
Again, details can be found in our documentation.


Thanks
----------------

Special thanks go to:

 * Andrew Lunn for going through the entire code base to refactor the code and  
   adjust the coding style to match standard Linux coding style guidelines
 * Linus Luessing for his restless testing in so many scenarios and sending a
    lot of patches and suggestions. 

Thanks to all people sending in patches:

 * Andrew Lunn <andrew@lunn.ch>
 * Julia Lawall <julia@diku.dk>
 * Linus Luessing <linus.luessing@web.de>
 * Marek Lindner <lindner_marek@yahoo.de>
 * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
 * Sven Eckelmann <sven.eckelmann@gmx.de>
 * Sven-Thorsten Dietrich <sdietrich@novell.com> 


batman-adv
----------------

Albeit being a bugfix release we dared to include some bigger changes because 
we felt their gain outweighs the risk. For instance, we replaced the packet 
handling thread which was responsible for routing the payload data through the 
mesh by an advanced skbuff handling technique. Now, packets are received 
directly by registering the Ethernet type and handling skbs instead of self-
allocated buffers which boosts the performance considerably and reduces 
latency.
On the other hand batman-adv is moving towards full Linux kernel integration 
which requires some significant changes under the hood as well as on the 
surface. Batman's own logging facility has been removed (the standard Linux 
logging is used instead). The vis output comes now in a neutral format, easily 
parsable by user space applications. Since the module entered the official Linux 
realm several people threw static code analyzers (e.g. Coccinelle, sparse) 
onto the code to find bugs. Some (possible) memory leaks, optimizations and a 
false alarms have been found and dealt with. Many more bugs, race conditions 
and crashes have been fixed. Now, it also is possible to change the MAC address 
on bat0.


batctl
----------------

Since the vis output format has changed, batctl received a parser for the 
neutral format to convert the output into either dot draw or JSON. If you wish 
to write your own parser, please see our documentation and/or the batctl code 
as an example. The batman-adv debug log will show up in the standard kernel 
logs of your system, hence to access the logs "batctl log" is not needed any 
longer. Please use the tools provided by your distribution 
(dmesg/logread/syslog/etc). However, "batctl log" remains available and can be 
used to filter existing logfiles for batman-adv output and to replace the mac 
addresses by bat-host names.


Happy routing,
The B.A.T.M.A.N. team
