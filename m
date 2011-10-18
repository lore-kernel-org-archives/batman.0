Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 19 Oct 2011 00:44:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201110190044.38983.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2011.3.1 released
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Today, the B.A.T.M.A.N. team releases an update for the 2011.3.0 release which 
corrects small but crucial bugs introduced within the last release. This is a 
pure bug fix release without any new features or protocol modifications. 
Everyone is strongly encouraged to upgrade to this version. As the kernel 
module always depends on the Linux kernel it was compiled against, it does not 
make sense to provide binaries on our website. As usual, you will find the 
signed tarballs in our download section: 

http://downloads.open-mesh.org/batman/releases/batman-adv-2011.3.1/ 

as well as prepackaged binaries in your distribution.


Thanks
------

Thanks to all people sending in patches:

   * Antonio Quartulli <ordex@autistici.org>

Special thanks go to: 

   * TY Wu for isolating / debugging the packet latency bug
   * Junkeun Song for his help and ideas to find the translation table bugs
   * Marek Lindner for debugging support and suggestions


batman-adv
----------

The high latency (4-5 times higher than usual) that could be observed when the 
gateway mode was activated because batman-adv broadcasted all packets instead 
of sending them via unicast, was fixed. The reported issues with non-mesh 
clients communicating with other clients have been addressed too: The 
translation tables were corrupted caused by uninitialized memory and invalid 
table sizes sent through client announcement mechanism. 
 

batctl
------

batctl remains unchanged.


Happy routing, 
The B.A.T.M.A.N. team
