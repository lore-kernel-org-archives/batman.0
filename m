Content-Disposition: inline
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 17 Nov 2008 00:04:23 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200811170004.23285.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv debian announcement
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

even if the news is still some days old - its worth mentioning: 
batman-advanced is now available in Debian! 

The packages are available through your favorite dpkg frontend (apt-get, 
aptitude, ...) using the unstable repositories. To follow the package 
development you can visit the following pages:

http://packages.debian.org/sid/batman-adv-source
http://packages.debian.org/sid/batman-adv-battool

batman-adv-source contains the source code and can be compiled for your kernel
using module-assistant [1]. batman-adv-battool contains the battool which
provides ping, traceroute and other tools for the batman-adv network.

Big thanks to Sven Eckelmann, Simon Wunderlich and Holger Levsen for their 
work on these packages. :)

BTW, you also can find the current batman stable (0.3) in the lenny and 
unstable repositories. Here the respective package pages:

http://packages.debian.org/lenny/batmand
http://packages.debian.org/sid/batmand


Regards,
Marek


[1] http://packages.debian.org/sid/module-assistant


