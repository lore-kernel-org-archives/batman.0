Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 5 Feb 2012 22:35:22 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201202052235.22621.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2012.0.0 released
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


Today the B.A.T.M.A.N. team releases its latest edition, 2012.0.0, containing 
a series of stabilization changes and bug fixes. This release does not 
introduce any new features and uniquely focuses on stability. As the kernel 
module always depends on the Linux kernel it was compiled against, it does not 
make sense to provide binaries on our website. As usual, you will find the 
signed tarballs in our download section: 

http://downloads.open-mesh.org/batman/releases/batman-adv-2012.0.0/ 

as well as prepackaged binaries in your distribution.


Thanks
------

Thanks to all people sending in patches:

 * Antonio Quartulli <ordex@autistici.org>
 * Dan Carpenter <dan.carpenter@oracle.com>
 * Marek Lindner <lindner_marek@yahoo.de>
 * Paul Kot <pawlkt@gmail.com>
 * Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
 * Sven Eckelmann <sven@narfation.org>


batman-adv
----------

The gateway handling code was refactored as it became nearly impossible to 
understand the various gateway handling cases that were added over time. Also 
refactored was the TT handling code and a common subtype for locally and 
globally announced mac addresses was introduced. All told, the TT code was 
thoroughly reviewed leading to numerous fixes: When adding a tt entry to the 
hash failed its memory is properly freed. Globally roaming clients are now 
clearly marked as such. The length of a TT packet is compared with the length 
the packet claims to have, thereby avoiding memory corruptions. The expensive 
packet linearize function is called only when absolutely necessary.
We also were in the lucky position of getting a security audit from Paul Kot 
who did find a possible memory corruption in the batman socket reading code. 
However, since there is no way to exploit it, according to him, we judged the 
risk to be low. Obviously, the fix for this corruption is part of the release. 
Also fixed was a kernel freeze when the bat0 interface could not be created. 


batctl
------

The log level parameter parser was fixed, so that it now correctly exits after 
receiving an invalid option as well as correctly handles the 'all' log level 
option.


Happy routing,
The B.A.T.M.A.N. team
