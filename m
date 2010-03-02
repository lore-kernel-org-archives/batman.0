Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Mar 2010 06:40:15 +0800
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201003030640.16085.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] reorganized kernel interface patches (version 2)
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


Hi,

I merged the feedback given so far into the patchset and post them again to 
offer you the chance of generating even more feedback.  :-)

Changes since version1:
* the known issue from version1 turned out to be a bug in the used kernel
* batctl sysfs path has been changed to /sys/class/net/ since older kernels 
don't provide the "virtual" subdirectory
* the year of the copyright notice was corrected
* In case the erroneous of input contains a newline it will not be printed to 
avoid printing 2 subsequent newlines
* the function calls which used global variables before now receive the 
bat_priv struct as an argument
* added _GNU_SOURCE to bat-hosts.c to avoid compile warning
* batctl gets bonding mode support

Cheers,
Marek
