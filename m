From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 25 Jan 2009 19:45:37 +0100
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200901251946.21505.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman 0.3.1 released
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

the B.A.T.M.A.N. team is pleased to announce the availability of batman 0.3.1  
a bugfix and maintenance release. As usual, we provide precompiled packages:
http://downloads.open-mesh.net/batman/stable/binaries/
as well as signed source tarballs:
http://downloads.open-mesh.net/batman/stable/sources/

As you may have noticed we slighty modified the folder structure to seperate 
binaries and sources better. Also, we will keep providing older source 
tarballs to support the various distributions better. In addition, we added a 
release "bundle" folder which contains related source packages:
http://downloads.open-mesh.net/batman/releases/

Many people outside the B.A.T.M.A.N. team contributed to make this release 
possible. Thanks to everyone that helped us.
Special thanks goes to Antonio and the open-mesh.com crew. They provided us 
with bug reports, test beds and ideas to improve the overall batman 
experience. Also, we wish to thank Sven Eckelmann for his endless stream of 
patches and thoughtful hints. 

During the past months the code received improvements all over the place. 
Nearly all functions were touched. The packet aggregation was debugged and 
improved. Areas with a high density of nodes suffered from bogus routing 
information which was fixed. BSD compability was committed. Now, on a changing 
route batman adds new routes to the kernel routing table before the old routes 
are deleted to avoid race conditions. The batgat kernel module received many 
fixes that improve stability. The makefile reduced the verbosity of its output 
to allow easy distinctions between warnings and commands. The full changelog 
can be retrieved here: http://open-mesh.net/log/trunk/batman?rev=1201

Happy routing,
Marek


