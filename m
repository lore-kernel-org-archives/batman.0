Message-ID: <20070606175918.t5afx9tub1ckwk88@wwwstudent.murdoch.edu.au>
Date: Wed, 06 Jun 2007 17:59:18 +0800
From: David Murray <30179198@student.murdoch.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Using batman
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
To: B.A.T.M.A.N@open-mesh.net

Hi

I have setup a testbed to try out the batman routing protocol and 
hopefully learn a little about it. I have installed it on 4 machines 
and they all seem ok but when I try to run batman with:

#./batmand interface ath0

I simply get another command line #. Then when I try a:

#ps -e

I cannot see batman running as a process anywhere. Is there something 
that I am missing?

My systems are all: Debian Sarge (kernel 2.6.8-3)
P3 800 with 256 Mb RAM

I am using the latest release of Batman:
B.A.T.M.A.N. III 0.2.0 rc2 (compability version 3)

Thanks

Dave

