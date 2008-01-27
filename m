Message-ID: <20080127174820.uo7k8twns4c8c4o8@webmail.ddmesh.de>
Date: Sun, 27 Jan 2008 17:48:20 +0100
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] gateway class/batmand termination
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

Hi,

I have implemented a mechanism that checks for a working internet connection.
Depending on this batmand is called either with options "-c -b -r2" or
"-c -b -g 1024/1024".

Most often when batmand is called with "-c -b -g 1024/1024" batmand  
terminates:

batmand -c -b -g 1024/1024
WARNING: You are using BatMan-eXp 0.3-alpha (compatibility version 10) !
Connection terminated by remote host.

I have to restart batmand, but all routes are removed and batman loses
its data. I also have to check for the internet connection again and must hope
that batmand does not terminate.

Batmand does not terminate every time.

Any ideas?
Tested rev. 966 (batman-experimental)

/Stephan

